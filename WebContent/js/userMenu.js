/*分页*/
function page(a,b,c,d){
	if(b=="next"){
		if(a>=c){
			return;
		}
		a=a+1;
	}else{
		if(a<=1){
			return;
		}
		a=a-1;
	}
	if(d.name=="payTransactionLog"){
		location.href="adminAction_findAllSystemRecord?page.currentpage="+a;
	}else if(d.name=="userCheckTransaction"){
		location.href="action_findAllTransactionLog?page.currentpage="+a;
	}else if(d.name=="adminUsers"){
		location.href="adminAction_findAllAccount?page.currentpage="+a;
	}else if(d.name=="freeze"){
		location.href="adminAction_findAllFreeze?page.currentpage="+a;
	}else if(d.name=="su"){
		location.href="adminAction_findAllSu?page.currentpage="+a;
	}
}
/*公共部分*/
//修改密码  新密码框
function newpwd1(){
	//新密码的值
	var i = $("#newpwd").val();
	//新密码不能和原密码一样 且不能为空
	if(i != $("#oldpwd").val() && i != ""){
		$("#span2").css("color","green");
	}else{
		$("#span2").css("color","red");
	}
}
//修改密码  确认密码框
function confirmpwd1(){
	//确认框密码不能为空且要和新密码一样
	if($("#confirmpwd").val() != "" && $("#confirmpwd").val()==$("#newpwd").val()){
		$("#span3").css("color","green");
	}else{
		$("#span3").css("color","red");
	}
}
//修改密码  提交按钮
function modify1(){
//	var red = "rgb(255, 0, 0)";
	var green = "rgb(0, 128, 0)";
	//第一个*的颜色
	var i = $("#span1").css("color");
	//第二个*的颜色
	var j = $("#span2").css("color");
	//第三个*的颜色
	var k = $("#span3").css("color");
	if(i==green && j==green && k==green){
		//重点：按钮button的提交
		$('#allow').submit();
	}else{
		layer.alert("不符合条件无法提交！");
	}
//	console.log($("#span2").css("color","red"));
//	console.log($("#span3").css("color","red"));
}
//用户注销
function loginout(){
	layer.confirm('您确定注销吗？', {
		  btn: ['确定','取消'] //按钮
		}, function(){
			location.href="action_loginout";
		}, function(){
			location.reload();
	});
}

//管理员注销
function aloginout(){
	layer.confirm('您确定注销吗？', {
		  btn: ['确定','取消'] //按钮
		}, function(){
			location.href="adminAction_aloginout";
		}, function(){
			location.reload();
	});
}
//注册返回登录界面
function bak(){
	layer.confirm("您是否确定放弃注册?",{
		btn:['确定','取消']
	},function(){
		location.href="login.jsp";
	});
}

/*菜单栏跳转*/
//用户
function login(){
	location.href="action_login";
}
function userTransfer(){
	location.href="action_userTransaction"
}
function checkTransaction(){
	location.href="action_findAllTransactionLog"
}
function checkInformation(){
	location.href="action_findpersoninfo";
}

function modifyInformation(){
	location.href="action_updatepersoninfo";
}

function userModifyPassword(){
	location.href="action_userModifyPassword";
}
//管理员
function users(){
	location.href="adminAction_findAllAccount";
}
function freeze(){
	location.href="adminAction_findAllFreeze";
}
function startUsing(){
	location.href="adminAction_findAllSu";
}
function modifyNotice(){
	location.href="adminAction_updateNotice";
}
function adminModifyPassword(){
	location.href="adminAction_adminModifyPassword";
}

function systemRecord(){
	location.href="adminAction_findAllRecord";
}
function freeze(a){
	location.href="adminAction_freeze";
}

