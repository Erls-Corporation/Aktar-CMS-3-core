@version[]
2008-09-21	Foodzy

@swapcontent_settings[opt]
$result[^table::create{param	type	default	descr
path	string		������ ��� �����������}]

@swapcontent_info[set]
��� ������������ ������������ ��� ����, ����� ��������� � ������ ������ ���������� ������ �������.
���� �������� ������ ������ ��� �����������, ����� �������������� ����������� �� ��������� ��� ������� �����.
��������, ���������������� �������� �������, ��������������� � �������� ����������.

@swapcontent[set]

^if(def ^cando[editor $epermission]){
^msg[��� �������� ���������� ��������. ����������, ������� ����������, ����� ���������� �� ����, ��� ����� ������������.]
}

@swap_path[base][url]
^connect[$scs]{
$url[${base}$cookie:fdzcity]
^if(!def $form:p && !def $form:editcontent && 
def ^string:sql{SELECT path FROM ^dtp[structure] WHERE path = '$url' LIMIT 1}[$.default{}]){
	$result[$url]
}{
	$result[$base]
}

}
