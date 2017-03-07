<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
    <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" />
    <link type="text/css" rel="stylesheet" media="all" href="styles/button.css" />
    <title>已冻结账户</title>
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
            <form id="form">
                <!--排序-->
                <div class="search_add">
                    <div>
                        <!--<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="基费" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="时长" class="sort_asc" onclick="sort(this);" />-->
                    </div>
                    <!-- <input type="button" value="返回" class="btn_add" onclick="location.href='adminAction_findAllAccount'"/> -->
                    <input type="button" value="返回" onclick="location.href='adminAction_findAllAccount'" style="font-size: xx-small;line-height:2px;padding: 0 10px;" class="button button-glow button-border button-rounded button-primary"/>
                </div> 
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist" style="margin-top: 16px;">
                        <tr>
                            <th>账户</th>
                            <th>用户名</th>
                            <th>账户余额</th>
                            <th>姓名</th>
                            <th>身份证号</th>
                            <th>银行卡号</th>
                            <th>电话</th>
                            <th>状态</th>
                            <th>操作</th>
                            <th>删除</th>
                        </tr>
                        <c:forEach items="${c}" var="a">                      
                        <tr>
                            <td>${a.accountid}</td>
							<td>${a.username}</td>
							<td><%-- ${a.balance} --%>
							<fmt:formatNumber value="${a.balance}" pattern="#.00"/>
							</td>
							<td>${a.personinfo.realname}</td>
							<td>${a.personinfo.pid}</td>
							<td>${a.personinfo.cardid}</td>
							<td>${a.personinfo.telephone}</td>
						    <td>
                                   <c:if test="${a.status.sname=='normal'}">
						    <c:set var="salary" value="冻结"/>
   							 		<c:out value="正常"/>
								</c:if>
								  <c:if test="${a.status.sname=='frozen'}">
							<c:set var="salary" value="解冻"/>
   							 		<c:out value="冻结"/>
								</c:if>
                            </td>
						    <td>
						    	<input type="button" value="${salary }" onclick="updatestatus('${a.username}','freeze')"  style="font-size: xx-small;line-height:2px;padding: 0 10px;" class="button button-glow button-border button-rounded button-primary"/>
							</td>
			   			    <td>
								<img src="images/delete.png" onclick="del(${a.accountid},'freeze');"/>
							</td>
                        </tr>
                        </c:forEach>
                    </table>
                </div>
                 <!--分页-->
                <div id="pages">
                    <a href="adminAction_findAllFreeze?page.currentpage=1">首页</a>
                    <!-- a标签失效 ，交给js处理 -->
        	        <a href="javascript:void(0)" onclick="page(${page.currentpage},'last',${page.totalpage},this);" name="freeze">上一页</a>
                     ${page.currentpage }/${page.totalpage }
                    <a href="javascript:void(0)" onclick="page(${page.currentpage},'next',${page.totalpage},this);" name="freeze">下一页</a>
                    <a href="adminAction_findAllFreeze?page.currentpage=${page.totalpage} ">末页</a>
                </div>
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p>版权所有(C) 网银二组 </p>
        </div>
 </body>
</html>








