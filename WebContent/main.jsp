<!-- 欢迎界面 -->
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
	<style type="text/css">
		.m1{
			margin-top: 160px;
		}
	</style>
<script type="text/javascript">
//获取当前时间
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
</head>
<body>
	<div id="main">
	<p id="userFreeze">${userFreeze}</p>
		<p class="m1" style="font-size: xx-large;" align="center">
			欢迎进入网上银行交易中心！
		</p>
		<!-- <p class="m2" id="time"> --><!-- <a id="txt" style="color: blue;">当前时间:</a> -->
			<!-- <a id="txt" style="color: blue;"></a> -->
			<%-- <%
						Date date = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
						String str = sdf.format(date);
					%> --%>
					<%-- <%=str%> --%>
		<!-- </p> -->
	</div>
</body>
</html>