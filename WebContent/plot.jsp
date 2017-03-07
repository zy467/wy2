<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>生成报表</title>
		<link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/button.css" />
		<style type="text/css">
			.sf{
				margin-left: 100px;
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
            <form>
                <!--排序-->
                <div class="search_add">
                    <div>
                        <!--<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="基费" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="时长" class="sort_asc" onclick="sort(this);" />-->
                    </div>
                    <!-- <input type="button" value="按金额查询" class="btn_add" onclick="" /> -->
                    <input type="button" value="返回交易信息" onclick="location.href='action_findAllTransactionLog'" style="font-size: xx-small;line-height:2px;padding: 0 10px;" class="button button-glow button-border button-rounded button-primary"/>
                </div> 
                <!--数据区域：用表格展示数据-->     
                <div id="data">

                			<br>
                			<img alt="sdf" src="action_createPlot"/>

                </div>
           	 </form>
        </div>     
        <!--主要区域结束-->
        <div id="footer">
            <p>版权所有(C) 网银二组 </p>
        </div>
</body>
</html>