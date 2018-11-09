classdef LvdSettings < matlab.mixin.SetGet
    %LvdSettings Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %integration
        intAbsTol(1,1) double = 1E-8;
        intRelTol(1,1) double = 1E-8;
        minAltitude(1,1) double = -1;  %km
        simMaxDur(1,1) double = 20000; %sec
        maxScriptPropTime(1,1) double = 5; %sec
        
        %optimization
        optUsePara(1,1) logical = false;
        optAlgo LvdOptimAlgorithmEnum = LvdOptimAlgorithmEnum.InteriorPoint
    end
    
    methods
        function obj = LvdSettings()

        end
    end
end