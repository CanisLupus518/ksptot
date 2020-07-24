classdef CalculusCalculationValueConstraint < AbstractConstraint
    %CalculusCalculationValueConstraint Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        normFact = 1;
        event LaunchVehicleEvent
        calculusCalc AbstractLaunchVehicleCalculusCalc
        
        lb(1,1) double = 0;
        ub(1,1) double = 0;
    end
    
    methods
        function obj = CalculusCalculationValueConstraint(event, lb, ub)
            obj.event = event;
            obj.lb = lb;
            obj.ub = ub;   
            
            obj.id = rand();
        end
        
        function [lb, ub] = getBounds(obj)
            lb = obj.lb;
            ub = obj.ub;
        end
        
        function [c, ceq, value, lwrBnd, uprBnd, type, eventNum] = evalConstraint(obj, stateLog, celBodyData)           
            type = obj.getConstraintType();
            stateLogEntry = stateLog.getLastStateLogForEvent(obj.event);
            cObjStates = stateLogEntry.getAllCalculusObjStates();
            cObjState = cObjStates([cObjStates.calcObj] == obj.calculusCalc);
            
            time = stateLogEntry.time;
            value = cObjState.getValueAtTime(time);
                       
            if(obj.lb == obj.ub)
                c = [];
                ceq(1) = value - obj.ub;
            else
                c(1) = obj.lb - value;
                c(2) = value - obj.ub;
                ceq = [];
            end
            c = c/obj.normFact;
            ceq = ceq/obj.normFact;  
            
            lwrBnd = obj.lb;
            uprBnd = obj.ub;
            
            eventNum = obj.event.getEventNum();
        end
        
        function sF = getScaleFactor(obj)
            sF = obj.normFact;
        end
        
        function setScaleFactor(obj, sF)
            obj.normFact = sF;
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
        
        function tf = usesEvent(obj, event)
            tf = obj.event == event;
        end
        
        function tf = usesStopwatch(obj, stopwatch)
            tf = false;
        end
        
        function tf = usesExtremum(obj, extremum)
            tf = false;
        end
        
        function tf = usesCalculusCalc(obj, calculusCalc)
            tf = [obj.calculusCalc] == calculusCalc;
        end
        
        function tf = canUseSparseOutput(obj)
            tf = false;
        end
        
        function event = getConstraintEvent(obj)
            event = obj.event;
        end
        
        function type = getConstraintType(obj)
            type = 'Calculus Calculation Value';
        end
                
        function [unit, lbLim, ubLim, usesLbUb, usesCelBody, usesRefSc] = getConstraintStaticDetails(obj)
            unit = obj.calculusCalc.unitStr;
            lbLim = -Inf;
            ubLim = Inf;
            usesLbUb = true;
            usesCelBody = false;
            usesRefSc = false;
        end
        
        function addConstraintTf = openEditConstraintUI(obj, lvdData)
            [listBoxStr, calcObjs] = lvdData.launchVehicle.getCalculusCalcObjListBoxStr();

            if(isempty(calcObjs))
                addConstraintTf = false;
                
                warndlg('Cannot create calculus calculation constraint: no calculus calculations have been created.  Create a calculus calculation first.','Calculus Calculation Constraint','modal');
            else
                [Selection,ok] = listdlg('PromptString',{'Select the calculus calculation','to constrain:'},...
                                'SelectionMode','single',...
                                'Name','Calculus Calculation',...
                                'ListString',listBoxStr);
                            
                if(ok == 0)
                    addConstraintTf = false;
                else
                    calcObj = calcObjs(Selection);
                    obj.calculusCalc = calcObj;
                    
                    addConstraintTf = lvd_EditGenericMAConstraintGUI(obj, lvdData);
                end
            end
        end
    end
    
    methods(Static)
        function constraint = getDefaultConstraint(~)            
            constraint = CalculusCalculationValueConstraint(LaunchVehicleEvent.empty(1,0),0,0);
        end
    end
end