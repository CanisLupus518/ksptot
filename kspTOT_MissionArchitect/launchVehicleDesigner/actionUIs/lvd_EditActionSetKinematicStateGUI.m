function varargout = lvd_EditActionSetKinematicStateGUI(varargin)
% LVD_EDITACTIONSETKINEMATICSTATEGUI MATLAB code for lvd_EditActionSetKinematicStateGUI.fig
%      LVD_EDITACTIONSETKINEMATICSTATEGUI, by itself, creates a new LVD_EDITACTIONSETKINEMATICSTATEGUI or raises the existing
%      singleton*.
%
%      H = LVD_EDITACTIONSETKINEMATICSTATEGUI returns the handle to a new LVD_EDITACTIONSETKINEMATICSTATEGUI or the handle to
%      the existing singleton*.
%
%      LVD_EDITACTIONSETKINEMATICSTATEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LVD_EDITACTIONSETKINEMATICSTATEGUI.M with the given input arguments.
%
%      LVD_EDITACTIONSETKINEMATICSTATEGUI('Property','Value',...) creates a new LVD_EDITACTIONSETKINEMATICSTATEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lvd_EditActionSetKinematicStateGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lvd_EditActionSetKinematicStateGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lvd_EditActionSetKinematicStateGUI

% Last Modified by GUIDE v2.5 29-Dec-2019 09:53:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lvd_EditActionSetKinematicStateGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @lvd_EditActionSetKinematicStateGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before lvd_EditActionSetKinematicStateGUI is made visible.
function lvd_EditActionSetKinematicStateGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lvd_EditActionSetKinematicStateGUI (see VARARGIN)

% Choose default command line output for lvd_EditActionSetKinematicStateGUI
    handles.output = hObject;
    
    action = varargin{1};
    setappdata(hObject, 'action', action);
    
    lvdData = varargin{2};
    setappdata(hObject, 'lvdData', lvdData);
    
    populateGUI(handles, action, lvdData);

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes lvd_EditActionSetKinematicStateGUI wait for user response (see UIRESUME)
    uiwait(handles.lvd_EditActionSetKinematicStateGUI);

    
function populateGUI(handles, action, lvdData)
    orbitModel = action.orbitModel;
    if(isempty(orbitModel.frame))
        newFrame = BodyCenteredInertialFrame(lvdData.celBodyData.sun,lvdData.celBodyData);
        orbitModel.frame = newFrame;
    end
    
    frame = orbitModel.frame;
    setappdata(handles.lvd_EditActionSetKinematicStateGUI,'curElemSet',orbitModel);
    
    bodyInfo = frame.getOriginBody();
    populateBodiesCombo(lvdData.celBodyData, handles.centralBodyCombo, false);
    value = findValueFromComboBox(bodyInfo.name, handles.centralBodyCombo);
	handles.centralBodyCombo.Value = value;
    
    handles.refFrameTypeCombo.String = ReferenceFrameEnum.getListBoxStr();
    handles.refFrameTypeCombo.Value = ReferenceFrameEnum.getIndForName(orbitModel.frame.typeEnum.name);
    
    handles.elementSetCombo.String = ElementSetEnum.getListBoxStr();
    value = ElementSetEnum.getIndForName(orbitModel.typeEnum.name);
    handles.elementSetCombo.Value = value;
    elementSetCombo_Callback(handles.elementSetCombo, [], handles);
    
    handles.utText.String = fullAccNum2Str(orbitModel.time);
    
    elemVector = orbitModel.getElementVector();
    handles.orbit1Text.String = fullAccNum2Str(elemVector(1));
    handles.orbit2Text.String = fullAccNum2Str(elemVector(2));
    handles.orbit3Text.String = fullAccNum2Str(elemVector(3));
    handles.orbit4Text.String = fullAccNum2Str(elemVector(4));
    handles.orbit5Text.String = fullAccNum2Str(elemVector(5));
    handles.orbit6Text.String = fullAccNum2Str(elemVector(6));
    
    handles.inheritTimeCheckbox.Value = double(action.inheritTime);
    handles.inheritStateCheckbox.Value = double(action.inheritPosVel);
    
    optVar = action.optVar;
	if(isempty(optVar))
        optVar = SetKinematicStateActionVariable(action);
	end
    useTf = optVar.getUseTfForVariable();  
    
    handles.optUtCheckbox.Value = double(useTf(1));
    handles.optOrbit1Checkbox.Value = double(useTf(2));
    handles.optOrbit2Checkbox.Value = double(useTf(3));
    handles.optOrbit3Checkbox.Value = double(useTf(4));
    handles.optOrbit4Checkbox.Value = double(useTf(5));
    handles.optOrbit5Checkbox.Value = double(useTf(6));
    handles.optOrbit6Checkbox.Value = double(useTf(7));
    
    optVar.setUseTfForVariable(true(size(useTf)));
    [lb, ub] = optVar.getBndsForVariable();
    optVar.setUseTfForVariable(useTf);
    
    handles.utLbText.String     = fullAccNum2Str(lb(1));
    handles.orbit1LbText.String = fullAccNum2Str(lb(2));
    handles.orbit2LbText.String = fullAccNum2Str(lb(3));
    handles.orbit3LbText.String = fullAccNum2Str(lb(4));
    handles.orbit4LbText.String = fullAccNum2Str(lb(5));
    handles.orbit5LbText.String = fullAccNum2Str(lb(6));
    handles.orbit6LbText.String = fullAccNum2Str(lb(7));
    
    handles.utUbText.String     = fullAccNum2Str(ub(1));
    handles.orbit1UbText.String = fullAccNum2Str(ub(2));
    handles.orbit2UbText.String = fullAccNum2Str(ub(3));
    handles.orbit3UbText.String = fullAccNum2Str(ub(4));
    handles.orbit4UbText.String = fullAccNum2Str(ub(5));
    handles.orbit5UbText.String = fullAccNum2Str(ub(6));
    handles.orbit6UbText.String = fullAccNum2Str(ub(7));
    
    inheritTimeCheckbox_Callback(handles.inheritTimeCheckbox, [], handles);  
    inheritStateCheckbox_Callback(handles.inheritStateCheckbox, [], handles);
    optUtCheckbox_Callback(handles.optUtCheckbox, [], handles);
    optOrbit1Checkbox_Callback(handles.optOrbit1Checkbox, [], handles);
    optOrbit2Checkbox_Callback(handles.optOrbit2Checkbox, [], handles);
    optOrbit3Checkbox_Callback(handles.optOrbit3Checkbox, [], handles);
    optOrbit4Checkbox_Callback(handles.optOrbit4Checkbox, [], handles);
    optOrbit5Checkbox_Callback(handles.optOrbit5Checkbox, [], handles);
    optOrbit6Checkbox_Callback(handles.optOrbit6Checkbox, [], handles);

