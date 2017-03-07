<%@page pageEncoding="utf-8"%> 
        <script type="text/javascript" src="js/userMenu.js"></script>
        <script type="text/javascript" src="js/jquery-1.11.1.js"></script>
        <script type="text/javascript" src="layer-v3.0.1/layer/layer.js"></script>
<!-- 此JSP是被其他JSP引用的，即所有的请求中都可以引用此JSP,所以无法判断当前访问的路径是谁,就不适合写相对路径 -->
<ul id="menu">
	<!-- 主页 -->
    <li><a href="adminAction_toAdminIndex" class="index_off"></a></li>
    <!-- 所有账户 -->
    <li><a href="adminAction_findAllAccount?page.currentpage=1" class="role_off"></a></li>
    <!-- 系统账单 -->
    <li><a href="adminAction_findAllSystemRecord?page.currentpage=1" class="bill_off"></a></li>
    <!-- 修改密码 -->
   	<li><a href="adminAction_adminModifyPassword" class="password_off"></a></li>
</ul>
 
