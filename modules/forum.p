@version[]
2009-09-23	����������� � ����� ������ �����
2009-05-29	�������� � ����������������
2008-02-27	��������� ��������� ������������ � ������ ������ ��� ������������������

@forum_settings[options][i]
$result[^table::create{param	type	default	descr
fid	string	$i[^uri.split[/;rh]]f_^i.0.left(29)	������������� ������ (������, ��������)
rpp	num	15	������� �� ��������
#is_spec	bool		���� ����� �������� ������������� �����������
#file_ext	option		���������� ����������� ������ (����� ������)
#file_size	num		����������� �� ������ �����
notify	string		Email, �� ������� ���������� ����������� � ����� ������
forum_descr	string		�������� ������
reged	bool	yes	������ ������������������ ����� �������
premod	bool	yes	������������ ���������
specans	string		�����, ����������� ����� (������ ���� - �������� ���)
ansbgr	string		���� ���� ��� �������
norate	bool	yes	��������� �����������
ratesort	bool	yes	����������� ��������� �� �������� �� ��������}]
@forum_info[set][inf;allinf;al2]
����� �� �������������: moder
^try{
$inf[^table::sql{SELECT DISTINCT fid , COUNT(fid) AS coun, '' AS title
FROM ^dtp[forum] GROUP BY fid ORDER BY coun DESC LIMIT 13}]
<br> ��������� �������������� (��������): ^inf.menu{$inf.fid ($inf.coun)}[, ].
^if($env:REQUEST_METHOD eq POST){
	^if(!-f "/my/deriv/forums.txt"){
		^inf.save[/my/deriv/forums.txt]
		$allinf[$inf]
	}{$allinf[^table::load[/my/deriv/forums.txt]]}
	$ffid[^form:forum_fid.split[ ;lh]]$ffid[$ffid.0]
	$al2[^allinf.select($allinf.fid eq $ffid)]
	$allinf[^allinf.select($allinf.fid ne $ffid)]
	^allinf.append{$ffid	$al2.coun	$document.menutitle}
	^allinf.sort($allinf.coun)[desc]$allinf[^allinf.select(^allinf.line[] < 15)]
	^allinf.sort{${allinf.title}$allinf.fid}[asc]
	^allinf.save[/my/deriv/forums.txt]
}

}{^blad[huinia]}
@forum[set]

^forum:operate[$set]

@CLASS
forum

@operate[set]
$seti[$set]

^if($MAIN:document.module ne "forum.p"){$seti.embedded(1)}
^if(!def $seti.specans){$canans(1)}{
	^if(def ^cando[^s2h[$seti.specans]] || ^moder[]){$canans(1)}
}

^if(!def $seti.fid){$seti.fid[default]$allid[^s2h[$seti.fid]]}{$allid[^s2h[$seti.fid]]$tmp[^seti.fid.split[ ;lh]]$seti.fid[$tmp.0]}
^if(def $form:msg){^die[$form:msg]}

^connect[$MAIN:scs]{
^if(^moder[] && def $form:edit){^editone[]}{
^if(^form:fdisplay.int(0) > 0){^showf1[^form:fdisplay.int(0)]}{^showall[]}
}
^if(((def $seti.reged && def $MAIN:user.id) || !def $seti.reged) && !def $form:noform){^post_form[]}
}
^call_js[/login/modules/forum/forum.js]

@urido[]
^if($MAIN:document.module eq "forum.p"){$result[$MAIN:uri?]}{
$result[$request:uri^if(^request:uri.pos[?]>0){&;?}]
}

@fcapchk[]
^if(!def $seti.reged && !def $MAIN:user.id){
^use[/login/captchadefault.htm]
^if(!^capchk0[]){$userdesc.data_error(1)}
}
@fcapshow[]
^if(!def $seti.reged && !def $MAIN:user.id){
^use[/login/captchadefault.htm]
<br>^capshow0[<br>]<br>
}
@showf1[id]
^if($env:REQUEST_METHOD eq POST && !def $seti.reged){^post_answer[]}


