classdef ksp < handle
    %KSP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        port
        role
        host
    end
    
    methods
        function obj = ksp(host,port,role)
            %KSP Construct an instance of this class
            %   Detailed explanation goes here
            obj.host = host;
            obj.port = port;
            obj.role = role;
        end
        function setHost(this,host)
            this.host = host;
        end
    end
    
    methods(Abstract)
       checkConnection(this);
       getVesselIDList(this);
       getVesselNameByGUID(this,guid);
       
    end
end

