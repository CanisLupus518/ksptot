clc; clear variables; format long g; close all;

%Include matlabrc, hopefully
%#function matlabrc

%set pathes if not deployed
if(~isdeployed) 
    addpath(genpath('helper_methods'));
    addpath(genpath('formsGUIs'));
    addpath(genpath('kspTOT_RTS'));
    addpath(genpath('kspTOT_MissionArchitect'));
    addpath(genpath('kspTOT_LaunchVehicleDesigner'));
    addpath(genpath('kspTOT_VehicleSizer'));
    addpath(genpath('kspTOT_SingleUIs'));
%     addpath('zArchive');
end

%set look and feel if deployed
if(isdeployed)
    if(ispc)
        javax.swing.UIManager.setLookAndFeel(com.sun.java.swing.plaf.windows.WindowsLookAndFeel);
    elseif(isunix)
        javax.swing.UIManager.setLookAndFeel(com.jgoodies.looks.plastic.Plastic3DLookAndFeel);
    elseif(ismac)
        javax.swing.UIManager.setLookAndFeel(com.apple.laf.AquaLookAndFeel);
    end
end

%display splashscreen
hS = splashScreenGUI(); drawnow;
t = tic;

%Initialize KSPTOT options
doesAppOptionsFileExist = exist('appOptions.ini','file');
if(doesAppOptionsFileExist)
    [appOptionsFromINI,~,~] = inifile('appOptions.ini','readall');
    appOptionsFromINI = addMissingAppOptionsRows(appOptionsFromINI);
else
    appOptionsFromINI = createDefaultKsptotOptions();
    inifile('appOptions.ini','write',appOptionsFromINI);
end
appOptions = processINIBodyInfo(appOptionsFromINI, false, 'appOptions'); %turns out this function works for other ini files too lol!

%Initalize KSP celestial body data
if(isprop(appOptions.ksptot,'bodiesinifile') && ~isempty(appOptions.ksptot.bodiesinifile) && exist(appOptions.ksptot.bodiesinifile,'file'))
    [celBodyDataFromINI,~,~] = inifile(appOptions.ksptot.bodiesinifile,'readall');
else
    [celBodyDataFromINI,~,~] = inifile('bodies.ini','readall');
end
celBodyData = processINIBodyInfo(celBodyDataFromINI, false, 'bodyInfo');
celBodyData = CelestialBodyData(celBodyData);
[goodTF, celBodyWarnMsgs] = verifyCelBodyData(celBodyData);  
bodyNames = fieldnames(celBodyData);

if(not(goodTF))
    msg = {sprintf('Potential issues were found with the loaded celestial body information: \n')};
    for(i=1:length(celBodyWarnMsgs))
        msg{end+1} = sprintf('\t%s\n', celBodyWarnMsgs{i}); %#ok<SAGROW>
    end
    
    msgbox(msg,'Celestial Body Data Warnings','warn');
end

%Pause for some time to show the splash screen
while(toc(t) < 1)
    pause(0.1);
end

%Set up the GUI for use
mainGUIHandle = mainGUI(celBodyData, bodyNames, hS, appOptions);
if(isgraphics(hS))
    close(hS);
end