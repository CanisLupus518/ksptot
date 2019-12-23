function [c, ceq] = ma_verticalVelConstraint(stateLog, eventID, lbVertVel, ubVertVel, bodyIDApply, celBodyData, maData)
%ma_semiMajorAxisConstraint Summary of this function goes here
%   Detailed explanation goes here

    normFact = 1;

    if(ischar(eventID) && strcmpi(eventID,'final'))
        eventNum = max(stateLog(:,13));
    else
        [~, eventNum] = getEventByID(eventID, maData.script);
    end

    eventLog = stateLog(stateLog(:,13)==eventNum,:);
    finalEntry = eventLog(end,:);
    
    bodyID = finalEntry(8);

    if(bodyID == bodyIDApply || bodyIDApply==-1)
        vertVel = ma_GALongLatAltTasks(finalEntry, 'vertVel', celBodyData);

        if(lbVertVel == ubVertVel)
            c = [0 0];
            ceq(1) = vertVel - ubVertVel;
        else
            c(1) = lbVertVel - vertVel;
            c(2) = vertVel - ubVertVel;
            ceq = [0];
        end
        c = c/normFact;
        ceq = ceq/normFact;
    else
        c = [0 0];
        ceq = [0];
    end
end