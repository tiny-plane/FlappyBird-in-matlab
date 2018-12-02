classdef numerical_<handle
    properties
        initialised=0;
        bird_height=0;
        bird_distance=0;
        timer;
        bar;
        hit=0;
    end
    methods
        function obj=numerical_()
            if nargin==0
                %
            end
            obj.bird_height=0;
            obj.bird_distance=0;
            obj.bar=zeros(2);
        end
    end
end