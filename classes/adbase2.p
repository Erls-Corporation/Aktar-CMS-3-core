
@notes----[]
��������� ���������� ������� � ��������� � ������������ ��������� ������ (����� �����������), 
� ������� ����������� �����. ������������ (��������� ���� � �������)
������������� � ����� ������������ ����� ����� ���� ��������� ������ ����� 
�������� �������� (�.�. ����� � ���� ���� id=xxx)
������ ����� �� ������������ ���� �� ���������������
�� �������� �������� � ��������� ������ �� ��� ������� � ������ ����������������� ��������
���������������� ������� ����� ����������� �������, ����� ��� ����� �������� ����������.
����� �������� ���: <���������������������/> ����� ����� ���������� � ������ ������.
������: � �������� ����� "������ ���� <person35/> ������ ���������..." 
����� ����� ����� �������, ����� ����������� ��������� �� � ������������ ������
��� ���� ����������� ������ �� ������ � ������ ����. ����� �� ����� ��� ������ ��������.
����� ��������� ���������� ������������ � �����-���� ������ (�� ������� � �� ������),
����� ��������� � ��� ������� � ��������� ����� [comments]

��������� ����������� (��� ������������): 
- �������� �����: ������ ad-base.p, �� ��������� ����� ���.������, ������ � datawork.p
- /custom/adbase.p - ����� �������
- /classes/adb_search.p - ����� �� ���.��������
- classes/adbase2.p - ����������� ��� ��������� ������ (��. ���� �� datawork)
����������� �������� �������� � ���, ��� � ��� ������������� ������ ��� ����������, � �� ��������.
� �����, ��� ��� �����������, ��������� � ������� �� ������. 

� ���������
- ��������� � 2 � ����� ����� ��������� ���������
- ������ � ������ (����� �������) - ����� �������� �����. ��������, ������ �������� ������� ��� ����.����
- �������� ��������� ����������� ���������
- ���������� ������ �������� ���� �� ������: ������ ������� ����� �� ����, ���������� ������ ����� ���� � ������ ����������, ��� ������ ���������� �������� ������ �������� ������ � ���������, � ���� �� + ��� ����� ����� �������� ��� �������������. ��������: ������ ������ ��� ������� ��������� ������������ �������
- ������� "�������� �� �����������" ������ ����� ������������ � ������ �������, �.�. ������� ������������ ������ ������������, ����������������� ������������ ��� �������/��������� ������, � ��� �� ���������. ����� ����, ����������� ������� ����������� ��� �� ������� (���� ������ ������ ������� 2 ��������� ������� + 1 �� ���� + 4-7 ��� ������ ���������� + 1 ��� ������������!!) ����������� ������ � ����� ������� ���������� �������, ��������������� ������. ���� ������ ��������� ��� �� �����, ��������� ��������� ������ ������������ ������ �� ����� ����������. �� ����� ������� ��������� � ����� �����������.
- ���������� �������, ���� � �.�. ���� ���-�� �������. ������ ��� ������������� ��� ������ �������?
������� ������ "���������"
- ������������, � ����� ������� ������ ��������� ��������� - ������� ��� ������� �����. ������� � ���, ��� ������� ���� ������, � ���������� ������� ����� ��������-�������� ������

������� ����������� �� ����� � ������ "�������", �������� �������� �� ����� � ������ "�������������", ����� � ������������ ����������� �� ����� � ������ "�������� �������"
��������-������� �������� �� ��� ����� ��� ������� ������� �����, ��. ��
!! ������ ����� �����!

� ������� "�����������" ��� ������ ���������� "������� �����������" �������� ��, �� � ����� ������ ��������
� ��������� ��� ����������� ���������
http://aktar-master/useful/links ����� ������
����� � ���������� ���������??

#������ �������� - �� ����� ����� ������� ��� ��� ��
#������� �������� ����� ������� ������ � ���� � ���� ����� �� ����� ������

����: 
5. ������������ USERDATA � CFORUM � ��������!!!!!! � ����?

@allowed[]
tags comments populars memories announcer myrecords tabled_header1

@myrecords[arg;a2][watchin;myt;hd]
^if(def $user.id){
$watchin[^table::load[/my/config/adbase_tables.txt]]
$watchin[^watchin.select(^watchin.cls.pos[u]>=0)]
^use[modinfo.p]
$newad[^modinfo::create[ad-base.p]]
^connect[$scs]{
^watchin.menu{
$myt[^table::sql{SELECT ^sr_out[$watchin.adt] AS name, path, id, moderated FROM ^dtp[$watchin.adt] WHERE ^if(def ^cando[editor base-editor]){moderated != 'yes'}{editby = '$MAIN:userid'}   }]
	<h3>$watchin.name</h3>
	^myt.menu{
	<a href="^myt.path.match[action=show][ig]{action=edit}"><img src="/login/img/edit.gif" border=0></a>
	<a href="$myt.path">^untaint{$myt.name} $myt.id ^if($myt.moderated ne yes){<img src="/login/img/eye.gif" title="�� ������������" border=0>}</a>}[<br>]
	^newad.focus[table;$watchin.adt]
	<p><a href="^newad.returnpath[]?action=edit&id=new">^newad.returnval[newtitle]</a>
}}$document.pagetitle[������ ����������]

}{<p>������ ��������� �������� ������ ��� ������������������ �������������<p>}
@announcer[tab][an]
^try{
^use[datawork.p]
^connect[$scs]{$an[^table::sql{SELECT CONCAT(^sr_out[$tab]) AS name, path 
FROM ^dtp[$tab] WHERE moderated != 'no' ORDER BY lastmodified DESC LIMIT 3}]}
^an.menu{<a href="$an.path" class="sided">$an.name<img src="/my/templates/mak/more.gif" class="morei"></a><p>}
}{$exception.handled(0)�������� �������� ������}
@memories[q]

