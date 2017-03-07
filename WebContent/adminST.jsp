<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>管理员查询系统交易记录</title>
        <link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" />
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
            <form action="adminAction_findAllSystemRecord" method="post">
                <!--排序-->
                <div class="search_add">
                    <div>
                        <!--<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="基费" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="时长" class="sort_asc" onclick="sort(this);" />-->
                    </div>
                </div> 
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th>序号</th>
                            <th>交易金额</th>
                            <th>交易时间</th>
                            <th>订单状态</th>
                            <th>交易类型</th>
                            <th>流水号</th>
                            <th>绑卡协议号</th>
                        </tr>
                        <c:forEach items="${record}" var="pay">                      
                        <tr>
                            <td>${pay.trid}</td>
                            <td><%-- ${pay.tr_money} --%>
                            <fmt:formatNumber value="${pay.tr_money}" pattern="#.00"/>
                            </td>
                            <td><%-- ${pay.datetime} --%>
                             <fmt:formatDate type="time" value="${pay.datetime}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                            <td><%-- ${pay.orderstatus} --%>
                               <c:if test="${pay.orderstatus==0}">
   							 		<c:out value="失败"/>
								</c:if>
                            	<c:if test="${pay.orderstatus==1}">
   							 		<c:out value="成功"/>
								</c:if>
								<c:if test="${pay.orderstatus==3}">
   							 		<c:out value="退款"/>
								</c:if>
                            </td>
                            <td>${pay.type.typename}</td>
                            <td>${pay.paymentsn}</td>
                            <td>${pay.bound.bid}</td>
                        </tr>
                        </c:forEach>
                    </table>
                </div>
                 <!--分页-->
                <div id="pages">
                    <a href="adminAction_findAllSystemRecord?page.currentpage=1">首页</a>
                    <!-- a标签失效 ，交给js处理 -->
        	        <a href="javascript:void(0)" onclick="page(${page.currentpage},'last',${page.totalpage},this);" name="payTransactionLog">上一页</a>
                     ${page.currentpage }/${page.totalpage }
                    <a href="javascript:void(0)" onclick="page(${page.currentpage},'next',${page.totalpage},this);" name="payTransactionLog">下一页</a>
                    <a href="adminAction_findAllSystemRecord?page.currentpage=${page.totalpage} ">末页</a>
                </div>
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p>版权所有(C) 网银二组 </p>
        </div>
    </body>
</html>