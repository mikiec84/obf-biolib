
module GenericAdaptor
  def method_missing method, *args
    if @adapted.respond_to? method
      @adapted.send(method, *args)
    else
      raise NotImplementedError 'Method missing in interface!'
    end
  end
end

module RQtlMap
  GMAP = { 'A' => 1, 'H' => 2, 'B' => 3, 'C' => 4, 'D' => 5, '-' => 'NA' }
  NAMAP = { '-' => 'NA', 'NA' => 'NA' }

  def gtranslate g
    return GMAP[g] if g
    g
  end

  def natranslate n
    return 'NA' if n==nil
    return NAMAP[n] if n
    n
  end
end

class RQtlGenotypesAdaptor
  include GenericAdaptor, RQtlMap

  def initialize adapted
    @adapted = adapted
  end

  def names
    @adapted.names.collect { | n | gtranslate(n) }
  end

  def alleles
    @adapted.alleles.collect { | n | gtranslate(n) }
  end

  def na
    @adapted.na.collect { | n | natranslate(n) }
  end

  def to_matrix
    raise "undefined"
  end
end

class RQtlPhenotypesAdaptor
  include GenericAdaptor, RQtlMap

  def initialize adapted
    @adapted = adapted
  end

  def na
    @adapted.na.collect { | n | natranslate(n) }
  end

  def to_a
    @adapted
  end

end

class RQtlInputAdaptor 
  include GenericAdaptor, RQtlMap

  def initialize qtldataset
    @adapted = qtldataset 
    @adaptedgenotypes = RQtlGenotypesAdaptor.new(qtldataset.genotypes)
    @adaptedphenotypes = RQtlPhenotypesAdaptor.new(qtldataset.phenotypes)
  end

  def genotype ind, mar
    gtranslate(@adapted.genotype(ind,mar))
  end

  def genotypes
    @adaptedgenotypes
  end

  def phenotypes
    @adaptedphenotypes
  end

  def weights
    []
  end
end


class RQtlScanoneAdaptor < RQtlInputAdaptor

  # return phenotypes for use by scanone function
  def scanone_inphenotypevector
    inds = use_individuals
    # FIX multiple phenotypes 
    phs = @adaptedphenotypes.to_a.flatten
    inds.collect { | i | phs[i] }
  end

  def scanone_ingenotypematrix
    inds = use_individuals
    gmatrix = Array.new.fill(0.0,0..inds.size*@adapted.markers.size)
    inds.each do | ind |
      (0..@adapted.markers.size-1).each do | mar |
        gmatrix[ind*@adapted.markers.size+mar] = genotype(ind,mar)
      end
    end
    # p gmatrix
    gmatrix.to_a.flatten.collect { | g | (g=='NA' ? 0:g) }
  end

  # return index of used individuals
  def use_individuals
    inds = []
    # test for valid phenotypes
    # FIX multiple phenotypes and NA's (now zeroed)
    phs = @adaptedphenotypes.to_a.flatten
    phs.each_with_index do | ph, i |
      inds.push i if ph != 'NA'
    end
    inds
  end


end