^if($adtabs is table){;$adtabs[^table::load[/my/config/adbase_tables.txt]]}
^use[adb_search.p] 
^adtabs.menu{ 
	^mem2[$q;$adtabs.adt] 
}
^if(def $membase){$document.pagetitle[���������� ������ '$q'] $membase}
@mem2[qqq;tab][rest]

$rest[^adbsearch:defquery[$qqq;$tab]]
^if(def $rest){$membase[$membase 
<h3>$adtabs.name: ^rest.count[]</h3>
<ul>^rest.menu{
<li><a href="^app_path[$rest.path;$adtabs.adt]">$rest.name</a> <br>
}</ul> ]
}

@app_path[path;table][locals]

$result[$path]
^if($adtabs is table){;$adtabs[^table::load[/my/config/adbase_tables.txt]]}
^if(^adtabs.locate[adt;$table] && def $adtabs.uri){
	^if(^path.pos[?]>=0){
		$tmp[^path.split[?;lh]]
		^if(^tmp.0.length[] <= 1){$result[$adtabs.uri?$tmp.1]}{$result[$path]}
	}{$result[$path]}
}{$result[$path]}


@populars[pp][frm;is;page]
^cache[/cache/populars](5200){
^connect[$scs]{$frm[^table::sql{
SELECT COUNT(fid) AS score, fid FROM ^dtp[forum] 
WHERE $before[^date::now(-^pp.int(-21))] mydate >= '^before.sql-string[]'
GROUP BY fid ORDER BY score DESC LIMIT 6
}]}

^frm.menu{
	^if(^frm.fid.int(0)){$is[news]}{
		^if(^frm.fid.left(1) eq "/"){$is[structure]}{
			$tmp[^frm.fid.trim[end;1234567890]] $tmp(^tmp.length[]) $sTable[^frm.fid.left($tmp)]
			^if(^frm.fid.length[] != $tmp && -f "/my/dbs/${sTable}.txt"){$is[adtab]}{$is[]} 
		}
	}
^if(def $is){^connect[$scs]{$page[^table::sql{
	SELECT path, 
	^switch[$is]{
		^case[structure]{menutitle}
		^case[news]{title}
		^case[adtab]{
			^sr_out[$sTable]
		}
	} AS name, '$frm.score' AS score
	FROM ^dtp[^switch[$is]{^case[adtab]{$sTable}^case[DEFAULT]{$is}}] WHERE 
	^switch[$is]{
		^case[news]{id = '$frm.fid'}
		^case[structure]{path = '$frm.fid'}
		^case[adtab]{id = '^frm.fid.mid($tmp;99)'}
	}
	AND ^switch[$is]{
		^case[adtab]{moderated = 'yes'}
		^case[structure]{visiblity != 'no'}
		^case[news]{ 1 }
	}
}]}}
^if($pages is table){;$pages[^table::create{path	name	score}]}
^if($page is table){^pages.join[$page]}
}
^pages.menu{<a href="$pages.path" class="sided">$pages.name 
($pages.score)<img src="/my/templates/mak/more.gif" class="morei"/></a>}[<br>]
}

@tags[data;sm]
$a[^table::sql{SELECT DISTINCT $data.column AS name, COUNT($data.column) AS score
FROM ^dtp[$data.table] WHERE moderated = 'yes' GROUP BY $data.column ORDER BY score DESC LIMIT 45}]
^tagcloud[$a;$data.url?filter=field&field=$data.column&value;, 
]

@sr_out[tab;anc]
$anc[^db_fld2showinlist[$tab]] CONCAT(
^switch[$tab]{
	^case[person]{$anc.1, ' ', $anc.2, ', ', $anc.3}
	^case[news]{DATE_FORMAT(postdate, '%d.%m.%Y' ), ', ', title}
	^case[adsite]{$anc.1, ' \(',$anc.2,'\)'}
	^case[abc]{$anc.1}
	^case[hot]{'<big><b>', resource, '</b></big><br> ', name, ', �� ', ^sql_rumonth[dto]}
#	^case[hot]{'� ', ^sql_rumonth[dfrom], ' �� ', ^sql_rumonth[dto], ' ', DATE_FORMAT(dto, '%Y'), '�, ', $anc.1}
	^case[tender]{$anc.1, ' \(', $anc.2, '\), ��������� �� ',  ^sql_rumonth[dto]}
	^case[DEFAULT]{$anc.1, ', ', $anc.2, ', ', $anc.3}
} )

@adb_tabselorder[tab]
^switch[$tab]{
	^case[DEFAULT]{lastmodified DESC}
}

@sql_rumonth[field]
DATE_FORMAT($field, '%d'), ' ', 
CASE DATE_FORMAT($field, '%m') 
WHEN 12 THEN '�������' WHEN 11 THEN '������' 
WHEN 10 THEN '�������' WHEN 09 THEN '��������' 
WHEN 08 THEN '�������' WHEN 07 THEN '����' 
WHEN 06 THEN '����' WHEN 05 THEN '���' WHEN 04 THEN '������' 
WHEN 03 THEN '�����' WHEN 02 THEN '�������' WHEN 01 THEN '������'
ELSE '������' END
