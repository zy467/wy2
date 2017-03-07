<%@page pageEncoding="utf-8"%>
<img src="images/logo.png" alt="logo" class="left"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- EL默认从4个对象中取值,而不会从cookie中取值,要想从cookie中取值，
		必须按照如下方法来书写EL:cookie.key.value -->
<%-- <span>${cookie.adminCode.value}</span> --%>
<%-- <span>${adm}</span> --%>
<script type="text/javascript">
<!--获取当前时间-->
var inter = setInterval("startTime()", 0)
function startTime(){
	var now = new Date()
	var y=now.getFullYear()
	var mon=now.getMonth()+1
	var d=now.getDate()
	var h=now.getHours()
	var m=now.getMinutes()
	var s=now.getSeconds()
	m=checkTime(m)
	s=checkTime(s)
	document.getElementById('txt').innerHTML=y+"-"+mon+"-"+d+" "+h+":"+m+":"+s
	}
	function checkTime(i)
	{
	if (i<10) 
	{i="0" + i}
	return i;	
}
	/* setInterval("document.getElementById('time').innerHTML = new Date().toLocaleString()+'星期'+'日一二三四五六'.charAt(new Date().getDay());",1000); */
</script>
<a href="action_findpersoninfo" style="font-size: x-large;">当前用户:${sessionScope.a.personinfo.realname}</a>
<a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
<a id="txt">当前时间：</a>
<a href="javascript:void(0)" onclick="loginout();">[退出]</a>