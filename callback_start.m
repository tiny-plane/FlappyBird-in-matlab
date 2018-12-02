function callback_start(hObject,eventdata)
obj=get(hObject,'UserData');
set(obj.graphic_handle.start,'enable','off');
obj.iterate_now;
end