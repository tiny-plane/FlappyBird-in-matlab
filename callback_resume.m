function callback_resume(hObject,eventdata)
obj=get(hObject,'UserData');
if obj.stop_num==0
    obj.stop_num=1;
    set(obj.graphic_handle.resume,'String','¼ÌÐø')
else
    obj.stop_num=0;
    set(obj.graphic_handle.resume,'String','ÔÝÍ£')
end
end