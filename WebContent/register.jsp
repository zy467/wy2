<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>注册</title>
<script type="text/javascript" src="js/jquery-1.11.1.js"></script>
		 <link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" /> 
        <link type="text/css" rel="stylesheet" media="all" href="styles/button.css" />
        <script type="text/javascript" src="js/userMenu.js"></script>
        <script type="text/javascript" src="layer-v3.0.1/layer/layer.js"></script>
        <style>
        .t1{
        	text-align:right;
        	width: 350px; 
        	font-size: large;
        }
        .t2{
        	width:180px;
        	font-size: large;
        } 
        .t3{
        	font-size: large;
        }
   		input{
   			margin:2px 0px 2px 0px;
   		}
        </style>
</head>
<body>
		<!--Logo区域开始-->
        <div id="header">
            <c:import url="registLogo.jsp"></c:import>    
        </div>
	<form method="post" action="action_add" id="main" onreset="res()">
		<div>
			<table >
				<tbody>
					<tr>
						<td class="t1">用户名：</td>
						<td class="t2"><input type="text" name="a.username" id="1" onblur="f2();"/></td>
						<td class="t3"><span style="color:red;" id="s1"></span></td>
					</tr>
					<tr>
						<td class="t1">密码：</td>
						<td class="t2"><input type="password" id="newpwd" onblur="newpwd1() "/></td>
						<td class="t3"><span style="color:red;"id="span2">*</span></td>
					</tr>
					<tr>
						<td class="t1">确认密码：</td>
						<td class="t2"><input type="password" name="a.password" id="confirmpwd" onblur="confirmpwd1()"/></td>
						<td class="t3"><span style="color:red;"id="span3">*</span></td>
					</tr>
					<tr>
						<td class="t1">银行卡号：</td>
						<td class="t2"><input type="text" name="a.personinfo.cardid" id="cardid" onblur="checkCardid()"/></td>
						<td class="t3"><span style="color:red" id="span4"></span></td>
					</tr>
					<tr>
						<td class="t1">开户金额：</td>
						<td class="t2"><input type="text" name="a.balance" id="money" onblur="checkMoney()"/></td>
						<td class="t3"><span style="color:red" id="span5"></span></td>
					</tr>
					<tr>
						<td class="t1">姓名：</td>
						<td class="t2"><input type="text" name="a.personinfo.realname" id="name" onblur="checkName()"/></td>
						<td class="t3"><span style="color:red" id="span6"></span></td>
					</tr>
					<tr>
						<td class="t1">年龄：</td>
						<td class="t2"><input type="text" name="a.personinfo.age" id="age" onblur="checkAge()"/></td>
						<td class="t3"><span style="color:red" id="span7"></span></td>
					</tr>
					<tr>
						<td class="t1">性别：</td>
						<td ><select name="a.personinfo.sex" id="8">
								<option value="男">男</option>
								<option value="女">女</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="t1">联系电话：</td>
						<td class="t2"><input type="text" name="a.personinfo.telephone" id="phone" onblur="checkPhone()"/></td>
						<td class="t3"><span style="color:red" id="span8"></span></td>
					</tr>
					<tr>
						<td class="t1">证件号码：</td>
						<td class="t2"><input type="text" name="a.personinfo.pid" id="person" onblur="checkPerson()"/></td>
						<td class="t3"><span style="color:red" id="span9"></span></td>
					</tr>
					<tr>
						<td><br></td>
					</tr>
					<tr>
						<td></td>
						<td>
							&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="提交" onclick="add();" style="font-size: small;line-height:20px;padding: 0 10px;" class="button button-glow button-rounded button-raised button-primary">
							&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重置"  style="font-size: small;line-height:20px;padding: 0 10px;" class="button button-glow button-rounded button-raised button-primary"/>
						</td>
						<td>${registermessage }</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
</body>
</html>