% --- Outputs from this function are returned to the command line.
function varargout = lvd_EditActionSetKinematicStateGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    if(isempty(handles))
        varargout{1} = false;
    else  
        lvdData = getappdata(handles.lvd_EditActionSetKinematicStateGUI,'lvdData');
        celBodyData = lvdData.celBodyData;
        action = getappdata(handles.lvd_EditActionSetKinematicStateGUI, 'action');
        
        
        contents = cellstr(get(handles.elementSetCombo,'String'));
        selElemSet = contents{get(handles.elementSetCombo,'Value')};
        elemSetEnum = ElementSetEnum.getEnumForListboxStr(selElemSet);
        
        contents = cellstr(get(handles.refFrameTypeCombo,'String'));
        selFrameType = contents{get(handles.refFrameTypeCombo,'Value')};
        refFrameEnum = ReferenceFrameEnum.getEnumForListboxStr(selFrameType);
        
        time = str2double(handles.utText.String);
        bodyInfo = getSelectedBodyInfo(handles);
        
        orbit1Elem = str2double(handles.orbit1Text.String);
        orbit2Elem = str2double(handles.orbit2Text.String);
        orbit3Elem = str2double(handles.orbit3Text.String);
        orbit4Elem = str2double(handles.orbit4Text.String);
        orbit5Elem = str2double(handles.orbit5Text.String);
        orbit6Elem = str2double(handles.orbit6Text.String);
        
        switch refFrameEnum
            case ReferenceFrameEnum.BodyCenteredInertial
                frame = BodyCenteredInertialFrame(bodyInfo, celBodyData);
                
            case ReferenceFrameEnum.BodyFixedRotating
                frame = BodyFixedFrame(bodyInfo, celBodyData);
                
            otherwise
                error('Unknown reference frame type: %s', class(refFrameEnum));                
        end
        
        switch elemSetEnum
            case ElementSetEnum.CartesianElements
                orbitModel = CartesianElementSet(time, [orbit1Elem, orbit2Elem, orbit3Elem], [orbit4Elem, orbit5Elem, orbit6Elem], frame);
                
            case ElementSetEnum.KeplerianElements
                orbitModel = KeplerianElementSet(time, orbit1Elem, orbit2Elem, deg2rad(orbit3Elem), deg2rad(orbit4Elem), deg2rad(orbit5Elem), deg2rad(orbit6Elem), frame);
                
            case ElementSetEnum.GeographicElements
                orbitModel = GeographicElementSet(time, deg2rad(orbit1Elem), deg2rad(orbit2Elem), orbit3Elem, deg2rad(orbit4Elem), deg2rad(orbit5Elem), orbit6Elem, frame);
                
            otherwise
                error('Unknown element set type: %s', class(elemSetEnum));
        end

        action.orbitModel = orbitModel;
        
        %Vars
        optVar = action.optVar;
        if(not(isempty(optVar)))
            lvdData.optimizer.vars.removeVariable(optVar);
        end
        optVar = SetKinematicStateActionVariable(action);
        lvdData.optimizer.vars.addVariable(optVar);
        
        action.inheritTime = logical(handles.inheritTimeCheckbox.Value);
        action.inheritPosVel = logical(handles.inheritStateCheckbox.Value);
        
        optUt         = logical(handles.optUtCheckbox.Value) && action.inheritTime;
        optOrbit1Elem = logical(handles.optOrbit1Checkbox.Value) && action.inheritPosVel;
        optOrbit2Elem = logical(handles.optOrbit2Checkbox.Value) && action.inheritPosVel;
        optOrbit3Elem = logical(handles.optOrbit3Checkbox.Value) && action.inheritPosVel;
        optOrbit4Elem = logical(handles.optOrbit4Checkbox.Value) && action.inheritPosVel;
        optOrbit5Elem = logical(handles.optOrbit5Checkbox.Value) && action.inheritPosVel;
        optOrbit6Elem = logical(handles.optOrbit6Checkbox.Value) && action.inheritPosVel;
        
        useTf = [optUt optOrbit1Elem optOrbit2Elem optOrbit3Elem optOrbit4Elem optOrbit5Elem optOrbit6Elem];
        optVar.setUseTfForVariable(useTf);
        
        utLb = str2double(handles.utLbText.String);
        orbit1ElemLb = str2double(handles.orbit1LbText.String);
        orbit2ElemLb = str2double(handles.orbit2LbText.String);
        orbit3ElemLb = str2double(handles.orbit3LbText.String);
        orbit4ElemLb = str2double(handles.orbit4LbText.String);
        orbit5ElemLb = str2double(handles.orbit5LbText.String);
        orbit6ElemLb = str2double(handles.orbit6LbText.String);
        
        utUb = str2double(handles.utUbText.String);
        orbit1ElemUb = str2double(handles.orbit1UbText.String);
        orbit2ElemUb = str2double(handles.orbit2UbText.String);
        orbit3ElemUb = str2double(handles.orbit3UbText.String);
        orbit4ElemUb = str2double(handles.orbit4UbText.String);
        orbit5ElemUb = str2double(handles.orbit5UbText.String);
        orbit6ElemUb = str2double(handles.orbit6UbText.String);
        
        lb = [utLb orbit1ElemLb orbit2ElemLb orbit3ElemLb orbit4ElemLb orbit5ElemLb orbit6ElemLb];
        ub = [utUb orbit1ElemUb orbit2ElemUb orbit3ElemUb orbit4ElemUb orbit5ElemUb orbit6ElemUb];
        
        for(i=1:length(lb)) %#ok<*NO4LP>
            if(lb(i) > ub(i))
                temp1 = lb(i);
                temp2 = ub(i);
                
                lb(i) = temp2;
                ub(i) = temp1;
            end
        end
        
        optVar.setBndsForVariable(lb, ub);
        
        varargout{1} = true;
        close(handles.lvd_EditActionSetKinematicStateGUI);
    end 
    
