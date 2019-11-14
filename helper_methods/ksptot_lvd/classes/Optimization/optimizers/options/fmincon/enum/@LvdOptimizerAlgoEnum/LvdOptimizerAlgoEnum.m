classdef LvdOptimizerAlgoEnum < matlab.mixin.SetGet
    %LvdOptimizerAlgoEnum Summary of this class goes here
    %   Detailed explanation goes here
    
    enumeration
        Fmincon('FMINCON', ...
                'The standard gradient-based nonlinear programming solver in MATLAB.  Supports a variety of subroutines.  Try this algorithm first.', ...
                true);
        PatternSearch('Pattern Search', ...
                      'Uses a "direct search" algorithm to solve NLP problems.  Direct search is a method for solving optimization problems that does not require any information about the gradient of the objective function.  Use this function to find a reasonable guess for a solution and then switch to a gradient-based method.', ...
                      false);
        Nomad('NOMAD', ...
              'NOMAD Descr Here', ...
              false);
    end
    
    properties
        name(1,:) char
        desc(1,:) char
        reqGrad(1,1) logical = true
    end
    
    methods
        function obj = LvdOptimizerAlgoEnum(name, desc, reqGrad)
            obj.name = name;
            obj.desc = desc;
            obj.reqGrad = reqGrad;
        end
    end
    
    methods(Static)
        function listBoxStr = getListBoxStr()
            m = enumeration('LvdOptimizerAlgoEnum');
            [~,I] = sort({m.name});
            listBoxStr = {m(I).name};
        end
        
        function [ind, enum] = getIndForName(name)
            m = enumeration('LvdOptimizerAlgoEnum');
            [~,I] = sort({m.name});
            m = m(I);
            ind = find(ismember({m.name},name),1,'first');
            enum = m(ind);
        end
        
        function [enum, ind] = getEnumForListboxStr(nameStr)
            m = enumeration('LvdOptimizerAlgoEnum');
            ind = find(ismember({m.name},nameStr),1,'first');
            enum = m(ind);
        end
    end
end