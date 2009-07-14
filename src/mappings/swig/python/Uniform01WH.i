%module bpp_
%{
#include "Uniform01WH.h"
%}
%include "RandomFactory.i"
namespace bpp
{
class Uniform01WH : public RandomFactory {
	public: 
		Uniform01WH(long seed);
		~Uniform01WH();

		void setSeed(long seed);
		void setSeeds(long seed1, long seed2 = 20356, long seed3 = 35412);
		double drawNumber() const;
};
} 