function bodyInfo = getSelectedBodyInfo(handles)
	lvdData = getappdata(handles.lvd_EditActionSetKinematicStateGUI,'lvdData');
    celBodyData = lvdData.celBodyData;
    
    bodyStr = handles.centralBodyCombo.String;
    bodyName = lower(strtrim(bodyStr{handles.centralBodyCombo.Value}));
    bodyInfo = celBodyData.(bodyName);
    

function errMsg = validateInputs(handles)
	lvdData = getappdata(handles.lvd_EditActionSetKinematicStateGUI,'lvdData');
    celBodyData = lvdData.celBodyData;

    errMsg = {};
    bodyInfo = getSelectedBodyInfo(handles);
    
    ut = str2double(get(handles.utText,'String'));
    enteredStr = get(handles.utText,'String');
    numberName = 'Epoch (UT)';
    lb = 0;
    ub = Inf;
    isInt = false;
    errMsg = validateNumber(ut, numberName, lb, ub, isInt, errMsg, enteredStr);
    
    if(handles.optUtCheckbox.Value)
        utLb = str2double(get(handles.utLbText,'String'));
        enteredStr = get(handles.utLbText,'String');
        numberName = 'Epoch (UT) (Lower Bound)';
        lb = 0;
        ub = Inf;
        isInt = false;
        errMsg = validateNumber(utLb, numberName, lb, ub, isInt, errMsg, enteredStr);

        utUb = str2double(get(handles.utUbText,'String'));
        enteredStr = get(handles.utUbText,'String');
        numberName = 'Epoch (UT) (Upper Bound)';
        lb = 0;
        ub = Inf;
        isInt = false;
        errMsg = validateNumber(utUb, numberName, lb, ub, isInt, errMsg, enteredStr);

        if(utLb < utUb)
            ut = str2double(get(handles.utText,'String'));
            enteredStr = get(handles.utText,'String');
            numberName = 'Epoch (UT)';
            isInt = false;
            errMsg = validateNumber(ut, numberName, utLb, utUb, isInt, errMsg, enteredStr);
        else
            errMsg{end+1} = sprintf('%s lower bound must be less than the upper bound.', 'Epoch (UT)');
        end
    end
    
    contents = cellstr(get(handles.elementSetCombo,'String'));
    selElemSet = contents{get(handles.elementSetCombo,'Value')};
    elemSetEnum = ElementSetEnum.getEnumForListboxStr(selElemSet);
    
    checkElementValues = ones(1,6);
    checkElementBnds = [handles.optOrbit1Checkbox.Value, ...
                        handles.optOrbit2Checkbox.Value, ...
                        handles.optOrbit3Checkbox.Value, ...
                        handles.optOrbit4Checkbox.Value, ...
                        handles.optOrbit5Checkbox.Value, ...
                        handles.optOrbit6Checkbox.Value];
                    
	switch elemSetEnum
        case ElementSetEnum.CartesianElements
            errMsg = CartesianElementSet.validateInputOrbit(errMsg, handles.orbit1Text, handles.orbit2Text, handles.orbit3Text, handles.orbit4Text, handles.orbit5Text, handles.orbit6Text, bodyInfo, '', checkElementValues);
            errMsg = CartesianElementSet.validateInputOrbit(errMsg, handles.orbit1LbText, handles.orbit2LbText, handles.orbit3LbText, handles.orbit4LbText, handles.orbit5LbText, handles.orbit6LbText, bodyInfo, 'Lower', checkElementBnds);
            errMsg = CartesianElementSet.validateInputOrbit(errMsg, handles.orbit1UbText, handles.orbit2UbText, handles.orbit3UbText, handles.orbit4UbText, handles.orbit5UbText, handles.orbit6UbText, bodyInfo, 'Upper', checkElementBnds);
            
        case ElementSetEnum.KeplerianElements
            errMsg = KeplerianElementSet.validateInputOrbit(errMsg, handles.orbit1Text, handles.orbit2Text, handles.orbit3Text, handles.orbit4Text, handles.orbit5Text, handles.orbit6Text, bodyInfo, '', checkElementValues);
            errMsg = KeplerianElementSet.validateInputOrbit(errMsg, handles.orbit1LbText, handles.orbit2LbText, handles.orbit3LbText, handles.orbit4LbText, handles.orbit5LbText, handles.orbit6LbText, bodyInfo, 'Lower', checkElementBnds);
            errMsg = KeplerianElementSet.validateInputOrbit(errMsg, handles.orbit1UbText, handles.orbit2UbText, handles.orbit3UbText, handles.orbit4UbText, handles.orbit5UbText, handles.orbit6UbText, bodyInfo, 'Upper', checkElementBnds);
            
        case ElementSetEnum.GeographicElements
            errMsg = GeographicElementSet.validateInputOrbit(errMsg, handles.orbit1Text, handles.orbit2Text, handles.orbit3Text, handles.orbit4Text, handles.orbit5Text, handles.orbit6Text, bodyInfo, '', checkElementValues);
            errMsg = GeographicElementSet.validateInputOrbit(errMsg, handles.orbit1LbText, handles.orbit2LbText, handles.orbit3LbText, handles.orbit4LbText, handles.orbit5LbText, handles.orbit6LbText, bodyInfo, 'Lower', checkElementBnds);
            errMsg = GeographicElementSet.validateInputOrbit(errMsg, handles.orbit1UbText, handles.orbit2UbText, handles.orbit3UbText, handles.orbit4UbText, handles.orbit5UbText, handles.orbit6UbText, bodyInfo, 'Upper', checkElementBnds);
            
        otherwise
            error('Unknown element set type: %s', class(elemSetEnum));
	end
    
    hVal = [handles.orbit1Text, handles.orbit2Text, handles.orbit3Text, handles.orbit4Text, handles.orbit5Text, handles.orbit6Text];
    hLb = [handles.orbit1LbText, handles.orbit2LbText, handles.orbit3LbText, handles.orbit4LbText, handles.orbit5LbText, handles.orbit6LbText];
    hUb = [handles.orbit1UbText, handles.orbit2UbText, handles.orbit3UbText, handles.orbit4UbText, handles.orbit5UbText, handles.orbit6UbText];
    
    elemNames = elemSetEnum.elemNames;
    
    for(i=1:length(hVal))
        if(checkElementBnds(i) == 1)
            lb = str2double(get(hLb(i),'String'));
            ub = str2double(get(hUb(i),'String'));
            
            if(lb <= ub)
                value = str2double(get(hVal(i),'String'));
                enteredStr = get(hVal(i),'String');
                numberName = [elemNames{i}];
                isInt = false;
                errMsg = validateNumber(value, numberName, lb, ub, isInt, errMsg, enteredStr);
            else
                errMsg{end+1} = sprintf('%s lower bound must be less than the upper bound.', elemNames{i}); %#ok<AGROW>
            end
        end
    end