/*用户功能*/
//转账按钮
function transaction(){
	//提交判断的条件：不能为空，金额必须大于0
	if($("#errormoney").text()=="" && $("#otherid").val()!="" && $('#tr_money').val()!=""){
		//满足条件后带上参数提交
		$.getJSON("action_userTransaction?tr.otherid="+$('#otherid').val()+"&"+"tr.tr_money="+$('#tr_money').val(),function(data){
			//接受json返回的结果
			var result = data.verify;
			console.log(result);
			//将json返回的结果放在<a>中
//			$('#result').text(result);
//			layer.alert(result);
			layer.msg(result, {
			    time: 3000, //3s后自动关闭
			  });
			//如果返回的结果是"转账成功"，则清除输入框里的信息
			var a = "转账成功！";
			if(a==result){
				$('#otherid').val("");
				$('#tr_money').val("");
			}
		})
	}
}
//转账
function checkTrMoney(){
	console.log(1);
	if(!($("#tr_money").val()>0)){
		console.log(2);
		$("#errormoney").text("必须大于0");
	}else{
		$("#errormoney").text("");
	}
}
//function transaction(){
//	if($("#errormoney").text()=="" && $("#otherid").val()!=""){
//		$('#transaction').submit();
//	}
//}

//修改密码  旧密码框
function oldpwd1(){
		console.log($('#oldpwd').val());
	$.getJSON("action_oldpwd?a.password="+$('#oldpwd').val(),function(data){
		var result = data.verify;
		console.log(1);
		console.log(result);
		if(result){
			$("#span1").css("color","green");
		}else{
			$("#span1").css("color","red");
		}
	})
//	document.getElementById("span1").color="green";
//	var oldpwd1 = session.getAttribute("password");
//	var oldpwd2 = $('oldpwd').val();
//	if(oldpwd1.equals(oldpwd2)){
//		$('#span1').style("color","green");
//	}
}
//挂失
function userFreeze(){
	layer.confirm('您确定挂失吗？', {
		  btn: ['确定','取消'] //按钮
		}, function(){
		  $.getJSON("action_userFreeze",function(data){
			  layer.msg(data.verify, {
				    time: 3000, //3s后自动关闭
				  });
		  })
		}, function(){
			location.reload();
	});
}
/*管理员*/
/*修改密码*/
function oldpwd2(a){
	var oldpwd =document.getElementById("oldpwd").value;
	$.getJSON("adminAction_adminOldpwd?adm.password="+$('#oldpwd').val(),function(data){
		var result = data.verify;
		console.log(1);
		console.log(result);
		if(result){
			$("#span1").css("color","green");
		}else{
			$("#span1").css("color","red");
		}
	})
//	document.getElementById("span1").color="green";
//	var oldpwd1 = session.getAttribute("password");
//	var oldpwd2 = $('oldpwd').val();
//	if(oldpwd1.equals(oldpwd2)){
//		$('#span1').style("color","green");
//	}
}
/*修改手机号码*/
function modifyTel(){
	$("#tel").removeAttr("readonly").css("color","red");
	$("#hidden").css("display","");	
}
//保存修改的手机号码
function saveTel(){
	var f1 = $("#tel").val();
	var reg = /^\d{11}$/;
	if(reg.test(f1)){
		$.getJSON("action_updatePersoninfoByPid?p.telephone="+$("#tel").val(),function(data){
			console.log(1);
			console.log(data.verify);
			layer.alert(data.verify);
			$("#hidden").css("display","none");
			$("#tel").attr("readonly","readonly")
		});
	}else{
		layer.alert("号码无效,请重新输入！");
		$("#tel").focus();
	}
}
//变色特效
function modifyTel1(){
	$("#tel").css("color","black");
}
function modifyTel2(){
	$("#tel").css("color","red");
}



/*修改账户状态*/
function updatestatus(a,b){
	$("#main").load("adminAction_updateStatus #form",{'a.username':a,returnType:b});
	//location.href='adminAction_updateStatus?returnType=allAccount&a.username='+'${a.username}'
}


