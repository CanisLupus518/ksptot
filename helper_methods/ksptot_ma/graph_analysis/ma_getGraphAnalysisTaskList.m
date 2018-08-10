function [taskList] = ma_getGraphAnalysisTaskList(excludeList)
%ma_getGraphAnalysisTaskList Summary of this function goes here
%   Detailed explanation goes here
    taskList = {};

    taskList{end+1} = 'Universal Time';
    taskList{end+1} = 'Body-centric Position (X)';
    taskList{end+1} = 'Body-centric Position (Y)';
    taskList{end+1} = 'Body-centric Position (Z)';
    taskList{end+1} = 'Body-centric Velocity (X)';
    taskList{end+1} = 'Body-centric Velocity (Y)';
    taskList{end+1} = 'Body-centric Velocity (Z)';
    taskList{end+1} = 'Sun-centric Position (X)';
    taskList{end+1} = 'Sun-centric Position (Y)';
    taskList{end+1} = 'Sun-centric Position (Z)';
    taskList{end+1} = 'Semi-major Axis';
    taskList{end+1} = 'Eccentricity';
    taskList{end+1} = 'Inclination';
    taskList{end+1} = 'Right Asc. of the Asc. Node';
    taskList{end+1} = 'Argument of Periapsis';
    taskList{end+1} = 'True Anomaly';
    taskList{end+1} = 'Mean Anomaly';
    taskList{end+1} = 'Orbital Period';
    taskList{end+1} = 'Radius of Periapsis';
    taskList{end+1} = 'Radius of Apoapsis';
    taskList{end+1} = 'Radius of Spacecraft';
    taskList{end+1} = 'Altitude of Apoapsis';
    taskList{end+1} = 'Altitude of Periapsis';
    taskList{end+1} = 'Speed of Spacecraft';
    taskList{end+1} = 'Longitude (East)';
    taskList{end+1} = 'Latitude (North)';
    taskList{end+1} = 'Longitudinal Drift Rate';
    taskList{end+1} = 'Altitude';
    taskList{end+1} = 'Surface Velocity';
    taskList{end+1} = 'Vertical Velocity';
    taskList{end+1} = 'Solar Beta Angle';
    taskList{end+1} = 'Distance to Ref. Celestial Body';
    taskList{end+1} = 'Distance to Ref. Spacecraft';
    taskList{end+1} = 'Distance to Ref. Station';
    taskList{end+1} = 'Relative Vel. to Ref. Spacecraft';
    taskList{end+1} = 'Relative Pos. of Ref. Spacecraft (In-Track)';
    taskList{end+1} = 'Relative Pos. of Ref. Spacecraft (Cross-Track)';
    taskList{end+1} = 'Relative Pos. of Ref. Spacecraft (Radial)';
    taskList{end+1} = 'Relative Pos. of Ref. Spacecraft (In-Track; Ref. SC-centered)';
    taskList{end+1} = 'Relative Pos. of Ref. Spacecraft (Cross-Track; Ref. SC-centered)';
    taskList{end+1} = 'Relative Pos. of Ref. Spacecraft (Radial; Ref. SC-centered)';
    taskList{end+1} = 'Relative SMA of Ref. Spacecraft';
    taskList{end+1} = 'Relative Eccentricity of Ref. Spacecraft';
    taskList{end+1} = 'Relative Inclination of Ref. Spacecraft';
    taskList{end+1} = 'Relative RAAN of Ref. Spacecraft';
    taskList{end+1} = 'Relative Argument of Periapsis of Ref. Spacecraft';
    taskList{end+1} = 'Elevation Angle w.r.t. Ref. Station';
    taskList{end+1} = 'Distance Traveled';
    taskList{end+1} = 'Line of Sight to Ref. Spacecraft';
    taskList{end+1} = 'Line of Sight to Ref. Station';
    taskList{end+1} = 'Equinoctial H1';
    taskList{end+1} = 'Equinoctial K1';
    taskList{end+1} = 'Equinoctial H2';
    taskList{end+1} = 'Equinoctial K2';
    taskList{end+1} = 'Central Body ID';
    taskList{end+1} = 'Liquid Fuel/Ox Mass';
    taskList{end+1} = 'Monopropellant Mass';
    taskList{end+1} = 'Xenon Mass';
    taskList{end+1} = 'Dry Mass';
    taskList{end+1} = 'Total Spacecraft Mass';
    taskList{end+1} = 'Eclipse';
    taskList{end+1} = 'Hyperbolic Velocity Unit Vector X';
    taskList{end+1} = 'Hyperbolic Velocity Unit Vector Y';
    taskList{end+1} = 'Hyperbolic Velocity Unit Vector Z';
    taskList{end+1} = 'Hyperbolic Velocity Vector Right Ascension';
    taskList{end+1} = 'Hyperbolic Velocity Vector Declination';
    taskList{end+1} = 'Hyperbolic Velocity Magnitude';
    
    taskList = setdiff(taskList,excludeList);
end