% --- Executes on button press in saveAndCloseButton.
function saveAndCloseButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveAndCloseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    errMsg = validateInputs(handles);

    if(isempty(errMsg))
        uiresume(handles.lvd_EditActionSetKinematicStateGUI);
    else
        msgbox(errMsg,'Errors were found while editing the state.','error');
    end

% --- Executes on button press in cancelButton.
function cancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in inheritStateCheckbox.
function inheritStateCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to inheritStateCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of inheritStateCheckbox
    if(get(hObject,'Value'))
        handles.orbit1Text.Enable = 'on';
        handles.optOrbit1Checkbox.Enable = 'on';
        
        handles.orbit2Text.Enable = 'on';
        handles.optOrbit2Checkbox.Enable = 'on';
        
        handles.orbit3Text.Enable = 'on';
        handles.optOrbit3Checkbox.Enable = 'on';
        
        handles.orbit4Text.Enable = 'on';
        handles.optOrbit4Checkbox.Enable = 'on';
        
        handles.orbit5Text.Enable = 'on';
        handles.optOrbit5Checkbox.Enable = 'on';
        
        handles.orbit6Text.Enable = 'on';
        handles.optOrbit6Checkbox.Enable = 'on';
        
        optOrbit1Checkbox_Callback(handles.optOrbit1Checkbox, [], handles);
        optOrbit2Checkbox_Callback(handles.optOrbit2Checkbox, [], handles);
        optOrbit3Checkbox_Callback(handles.optOrbit3Checkbox, [], handles);
        optOrbit4Checkbox_Callback(handles.optOrbit4Checkbox, [], handles);
        optOrbit5Checkbox_Callback(handles.optOrbit5Checkbox, [], handles);
        optOrbit6Checkbox_Callback(handles.optOrbit6Checkbox, [], handles);
    else
        handles.orbit1Text.Enable = 'off';
        handles.optOrbit1Checkbox.Enable = 'off';
        
        handles.orbit2Text.Enable = 'off';
        handles.optOrbit2Checkbox.Enable = 'off';
        
        handles.orbit3Text.Enable = 'off';
        handles.optOrbit3Checkbox.Enable = 'off';
        
        handles.orbit4Text.Enable = 'off';
        handles.optOrbit4Checkbox.Enable = 'off';
        
        handles.orbit5Text.Enable = 'off';
        handles.optOrbit5Checkbox.Enable = 'off';
        
        handles.orbit6Text.Enable = 'off';
        handles.optOrbit6Checkbox.Enable = 'off';
        
        handles.orbit1LbText.Enable = 'off';
        handles.orbit1UbText.Enable = 'off';
        
        handles.orbit2LbText.Enable = 'off';
        handles.orbit2UbText.Enable = 'off';
        
        handles.orbit3LbText.Enable = 'off';
        handles.orbit3UbText.Enable = 'off';
        
        handles.orbit4LbText.Enable = 'off';
        handles.orbit4UbText.Enable = 'off';
        
        handles.orbit5LbText.Enable = 'off';
        handles.orbit5UbText.Enable = 'off';
        
        handles.orbit6LbText.Enable = 'off';
        handles.orbit6UbText.Enable = 'off';
    end
    

