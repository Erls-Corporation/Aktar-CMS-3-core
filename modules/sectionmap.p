@version[]
2008-03-19	���������� - � ������ + %this% + minor bugs

@sectionmap_settings[][set]
$result[^table::create{param	type	default	descr
path	string	this	�����������, ������� � �������
limit	num	5	������� �����������
bydate	bool	yes	����������� �� ����
showpic	bool	yes	���������� ��������
markempty	bool	yes	�������� �������� �������}]


@sectionmap_info[set][ut;ks;�]
^process{@sitemap_design[d]

}
$set[^set.menu{$.[$set.param][$set.value]}]
^if($set.path eq this){$set.path[$uri]}
^sitemap[$set] <b>^sitemap.count[]</b> �������� ����� ������������
@sectionmap[set]
^if(!def $set.bydate && def ^cando[editor]){<p><a href="/login/groupedit.htm?grpfield=s.sect_order&grplimit=$uri&grpnum=2">�������� ����������� ��������</a></p>}
^connect[$scs]{
^sitemap[$set]
}


@sitemap[set;d][eye;pic]
#��������� ��������
^if($set is hash){}{$set[^hash::create[]]}
^if($set.path eq this){$set.path[$MAIN:uri]}
^if(!def $set.path){$set.path[$uri]} $set.path[^set.path.trim[end;/]/]

#�������� �����
$sitemap[^table::sql{SELECT s.path, s.sect_order, s.sect_key, 
^if(def $set.bydate){1 AS level}{s.level}, 
s.menutitle, se.pagetitle, se.description, se.picture, 
s.rpermission, s.epermission, s.visiblity, s.module, s.modified, 
#��������� ������� ��������
^if(def $globals.IUseFiles && !def $set.markempty){
	'y' AS exist
	}{
	CASE se.content WHEN '' THEN '' ELSE 'y' END AS exist
}
^combine_s_se[] WHERE s.path LIKE '$set.path%' 
#������������ ����� ������� �� �����������
^if(def $set.limit){AND level <= '^eval(^pathlevel[$set.path] + ^set.limit.int(2))'} 
#������ �������� ������, ��� ������� � �����
^if($set.path eq "/"){AND s.path != '/'}
#������� �������, ���� ���� �����
^if(!def ^cando[$erpermission] && !def ^cando[$.editor(1)]){
	^if(!def $globals.includeNoMenu){
		AND s.visiblity LIKE 'yes'
	}{
		AND s.visiblity NOT LIKE 'no'
	}
	}
#���� ������� �� ����, �� ��������� ��������
ORDER BY ^if(def $set.bydate){s.created DESC}{s.path}}]
^if(!def $set.bydate){$sitemap[^tree_sort[$sitemap]]}
^if($sitemap_design is junction){^sitemap_design[$sitemap]}{
#����� ������� ����� �� ���������
 $eye{^if($sitemap.visiblity ne yes){<img src="/login/img/eye.gif" align=baseline title="�������">}}
 $pic{^if(def $set.showpic && def $sitemap.picture){^if(-f "/my/img/node_pics/$sitemap.picture"){<a href="$sitemap.path"><img src="/my/img/node_pics/$sitemap.picture" border="0" /></a><br>}}}
 ^sitemap.menu{$otstup(^eval($sitemap.level - ^pathlevel[$set.path] -1))
 <div style="padding-left:^eval($otstup * 20)px^; padding-top:8px">$eye<a href="$sitemap.path">
 ^if(def $sitemap.exist){<b>}
 ^default[$sitemap.pagetitle;$sitemap.menutitle] ^if(def ^cando[]){$sitemap.modified} </a></b><br>$pic ^if(def $sitemap.description){$sitemap.description <a href="$sitemap.path">&gt^;&gt^;</a>}
 </b></div>
 }
}
