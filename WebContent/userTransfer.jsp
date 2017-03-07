<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
    <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" />
    <link type="text/css" rel="stylesheet" media="all" href="styles/button.css" /> 
    <title>用户转账页面</title>
    <script type="text/javascript" src="js/userMenu.js"></script>
    <script type="text/javascript" src="js/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="layer-v3.0.1/layer/layer.js"></script>
    <style type="text/css">
    		input{
     			margin:2px 0px 2px 0px;
     		}
   	</style>
</head>
<body>
    <!--Logo区域开始-->
        <div id="header">
            <c:import url="logo.jsp"></c:import>    
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <div id="navi">                        
            <c:import url="userMenu.jsp"></c:import>   
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <form action="action_userTransaction" method="post" id="transaction">
            <div>
                <!--转账区-->    
                 <table>
	                 <tbody>
						<tr>
							<td style="font-size: large;">对方卡号：
								<input type="text" name="tr.otherid" id="otherid"/>
								<span id="errorotherid" style="color:red;"/>
							</td>
						</tr>
						<tr>
							<td style="font-size: large;">转账金额：
								<input type="text" name="tr.tr_money"  id="tr_money" onblur="checkTrMoney();"/>
								<span id="errormoney" style="color:red;font-size: 20px;"/>
							</td>
						</tr>
						<tr>
							<td style="padding-left: 73px;">
							<br></br>
								<input type="button" value="转账" onclick="transaction();" class="button button-glow button-rounded button-raised button-primary"/>
							</td>
						</tr>
					</tbody>
				</table>
				</div> 
			</form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p>版权所有(C) 网银二组 </p>
        </div>
 </body>
</html>