function loginout(){
	layer.confirm('您确定注销吗？', {
		  btn: ['确定','取消'] //按钮
		}, function(){
			location.href="action_loginout";
		}, function(){
			location.reload();
	});
}

//删除
function del(a,b) {
	//$("#registerform").load("action_verify #d1",{'a.username':$('#1').val()});
	//location.href="adminAction_adminDeleteAccout?a.accountid="+a;
	layer.confirm('您确定删除吗？',{
		btn:['确定','取消']
	},function(){
		$("#main").load("adminAction_adminDeleteAccout #form",{'a.accountid':a,returnType:b},function(data,status){
			if(status=='success'){
				layer.msg("删除成功", {
					time: 2000, //3s后自动关闭
				});				
			}else{
				layer.msg("操作失败，请稍后再试", {
					time: 2000, //3s后自动关闭
				});	
			}
		})
	},function(){
		return;
	});
}
/*function del1(a) {
	//$("#registerform").load("action_verify #d1",{'a.username':$('#1').val()});
	//location.href="adminAction_adminDeleteAccout?a.accountid="+a;
	$("#main").load("adminAction_adminFreeze #form",{'a.accountid':a});
}
function del2(a) {
	//$("#registerform").load("action_verify #d1",{'a.username':$('#1').val()});
	//location.href="adminAction_adminDeleteAccout?a.accountid="+a;
	$("#main").load("adminAction_adminSu #form",{'a.accountid':a});
}*/
/*注册验证*/
//注册
function register(){
	location.href="action_register";
}
function exit(){
	layer.alert("确认退出当前账号");
}
function back(){
	layer.alert("是否放弃注册？");
}
function add(){
	/*if($("#1").val()==""
			||$("#newpwd").val()==""
			||$("#confirmpwd").val()==""
			||$("#4").val()==""
			||$("#money").val()==""
			||$("#name").val()==""
			||$("#age").val()==""
			||$("#8").val()==""
			||$("#phone").val()==""
			||$("#person").val()==""){		
		  layer.alert("请输入完整信息");
	}else if(
			$("#span4").text("请输入正确的银行卡号")
			||$("#span5").text("请输入数字")
			||$("#span6").text("请输入正确的姓名格式(如:周杰伦 或者 Cherish)")
			||$("#span7").text("请输入1-120之间的数字")
			||$("#span8").text("号码格式有误，请重新输入(提示:由11位数字组成)")
			||$("#span9").text("证件号码有误(提示18位纯数字或17位纯数字+1位大写英文字母)")
			||$("#span9").text("身份证已被注册")
		){
		layer.alert("请完善信息(error:输入信息有误)");
	}*/
	
	if(
		$("#s1").html()=="可以使用！"
		&&$("#span2").css("color")=="rgb(0, 128, 0)"
		&&$("#span3").css("color")=="rgb(0, 128, 0)"
		&&$("#span4").html()=="正确"
		&&$("#span5").html()=="正确"
		&&$("#span6").html()=="正确"
		&&$("#span7").html()=="正确"
		&&$("#span8").html()=="正确"
		&&$("#span9").html()=="可以使用!"
	){
		$('#main').submit();
	}else{
		layer.alert("请完善信息(error:输入信息有误)");
	}	
}
//验证银行卡号(cardid)
function checkCardid(){
	var cardid = $("#cardid").val();
	var reg = /^2000[0-9]{12}$/;
	console.log($("#span4").val());
	if(!reg.test(cardid)){
		$("#span4").text("请输入正确的银行卡号");
	}else{
		$("#span4").text("正确");
		$("#span4").css("color","black");
	}
}
//验证姓名
function checkName(){
	var name = $("#name").val();
	var reg = /^([\u4E00-\u9FA5]+|[a-zA-Z]+)$/;
	if(!reg.test(name)){
		$("#span6").text("请输入正确的姓名格式(如:周杰伦 或者 Cherish)");
	}else{
		$("#span6").text("正确");
		$("#span6").css("color","black");
	}
}
//验证用户名
function f2(){
	// location.href="action_verify?a.username="+$('#1').val();
	$.getJSON("action_verify?a.username="+$('#1').val(),function(data){
		if(data.verify=="可以使用！"){
			$("#s1").text(data.verify);
			$("#s1").css("color","black");
		}else{
			$("#s1").text(data.verify);
		}
	})
	//$("#registerform").load("action_verify #d1",{'a.username':$('#1').val()});
	//$("#registerform").load("action_verify?a.username="+$('#1').val());
}
//验证年龄
//范围1-120
function checkAge(){
	var age = $("#age").val();
	var reg = /(^([1-9][0-9]?|1[01][0-9]|120)$)/;
	if(!reg.test(age)){
		$("#span7").text("请输入1-120之间的数字");
	}
	else{
		$("#span7").text("正确");
		$("#span7").css("color","black");
	}
}
//验证手机号
function  checkPhone(){
	var phone = $("#phone").val();
	/*
	 * 固话=区号(3位到4位)+固话(8位)
	 * 手机号=首位('1')+剩余(10位数字)
	 */
	if(!(/(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^1[0-9]{10}$)/.test(phone))){
		$("#span8").text("号码格式有误，请重新输入(提示:由11位数字组成)");
	}else{
		$("#span8").text("正确");
		$("#span8").css("color","black");
	}
}
//验证开户金额
function checkMoney(){
	var money = $("#money").val();
	var reg = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
	if(!reg.test(money)){
		$("#span5").text("请输入数字");
	}else{
		$("#span5").text("正确");
		$("#span5").css("color","black");
	}
}
//用户登录
function userslogin(){
	$.getJSON("action_login",$('#form').serialize(),function(data){
		if(data.loginmsg=="success"){
			location.href="action_toUserIndex";
		}else{
			$("#login_result").text(data.loginmsg);
		}
				})
}

