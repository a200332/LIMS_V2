$(function() {
	$("#usual1 ul").idTabs();
	$('.tablelist tbody tr:odd').addClass('odd');
	$('.viewProjectBook').click(function() {
		var id = $(this).attr("data-id");
		asyncbox.open({
			title : '查看合同任务书',
			url : 'contractManage_projectBook_viewProjectBook.action?viewId=' + id,
			width : 1000,
			height : 550,
			btnsbar : $.btn.CANCEL,
			callback : function(action, opt) {
			}
		});
	});
	
	
	$('.viewDeliveryReceitp').click(function(){
		var id = $(this).attr("data-id");
		asyncbox.open({
			title : '查看交联单信息',
			url : 'selfSendSampleInfo_deliveryReceitp_viewPage.action?viewId=' + id,
			width : 1000,
			height : 700,
			btnsbar : $.btn.CANCEL,
			callback : function(action, opt) {
			}
		});
	});
	$('.viewNonDeliveryReceitp').click(function(){
		var id = $(this).attr("data-id");
		asyncbox.open({
			title : '查看交联单信息',
			url : 'nonSelfSendSample_deliveryReceitp_viewPage.action?viewId=' + id,
			width : 1000,
			height : 700,
			btnsbar : $.btn.CANCEL,
			callback : function(action, opt) {
			}
		});
	});
	
	$('.viewInspectionSheet').click(function(){
		var typeNum = $(this).data("type");// 送检单的类型
		var itemId = $(this).data("id");// 监测项目的id
		var viewId = $(this).data("projectid");
		if (typeNum == 0) {
			asyncbox
					.open({// 水质
						title : '水质样品送检单',
						top:0,
						url : 'selfSendSampleInfo_inspectionSheet_viewWaterDetailPage.action?viewId='
								+ viewId
								+ '&itemId='
								+ itemId,
						width : 1100,
						height : 700,
						btnsbar : $.btn.CANCEL,
					});
		}
		if (typeNum == 1) {
			asyncbox
					.open({// 土壤
						title : '土壤、底质样品送检单',
						top:0,
						url : 'selfSendSampleInfo_inspectionSheet_viewSoilDetailPage.action?viewId='
								+ viewId
								+ '&itemId='
								+ itemId,
								width : 1100,
								height : 700,
						btnsbar : $.btn.CANCEL,
					});
		}
		if (typeNum == 2) {
			asyncbox
					.open({// 固定污染源
						title : '固定污染源有组织废气样品送检单',
						top:0,
						url : 'selfSendSampleInfo_inspectionSheet_viewSolidDetailPage.action?viewId='
								+ viewId
								+ '&itemId='
								+ itemId,
								width : 1100,
								height : 700,
						btnsbar : $.btn.CANCEL,
					});
		}
		if (typeNum == 3) {// 环境空气
			asyncbox
					.open({
						title : '环境空气和无组织废气样品送检单',
						top:0,
						url : 'selfSendSampleInfo_inspectionSheet_viewAirDetailPage.action?viewId='
								+ viewId
								+ '&itemId='
								+ itemId,
								width : 1100,
								height : 700,
						btnsbar : $.btn.CANCEL,
					});
		}
	});
	$('.referAll').click(function(){
		var id=$(this).attr("data-id");
		asyncbox.open({
			title : '项目审核页面',
			url : 'resultAudit_resultAudit_referPage.action?viewId=' + id,
			width : 850,
			height : 500,
			btnsbar: [{
				text: '审　核', 
				action: 'save' 
			}].concat($.btn.CANCEL),
			callback : function(action, opt) {
				var oForm=$(opt.document).find("#auditForm");
				var hasSave=0;
				if(action=="save"){
					var oChecks=oForm.find('input[type=radio]:checked');
					var result=0;
					var str="";
					oChecks.each(function(){
						if($(this).prop("value")!=1){
							result=1;
						}
					});
					if(result==0){
						// 全部选“是”
						str="是否对该合同项目进行原始记录审核，您的审核意见为<b style='color:red;'>【审核通过】</b>，审核完成后您将无法修改审核结果，项目即将进入下一流程！";
					}else{
						// 选择了“否”
						str="是否对该合同项目进行原始记录审核，您的审核意见为<b style='color:red;'>【审核不通过】</b>，审核完成之后您将无法修改审核结果，项目即将返回实验分析流程！";
					}
					asyncbox.confirm(str, '业务流转', function(action) {
						if (action == 'ok') {
							$.ajax({
								url:"resultAudit_resultAudit_add.action?resultType="+result,
								data:oForm.serialize(), 
								async:false,
								success:function(data){
									var json = eval('('+data+')');
									if(json.info=="success"){
										asyncbox.alert("审核成功！", '结果',function(){
											window.location.reload();
										});						
									}
									if(json.info=="failed"){
										asyncbox.error("审核失败，请刷新之后重新尝试！", '结果');
									}
									return false;
								}
							});
						}
					});
					return false;
				}
			}
		});
	});
	$('.delRecord').click(function(){
		var id=$(this).attr("data-id");
		asyncbox.confirm('是否删除当前已经存在的原始记录表？','警告', function(action) {　
			if (action == 'ok') {
				$.ajax({
					url:"detectionResult_detectionResult_deleteRecord.action",
					data:{'viewId':id},
					async:false,
					success:function(data){
						var json = eval('('+data+')');
						if(json.info=="success"){
							asyncbox.alert("删除成功！", '结果',function(){
								window.location.reload();
							});						
						}
						if(json.info=="failed"){
							asyncbox.error("删除失败，请刷新之后重新尝试！", '结果');
						}
						return false;
					}
				});
			}
		});
	});
	$('.viewQualityControl').click(function(){
		var id = $(this).attr("data-id");
		asyncbox.open({
			title : '查看质量控制统计信息',
			url : 'qualityControl_qualityControl_viewPage.action?viewId=' + id,
			width : 1100,
			height : 700,
			btnsbar : $.btn.CANCEL,
			callback : function(action, opt) {
			}
		});
	});
	
	$('.downRecord').click(function(){
		var id=$(this).attr("data-id");
		asyncbox.open({
			title : '查看原始记录表',
			url : 'detectionResult_detectionResult_viewPage.action?viewId=' + id,
			width : 1100,
			height : 700,
			btnsbar : $.btn.CANCEL,
			callback : function(action, opt) {
			}
		});
	});
	$('.export').click(function(){
		var viewId=$(this).attr('data-projectId');
		var itemId=$(this).attr("data-id");
		asyncbox.confirm('是否下载该送检单？', '警告', function(action) {　
			if (action == 'ok') {
				window.location.href="selfSendSampleInfo_inspectionSheet_export.action?viewId="+viewId+"&itemId="+itemId;
			}　　　　　
		});
	});
	$('.model').click(function(){
		asyncbox.open({
			title : '查看原始记录表',
			url : 'commonTemplet_commonTemplet_choosePage.action?type=0',
			width : 850,
			height : 500,
			btnsbar : $.btn.CANCEL,
			callback : function(action, opt) {
			}
		});
	});
	function testMessage() {
		asyncbox
				.open({
					title : '消息队列',
					url : 'mainPage_showMessageQueue.action',
					width : 520,
					height : 500,
					btnsbar : [ {
						text : '全部忽略',
						action : 'delete'
					} ].concat($.btn.CANCEL),
					callback : function(action, opt) {
						if (action == 'delete') {
							$
									.ajax({
										url : "pushMessage_ignoreMessageAll.action",
										async : false,
										success : function(data) {
											var json = eval('(' + data + ')');
											if (json.info == "success") {
												asyncbox.alert('全部忽略成功 !',
														'忽略结果');
												window.parent.parent.frames["topFrame"].location
														.reload();
											}
										}
									});
						}
					}
				});
	}
	document.testMessage = testMessage;
});