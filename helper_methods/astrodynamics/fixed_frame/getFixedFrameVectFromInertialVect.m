function [rVectECEF, vVectECEF] = getFixedFrameVectFromInertialVect(ut, rVectECI, bodyInfo, varargin)
%getFixedFrameVectFromInertialVect Summary of this function goes here
%   Detailed explanation goes here

    if(~isempty(varargin))
        vVectECI = varargin{1};
    else
        vVectECI = [NaN;NaN;NaN];
    end

    spinAngle = getBodySpinAngle(bodyInfo, ut);
    
    R = [cos(spinAngle) -sin(spinAngle) 0;
         sin(spinAngle) cos(spinAngle) 0;
         0 0 1];
    rVectECI = reshape(rVectECI,3,1);
    
    rVectECEF = R' * rVectECI;
    
    if(~any(isnan(vVectECI)))
        rotRateRadSec = 2*pi/bodyInfo.rotperiod;
        omegaRI = [0;0;rotRateRadSec];
        vVectECEF = R'*(vVectECI - crossARH(omegaRI, rVectECI));
    else
        vVectECEF = [NaN;NaN;NaN];
    end
    
end