$message[^getmessage[$id]]
^if(def $message.content){$message.content[^message.content.replace[^unbrul[]]]}
$answers[^table::sql{SELECT a.*, u.rig FROM ^dtp[ans] a 
LEFT JOIN ^dtp[users] u ON a.userid = u.id
WHERE a.id = '$id'}]
^if($MAIN:message_design is junction){^message_design[]}{
 $MAIN:document.title[$message.title - $message.author - $MAIN:document.title]
^if(def $seti.asmain){
^MAIN:crumbs.append{$MAIN:uri?fdisplay=$form:fdisplay	^wisetrim[$message.title;16]}
 $MAIN:document.pagetitle[^default[$message.title;���������] - $MAIN:document.pagetitle] $MAIN:document.keywords[$message.title] $MAIN:document.content[]
}{<h2>^default[$message.title;���������]</h2>}
^use[rating.p]
^rating:addrange[f$message.id
^answers.menu{a$answers.ansid}[
]]
  ����� <span class="$message.rig" onClick="userbox(this, $message.userid, 'userinfo')"></span><b>$message.author</b> (^dmy[$message.mydate])^ratingbox[f$message.id] <br>
  ^process_content[$message.content]
  ^if($MAIN:forum_onshow is junction){^forum_onshow[]}
  <h3>������ �� �${message.title}�</h3>
  
  ^answers.menu{<span id="forumbox$answers.ansid"><hr size="1">
    ^if(def $answers.title){<b>$answers.title</b> - }<span onClick="userbox(this, $answers.userid, 'userinfo')" class="$answers.rig"></span>$answers.author,   ^dmy[$answers.mydate]^ratingbox[a$answers.ansid]<br>
    
    ^process_content[$answers.content]
    <br>
    ^ansadmin[$answers.ansid]
    <br>
  </span>}
  ^if(^answers.count[] < 1){��� ����� �� ������� �� ��� ���������.}
^if(def $form:noform){<p><a href="^urido[]^rn[?]">��������� � �����</a><p>}
  
}
$message[$.author[$MAIN:user.name]$.email[$MAIN:user.email]]
@ansadmin[id]
^if(^moder[]){<a href="/login/modules/forum/moder.htm?a=del&ansid=$id" title="������� ���� �����?" class="ajaxhandled">�������</a>}
@process_content[c][text]
#$text[^try{^process{^untaint{$c}}}{$exception.handled(1)$c}]
$result[^c.replace[^unbrul[]]]
@post_answer[]
^use[collection.p]
$ans1[^collection::create[ans]]
$ans_message[^ans1.createInstance[postid whois title author email content]]
$ans_message.mydate[^MAIN:now.sql-string[]]
$ans_message.whois[^if(^moder[]){spec}{user}]
$ans_message.id[^form:fdisplay.int(-1)]
$ans_message.content[^utf2win[$ans_message.content]]
$ans_message.author[^utf2win[$ans_message.author]]
$ans_message.userid($MAIN:user.id)
^fcapchk[]
^if(!def $form:author){$forum_err(1)^die[���������� ��������� ���� ���]}
^if(def ^string:sql{SELECT postid FROM ^dtp[ans] WHERE postid = '$form:postid'}[$.default{} $.limit(1)]){^die[�� ��� ��������� ��� ���������]$forum_err(1)}
^if(!$forum_err){

$author_want[^table::sql{SELECT email, author, iwantcomment FROM ^dtp[forum] WHERE id = '^form:fdisplay.int(0)'}]


<!-- ^ans1.insertInstance[$ans_message] ^msg[����� ��������]-->
^delcache[$form:subst_url]
#^redirect[^urido[]fdisplay=$form:fdisplay^rn[&]]
^void:sql{UPDATE ^dtp[forum] SET answers = answers + 1 WHERE id = '^form:fdisplay.int(-1)'}


^if($author_want.iwantcomment eq yes && ^is_email[$author_want.email]){^try{
^mailsend[
  $.from["$env:SERVER_NAME Forum" <^default[$seti.notify;$MAIN:globals.site_admin]>]      $.to["$author_want.author" <$author_want.email>]
    $.subject[����� �� $ans_message.author]    $.charset[$globals.mailcharset]
    $.text[������������, $author_want.author
�� ���� ��������� � ������ �������� ����� �� $ans_message.author
http://${env:SERVER_NAME}^urido[]fdisplay=$form:fdisplay

$ans_message.title
$ans_message.content
]
$.charset[$response:charset]
]
^msg[������ ���� ���������� ����������� �� ������.]
}{$exception.handled(1)^blad[huinia]}}

#end if !$forum_err
}

@getmessage[id][tmp]
$tmp[^table::sql{SELECT f.*, u.rig FROM ^dtp[forum] f 
LEFT JOIN ^dtp[users] u ON f.userid = u.id
WHERE f.id = '$id'}]
$result[$tmp.fields]


