<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>用户登录</title>
        <link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" /> 
        <script type="text/javascript" src="js/userMenu.js"></script>
        <script type="text/javascript" src="js/jquery-1.11.1.js"></script>
        <script type="text/javascript" src="layer-v3.0.1/layer/layer.js"></script>
        <style type="text/css">
        		a:visited{
        			color:white;
        		}
        		a:HOVER {
					color:blue;
				}
        </style>
    </head>
    <body class="index" onload="loginload('${successmessage}');">
        <div class="login_box">
       	 <form action="action_login" method="post" id="form">
            <table>
                <tr>
                    <td class="login_info">用户名：</td>
                    <td colspan="2"><input name="a.username" id = "a.username" type="text" class="width150" /></td>
                 
                </tr>
                <tr>
                    <td class="login_info">密码：</td>
                    <td colspan="2"><input name="a.password" type="password" class="width150" /></td>
                  
                </tr>
                <tr>
                    <td class="login_info">验证码：</td>
                    <td class="width70"><input name="code" type="text" class="width70" /></td>
                    <td><img src="action_createImg" onclick="this.setAttribute('src','action_createImg?x='+Math.random());" alt="验证码" title="点击更换" />
                    </td>  
                    <td><span class="required" id="login_result">${loginmsg}</span></td>              
                </tr>  
            </table>
       		<table>
          		<tr>
           			<td style="text-align: right;" width="65%">
           			<!-- 点击submit按钮，它自动触发了form元素的onsubmit事件，
           			  而该事件内自动调用了form元素的submit()，我们也可以通过js主动调用此方法 -->
            			<!-- <a href="javascript:document.forms[0].submit();"><img src="images/login_btn.png" /></a> -->
            			<a href="javascript:userslogin()"><img src="images/login_btn.png" /></a>
           			</td>
           			<td>
             		 	<a href="action_register" style="text-decoration: underline;">注册新用户</a>
         			</td>
       			</tr>
       		</table>
          </form>
        </div>
        <!-- opacity:0  透明度 -->
        <div style="width: 50px;height: 50px;margin-right:28.2%; font-size: 15px;" >
        	<a href= "alogin.jsp" style="opacity:0">管理员登录入口</a>
        </div>
    </body>
</html>
