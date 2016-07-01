<%@page import="com.boncontact.util.StringSplitUtils"%>
<%@page import="com.boncontact.domain.InspectionSheet"%>
<%@page import="com.boncontact.util.MD5Utils"%>
<%@page import="com.boncontact.domain.OriginalRecord"%>
<%@page import="com.boncontact.domain.Project"%>
<%@page import="com.boncontact.domain.ProjectBook"%>
<%@page import="com.boncontact.domain.ContractMonitoringItem"%>
<%@page import="com.boncontact.util.moneyUtils"%>
<%@page import="com.boncontact.domain.TrafficContract"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java"
	import="java.util.*,com.zhuozhengsoft.pageoffice.wordwriter.*,com.zhuozhengsoft.pageoffice.*,java.sql.*,java.text.NumberFormat,java.util.Locale,java.text.SimpleDateFormat,java.util.Date"
	pageEncoding="gb2312"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%
	String err = "";
	PageOfficeCtrl poCtrl = new PageOfficeCtrl(request);
	//����WordDocment����
	WordDocument doc = new WordDocument();
	//����������
	InspectionSheet entity = (InspectionSheet) ActionContext.getContext()
			.get("entity");
	Project pj=entity.getProject();
	String username = (String) ActionContext.getContext().get(
			"username");
	String[] paths = StringSplitUtils.splite(entity.getResultPath(), "/");
	poCtrl.setTitlebar(true); //���ر�����
	//poCtrl.setMenubar(false); //���ز˵���
	poCtrl.setOfficeToolbars(false);//����Office������
	//poCtrl.setCustomToolbar(false);//�����Զ��幤����
	poCtrl.addCustomToolButton("����", "saveWord", 1);
	poCtrl.addCustomToolButton("����", "exportWord", 13);
	poCtrl.addCustomToolButton("-", "", 0);
	poCtrl.addCustomToolButton("��ӡԤ��", "printPreview", 7);
	poCtrl.addCustomToolButton("��ӡ", "printWord", 6);
	poCtrl.setSaveFilePage("savefile.jsp?id=1&&title="+(paths[1]!=null?paths[1]:MD5Utils.GetMD5Code(pj.getContractId()+"ԭʼ��¼��")));
	poCtrl.setWriter(doc);
	poCtrl.setCaption(pj.getContractId()+"ԭʼ��¼�޸ĸ�");
	poCtrl.setFileTitle(pj.getContractId()+"ԭʼ��¼�޸ĸ�");
	poCtrl.setServerPage("poserver.do");
	poCtrl.webOpen(entity.getResultPath(), OpenModeType.docNormalEdit,
			username);
	
	poCtrl.setTagId("PageOfficeCtrl1");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<link href="css/cssReset.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="asyncbox/skins/ZCMS/asyncbox.css" />
<script src="js/jquery-1.11.3.min.js" type="text/javascript"
	charset="utf-8"></script>
<script src="asyncbox/AsyncBox.v1.4.js" type="text/javascript"
	charset="utf-8"></script>
<script type="text/javascript">
	function saveWord() {
		document.getElementById("PageOfficeCtrl1").WebSave();
		var path =document.getElementById("PageOfficeCtrl1").CustomSaveResult;
		 if(path&&path!=""){
			$.ajax({
				url:"detectionResult_detectionResult_saveRecord.action",
				data:{'projectId':$('#projectId').val(),'recordPath':path},
				async:false,
				success:function(data){
					var json = eval('('+data+')');
					if(json.info=="success"){
						document.getElementById("PageOfficeCtrl1").Alert( "ԭʼ��¼�޸ĳɹ���" );					
					}
					if(json.info=="failed"){
						document.getElementById("PageOfficeCtrl1").Alert( "ԭʼ��¼�޸�ʧ�ܣ���ˢ�º����³��ԣ�" );
					}
					return false;
				}
			});
		} 
	}
	function exportWord() {
		document.getElementById("PageOfficeCtrl1").ShowDialog(3);
	}
	function printWord() {
		document.getElementById("PageOfficeCtrl1").ShowDialog(4);
	}
	function printPreview() {
		document.getElementById("PageOfficeCtrl1").PrintPreview();
	}
</script>
</head>
<body>
	<form id="form1">
		<input type="hidden" name="projectId" id="projectId" value="${projectId }">
		<div style="width: auto; height: 100%;">
			<po:PageOfficeCtrl id="PageOfficeCtrl1">
			</po:PageOfficeCtrl>
		</div>
	</form>
</body>
</html>