@fsel[]
$instance[^table::load[/my/dbs/forum.txt]]
$r(^int:sql{SELECT COUNT(id) FROM ^dtp[forum] WHERE fid IN (^allid.foreach[k;v]{'$k'}[, ])})
$pp[^pagination::create[$r;^seti.rpp.int(15)]]
$forum[^table::sql{
	SELECT ^instance.menu{^if($instance.column ne content){f.$instance.column, }}
	LEFT(f.content,80) AS content, u.rig FROM ^dtp[forum] f
	LEFT JOIN ^dtp[users] u ON f.userid = u.id
	WHERE fid IN (^allid.foreach[k;v]{'$k'}[, ])
	^if(!^moder[]){AND visiblity = 'yes'} 
	ORDER BY mydate DESC
}[^pp.q[limits]]]

$fans[^table::sql{SELECT *, LEFT(content,80) AS content FROM ^dtp[ans] WHERE id IN (^forum.menu{'$forum.id', }'-1')
 ORDER BY mydate ASC}]

@showall[]
^if($env:REQUEST_METHOD eq POST && !def $seti.reged && def $form:author){^post_message[]}
^fsel[]
 $seti.forum_descr
<style>.ans{margin-left:30px^;margin-top:8px^;padding:2px}</style>
^use[rating.p]
^rating:addrange[^forum.menu{f$forum.id}[
]
^fans.menu{a$fans.ansid}[
]]
^if(def $seti.ratesort){
^forum.sort(^rating:box[f$forum.id;-1])[desc]
}
^forum.menu{<span id="forumbox$forum.id" class="forumbox">
^if(^forum.userid.int(0) || 1){<span class="$forum.rig" onClick="userbox(this, $forum.userid, 'userinfo')"></span>}
<a href="^urido[]fdisplay=$forum.id"><b>$forum.title</b></a> - 
^if($forum.userid && ^moder[]){<a href="/login/users.htm?uid=$forum.userid">}
$forum.author</a>,
^ufdate[$forum.mydate] ^ratingbox[f$forum.id]
^if(def $forum.content){
	<br>^forum.content.replace[^unbrul[]] <a href="^urido[]fdisplay=$forum.id#msgForm">...</a>
} 
<br>^if($canans){<a href="^urido[]fdisplay=$forum.id#msgForm" class="anslink"><img src="/login/img/edit.gif" border=0><b>�������� �����</b></a>}

	^if(^moder[]){
	<a class="ajaxhandled" href="/login/modules/forum/moder.htm?a=screen&id=$forum.id&show=^if($forum.visiblity eq yes){off">������;on"><img src="/login/img/eye.gif" border=0>����������}</a>
	<a href="/login/modules/forum/moder.htm?a=del&id=$forum.id" class="ajaxhandled" title="����� ������� ��� ��������� � ��� ������?">�������</a> 
	<a class="pmop" href="#" id="move$forum.id" onClick="PDdialog(this, $forum.id, '#fMoveBox')">�����������</a> 
	}
$this_ans[^fans.select($fans.id == $forum.id)]
^if(^this_ans.count[]>0){
	^this_ans.menu{
		<div class="ans" ^if(^math:frac(^this_ans.line[]/2)){style="background-color:#$seti.ansbgr"}>
		<b><span class="isUser"></span>$this_ans.title $this_ans.author</b>,   ^dmy[$this_ans.mydate] ^rating:box[a$this_ans.ansid]<br>
		^this_ans.content.replace[^unbrul[]]... ^ansadmin[$this_ans.ansid]
	</div>}
}
#<a href="^urido[]fdisplay=$forum.id">�������: $forum.answers</a>

  <br><br>

</span>}[<span class="interforum"></span>]

^pp.listpages[ | ;$.url[^urido[]]$.prescript[��������:]] <br><br>

^if(^moder[]){<div id="fMoveBox" style="position:absolute^;display:none^;z-index:9000^;background:#FFDDFF">^try{
$finfos[^table::load[/my/deriv/forums.txt]]
^finfos.menu{<a href="#" onClick="moveTopic('$finfos.fid')">^default[$finfos.title;$finfos.fid]</a><br>}
}{^blad[huinia]}</div>}

@ratingbox[id]
^if(!def $seti.norate){^rating:box[$id]}

