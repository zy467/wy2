<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>用户查看个人信息</title>
        <link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/button.css" /> 
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
            <form action="action_updatePersoninfoByPid" id="saveTel" method="post">
                <!--排序-->
                <div class="search_add">
                    <div>
                        <!--<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="基费" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="时长" class="sort_asc" onclick="sort(this);" />-->
                    </div>
                    <input type="button" value="修改手机号码" onclick="modifyTel();" style="font-size: small;line-height:25px;padding: 0 12px;" class="button button-glow button-border button-rounded button-primary"/>
                    <span>
                    	<input type="button" value="保存" id="hidden" style="display: none;font-size: small;" onclick="saveTel();" class="button button-glow button-border button-rounded button-primary"/>
                	</span>
                </div>
                <br></br> 
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
							<td>账户编号：</td>
							<td>${p.account.accountid}</td>
						</tr>
						<tr>
							<td>姓名：</td>
							<td>${p.realname }</td>
						</tr>
						<tr>
							<td>年龄：</td>
							<td>${p.age}</td>
						</tr>
						<tr>
							<td>性别：</td>
							<td>${p.sex}</td>
						</tr>
						
						<tr>
							<td>手机号码：</td>
							<td><input type="text" style="text-align: center;" name="p.telephone" readonly="readonly" id="tel" value="${p.telephone}" onblur="modifyTel1();" onclick="modifyTel2();"/></td>
						</tr>
						<tr>
							<td>身份证号码：</td>
							<td>${p.pid}</td>
						</tr>
						<tr>
							<td>账户卡号：</td>
							<td>${p.cardid}</td>
						</tr>
						<tr>
							<td>余额：</td>
							<td><%-- ${p.account.balance} --%>
							<fmt:formatNumber value="${p.account.balance}" pattern="#.00"/>
							</td>
						</tr>
                    </table>
         		</div>
         	</form>
         </div>
    </body>
</html>

