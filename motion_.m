classdef motion_<handle
    properties
        initialised=0;        %��ʼ������
        bird_height;          %��ĸ߶�
        bird_distance;        %�Ѿ�ˮƽ�ƶ��ľ��룬��������йأ������ݹ���
        timer;                %ÿһ�η��еļ�ʱ��
        numerical_handle;
    end
    methods
        function obj=motion_()
            if nargin==0
                %
            end
            obj.bird_height=0;
            obj.timer=0;
        end
        function fresh_status(obj)
            %obj ��motion����
            %��Ϊˮƽ�����ٶȺ㶨��ÿgap_time=5������������ͨ��һ���ϰ���
            %�����ÿ����һ����45��б���׵ķ���Ч�����и߶Ⱥ;����Ϊ1:2����10��20��gap��15�����ж�����ȷ��С��
            obj.numerical_handle.bird_height=obj.numerical_handle.bird_height-0.001*(obj.timer-15)^3;
            obj.timer=obj.timer+1;       
        end
    end
end