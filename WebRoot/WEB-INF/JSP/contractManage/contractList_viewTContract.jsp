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
	TrafficContract entity = (TrafficContract) ActionContext
	.getContext().get("entity");
	SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
	NumberFormat formater = NumberFormat
	.getCurrencyInstance(Locale.CHINA);
	//����������ֵ
	doc.openDataRegion("PO_identify").setValue(entity.getIdentify());
	//������������Ŀɱ༭��
	doc.openDataRegion("PO_customerName").setValue(
	entity.getCustomerName());
	doc.openDataRegion("PO_customerCode").setValue(
	entity.getCustomerCode());
	doc.openDataRegion("PO_customerAddress").setValue(
	entity.getCustomerAddress());
	doc.openDataRegion("PO_customerPeople").setValue(
	entity.getCustomerPeople());
	doc.openDataRegion("PO_customerTel").setValue(
	entity.getCustomerTel());
	doc.openDataRegion("PO_customerFax").setValue(
	entity.getCustomerFax());
	doc.openDataRegion("PO_projectName").setValue(
	entity.getProjectName());
	doc.openDataRegion("PO_projectAim")
	.setValue(entity.getProjectAim());
	if (entity.getProjectType().equals("ί�м��")) {
		doc.openDataRegion("PO_projectType1").setValue("��");
	}
	if (entity.getProjectType().equals("���ռ��")) {
		doc.openDataRegion("PO_projectType2").setValue("��");
	}
	if (entity.getProjectType().equals("ί�з���")) {
		doc.openDataRegion("PO_projectType3").setValue("��");
	}
	if (entity.getProjectType().equals("����")) {
		doc.openDataRegion("PO_projectType4").setValue("��");
	}
	if (entity.getProjectWay() == 0) {
		doc.openDataRegion("PO_projectWay1").setValue("��");
	}
	if (entity.getProjectWay() == 1) {
		doc.openDataRegion("PO_projectWayText").setValue(
		entity.getProjectWayText());
	}
	doc.openDataRegion("PO_subpackageName").setValue(
	entity.getSubpackageName());
	doc.openDataRegion("PO_subProject")
	.setValue(entity.getSubProject());
	if (entity.getPaymentWay().equals("��ȡ")) {
		doc.openDataRegion("PO_paymentWay1").setValue("��");
	}
	if (entity.getPaymentWay().equals("�Һ��ʼ�")) {
		doc.openDataRegion("PO_paymentWay2").setValue("��");
	}
	if (entity.getPaymentWay().equals("����")) {
		doc.openDataRegion("PO_paymentWay3").setValue("��");
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	doc.openDataRegion("PO_deadLine").setValue(
	sdf.format(entity.getDeadLine()));
	doc.openDataRegion("PO_costChinese").setValue(
	moneyUtils.change(entity.getCost()));
	doc.openDataRegion("PO_costLower").setValue(entity.getCost() + "Ԫ");
	if (entity.getInRoom() == 1) {
		doc.openDataRegion("PO_inRoom").setValue("��");
	}
	if (entity.getSecrecy() == 1) {
		doc.openDataRegion("PO_secrecy").setValue("��");
	}
	doc.openDataRegion("PO_other").setValue(entity.getOther());
	doc.openDataRegion("PO_entrusted").setValue(entity.getEntrusted());
	doc.openDataRegion("PO_entrustedCode").setValue(
	entity.getEntrustedCode());
	doc.openDataRegion("PO_entrustedAddress").setValue(
	entity.getEntrustedAddress());
	doc.openDataRegion("PO_entrustedTel").setValue(
	entity.getEntrustedTel());
	doc.openDataRegion("PO_Contractors").setValue(
	entity.getContractors().getName());
	doc.openDataRegion("PO_entrustedFax").setValue(
	entity.getEntrustedFax());

	DataRegion dataRegion = doc.openDataRegion("PO_itemTable");
	Table table = dataRegion.openTable(1);
	Iterator<ContractMonitoringItem> itemIterator = entity.getItems()
	.iterator();
	int i = 0;
	while (itemIterator.hasNext()) {
		ContractMonitoringItem item = itemIterator.next();
		table.openCellRC(8 + i, 2).setValue(
		item.getAnalysisCategory().getName());
		table.openCellRC(8 + i, 3).setValue(item.getSiteNum() + "");
		table.openCellRC(8 + i, 4).setValue(
		item.getAnalysisProject().getName());
		table.openCellRC(8 + i, 5).setValue(
		item.getAnalysisFrequency().getName());
		table.openCellRC(8 + i, 6).setValue(item.getOther());
		i++;
	}
	poCtrl.setTitlebar(false); //���ر�����
	//poCtrl.setMenubar(false); //���ز˵���
	poCtrl.setOfficeToolbars(false);//����Office������
	//poCtrl.setCustomToolbar(false);//�����Զ��幤����
	poCtrl.addCustomToolButton("����", "exportWord", 1);
	poCtrl.addCustomToolButton("-", "", 0);
	poCtrl.addCustomToolButton("��ӡԤ��", "printPreview", 7);
	poCtrl.addCustomToolButton("��ӡ", "printWord", 6);
	poCtrl.setSaveFilePage("savefile.jsp");
	poCtrl.setWriter(doc);
	poCtrl.setCaption("�������ҵ���ͬ(ί����)");
	poCtrl.setFileTitle(entity.getIdentify()+entity.getProjectName());
	poCtrl.setServerPage("poserver.do");
	poCtrl.webOpen("doc/trafficContract.doc",
	OpenModeType.docSubmitForm, "someBody");
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
		<input type="hidden" name="viewId" id="viewId" value="${entity.id }">
		<div style="width: auto; height: 100%;">
			<po:PageOfficeCtrl id="PageOfficeCtrl1">
			</po:PageOfficeCtrl>
		</div>
	</form>
</body>
</html>