% --- Executes on button press in inheritTimeCheckbox.
function inheritTimeCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to inheritTimeCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of inheritTimeCheckbox
    if(get(hObject,'Value'))
        handles.utText.Enable = 'on';
        handles.optUtCheckbox.Enable = 'on';
        
        optUtCheckbox_Callback(handles.optUtCheckbox, [], handles);
    else
        handles.utText.Enable = 'off';
        handles.optUtCheckbox.Enable = 'off';
        
        handles.utLbText.Enable = 'off';
        handles.utUbText.Enable = 'off';
    end
    
    

% --- Executes on selection change in elementSetCombo.
function elementSetCombo_Callback(hObject, eventdata, handles)
% hObject    handle to elementSetCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns elementSetCombo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from elementSetCombo
    contents = cellstr(get(hObject,'String'));
    sel = contents{get(hObject,'Value')};
    [~, elemSetEnum] = ElementSetEnum.getIndForName(sel);
    
    elemNames = elemSetEnum.elemNames;
    unitNames = elemSetEnum.unitNames;
    
    handles.orbit1Label.String = elemNames{1};
    handles.orbit2Label.String = elemNames{2};
    handles.orbit3Label.String = elemNames{3};
    handles.orbit4Label.String = elemNames{4};
    handles.orbit5Label.String = elemNames{5};
    handles.orbit6Label.String = elemNames{6};
    
    handles.orbit1UnitLabel.String = unitNames{1};
    handles.orbit2UnitLabel.String = unitNames{2};
    handles.orbit3UnitLabel.String = unitNames{3};
    handles.orbit4UnitLabel.String = unitNames{4};
    handles.orbit5UnitLabel.String = unitNames{5};
    handles.orbit6UnitLabel.String = unitNames{6};
    
    curElemSet = getappdata(handles.lvd_EditInitialStateGUI,'curElemSet');
    
    try
        switch elemSetEnum
            case ElementSetEnum.CartesianElements
                newElemSet = curElemSet.convertToCartesianElementSet();

            case ElementSetEnum.KeplerianElements
                newElemSet = curElemSet.convertToKeplerianElementSet();

            case ElementSetEnum.GeographicElements
                newElemSet = curElemSet.convertToGeographicElementSet();

            otherwise
                error('Unknown element set type: %s', class(elemSetEnum));
        end
        
        elemVect = newElemSet.getElementVector();
        
        if(any(isnan(elemVect)) || any(not(isfinite(elemVect))))
            error('State conversion resulted in NaN or Inf');
        end        
        
        handles.orbit1Text.String = fullAccNum2Str(elemVect(1));
        handles.orbit2Text.String = fullAccNum2Str(elemVect(2));
        handles.orbit3Text.String = fullAccNum2Str(elemVect(3));
        handles.orbit4Text.String = fullAccNum2Str(elemVect(4));
        handles.orbit5Text.String = fullAccNum2Str(elemVect(5));
        handles.orbit6Text.String = fullAccNum2Str(elemVect(6));

        setappdata(handles.lvd_EditInitialStateGUI,'curElemSet', newElemSet);
        
    catch ME
        updateValuesInState(handles);
        msgbox('Error converting state to new element set.','Conversion Error','error');
    end

