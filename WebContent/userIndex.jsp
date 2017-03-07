<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>主页</title>
        <link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" /> 
        <script type="text/javascript" src="js/userMenu.js"></script>
    </head>
<body>
	 <!--Logo区域开始-->
        <div id="header">
            <c:import url="logo.jsp"></c:import>    
        </div>
    <!--导航区域开始-->
    <div id="navi">
        <c:import url="userMenu.jsp"></c:import>
    </div>
    <div>
    	<c:import url="main.jsp"></c:import>
    </div>
    <div id="footer">
        <p>版权所有(C) 网银二组 </p>
    </div>
</body>
</html>
