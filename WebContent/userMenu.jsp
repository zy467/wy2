<%@page pageEncoding="utf-8"%>
<script type="text/javascript" src="js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="js/userMenu.js"></script>
<script type="text/javascript" src="layer-v3.0.1/layer/layer.js"></script>
<!-- 此JSP是被其他JSP引用的，即所有的请求中都可以引用此JSP,所以无法判断当前访问的路径是谁,就不适合写相对路径 -->
<ul id="menu">
	<!-- 主页 -->
    <li><a href="action_toUserIndex" class="index_off"></a></li>
    <!-- 转账 -->
    <li><a href="action_userTransfer" class="fee_off"></a></li>
    <!-- 交易记录 -->
    <li><a href="action_findAllTransactionLog?page.currentpage=1" class="account_off"></a></li>
    <!-- 查询个人信息 -->
    <li><a href="action_findpersoninfo" class="information_off"></a></li>
    <!-- 挂失 javascript:void(0):单击这个超链接什么都不会发生，即超链接跳转 -->
    <li><a href="javascript:void(0)" onclick="userFreeze();" class="report_off"></a></li>
    <!-- 修改密码 -->
    <li><a href="action_userModifyPassword" class="password_off"></a></li>
</ul>
 