% --- Executes during object creation, after setting all properties.
function elementSetCombo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elementSetCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function updateStateDueToFrameChange(handles)
    lvdData = getappdata(handles.lvd_EditInitialStateGUI,'lvdData');
    celBodyData = lvdData.celBodyData;

    curElemSet = getappdata(handles.lvd_EditInitialStateGUI,'curElemSet');
    
    bodyInfo = getSelectedBodyInfo(handles);
    
    contents = cellstr(get(handles.refFrameTypeCombo,'String'));
    selFrameType = contents{get(handles.refFrameTypeCombo,'Value')};
    refFrameEnum = ReferenceFrameEnum.getEnumForListboxStr(selFrameType);
    
    switch refFrameEnum
        case ReferenceFrameEnum.BodyCenteredInertial
            newFrame = BodyCenteredInertialFrame(bodyInfo, celBodyData);

        case ReferenceFrameEnum.BodyFixedRotating
            newFrame = BodyFixedFrame(bodyInfo, celBodyData);

        otherwise
            error('Unknown reference frame type: %s', class(refFrameEnum));                
    end
    
    try
        newElemSet = curElemSet.convertToFrame(newFrame);

        elemVect = newElemSet.getElementVector();
        
        if(any(isnan(elemVect)) || any(not(isfinite(elemVect))))
            error('State conversion resulted in NaN');
        end
        
        handles.orbit1Text.String = fullAccNum2Str(elemVect(1));
        handles.orbit2Text.String = fullAccNum2Str(elemVect(2));
        handles.orbit3Text.String = fullAccNum2Str(elemVect(3));
        handles.orbit4Text.String = fullAccNum2Str(elemVect(4));
        handles.orbit5Text.String = fullAccNum2Str(elemVect(5));
        handles.orbit6Text.String = fullAccNum2Str(elemVect(6));

        setappdata(handles.lvd_EditInitialStateGUI,'curElemSet', newElemSet);
    catch ME
        updateValuesInState(handles);
        msgbox('Error converting state to new frame.','Conversion Error','error');
    end
    
