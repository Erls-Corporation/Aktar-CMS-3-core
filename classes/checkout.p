@CLASS
checkout
#�������� ������������� � ��� ����������� �����
#��������� ����� ^checkout:file ����� ������� ����� �������.
@file[path]
<p>
<b>���������� �������� $path �� ������������� � Aktar CMS.</b><br>
^if(-f "$path"){
$code[^file::load[text;$path]]
^checkfile[$code.text]
}{���, ���� ���� �� ����������!}
<p>

@checkfile[txt]
$ops[^table::create{op}]
$vars[^hash::create[]]
$vartxt[^txt.split[@CLASS;lh]]
$vartxt[$vartxt.0]

$babyfrog[@]
$optxt[^txt.replace[^table::create{f	t
${babyfrog}CLASS	
${babyfrog}USE	
${babyfrog}BASE	}]]

$a[
^optxt.match[(\n@)(.+?)(\^[)][ig]{^ops.append{$match.2}}
#�����-�� ������ ^vartxt.match[(\^$^{|\^$|\^^)(.+?)(^[\^]\' &/\^}\^)\^;\^{\^[\^(\.\:^])][ig]{$vars.[$match.2](1)}
^vartxt.match[(\^$^{|\^$)(.+?)(^[\^{\^[\^(\.\:^])][ig]{$vars.[$match.2](1)}

]

$ops[^ops.select($MAIN:[$ops.op] is junction && $ops.op ne main && $ops.op ne auto)]
^ops.sort{$ops.op}
^if(def $ops){ $checkfail(1)
��� ��������� ��� ���������� � ������ MAIN:<br>
^ops.menu{$ops.op<br>}
}

$vars[^table::create{var
^vars.foreach[k;v]{$k}[
]}]
$vars[^vars.select(def $MAIN:[$vars.var])]
^vars.sort{$vars.var}
^if(def $vars){$checkfail(1)<p>��� ���������� ��� ������������ � ������ MAIN:<br>}
^vars.menu{$vars.var<br>}
^if(!$checkfail){�����, �� � �������...}
