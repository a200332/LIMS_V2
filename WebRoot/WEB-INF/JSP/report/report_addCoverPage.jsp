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
	Project project = entity.getProject();
	int reportType = entity.getType();
	String type = "";
	String fileName = "";
	if (reportType == 0) {
		fileName = project.getContractId() + "�������Ա������";
		type = "��";
	}
	if (reportType == 1) {
		fileName = project.getContractId() + "������ⱨ�����";
		type = "��";
	}
	if (reportType == 2) {
		fileName = project.getContractId() + "ˮ�ʼ�ⱨ�����";
		type = "ˮ";
	}
	if (reportType == 3) {
		fileName = project.getContractId() + "������ⱨ����";
		type = "����";
	}
	if (reportType == 4) {
		fileName = project.getContractId() + "��ҵ�������̳����Ա������";
		type = "����";
	}
	String identify = entity.getIdentify();
	String[] ids = StringSplitUtils.splite(identify, "-");
	String year = ids[0];
	String id = ids[1];
	if (year != null && id != null && type != "") {
		doc.openDataRegion("PO_year").setValue(year);
		doc.openDataRegion("PO_identify").setValue(id);
		doc.openDataRegion("PO_type").setValue(type);
	}
	//poCtrl.setTitlebar(false); //���ر�����
	poCtrl.setMenubar(false); //���ز˵���
	//poCtrl.setOfficeToolbars(false);//����Office������
	//poCtrl.setCustomToolbar(false);//�����Զ��幤����
	poCtrl.addCustomToolButton("����", "saveWord", 1);
	poCtrl.addCustomToolButton("-", "", 0);
	poCtrl.addCustomToolButton("������", "viewProjectBook", 7);
	if (project.getGainSample().equals("1")) {
		poCtrl.addCustomToolButton("��Ʒ��Ϣ", "viewSelfSendInfo", 7);
	}
	if (project.getGainSample().equals("0")) {
		poCtrl.addCustomToolButton("��Ʒ��Ϣ", "viewNonSelfSendInfo", 7);
	}

	poCtrl.addCustomToolButton("��������", "viewQualityControl", 7);
	poCtrl.addCustomToolButton("�ͼ쵥", "viewInspectionSheet", 7);
	poCtrl.addCustomToolButton("��¼��˱�", "viewRecordAudit", 7);
	poCtrl.setSaveFilePage("savefile.jsp?id=2&&title="
			+ MD5Utils.GetMD5Code(fileName + UUIDGenerator.getUUID()));
	poCtrl.setWriter(doc);
	poCtrl.setCaption(fileName);
	poCtrl.setFileTitle(fileName);
	poCtrl.setServerPage("poserver.do");
	poCtrl.webOpen("doc/reportCover.doc", OpenModeType.docNormalEdit,
			"");
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
	function saveWord() {

		document.getElementById("PageOfficeCtrl1").WebSave();
		if (!$("#reportId").val() && $("#reportId").val() == "") {
			document.getElementById("PageOfficeCtrl1").Alert(
					"��ⱨ�汣��ʧ�ܣ���ˢ�º����³��ԣ�");
			return false;
		}
		var re = confirm("�Ƿ񱣴浱ǰ��ⱨ����棿")
		if (re == true) {
			var path = document.getElementById("PageOfficeCtrl1").CustomSaveResult;
			if (path && path != "") {
				$
						.ajax({
							url : "report_report_saveRecordCover.action",
							data : {
								'viewId' : $("#reportId").val(),
								'reportPath' : path
							},
							async : false,
							success : function(data) {
								var json = eval('(' + data + ')');
								if (json.info == "success") {
									document.getElementById("PageOfficeCtrl1")
											.Alert("��ⱨ�汣��ɹ���");
									if (json.year && json.identify && json.id) {
										document
												.getElementById("PageOfficeCtrl1").DataRegionList
												.GetDataRegionByName("PO_year").Value = json.year;
										document
												.getElementById("PageOfficeCtrl1").DataRegionList
												.GetDataRegionByName("PO_identify").Value = json.identify;
										$("#reportId").attr("value", json.id);
									}

								}
								if (json.info == "failed") {
									document.getElementById("PageOfficeCtrl1")
											.Alert("��ⱨ�汣��ʧ�ܣ���ˢ�º����³��ԣ�");
								}
								return false;
							}
						});
			}
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
	function viewQualityControl() {
		var id = $('#projectId').val();
		$('#iframe').attr("src",
				"qualityControl_qualityControl_viewPage.action?viewId=" + id);
	}
	function viewProjectBook() {
		var id = $('#projectId').val();
		$('#iframe').attr(
				"src",
				"contractManage_projectBook_viewProjectBook.action?viewId="
						+ id);
	}
	function viewSelfSendInfo() {
		var id = $('#projectId').val();
		$('#iframe').attr(
				"src",
				"selfSendSampleInfo_selfSendSampleInfo_viewPage.action?viewId="
						+ id);
	}
	function viewNonSelfSendInfo() {
		var id = $('#projectId').val();
		$('#iframe').attr(
				"src",
				"nonSelfSendSample_nonSelfSendSample_viewPage.action?viewId="
						+ id);
	}
	function viewRecordAudit() {
		var id = $('#projectId').val();
		$('#iframe').attr("src",
				"resultAudit_resultAudit_viewPage.action?viewId=" + id);
	}
	function viewInspectionSheet() {
		var id = $('#projectId').val();
		$('#iframe').attr(
				"src",
				"selfSendSampleInfo_inspectionSheet_viewReportPage.action?viewId="
						+ id);
	}
</script>
</head>
<body>
	<form id="form1">
		<input type="hidden" name="projectId" id="projectId"
			value="${entity.project.id }"> <input type="hidden"
			name="reportId" id="reportId" value="${entity.id }">
		<div style="width: 50%; height: 100%; float: left;" id="report">
			<po:PageOfficeCtrl id="PageOfficeCtrl1">
			</po:PageOfficeCtrl>
		</div>
		<div style="width:50%;height: 100%;float: left;" id="info">
			<iframe id="iframe" src="" width="100%" scrolling="yes" height="100%">
			</iframe>
		</div>
	</form>
</body>
</html>
