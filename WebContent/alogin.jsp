<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" /> 
        <script type="text/javascript" src="js/userMenu.js"></script>
        <script type="text/javascript" src="js/jquery-1.11.1.js"></script>
        <script type="text/javascript" src="layer-v3.0.1/layer/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理员登录</title>
<style>

</style>
</head>
<body class="index" onload="document.getElementById('adm.username').focus()">
	<div class="login_box"> 
	<form action="adminAction_alogin" method="post">
		<table>
			<tr>
				<td class="login_info">管理员：</td>
                <td colspan="2"><input name="adm.username" id="adm.username" type="text" class="width150" /></td>
			</tr>
			<tr>
				<td class="login_info">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
                <td colspan="2"><input name="adm.password" type="password" class="width150" /></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<a href="javascript:document.forms[0].submit();"><img src="images/login_btn.png"></a>
					<!-- <input type="submit" value="登录" id="alogin"> -->
			</tr>	
			<tr>
				<td></td>
				<td>
					<span class="required">${requestScope.adm}</span>
				</td>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>
