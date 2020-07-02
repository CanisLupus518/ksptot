function [objFuncValue, dv, deltaV1, deltaV2, deltaV1R, deltaV2R, xfrOrbit, deltaV1NTW, deltaV2NTW] = rendezvousObjFunc(x, iniOrbit, finOrbit, gmuXfr, weights, onlyOptBurn1)
%rendezvousObjFunc Summary of this function goes here
%   Detailed explanation goes here
    time1 = x(1);
    time2 = time1 + x(2);

    iniOrbBodyInfo = getBodyInfoStructFromOrbit(iniOrbit);
    [rVect, vVect] = getStateAtTime(iniOrbBodyInfo, time1, iniOrbit(8));
    [~, ~, ~, ~, ~, iniTA] = getKeplerFromState(rVect,vVect,iniOrbit(8));
    % iniOrbit(7) = [];
    % iniOrbit(6) = [];

    finOrbBodyInfo = getBodyInfoStructFromOrbit(finOrbit);
    [rVect, vVect] = getStateAtTime(finOrbBodyInfo, time2, finOrbit(8));
    [~, ~, ~, ~, ~, finTA] = getKeplerFromState(rVect,vVect,finOrbit(8));
    % finOrbit(7) = [];
    % finOrbit(6) = [];

    x(1) = iniTA;
    x(2) = finTA;
    x(3) = time2 - time1;
    [dv, deltaV1, deltaV2, deltaV1R, deltaV2R, xfrOrbit, deltaV1NTW, deltaV2NTW] = twoBurnOrbitChangeObjFunc(x, iniOrbit, finOrbit, gmuXfr);

    if(onlyOptBurn1)
        dv = norm(deltaV1);
    end
    
    dvWt = weights(1);
    timeWt = weights(2);
    timeNorm = computePeriod(mean([abs(iniOrbit(1)),abs(finOrbit(1))]), gmuXfr); %time norm is the period of the average of the initial and final orbit SMAs

    objFuncValue = dvWt*dv + timeWt*(time2 - time1)/timeNorm;
end