function updateValuesInState(handles)
    curElemSet = getappdata(handles.lvd_EditInitialStateGUI,'curElemSet');
    newElemSet = curElemSet;
    
    time = str2double(handles.utText.String);
    orbit1Elem = str2double(handles.orbit1Text.String);
    orbit2Elem = str2double(handles.orbit2Text.String);
    orbit3Elem = str2double(handles.orbit3Text.String);
    orbit4Elem = str2double(handles.orbit4Text.String);
    orbit5Elem = str2double(handles.orbit5Text.String);
    orbit6Elem = str2double(handles.orbit6Text.String);
    
    frame = newElemSet.frame;
	switch newElemSet.typeEnum
        case ElementSetEnum.CartesianElements
            newElemSet = CartesianElementSet(time, [orbit1Elem, orbit2Elem, orbit3Elem], [orbit4Elem, orbit5Elem, orbit6Elem], frame);

        case ElementSetEnum.KeplerianElements
            newElemSet = KeplerianElementSet(time, orbit1Elem, orbit2Elem, deg2rad(orbit3Elem), deg2rad(orbit4Elem), deg2rad(orbit5Elem), deg2rad(orbit6Elem), frame);

        case ElementSetEnum.GeographicElements
            newElemSet = GeographicElementSet(time, deg2rad(orbit1Elem), deg2rad(orbit2Elem), orbit3Elem, deg2rad(orbit4Elem), deg2rad(orbit5Elem), orbit6Elem, frame);
                
        otherwise
            error('Unknown element set type: %s', class(elemSetEnum));
	end
    
    setappdata(handles.lvd_EditInitialStateGUI,'curElemSet', newElemSet);


% --- Executes on selection change in centralBodyCombo.
function centralBodyCombo_Callback(hObject, eventdata, handles)
% hObject    handle to centralBodyCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns centralBodyCombo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from centralBodyCombo
    updateStateDueToFrameChange(handles);

% --- Executes during object creation, after setting all properties.
function centralBodyCombo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to centralBodyCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in refFrameTypeCombo.
function refFrameTypeCombo_Callback(hObject, eventdata, handles)
% hObject    handle to refFrameTypeCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns refFrameTypeCombo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from refFrameTypeCombo
    updateStateDueToFrameChange(handles);

% --- Executes during object creation, after setting all properties.
function refFrameTypeCombo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to refFrameTypeCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function utText_Callback(hObject, eventdata, handles)
% hObject    handle to utText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of utText as text
%        str2double(get(hObject,'String')) returns contents of utText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function utText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to utText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in optUtCheckbox.
function optUtCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to optUtCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of optUtCheckbox
    if(get(hObject,'Value') && get(handles.inheritTimeCheckbox,'Value'))
        handles.utLbText.Enable = 'on';
        handles.utUbText.Enable = 'on';
    else
        handles.utLbText.Enable = 'off';
        handles.utUbText.Enable = 'off';
    end


function utLbText_Callback(hObject, eventdata, handles)
% hObject    handle to utLbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of utLbText as text
%        str2double(get(hObject,'String')) returns contents of utLbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function utLbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to utLbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function utUbText_Callback(hObject, eventdata, handles)
% hObject    handle to utUbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of utUbText as text
%        str2double(get(hObject,'String')) returns contents of utUbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function utUbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to utUbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit1Text_Callback(hObject, eventdata, handles)
% hObject    handle to orbit1Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit1Text as text
%        str2double(get(hObject,'String')) returns contents of orbit1Text as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit1Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit1Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in optOrbit1Checkbox.
function optOrbit1Checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to optOrbit1Checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of optOrbit1Checkbox
    if(get(hObject,'Value') && get(handles.inheritStateCheckbox,'Value'))
        handles.orbit1LbText.Enable = 'on';
        handles.orbit1UbText.Enable = 'on';
    else
        handles.orbit1LbText.Enable = 'off';
        handles.orbit1UbText.Enable = 'off';
    end


function orbit1LbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit1LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit1LbText as text
%        str2double(get(hObject,'String')) returns contents of orbit1LbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit1LbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit1LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit1UbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit1UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit1UbText as text
%        str2double(get(hObject,'String')) returns contents of orbit1UbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit1UbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit1UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit2Text_Callback(hObject, eventdata, handles)
% hObject    handle to orbit2Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit2Text as text
%        str2double(get(hObject,'String')) returns contents of orbit2Text as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit2Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit2Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in optOrbit2Checkbox.
function optOrbit2Checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to optOrbit2Checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of optOrbit2Checkbox
    if(get(hObject,'Value') && get(handles.inheritStateCheckbox,'Value'))
        handles.orbit2LbText.Enable = 'on';
        handles.orbit2UbText.Enable = 'on';
    else
        handles.orbit2LbText.Enable = 'off';
        handles.orbit2UbText.Enable = 'off';
    end



