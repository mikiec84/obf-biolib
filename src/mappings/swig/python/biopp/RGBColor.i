%module bpp_rgbcolor

%{
#include "RGBColor.h"
using namespace bpp;
%}

//%include <cstdlib>
//%include <cmath>
%include "TextTools.i"
%include "Exceptions.i"
%include "Clonable.i"

using namespace std;

%rename(__aref__) RGBColor::operator[];
%rename(__eq__) RGBColor::operator==;
%rename(__lt__) RGBColor::operator<;

class RGBColor:public virtual Clonable
{
  public:
    RGBColor(unsigned int red, unsigned int green, unsigned int blue): _red(red), _green(green), _blue(blue);
    RGBColor(): _red(0), _green(0), _blue(0);
    virtual ~RGBColor();
    RGBColor* clone() const;

    bool operator==(const RGBColor & color) const;
    bool operator<(const RGBColor & color) const;
    string toHex() const;
    const unsigned int & operator[](unsigned int i) const;
    unsigned int & operator[](unsigned int i);
    string toString() const;
};