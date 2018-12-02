classdef judge_<handle
    properties
        initialised=0;
        numerical_handle
    end
    methods
        function obj=judge_()
            if nargin==0
                %
            end
        end
        function fresh_statue(obj)
            temp=mod(obj.numerical_handle.bird_distance-20,40);
            if temp<=20
                if obj.numerical_handle.bird_height>=obj.numerical_handle.bar(2) || ...
                        obj.numerical_handle.bird_height<=obj.numerical_handle.bar(1)
                    obj.numerical_handle.hit=1;
                end
            end
        end
    end
end