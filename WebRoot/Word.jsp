<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page
	import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*,javax.servlet.*,javax.servlet.http.*,java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%
	/* Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");//���������������
	String strUrl = "jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ="
			+ this.getServletContext().getRealPath("demodata/")
			+ "\\demo.mdb";
	Connection conn = DriverManager.getConnection(strUrl);
	Statement stmt = conn.createStatement();
	String id = request.getParameter("ID");
	ResultSet rs = stmt.executeQuery("select * from resumes where ID = " + id); */
	
	SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");

	//-----------  PageOffice �������˱�̿�ʼ  -------------------//
	WordDocument doc = new WordDocument();
	DataRegion dataReg = doc.openDataRegion("PO_table");
	//dataReg.setEditing(true);
	Table table = dataReg.openTable(1);
	/* if (rs.next()) {

		table.openCellRC(1, 2).setValue(rs.getString("Name"));
		table.openCellRC(1, 4).setValue(formatDate.format(formatDate.parse(rs.getString("BirthDate"))));
		String photoUrl = rs.getString("PhotoUrl");
		if (photoUrl != null && photoUrl != "") {
			//��ʾͼƬ
			table.openCellRC(1, 5).setValue("[image]" + photoUrl + "[/image]");
		}
		table.openCellRC(2, 2).setValue(rs.getString("Sex"));
		table.openCellRC(2, 4).setValue(rs.getString("EduGrade"));
		table.openCellRC(3, 2).setValue(rs.getString("Profession"));
		table.openCellRC(3, 4).setValue(rs.getString("Job"));
		table.openCellRC(4, 2).setValue(rs.getString("Experience"));
		table.openCellRC(5, 2).setValue(rs.getString("PersonalAbility"));
		table.openCellRC(6, 3).setValue(rs.getString("Address"));
		table.openCellRC(7, 3).setValue(rs.getString("Email"));
		table.openCellRC(8, 3).setValue(rs.getString("Phone"));
	}
	rs.close();
	stmt.close();
	conn.close(); */
	table.openCellRC(1, 2).setValue("����");
	table.openCellRC(1, 4).setValue(formatDate.format(new Date()));
	String photoUrl = "images/backup.jpg";
	if (photoUrl != null && photoUrl != "") {
		//��ʾͼƬ
		table.openCellRC(1, 5).setValue("[image]" + photoUrl + "[/image]");
	}
	table.openCellRC(2, 2).setValue("��");
	table.openCellRC(2, 4).setValue("��ѧ����");
	table.openCellRC(3, 2).setValue("Profession");
	table.openCellRC(3, 4).setValue("JOB");
	table.openCellRC(4, 2).setValue("Experience");
	table.openCellRC(5, 2).setValue("PersonalAbility");
	table.openCellRC(6, 3).setValue("Address");
	table.openCellRC(7, 3).setValue("Email");
	table.openCellRC(8, 3).setValue("Phone");
	

	// ����PageOffice�������ҳ��

	PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);
	poCtrl1.setServerPage("poserver.do"); //���б���

	// ����Զ��幤������ť
	poCtrl1.addCustomToolButton("����", "Save()", 1);
	//���ع�����
	poCtrl1.setMenubar(false);

	// ���ñ����ĵ��ķ�����ҳ��
	poCtrl1.setSaveDataPage("savefile.jsp");
	////��ȡ���ݶ���
	poCtrl1.setWriter(doc);
	// ���ĵ�
	poCtrl1.webOpen("doc/test2.doc", OpenModeType.docNormalEdit, "Tom");
	poCtrl1.setTagId("PageOfficeCtrl1"); //���б���
	//-----------  PageOffice �������˱�̽���  -------------------//
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema"
			content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body>
		<form id="form1" method="post">

			<!-- *********************pageoffice�����ʹ�� **************************-->
			<script type="text/javascript">
				//����
				function Save() {
					 document.getElementById("PageOfficeCtrl1").WebSave();
			         if (document.getElementById("PageOfficeCtrl1").CustomSaveResult == "ok") {
			         	alert('����ɹ�');
			         }
				}
			</script>
			<po:PageOfficeCtrl id="PageOfficeCtrl1" />
			<!-- *********************pageoffice�����ʹ�� **************************-->

		</form>
	</body>
</HTML>
