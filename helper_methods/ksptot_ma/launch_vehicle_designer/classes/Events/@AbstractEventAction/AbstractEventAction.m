classdef(Abstract) AbstractEventAction < matlab.mixin.SetGet & matlab.mixin.Heterogeneous
    %AbstractEventAction Summary of this class goes here
    %   Detailed explanation goes here
        
    properties(Abstract=false)
        id(1,1) double
    end
    
    methods
        newStateLogEntry = exectuteAction(obj, stateLogEntry)
        
        initAction(obj, initialStateLogEntry)
        
        name = getName(obj)
    end
    
    methods(Sealed)
        function tf = eq(A,B)
            tf = [A.id] == [B.id];
        end  
    end
    
    methods(Static)
        addActionTf = openEditActionUI(action, lv);
    end
end