classdef graphic_<handle
    properties
        initialised=0;
        bar;
        step;             %每个障碍物距离其初始位置已经平移了多少，范围0~width/5;
        axes_w;           %画幅半宽度，数值为相对数值，非分辨率
        axes_h;           %画幅半高度，数值为相对数值，非分辨率
        figure_handle;    %窗口句柄，以备需要
        axes_handle;      %画图句柄
        vertices;         %障碍顶点
        numerical_handle; %数据类
        start
        resume;
        exit_pushbutton;
        text_handle;
    end
    methods
        function obj=graphic_()
            if nargin==0
                %
            end
            graphic_build(obj);
        end
        function graphic_build(obj)
            obj.bar=zeros(5,5);
            obj.step=0;
            %bar保存障碍物的信息，，每列分别表示 1：该障碍高度是否需要刷新，2：该列所处的横向位置，与distance有关
            %3：上障碍物的高度，4：下障碍物的高度，5：保留位
            %横向位置表示的是该障碍物左侧的位置，上障碍是下侧距中立位置的距离，下障碍是上侧距中立位置的距离
            obj.axes_h=50;
            obj.axes_w=100;
            obj.bar(1,:)=0;
            obj.bar(2,:)=[-60,-20,20,60,100]';
            for i=1:5
                obj.bar(3,i)=10+30*rand(1,1);
                obj.bar(4,i)=-10-30*rand(1,1);
            end
            obj.vertices=zeros(5,2,8,2);    %五个障碍组，每个有上下两个，需要8个点确认位置，两个坐标
            initialise_frame(obj);
        end
        function fresh_statue(obj)
            %             obj.step=obj.step+1;
            %             if obj.step>40
            %                 obj.step=0;
            %             end
            obj.bar(2,:)=obj.bar(2,:)-1;
            for i=1:5
                if obj.bar(2,i)<=-100
                    obj.bar(2,i)=100;
                    obj.bar(3,i)=10+30*rand(1,1);
                    obj.bar(4,i)=-10-30*rand(1,1);
                end
            end
            bar_vertices_build(obj);
            obj.numerical_handle.bar(1:2)=[obj.bar(4,3),obj.bar(3,3)];
        end
        %%
        %绘图核心函数
        function initialise_frame(obj)
            screen=get(0,'screensize');
            w=screen(3);
            h=screen(4);
            obj.figure_handle=figure('color',[0.6,0.6,0.6],'Position',...         %建立主界面
                [0,0.05*h,w,0.91*h],'name','flappy girl',...
                'numbertitle','off','menubar','none');
            obj.axes_handle=axes('parent',obj.figure_handle,'position',[0,0,0.8,0.9]);
            obj.start=uicontrol(obj.figure_handle,'Style', 'pushbutton', 'Units','normalized','String', '开始',...
                'Position', [0.85,0.5,0.1,0.05],...
                'Callback', @callback_start,'FontSize',11);
            obj.resume=uicontrol(obj.figure_handle,'Style', 'pushbutton', 'Units','normalized','String', '暂停',...
                'Position', [0.85,0.4,0.1,0.05],...
                'Callback', @callback_resume,'FontSize',11);
            obj.exit_pushbutton=uicontrol(obj.figure_handle,'Style', 'pushbutton', 'Units','normalized','String', '退出',...
                'Position', [0.85,0.3,0.1,0.05],...
                'Callback', @callback_exit,'FontSize',11);
            uicontrol(obj.figure_handle,'style','Text','Units','normalized',...
                'Position',[0.85,0.8,0.1,0.05],'string','分数',...
                'Back',[0.6,0.6,0.6],'FontSize',11);
            obj.text_handle=uicontrol(obj.figure_handle,'style','Text','Units','normalized',...
                'Position',[0.85,0.7,0.1,0.05],'string','0',...
                'Back',[0.6,0.6,0.6],'FontSize',11);
            hold on;                                                    %设立参数和绘制方案
            axis([-obj.axes_w,obj.axes_w,-obj.axes_h,obj.axes_h]);
            plot(-100,-100,'markersize',15)
            axis manual
            grid off 
            box off
            axis off
            set(obj.axes_handle,'XTickLabel','','YTickLabel','');
            set(obj.figure_handle,'doublebuffer','on');
            cla
            %可以固定是个图像，只改变每个顶点的坐标
            fresh_statue(obj);
            for i=1:5
                for j=1:2
                    patch(squeeze(obj.vertices(i,j,1:8,1)),squeeze(obj.vertices(i,j,1:8,2)),'green')
                end
            end
        end
        function fresh_frame(obj)
            cla
            %可以固定是个图像，只改变每个顶点的坐标
            fresh_statue(obj);
            for i=1:5
                for j=1:2
                    patch(squeeze(obj.vertices(i,j,1:8,1)),squeeze(obj.vertices(i,j,1:8,2)),'green')
                end
            end
            
            plot(0,obj.numerical_handle.bird_height,'.','markersize',70);
        end
        function bar_vertices_build(obj)
            for i=1:5
                % 障碍数 1下2上 点数 1x2y
                obj.vertices(i,1,1,1)=obj.bar(2,i);
                obj.vertices(i,1,1,2)=obj.bar(4,i);
                obj.vertices(i,2,4,1)=obj.bar(2,i);
                obj.vertices(i,2,4,2)=obj.bar(3,i);
                obj.vertices(i,1,2,1)=obj.vertices(i,1,1,1);
                obj.vertices(i,1,3,1)=obj.vertices(i,1,1,1)+2;
                obj.vertices(i,1,4,1)=obj.vertices(i,1,1,1)+2;
                obj.vertices(i,1,5,1)=obj.vertices(i,1,1,1)+13;
                obj.vertices(i,1,6,1)=obj.vertices(i,1,1,1)+13;
                obj.vertices(i,1,7,1)=obj.vertices(i,1,1,1)+15;
                obj.vertices(i,1,8,1)=obj.vertices(i,1,1,1)+15;
                %
                obj.vertices(i,1,2,2)=obj.vertices(i,1,1,2)-2;
                obj.vertices(i,1,3,2)=obj.vertices(i,1,1,2)-2;
                obj.vertices(i,1,4,2)=-obj.axes_h;
                obj.vertices(i,1,5,2)=-obj.axes_h;
                obj.vertices(i,1,6,2)=obj.vertices(i,1,1,2)-2;
                obj.vertices(i,1,7,2)=obj.vertices(i,1,1,2)-2;
                obj.vertices(i,1,8,2)=obj.vertices(i,1,1,2);
                %
                obj.vertices(i,2,1,1)=obj.vertices(i,2,4,1)+2;
                obj.vertices(i,2,2,1)=obj.vertices(i,2,4,1)+2;
                obj.vertices(i,2,3,1)=obj.vertices(i,2,4,1);
                obj.vertices(i,2,5,1)=obj.vertices(i,2,4,1)+15;
                obj.vertices(i,2,6,1)=obj.vertices(i,2,4,1)+15;
                obj.vertices(i,2,7,1)=obj.vertices(i,2,4,1)+13;
                obj.vertices(i,2,8,1)=obj.vertices(i,2,4,1)+13;
                %
                obj.vertices(i,2,1,2)=obj.axes_h;
                obj.vertices(i,2,2,2)=obj.vertices(i,2,4,2)+2;
                obj.vertices(i,2,3,2)=obj.vertices(i,2,4,2)+2;
                obj.vertices(i,2,5,2)=obj.vertices(i,2,4,2);
                obj.vertices(i,2,6,2)=obj.vertices(i,2,4,2)+2;
                obj.vertices(i,2,7,2)=obj.vertices(i,2,4,2)+2;
                obj.vertices(i,2,8,2)=obj.axes_h;
            end
        end
    end
end