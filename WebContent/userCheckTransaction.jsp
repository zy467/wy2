<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>用户查询交易记录</title>
        <link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/button.css" />
        
        <!--  时间控件样式-->
        <link rel="stylesheet" href="Zebra_Datepicker/public/css/default.css" type="text/css"/>
       	<link type="text/css" rel="stylesheet" href="Zebra_Datepicker/examples/libraries/syntaxhighlighter/public/css/shCoreDefault.css"/>
        
       
        <!--  时间控件-->
        <script type="text/javascript" src="Zebra_Datepicker/examples/libraries/syntaxhighlighter/public/javascript/XRegExp.js"></script>
        <script type="text/javascript" src="Zebra_Datepicker/examples/libraries/syntaxhighlighter/public/javascript/shCore.js"></script>
        <script type="text/javascript" src="Zebra_Datepicker/examples/libraries/syntaxhighlighter/public/javascript/shLegacy.js"></script>
        <script type="text/javascript" src="Zebra_Datepicker/examples/libraries/syntaxhighlighter/public/javascript/shBrushJScript.js"></script>
        <script type="text/javascript" src="Zebra_Datepicker/examples/libraries/syntaxhighlighter/public/javascript/shBrushXml.js"></script>

       
        <script type="text/javascript" src="js/userMenu.js"></script>
        
          <script type="text/javascript">
            SyntaxHighlighter.defaults['toolbar'] = false;
            SyntaxHighlighter.all();
        </script>
        


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
                    
                    <input id="starttime" name="starttime" style="width: 95px"/>-----<input id="endtime" name="endtime" style="width: 95px"/>
                    <input type="button" value="时间查询" onclick="selectByDate();" style="font-size: xx-small;line-height:2px;padding: 0 10px;" class="button button-glow button-border button-rounded button-primary"/>
                    <input type="button" value="按时间下载" onclick="downloadByDate();" style="font-size: xx-small;line-height:2px;padding: 0 10px;" class="button button-glow button-border button-rounded button-primary"/>
                        <!--<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="基费" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="时长" class="sort_asc" onclick="sort(this);" />-->
                    </div>
                  
                    <!-- <input type="button" value="按金额查询" class="btn_add" onclick="" /> -->
                    <input type="button" value="生成报表" onclick="location.href='action_toPlot'" style="font-size: xx-small;line-height:2px;padding: 0 10px;" class="button button-glow button-border button-rounded button-primary"/>
                    <input type="button" value="下载表格" onclick="location.href='action_downloadAllTransactionLog'" style="font-size: xx-small;line-height:2px;padding: 0 10px;" class="button button-glow button-border button-rounded button-primary"/>
                    
                </div> 
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist" style="margin-top: 16px;">
                        <tr>
                            <th>对方账户</th>
                            <th>交易金额</th>
                            <th>交易类型</th>
                            <th>订单状态</th>
                            <th>交易日期</th>
                        </tr>
                        <c:forEach items="${t}" var="a">                      
                        <tr>
                            <td>
                        <%--      <c:if test="${a.otherAccount=='100000'}">
   							 		<c:out value="平台一"/>
								</c:if>
								<c:if test="${a.otherAccount=='200000'}">
   							 		<c:out value="平台二"/>
								</c:if> --%>
								<c:choose>
								   <c:when test="${a.otherAccount=='100000'}">
								      <c:out value="平台一"/>
								   </c:when>
								   <c:when test="${a.otherAccount=='200000'}">
								      <c:out value="平台二"/>
								   </c:when>
								 <c:otherwise>
								       ${a.otherAccount}
								   </c:otherwise>
								</c:choose>
                            </td>
                            <td><%-- ${a.tr_money} --%>
                            <fmt:formatNumber value="${a.tr_money}" pattern="#.00"/>
                            </td>
                            <td>${a.type.typename}</td>
                            <td>
                                <c:if test="${a.orderstatus==0}">
   							 		<c:out value="失败"/>
								</c:if>
                            	<c:if test="${a.orderstatus==1}">
   							 		<c:out value="成功"/>
								</c:if>
								<c:if test="${a.orderstatus==3}">
   							 		<c:out value="退款"/>
								</c:if>
							</td>
                            <td><%-- ${a.datetime} --%>
                            <fmt:formatDate type="time" value="${a.datetime}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                           
                        </tr>
                        </c:forEach>
                    </table>
                </div>
                <!--分页-->
                <div id="pages">
                    <a href="action_findAllTransactionLog?page.currentpage=1">首页</a>
        	        <a href="javascript:void(0)" onclick="page(${page.currentpage},'last',${page.totalpage},this);" name="userCheckTransaction">上一页</a>
                     ${page.currentpage }/${page.totalpage }
                    <a href="javascript:void(0)" onclick="page(${page.currentpage},'next',${page.totalpage},this);" name="userCheckTransaction">下一页</a>
                    <a href="action_findAllTransactionLog?page.currentpage=${page.totalpage} ">末页</a>
                </div>
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p>版权所有(C) 网银二组 </p>
        </div>
        
        <!--  时间控件-->
        <script type="text/javascript" src="Zebra_Datepicker/public/javascript/jquery-1.12.0.js"></script>
        <script type="text/javascript" src="Zebra_Datepicker/public/javascript/zebra_datepicker.js"></script>
        <!-- 例子 -->
        <script type="text/javascript" src="Zebra_Datepicker/examples/public/javascript/core.js"></script>
       
        <script type="text/javascript" src="js/datepicker.js"></script>
    </body>
</html>