<%@page import="com.boncontact.util.StringSplitUtils"%>
<%@page import="com.boncontact.domain.Report"%>
<%@page import="com.boncontact.util.UUIDGenerator"%>
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
	Report entity = (Report) ActionContext.getContext().get("entity");
	String path = StringSplitUtils.splite(entity.getPath(), "/")[1];
	String identify = entity.getIdentify();
	String[] ids = StringSplitUtils.splite(identify, "-");
	String year = ids[0];
	String id = ids[1];
	if (year != null) {
		doc.openDataRegion("PO_year").setValue(year);
		doc.openDataRegion("PO_identify").setValue(id);
	}
	//poCtrl.setTitlebar(false); //���ر�����
	poCtrl.setMenubar(false); //���ز˵���
	//poCtrl.setOfficeToolbars(false);//����Office������
	//poCtrl.setCustomToolbar(false);//�����Զ��幤����
	poCtrl.addCustomToolButton("����", "exportWord", 1);
	poCtrl.addCustomToolButton("-", "", 0);
	poCtrl.addCustomToolButton("��ӡԤ��", "printPreview", 7);
	poCtrl.addCustomToolButton("��ӡ", "printWord", 6);
	poCtrl.setSaveFilePage("savefile.jsp?id=1&&title=" + path);
	poCtrl.setWriter(doc);
	if (entity.getType() == 0) {
		poCtrl.setCaption(entity.getIdentify() + "�������Ա���");
		poCtrl.setFileTitle(entity.getIdentify() + "�������Ա���");
	}
	if (entity.getType() == 1) {
		poCtrl.setCaption(entity.getIdentify() + "������ⱨ��");
		poCtrl.setFileTitle(entity.getIdentify() + "������ⱨ��");
	}
	if (entity.getType() == 2) {
		poCtrl.setCaption(entity.getIdentify() + "ˮ�ʼ�ⱨ��");
		poCtrl.setFileTitle(entity.getIdentify() + "ˮ�ʼ�ⱨ��");
	}
	if (entity.getType() == 3) {
		poCtrl.setCaption(entity.getIdentify() + "������ⱨ��");
		poCtrl.setFileTitle(entity.getIdentify() + "������ⱨ��");
	}
	if (entity.getType() == 4) {
		poCtrl.setCaption(entity.getIdentify() + "��ҵ�������̳����Ա���");
		poCtrl.setFileTitle(entity.getIdentify() + "��ҵ�������̳����Ա���");
	}
	
	poCtrl.setServerPage("poserver.do");
	poCtrl.webOpen(entity.getPath(), OpenModeType.docReadOnly, "");
	poCtrl.setTagId("PageOfficeCtrl1");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/select.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="asyncbox/skins/ZCMS/asyncbox.css" />
<script src="js/jquery-1.11.3.min.js" type="text/javascript"
	charset="utf-8"></script>
<script src="asyncbox/AsyncBox.v1.4.js" type="text/javascript"
	charset="utf-8"></script>
<script type="text/javascript">
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
		<input type="hidden" name="reportId" id="reportId">
		<div style="width: 100%; height: 100%; float: left;" id="report">
			<po:PageOfficeCtrl id="PageOfficeCtrl1">
			</po:PageOfficeCtrl>
		</div>
	</form>
</body>
</html>
