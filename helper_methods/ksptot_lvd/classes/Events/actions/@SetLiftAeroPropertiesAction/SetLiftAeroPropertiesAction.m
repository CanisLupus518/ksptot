classdef SetLiftAeroPropertiesAction < AbstractEventAction
    %SetLiftAeroPropertiesAction Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        useLift(1,1) logical = false;
        areaLift(1,1) double = 16.2; 
        Cl_0(1,1) double = 0.731;  
        bodyLiftVect(3,1) double = [0;0;-1];
    end
    
    methods
        function obj = SetDragAeroPropertiesAction(useLift, areaLift, Cl_0, bodyLiftVect)
            if(nargin > 0)
                obj.useLift = useLift;
                obj.areaLift = areaLift;
                obj.Cl_0 = Cl_0;
                obj.bodyLiftVect = bodyLiftVect;
            end
            
            obj.id = rand();
        end
        
        function newStateLogEntry = executeAction(obj, stateLogEntry)
            newStateLogEntry = stateLogEntry;
            
            newStateLogEntry.aero.useLift = obj.useLift;
            newStateLogEntry.aero.areaLift = obj.areaLift;
            newStateLogEntry.aero.Cl_0 = obj.Cl_0;
            newStateLogEntry.aero.bodyLiftVect = obj.bodyLiftVect;
        end
        
        function initAction(obj, initialStateLogEntry)
            %none
        end
        
        function name = getName(obj)           
            name = 'Set Lift Aero Properties';
        end
        
        function tf = usesStage(obj, stage)
            tf = false;
        end
        
        function tf = usesEngine(obj, engine)
            tf = false;
        end
        
        function tf = usesTank(obj, tank)
            tf = false;
        end
        
        function tf = usesEngineToTankConn(obj, engineToTank)
            tf = false;
        end
        
        function tf = usesStopwatch(obj, stopwatch)
            tf = false;
        end
        
        function tf = usesExtremum(obj, extremum)
            tf = false;
        end
        
        function tf = usesTankToTankConn(obj, tankToTank)
            tf = false;
        end
        
        function [tf, vars] = hasActiveOptimVar(obj)
            tf = false;
            vars = AbstractOptimizationVariable.empty(0,1);
        end
    end
    
    methods(Static)
        function addActionTf = openEditActionUI(action, lv)
            fakeLvdData = LvdData.getDefaultLvdData(lv.lvdData.celBodyData);
            
            initStateModel = fakeLvdData.initStateModel;
            initStateModel.aero.useLift = action.useLift;
            initStateModel.aero.areaLift = action.areaLift;
            initStateModel.aero.Cl_0 = action.Cl_0;
            initStateModel.aero.bodyLiftVect = action.bodyLiftVect;
            
            [addActionTf, useLift, areaLift, Cl_0, bodyLiftVect] = lvd_EditLiftPropertiesGUI(fakeLvdData);
            if(addActionTf)
                action.useLift = useLift;
                action.areaLift = areaLift;
                action.Cl_0 = Cl_0;
                action.bodyLiftVect = bodyLiftVect;
            end
        end
    end
end