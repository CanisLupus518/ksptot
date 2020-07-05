classdef KSPTOT_BodyInfo < matlab.mixin.SetGet
    %KSPTOT_BodyInfo Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        epoch double
        sma double
        ecc double
        inc double
        raan double
        arg double
        mean double
        gm double
        radius double
        atmohgt double
        atmopresscurve = griddedInterpolant([0 1]',[0 0]','spline', 'nearest');
        atmotempcurve = griddedInterpolant([0 1]',[0 0]','spline', 'nearest');
        atmotempsunmultcurve = griddedInterpolant([0 1]',[0 0]','spline', 'nearest');
        lattempbiascurve = griddedInterpolant([0 1]',[0 0]','spline', 'nearest');
        lattempsunmultcurve = griddedInterpolant([0 1]',[0 0]','spline', 'nearest');
        axialtempsunbiascurve = griddedInterpolant([0 1]',[0 0]','spline', 'nearest');
        axialtempsunmultcurve = griddedInterpolant([0 1]',[0 0]','spline', 'nearest');
        ecctempbiascurve = griddedInterpolant([0 1]',[0 0]','spline', 'nearest');
        atmomolarmass double
        rotperiod double
        rotini double
        bodycolor char
        canbecentral double
        canbearrivedepart double
        parent
        parentid double
        name char
        id double
        
        %orientation of inertial frame (spin axis handling)
        bodyZAxis(3,1) double = [0;0;1];
        bodyXAxis(3,1) double = [1;0;0];
        bodyRotMatFromGlobalInertialToBodyInertial = [];
    end
    
    properties
        celBodyData
        
        parentBodyInfo KSPTOT_BodyInfo
        parentBodyInfoNeedsUpdate logical = true;
        
        childrenBodyInfo KSPTOT_BodyInfo
        childrenBodyNames cell
        childrenBodyInfoNeedsUpdate logical = true;
    end
    
    properties(Access=private)
        bodyInertialFrameCache BodyCenteredInertialFrame = BodyCenteredInertialFrame.empty(1,0);
        bodyFixedFrameCache BodyFixedFrame = BodyFixedFrame.empty(1,0);
    end
    
    methods
        function obj = KSPTOT_BodyInfo() 
        
        end
        
        function parentBodyInfo = getParBodyInfo(obj, celBodyData)
            if(obj.parentBodyInfoNeedsUpdate && isempty(obj.parentBodyInfo))
                pBodyInfo = getParentBodyInfo(obj, celBodyData);
                
                if(not(isempty(pBodyInfo)))
                    obj.parentBodyInfo = pBodyInfo;
                end
                
                obj.parentBodyInfoNeedsUpdate = false;
            end
            
            parentBodyInfo = obj.parentBodyInfo;
        end
        
        function [childrenBodyInfo, cbNames] = getChildrenBodyInfo(obj, celBodyData)
            if(obj.childrenBodyInfoNeedsUpdate && isempty(obj.childrenBodyInfo))
                [cBodyInfo,cbNames] = getChildrenOfParentInfo(celBodyData, obj.name);
                
                if(not(isempty(cBodyInfo)))
                    for(i=1:length(cBodyInfo))
                        obj.childrenBodyInfo(i) = cBodyInfo{i};
                    end
                    obj.childrenBodyNames = cbNames;
                end
                
                obj.childrenBodyInfoNeedsUpdate = false;
            end
            
            childrenBodyInfo = obj.childrenBodyInfo;
            cbNames = obj.childrenBodyNames;
        end
        
        function rotMat = get.bodyRotMatFromGlobalInertialToBodyInertial(obj)
            if(isempty(obj.bodyRotMatFromGlobalInertialToBodyInertial))
                obj.bodyZAxis = normVector(obj.bodyZAxis);
                obj.bodyXAxis = normVector(obj.bodyXAxis);
                
                rotY = normVector(crossARH(obj.bodyZAxis, obj.bodyXAxis));
                rotX = normVector(crossARH(rotY, obj.bodyZAxis));
                rotMat = [rotX, rotY, obj.bodyZAxis];
                
                obj.bodyRotMatFromGlobalInertialToBodyInertial = rotMat;
            else
                rotMat = obj.bodyRotMatFromGlobalInertialToBodyInertial;
            end
        end
        
        function frame = getBodyCenteredInertialFrame(obj)
            if(isempty(obj.bodyInertialFrameCache))
                obj.bodyInertialFrameCache = BodyCenteredInertialFrame(obj, obj.celBodyData);
            end
            
            frame = obj.bodyInertialFrameCache;
        end
        
        function frame = getBodyFixedFrame(obj)
            if(isempty(obj.bodyFixedFrameCache))
                obj.bodyFixedFrameCache = BodyFixedFrame(obj, obj.celBodyData);
            end
            
            frame = obj.bodyFixedFrameCache;
        end
        
        function states = getElementSetsForTimes(obj, times)
            parBodyInfo = obj.getParBodyInfo();
            if(not(isempty(parBodyInfo)))
                frame = parBodyInfo.getBodyCenteredInertialFrame();
                gmu = parBodyInfo.gm;

                [rVects, vVects] = getStateAtTime(obj, times, gmu);

                for(i=1:length(times))
                    states(i) = CartesianElementSet(times(i), rVects(:,i), vVects(:,i), frame); %#ok<AGROW>
                end
            else
                frame = obj.getBodyCenteredInertialFrame();
                
                for(i=1:length(times))
                    states(i) = CartesianElementSet(times(i), [0;0;0], [0;0;0], frame); %#ok<AGROW>
                end
            end
        end
        
        function bColorRGB = getBodyRGB(obj)
            bColor = obj.bodycolor;
            cmap = colormap(bColor);
            midRow = round(size(cmap,1)/2);
            bColorRGB = cmap(midRow,:);
        end
        
        function tf = eq(A,B)
            tf = [A.id] == [B.id];
            
            if(isempty(tf))
                tf = false;
            end
        end
    end
    
	methods(Static)
        function bodyObj = getObjFromBodyInfoStruct(bodyInfo)
            bodyObj = KSPTOT_BodyInfo();
          
            bodyObj.epoch = bodyInfo.epoch;
            bodyObj.sma = bodyInfo.sma;
            bodyObj.ecc = bodyInfo.ecc;
            bodyObj.inc = bodyInfo.inc;
            bodyObj.raan = bodyInfo.raan;
            bodyObj.arg = bodyInfo.arg;
            bodyObj.mean = bodyInfo.mean;
            bodyObj.gm = bodyInfo.gm;
            bodyObj.radius = bodyInfo.radius;
            bodyObj.atmohgt = bodyInfo.atmohgt;
            bodyObj.atmopresscurve = bodyInfo.atmopresscurve;
            bodyObj.atmotempcurve = bodyInfo.atmotempcurve;
            bodyObj.atmotempsunmultcurve = bodyInfo.atmotempsunmultcurve;
            bodyObj.lattempbiascurve = bodyInfo.lattempbiascurve;
            bodyObj.lattempsunmultcurve = bodyInfo.lattempsunmultcurve;
            bodyObj.atmomolarmass = bodyInfo.atmomolarmass;
            bodyObj.rotperiod = bodyInfo.rotperiod;
            bodyObj.rotini = bodyInfo.rotini;
            bodyObj.bodycolor = bodyInfo.bodycolor;
            bodyObj.canbecentral = bodyInfo.canbecentral;
            bodyObj.canbearrivedepart = bodyInfo.canbearrivedepart;
            bodyObj.parent = bodyInfo.parent;
            bodyObj.parentid = bodyInfo.parentid;
            bodyObj.name = bodyInfo.name;
            bodyObj.id = bodyInfo.id;
        end
    end
end

