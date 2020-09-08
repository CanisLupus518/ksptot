classdef ksptot_connect < ksp
    %KSPTOT_CONNECT Summary of this class goes here
    %   Detailed explanation goes here
    methods
        function checkConnection(this)
            try
              resolveip(this.host);
            catch ME
              error(getReport(ME,'extended','hyperlinks','off'));
            end
    
            try
              tcpipClient = createTcpIpClient(this.port, this.role, this.host);
              writeDataToKSPTOTConnect('ConnectionCheck', [1 2 3 4 5], 'd', tcpipClient);
           catch ME
              error(getReport(ME,'extended','hyperlinks','off'))
            end
            fclose(tcpipClient);
            delete(tcpipClient);
        end
        function guids = getVesselIDList(this)
            tcpipClient = createTcpIpClient(this.port, this.role, this.host);
            guids = readManyStringsFromKSPTOTConnect('GetVesselIDList', '', 32, true, tcpipClient);
            if(isempty(guids))
                error('Error reading vessels from KSP.');
            end
            fclose(tcpipClient);
            delete(tcpipClient);
        end
        function name = getVesselNameByGUID(this,guid)
            tcpipClient = createTcpIpClient(this.port, this.role, this.host);
            name = readStringFromKSPTOTConnect('GetVesselNameByGUID', guid, true, tcpipClient);
            fclose(tcpipClient);
            delete(tcpipClient);
        end
    end
end

