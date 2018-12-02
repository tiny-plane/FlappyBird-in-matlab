classdef motion_<handle
    properties
        initialised=0;        %初始化数据
        bird_height;          %鸟的高度
        bird_distance;        %已经水平移动的距离，与分数等有关，此数据共享
        timer;                %每一次飞行的计时器
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
            %obj 是motion对象
            %认为水平方向速度恒定，每gap_time=5迭代次数可以通过一个障碍物
            %制造出每飞行一次以45°斜上抛的飞行效果飞行高度和距离比为1:2，高10宽20，gap宽15，飞行动作精确到小数
            obj.numerical_handle.bird_height=obj.numerical_handle.bird_height-0.001*(obj.timer-15)^3;
            obj.timer=obj.timer+1;       
        end
    end
end