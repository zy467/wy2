<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>管理员修改密码</title>
    <link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
    <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" />
    <link type="text/css" rel="stylesheet" media="all" href="styles/button.css" />
    <script type="text/javascript" src="js/userMenu.js"></script>
    <style type="text/css">
    	input{
    		margin:2px 0px 2px 0px;
    	}
    </style>
</head>
<body>
    <!--Logo区域开始-->
        <div id="header">
            <c:import url="alogo.jsp"></c:import>    
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <div id="navi">                        
            <c:import url="adminMenu.jsp"></c:import>   
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <form action="adminAction_adminModifyPwd" method="post" id="allow">
			<table>
                <tr>
                    <td class="login_info">当前密码：</td>
                    <td colspan="2"><input name="pwd.oldpwd" type="password" class="width150" id="oldpwd" onblur="oldpwd2('${sessionScope.adm.password}');"/>
                    <span style="color: red;" id="span1" class="login_error_info">*</span></td>
                </tr>
                <tr>
                    <td class="login_info">新密码：</td>
                    <td colspan="2"><input type="password" class="width150" name="pwd.newpwd" id="newpwd" onblur="newpwd1()"/>
                    <span style="color: red;" id="span2">*</span></td>
                </tr>
                <tr>
                    <td class="login_info">确认密码：</td>
                    <td colspan="2"><input type="password" class="width150" name="adm.password" id="confirmpwd" onblur="confirmpwd1()"/>
                    <span style="color: red;" id="span3">*</span></td>
                </tr>           
                <tr>
                    <td></td>
                    <td class="login_button" colspan="2">
                    	<!-- 点击submit按钮，它自动触发了form元素的onsubmit事件，
                    		  而该事件内自动调用了form元素的submit()，我们也可以通过js主动调用此方法 -->
                    		  <!-- 下面的是伪协议 href目的是为了点击链接不会跳转，同事执行onclick里面的js -->
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="修改" onclick="modify1()" class="button button-glow button-rounded button-raised button-primary"/>
                        <!-- <a href="javascript:void(0)" onclick="modify1()"><img src="images/login_btn.png" /></a> -->
                    	<%-- <span class="required">${a}</span></td> --%>  
                    	</td>            
                </tr>
            </table>
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p>版权所有(C)网银二组 </p>
        </div>
 </body>
</html>








