<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>管理员修改公告页面</title>
    <style>
    	.logo{
			background-image:url("images/b.png");
    	}
    </style>
</head>
<body>
    <!--导航区域开始-->
    <div class="d0">
	    <div id="index_navi" class="d1">
	        <c:import url="alogo.jsp"></c:import>
	    </div>
	    <div class="d2">
	    	<div class="d3">
				<c:import url="adminMenu.jsp"></c:import>
			</div>   
			<div class="d4">
				<c:import url="adminModifyNotice.jsp"></c:import>
			</div>  
			<div class="d5"></div>
	    </div>
    </div>
 </body>
</html>