//验证证件号
function checkPerson(){
	/*var person = $("#person").val();
	var reg = /(^d{15}$)|(^\d{17}([0-9]|X)$)/;*/
	$.getJSON("action_qwe?a.personinfo.pid="+$("#person").val(),function(data){
		if(data.qwe=="可以使用!"){
			$("#span9").text(data.qwe);
			$("#span9").css("color","black");
		}else{
			$("#span9").text(data.qwe);
		}
		/*if(!(reg.test(person))){
			$("#span9").text("证件号码有误(提示18位纯数字或17位纯数字+1位

大写英文字母)");
		}else{
			$("#span9").text(data.qwe);
			$("#span9").css("color","black");
		}*/
	})
}
function res(){
	$("#s1").text("");
	$("#span4").text("");
	$("#span5").text("");
	$("#span6").text("");
	$("#span7").text("");
	$("#span8").text("");
	$("#span9").text("");
}

function loginload(a){
	document.getElementById('a.username').focus();
	if(a!=""){
		layer.alert(a);
	}
	
}

/*$(document).ready(function(){
	$('#starttime').Zebra_DatePicker();	
	$('#endtime').Zebra_DatePicker();	
});*/


function selectByDate(){
	/*alert($("#starttime").val());
	alert($("#endtime").val());*/
	if($("#starttime").val()==""||$("#endtime").val()==""){
		layer.alert("请选择时间");
		//location.href="action_findAllTransactionLog?page.currentpage=1";
	}else{
		location.href="action_findUserTransactionByDate?starttime="+$("#starttime").val()+" 00:00:00"+"&endtime="+$("#endtime").val()+" 24:00:00";	
	}
	
}

function downloadByDate(){
	if($("#starttime").val()==""||$("#endtime").val()==""){
		layer.alert("请选择时间");
		//return;
	}else{
		location.href="action_downloadAllTransactionLogByDatetime?starttime="+$("#starttime").val()+" 00:00:00"+"&endtime="+$("#endtime").val()+" 24:00:00";	
	}
}

