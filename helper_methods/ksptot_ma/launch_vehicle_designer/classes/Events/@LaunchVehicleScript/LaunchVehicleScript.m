classdef LaunchVehicleScript < matlab.mixin.SetGet
    %LaunchVehicleScript Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        evts(1,:) LaunchVehicleEvent
        
        lvdData LvdData
    end
    
    properties(Access=private)
        simDriver LaunchVehicleSimulationDriver
    end
    
    methods
        function obj = LaunchVehicleScript(lvdData, simDriver)
            obj.lvdData = lvdData;
            obj.simDriver = simDriver;
        end
        
        function addEvent(obj, newEvt)
            obj.evts(end+1) = newEvt;
        end
        
        function addEventAtInd(obj, newEvt, ind)
            if(ind == length(obj.evts))
                obj.evts(end+1) = newEvt;
            else
                obj.evts = [obj.evts(1:ind), newEvt, obj.evts(ind+1:end)];
            end
        end
        
        function removeEvent(obj, evt)
            obj.evts(obj.evts == evt) = [];
        end
        
        function removeEventFromIndex(obj, ind)
            if(ind >= 1 && ind <= length(obj.evts))
                obj.removeEvent(obj.evts(ind));
            end
        end
        
        function evtNum = getNumOfEvent(obj, evt)
            evtNum = find(obj.evts == evt);
        end
        
        function evt = getEventForInd(obj, ind)
            evt = LaunchVehicleEvent.empty(1,0);
            
            if(ind >= 1 && ind <= length(obj.evts))
                evt = obj.evts(ind);
            end
        end
        
        function moveEvtAtIndexDown(obj, ind)
            if(ind < length(obj.evts))
                obj.evts([ind+1,ind]) = obj.evts([ind,ind+1]);
            end
        end
        
        function moveEvtAtIndexUp(obj, ind)
            if(ind > 1)
                obj.evts([ind,ind-1]) = obj.evts([ind-1,ind]);
            end
        end
        
        function listboxStr = getListboxStr(obj)
            listboxStr = cell(length(obj.evts),1);
            
            for(i=1:length(obj.evts))
                listboxStr{i} = obj.evts(i).getListboxStr();
            end
        end
        
        function stateLog = executeScript(obj)
            initStateLogEntry = obj.lvdData.initialState;
            stateLog = obj.lvdData.stateLog;
            
            stateLog.clearStateLog();
            
            for(i=1:length(obj.evts)) %#ok<*NO4LP>
                obj.evts(i).initEvent(initStateLogEntry);
                initStateLogEntry.event = obj.evts(i);
                
                newStateLogEntries = obj.evts(i).executeEvent(initStateLogEntry, obj.simDriver);
                stateLog.appendStateLogEntries(newStateLogEntries);
                
                initStateLogEntry = newStateLogEntries(end).deepCopy();
                obj.evts(i).cleanupEvent(initStateLogEntry);
            end
        end
    end
end