classdef data<handle
    properties
        initialised=0;
        graphic_handle;
        numerical_handle;
        motion_handle;
        judge_handle;
        stop_num=0;
    end
    methods
        function obj=data()
            if nargin==0
                %
            end
            obj.build_function;
        end
        function build_function(obj)
            obj.numerical_handle=numerical_;
            obj.graphic_handle=graphic_;
            obj.motion_handle=motion_;
            obj.judge_handle=judge_;
            obj.graphic_handle.numerical_handle=obj.numerical_handle;
            obj.motion_handle.numerical_handle=obj.numerical_handle;
            obj.judge_handle.numerical_handle=obj.numerical_handle;
            set(obj.graphic_handle.start,'UserData',obj);
            set(obj.graphic_handle.resume,'UserData',obj);
            obj.initialised=1;
            set(gcf,'WindowButtonDownFcn','ans.change_mouse');
        end
        function iterate_now(obj)
            i=0;
            while 1
                pause(0.02);
                if obj.stop_num==0 && obj.numerical_handle.hit==0
                    i=i+1;
                    obj.numerical_handle.bird_distance=i;
                    set(obj.graphic_handle.text_handle,'string',i);
                    obj.motion_handle.fresh_status;
                    obj.judge_handle.fresh_statue;
                    obj.graphic_handle.fresh_frame;
                elseif obj.numerical_handle.hit==1
                    set(obj.graphic_handle.text_handle,'string','you loss');
                    clear
                    clc
                    break
                end
            end
        end
        function change_mouse(obj)
            obj.motion_handle.timer=0;
        end
    end
end