function orbit2LbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit2LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit2LbText as text
%        str2double(get(hObject,'String')) returns contents of orbit2LbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit2LbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit2LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit2UbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit2UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit2UbText as text
%        str2double(get(hObject,'String')) returns contents of orbit2UbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit2UbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit2UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit3Text_Callback(hObject, eventdata, handles)
% hObject    handle to orbit3Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit3Text as text
%        str2double(get(hObject,'String')) returns contents of orbit3Text as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit3Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit3Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in optOrbit3Checkbox.
function optOrbit3Checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to optOrbit3Checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of optOrbit3Checkbox
    if(get(hObject,'Value') && get(handles.inheritStateCheckbox,'Value'))
        handles.orbit3LbText.Enable = 'on';
        handles.orbit3UbText.Enable = 'on';
    else
        handles.orbit3LbText.Enable = 'off';
        handles.orbit3UbText.Enable = 'off';
    end



function orbit3LbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit3LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit3LbText as text
%        str2double(get(hObject,'String')) returns contents of orbit3LbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit3LbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit3LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit3UbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit3UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit3UbText as text
%        str2double(get(hObject,'String')) returns contents of orbit3UbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit3UbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit3UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit4Text_Callback(hObject, eventdata, handles)
% hObject    handle to orbit4Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit4Text as text
%        str2double(get(hObject,'String')) returns contents of orbit4Text as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit4Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit4Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in optOrbit4Checkbox.
function optOrbit4Checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to optOrbit4Checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of optOrbit4Checkbox
    if(get(hObject,'Value') && get(handles.inheritStateCheckbox,'Value'))
        handles.orbit4LbText.Enable = 'on';
        handles.orbit4UbText.Enable = 'on';
    else
        handles.orbit4LbText.Enable = 'off';
        handles.orbit4UbText.Enable = 'off';
    end


function orbit4LbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit4LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit4LbText as text
%        str2double(get(hObject,'String')) returns contents of orbit4LbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit4LbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit4LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit4UbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit4UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit4UbText as text
%        str2double(get(hObject,'String')) returns contents of orbit4UbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit4UbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit4UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit5Text_Callback(hObject, eventdata, handles)
% hObject    handle to orbit5Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit5Text as text
%        str2double(get(hObject,'String')) returns contents of orbit5Text as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit5Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit5Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in optOrbit5Checkbox.
function optOrbit5Checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to optOrbit5Checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of optOrbit5Checkbox
    if(get(hObject,'Value') && get(handles.inheritStateCheckbox,'Value'))
        handles.orbit5LbText.Enable = 'on';
        handles.orbit5UbText.Enable = 'on';
    else
        handles.orbit5LbText.Enable = 'off';
        handles.orbit5UbText.Enable = 'off';
    end


function orbit5LbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit5LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit5LbText as text
%        str2double(get(hObject,'String')) returns contents of orbit5LbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit5LbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit5LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit5UbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit5UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit5UbText as text
%        str2double(get(hObject,'String')) returns contents of orbit5UbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit5UbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit5UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit6Text_Callback(hObject, eventdata, handles)
% hObject    handle to orbit6Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit6Text as text
%        str2double(get(hObject,'String')) returns contents of orbit6Text as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit6Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit6Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in optOrbit6Checkbox.
function optOrbit6Checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to optOrbit6Checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of optOrbit6Checkbox
    if(get(hObject,'Value') && get(handles.inheritStateCheckbox,'Value'))
        handles.orbit6LbText.Enable = 'on';
        handles.orbit6UbText.Enable = 'on';
    else
        handles.orbit6LbText.Enable = 'off';
        handles.orbit6UbText.Enable = 'off';
    end


function orbit6LbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit6LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit6LbText as text
%        str2double(get(hObject,'String')) returns contents of orbit6LbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit6LbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit6LbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orbit6UbText_Callback(hObject, eventdata, handles)
% hObject    handle to orbit6UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orbit6UbText as text
%        str2double(get(hObject,'String')) returns contents of orbit6UbText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);

% --- Executes during object creation, after setting all properties.
function orbit6UbText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orbit6UbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on lvd_EditActionSetKinematicStateGUI or any of its controls.
function lvd_EditActionSetKinematicStateGUI_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lvd_EditActionSetKinematicStateGUI (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
    switch(eventdata.Key)
        case 'return'
            saveAndCloseButton_Callback(handles.saveAndCloseButton, [], handles);
        case 'enter'
            saveAndCloseButton_Callback(handles.saveAndCloseButton, [], handles);
        case 'escape'
            close(handles.lvd_EditActionSetKinematicStateGUI);
    end