@post_message[]
^use[collection.p]
$forum1[^collection::create[forum]]
$newpost[^forum1.createInstance[postid title author content email fid visiblity has_answer answers iwantcomment custom1 custom2]]
$newpost.userid($MAIN:user.id)
$newpost.mydate[^MAIN:now.sql-string[]]
$newpost.title[^utf2win[$form:title]]
$newpost.author[^utf2win[$form:author]]
$newpost.content[^utf2win[$form:content]]
^if(def $seti.premod){$newpost.visiblity[no]}
$newpost.custom1[$form:custom1]

^if(def ^string:sql{SELECT postid FROM ^dtp[forum] WHERE postid = '$form:postid'}[$.default{}]){^die[�� ��� ��������� ��� ���������]$forum_err(1)}
^if(!def $newpost.author || !def $newpost.title){^die[���������� ��������� ��������� ��������� � ���� ���]$forum_err(1)}
^fcapchk[]
^if(!$forum_err){
  $msgId(^forum1.insertInstance[$newpost])
  ^delcache[$form:subst_url]
^if(!$ajaxcalled){
  ^redirect[^urido[]fdisplay=$msgId^rn[&]&msg=���� ������ ���������.^if(def $seti.premod){��� �������� ����� �������� �����������.}&noform=true]]
}{^die[��������� ���������]}
^if(def $seti.notify){$notify[^s2h[$seti.notify]]^notify.foreach[k;v]{
  ^mailsend[
  $.from["$env:SERVER_NAME Forum" <$MAIN:globals.site_admin>]      $.to["$env:SERVER_NAME Forum supervisor" <$k>]
    $.subject[����� ��������� � ������]    $.charset[$MAIN:globals.mailcharset]
    $.text[� ����� ��������� ��������� �� $newpost.author
http://${env:SERVER_NAME}$form:subst_url

$newpost.title
$newpost.content
]
   ]
}}
}


@post_form[mode]
^if(def $form:fdisplay && $canans || !def $form:fdisplay){
	^post_form2[$mode]
}

@post_form2[mode]
^if(!def $message){$message[ $t[^math:uid64[]]$.postid[^t.left(12)] $.author[$MAIN:user.name] $.email[$MAIN:user.email] $.fid[$seti.fid] ]}
#mode forum ans spec_ans

^if($seti.embedded && !def $form:fdisplay){<h3 class="left_comment"><a href="#" onClick="^$('#fpostbox').show('slow')^;return false">�������� �����������</a></h3><div id="fpostbox" style="display:none">}{<div id="fpostbox"}
<h2>^if(def $form:fdisplay){��� ����� ��}{����} ���������</h2>
^if(def $form:fdisplay && !$seti.embedded){ (<a href="^urido[]^rn[?]#msgForm">�������� ��������� � ������</a>) }
<span id="forumpostmsg"></span>
<a name="msgForm"> </a>
<form action="^urido[]fdisplay=$form:fdisplay" method=post name=post id="forumpost" enctype="multipart/form-data">
^keepvalue[fdisplay]
<input type=hidden name="id" value="$message.id">
<input type=hidden name="postid" value="$message.postid">
<input type=hidden name="fid" value="$message.fid">
<input type=hidden name="subst_url" value="$MAIN:uri">
<input type=hidden name="seti_src" value="$MAIN:document.sect_key">
^if(!def $form:fdisplay){* ��������� ���������<br>
<input type=text size=60 name="title" value="$message.title"><br>}
* ���� ��� <span id="author_name"></span><br>
<input type=text size=30 name="author" value="^if(def $form:author && !def $message.author){$form:author}$message.author"><span></span><br>
��� e-mail (����� �����):<br>
<input type=text size=30 name="email" value="$message.email">
^if(!def $form:fdisplay){<input type=checkbox name=iwantcomment value="yes">��������� ���� �� ������}<br>
^if(!def $form:fdisplay && $MAIN:forum_onedit is junction){^forum_onedit[]}
����� ���������: <br>
^if($mode eq spec_ans){^carea[]}{<textarea name=content cols=50 rows=10>^if(def $form:content && !def $message.content){$form:content}$message.content</textarea>}
^fcapshow[]
<br>

<input type=submit value="���������" id="forumsubmit">
^if(def $seti.premod && !def $form:fdisplay){<br>���� ��������� �������� ����� �������� �����������}
</form>
</div>
@moder[]
^if(def ^cando[$epermission] || (def ^cando[$rpermission] && def ^cando[$.moder(1)])){$result(1)}{$result(0)}
