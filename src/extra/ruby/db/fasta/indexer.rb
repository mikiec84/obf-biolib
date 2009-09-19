# Indexer module for the FASTA class
#
# This is a simple memory based key storage
#

module Indexer

  def indexer_use state
    if state
      @indexer = {}
    end
  end

  def indexer_set key, value
    raise "Trying to use 'set' when there is no index" if @indexer == nil
    raise "Indexer key #{key} alread in use!" if @indexer[key]
    @indexer[key] = value
  end

  def indexer_get key
    raise "Trying to use 'get' when there is no index" if @indexer == nil
    @indexer[key] 
  end

end

