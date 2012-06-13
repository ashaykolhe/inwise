<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes-dynattr.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<s:useActionBean beanclass="com.inwise.action.SearchActionBean" event="redirectorderpopup" var="in"></s:useActionBean>
<%
    request.setAttribute("invoice",in.getInvoice());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>INVOICE</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script language="javascript">
	function wait(msecs)
	{
		var start = new Date().getTime();
		var cur = start;
		while(cur - start < msecs)
		{
			cur = new Date().getTime();
		}
	}
	function callPrint(invoiceid)
	{
		document.getElementById('inPrint').style.display='none';
		document.getElementById('inClose').style.display='none';

		window.print();
		wait(3000);

		document.getElementById('buyer').value="DUPLICATE FOR TRANSPORTER";
		window.print();
		wait(3000);


		document.getElementById('buyer').value="COPY FOR ASSESSEE";
		window.print();
		wait(3000);


		document.getElementById('buyer').value="EXTRA COPY";
		window.print();
		wait(3000);

		Disp();
		OpenPopuppdf(invoiceid);
		return true;
	}
	function Disp()
	{
		document.getElementById('inPrint').style.display='inline';
		document.getElementById('inClose').style.display='inline';
	}
	function OpenPopuppdf(invoiceid){
		var w = 850;
		var h = 900;
		var winl = (screen.width-w)/2;
		var wint = (screen.height-h)/2;
		if (winl < 0) winl = 0;
		if (wint < 0) wint = 0;

		var page = "PdfGenerateServlet?id="+invoiceid;
		windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,"
		+ "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
		window.open(page, "Popup", windowprops);

	}
    $(document).ready(function(){
            $('#printPDF').click(function(){
                        alert("in pdf creation");
                $('#hide').css("display","none");
                $('#content').attr("value",$('#printContent').html());

            });
        });

</script>
</head>
<body style="margin-left:50px;">

<div align="center" style="margin-left:2px;" id="printContent">
	<s:form beanclass="com.inwise.action.SearchActionBean">
			<table width="760px" align="center" cellspacing="0" cellpadding="0" border="0" style="color:#000000;">
			<tr>
				<td colspan="6">
					<div align="center" style="margin-left:7px; font-family:Copperplate Gothic Light; font-size:16px">
						INVOICE
					</div>
					<div align="center" style="margin-left:7px; font-family:Vrinda; font-size:15px">
						(UNDER RULE 11 OF CENTRAL EXCISE RULES, 2002)
					</div>
					<div align="right" style="margin-left:7px">
						<input name="buyer" id="buyer" type="text" value="ORIGINAL FOR BUYER"  size="35" readonly="readonly" style="font-family:Vrinda; font-size:15px; border:0px; text-align:right; background-color: white;">
					</div>
				</td>
			</tr>
			<tr>
				<td nowrap style="background:#ffffff; color:#000000; border-left:2px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
					<img style="margin-left:7px;" src="images/WE.jpg" height="40px" width="40px" align="center">				</td>
				<td width="200" nowrap style="background:#ffffff; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
					<div align="left" style="margin-left:7px; margin-right:7px; font-family:Times New Roman; font-size:14px">
						<b>WELDTECH ENGINEERS</b>
						<div style="margin-left:7px; font-family:Times New Roman; font-size:11px">
							AT:LAING<br>PO:KANSBAHAL<br>DIST:SUNDARGARH<br>ORISSA,INDIA
						</div>
					</div>
				</td>
				<td width="250" nowrap style="background:#ffffff; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
					<div align="left" style="margin-left:7px; margin-right:7px; font-family:Times New Roman; font-size:11px;">
						Tel No. : 06624-280433<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						: 092387-23033<br>Fax No. :06624-280433<br>E-Mail : weldtech_engineers@rediffmail.com
					</div>
				</td>
				<td width="20" nowrap style="background:#ffffff; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
					<div align="center" style="font-family:Times New Roman; font-size:11px">
						<img style="margin-left:0px; margin-top:5px;" src="images/Time.JPG">
					</div>
				</td>
				<td width="140" nowrap valign="top" style="background:#ffffff; color:#000000;">
					<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tr>
							<td width="70" nowrap style="background:#ffffff; height:26px; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
									<div align="center" style="font-family:Times New Roman; font-size:9px">
										DATE
									</div>
							</td>
							<td nowrap style="background:#ffffff; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
								<div align="center" style="font-family:Verdana; font-size:9px">
									<b>24/05/2012</b>
								</div>
							</td>
						</tr>
						<tr>
							<td nowrap style="background:#ffffff; height:26px; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
								<div align="center" style="font-family:Times New Roman; font-size:9px">
									ISSUE
								</div>
							</td>
							<td nowrap style="background:#ffffff; height:25px; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
								<div align="center" style="font-family:Times New Roman; font-size:9px">

										<b>11:00 AM</b>

								</div>
							</td>
						</tr>
						<tr>
							<td nowrap style="background:#ffffff; height:27px; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
								<div align="center" style="margin-bottom:5px; font-family:Times New Roman; font-size:9px">
									REMOVAL
								</div>
							</td>
							<td nowrap style="background:#ffffff; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
								<div align="center" style="font-family:Times New Roman; font-size:9px">

										<b>12:00 AM</b>

								</div>
							</td>
						</tr>
					</table>
				</td>
				<td width="110" nowrap align="left" valign="top" style="background:#ffffff; color:#000000;">
					<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tr>
							<td nowrap style="background:#ffffff; height:40px; color:#000000; border-top:2px solid #000000; border-right:2px solid #000000; border-bottom:1px  solid #000000;">
								<div align="left" style="margin-left:1px; font-family:Times New Roman; font-size:11px">
									INVOICE NO.
									<div align="right" style="margin-right:1px; font-family:Verdana; font-size:11px;">
										<b>${invoice.invoiceNumber}</b>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td nowrap style="background:#ffffff; height:40px; color:#000000; border-right:2px solid #000000; border-bottom:1px  solid #000000;">
								<div align="left" style="margin-left:2px; font-family:Times New Roman; font-size:9px">
									DATE
									<div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
										<b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoice.createDate}"/></b>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<table width="100%"  align="center" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td width="353px" valign="top" style="background:#ffffff; height:37px; color:#000000; height:100px; border-left:2px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
								<div align="left" style="margin-left:7px; margin-top:5px; font-family:Times New Roman; font-size:9px">
									INVOICE TO :
									<div align="left" style="margin-left:60px; margin-right:7px; font-family:Verdana; font-size:9px;">
										<b>blank</b>
									</div>
									<div align="left" style="margin-left:68px; margin-top:5px; font-family:Times New Roman; font-size:9px">
									Tin No :
									<div align="left" style="margin-left:45px;  margin-top:-14px; margin-right:7px; font-family:Verdana; font-size:9px;">
										<b>
															<b>${invoice.customer.tinNo}</b>
														</b>
									</div>
								</div>
								<div align="left" style="margin-left:68px; margin-top:5px; font-family:Times New Roman; font-size:9px">
									Ecc No :
									<div align="left" style="margin-left:45px;  margin-top:-14px; margin-right:7px; font-family:Verdana; font-size:9px;">
										<b>
															<b>${invoice.customer.eccNo}</b>
														</b>
									</div>
								</div>
								</div>
							</td>
							<td width="302px" valign="top" style="background:#ffffff; height:37px; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
								<div align="left" style="margin-left:7px; margin-top:5px; font-family:Times New Roman; font-size:9px; ">
									CONSIGNEE :
									<div align="left" style="margin-left:55px; font-family:Verdana; font-size:9px;">
                                        <b>${invoice.order.consigneeName}</b>

									</div>
									<div align="left" style="margin-left:55px; font-family:Verdana; font-size:9px;">
										<b>blank</b>
									</div>
								</div>
							</td>
							<td nowrap valign="top" style="background:#ffffff; color:#000000;">
								<div align="left">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="50%" nowrap style="background:#ffffff; height:50px; color:#000000; border-right:2px solid #000000;">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Des. Adv. No.
													<div align="right" style="margin-right:7px; margin-top:5px; font-family:Times New Roman; font-size:9px;">

															<b>${invoice.desAdvNo}</b>

													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td width="50%" nowrap style="background:#ffffff; height:50px; color:#000000; border-right:2px solid #000000; border-bottom:1px  solid #000000;">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Date
													<div align="right" style="margin-right:1px; margin-top:5px; font-family:Verdana; font-size:9px;">
														<b>blank</b>
													</div>
												</div>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<table width="100%"  align="center" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td width="137px" valign="top" style="background:#ffffff; height:30px; color:#000000; border-left:2px solid #000000; border-right:1px solid #000000; border-bottom:2px  solid #000000;">
								<div align="left" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px">
									SALES REP CODE :
									<div align="right" style="margin-right:3px; font-family:Verdana; font-size:9px">
										 ${invoice.salesRepCode}
									</div>
								</div>
							</td>
							<td width="215px" valign="top" style="background:#ffffff; height:28px; color:#000000; border-right:1px solid #000000; border-bottom:2px  solid #000000;">
								<div align="left" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px; ">
									STATION FROM :
									<div align="right" style="margin-right:3px; font-family:Verdana; font-size:9px;">
										<b>Kansbahal</b>
									</div>
								</div>
							</td>
							<td width="302px" valign="top" style="background:#ffffff; height:28px; color:#000000; border-right:1px solid #000000; border-bottom:2px  solid #000000;">
								<div align="left" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px; ">
									STATION TO :
									<div align="right" style="margin-right:3px; font-family:Verdana; font-size:9px;">

											<b>${invoice.stationto}</b>

									</div>
								</div>
							</td>
							<td nowrap valign="top" style="background:#ffffff; color:#000000; border-right:2px solid #000000; border-bottom:2px  solid #000000;">
								<div align="left" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px">
									FGN No.
									<div align="right" style="margin-right:3px; font-family:Times New Roman; font-size:9px;">

											<b>${invoice.fgnNo}</b>

									</div>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="100%" colspan="6">
					<table width="100%"  align="center" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td width="186" valign="top" style="background:#ffffff; height:37px; color:#000000; border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
						  <div align="center" style="margin-left:0px; margin-right:0px; margin-top:5px; font-family:Times New Roman; font-size:9px">
									REGION & BR A/C CODE
									<div align="right" style="margin-left:1px; margin-right:1px; font-family:Verdana; font-size:9px;">


												${invoice.regBr}


									</div>
								</div>
							</td>
					  <td width="210" valign="top" style="background:#ffffff; height:37px; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
			  <div align="left" style="margin-left:7px; margin-top:5px; font-family:Times New Roman; font-size:9px; ">
									CUSTOMER CODE :
									<div align="right" style="margin-right:7px; margin-top:7px; font-family:Verdana; font-size:9px;">
										<b>${invoice.customer.customerCode}</b>
									</div>
								</div>
							</td>
					  <td width="430" valign="top" style="background:#ffffff; height:37px; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="left" style="margin-left:7px; margin-top:5px; font-family:Times New Roman; font-size:9px; ">
									CUSTOMER ORDER No. :
								</div>
								<div align="right" style="margin-right:7px; margin-left:140px; margin-top:-15px; font-family:Verdana; font-size:9px; ">
									<b>${invoice.order.customerOrderNo}</b>
								</div>
								<div align="left" style="margin-left:7px; margin-top:7px; font-family:Times New Roman; font-size:9px">
									DATE :
								</div>

								<div align="right" style="margin-right:7px; margin-top:-15px; font-family:Verdana; font-size:9px; ">
									<b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoice.order.createDate}"/></b>
								</div>
							</td>

                              <td width="250" valign="top" style="background:#ffffff; height:37px; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="left" style="margin-left:7px; margin-top:5px; font-family:Times New Roman; font-size:9px; ">AMENDMENT NO. :
								</div>
								<div align="right" style="margin-right:7px; margin-left:140px; margin-top:-15px; font-family:Verdana; font-size:9px; ">

											${invoice.order.amendmentNo}

										</div>

								<div align="left" style="margin-left:7px; margin-top:7px; font-family:Times New Roman; font-size:9px">
									AMENDMENT DATE :
								</div>
								<div align="right" style="margin-right:7px; margin-top:-15px; font-family:Verdana; font-size:9px; ">

										<b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoice.order.amendmentDate}"/></b>

								</div>
							</td>

                      <td width="178" valign="top" nowrap style="background:#ffffff; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="left" style="margin-left:7px; margin-right:7px; margin-top:5px; font-family:Times New Roman; font-size:9px">
									CONTRACT NOTE No. & DATE
									<div align="right" style="margin-top:5px; font-family:Verdana; font-size:9px">

											<b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoice.contNoteDate}"/></b>

									</div>
								</div>
							</td>
					  </tr>
					</table>
				</td>
			</tr>
            <td colspan="6" style="border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;border-top:1px solid #000000;">
                	<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
                  	<tr>
                    	<td width="159" valign="top" style="background:#ffffff;  border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;"><div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px">
								ITEM NO.
							</div>
					  </td>
                    	<td width="153" valign="top" style="background:#ffffff;  border-right:1px solid #000000; border-bottom:1px  solid #000000;">
			  <div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px; ">
								CSH NO.
							</div>
					  </td>
               		  <td width="671" valign="top" style="background:#ffffff;  border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px; ">
								COMMODITY/DESCRIPTION
						</div>
					  </td>
               		  <td width="103" nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style="margin-top:2px; font-family:Times New Roman; font-size:9px">
								QTY
						</div>
					  </td>
                 		<td width="170" nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style=" margin-top:2px; font-family:Times New Roman; font-size:9px">
								RATE
								<div align="center" style="margin-right:7px; font-family:Times New Roman; font-size:14px">
									<img src="images/Rupee.JPG"/>
								</div>
							</div>
					  </td>
                  		<td width="211" valign="top" nowrap style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
					  <div align="center" style=" margin-top:2px; font-family:Times New Roman; font-size:9px">
								AMOUNT
								<div align="center" style="margin-right:7px; font-family:Times New Roman; font-size:14px">
									<img src="images/Rupee.JPG"/>
								</div>
							</div>
					  </td>
					</tr>
                       <c:forEach items="${invoice.invoiceDetail}" var="invoicedetail" varStatus="loop" >
                <c:forEach items="${invoice.order.orderDetail}" var="orderdetail" varStatus="loop1"  >
                    <c:if test="${invoicedetail.product.id eq orderdetail.product.id}">
						<tr style="border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;height:50px">
	                    	<td valign="top" style="background:#ffffff; border-right:1px solid #000000;border-left:1px solid #000000; ">
								<div align="center" style="margin-top:7px; font-family:Verdana; font-size:9px">

											${invoicedetail.drawingNo}

								</div>
							</td>
	                    	<td valign="top" style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="center" style="margin-top:7px; font-family:Verdana; font-size:9px; ">
									${invoicedetail.cshNo}
								</div>
							</td>
							<td valign="top" style="background:#ffffff;  border-right:1px solid #000000; ">
							<strong>	<div align="left" style="margin-left:7px; margin-top:7px; font-family:Verdana; font-size:9px; ">
									${invoicedetail.productCategory.type}&nbsp; Of :-
								</div>
								<div align="left" style="margin-left:7px; margin-top:2px; font-family:Verdana; font-size:9px; ">
									 ${invoicedetail.product.productName}
								</div></strong>
							</td>
							<td nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000;">
								<div align="center" style="margin-top:7px; font-family:Verdana; font-size:9px">
									${invoicedetail.dispatching}
                                    <c:if test="${invoicedetail.product.productMeasurementType.measurementType eq 'MT'}">
                                        <span style="margin-top:0px ; border:0px; text-align:right; background-color: #ccffcc; font-size: 12px;">MT</span>
                                    </c:if>
                                    <c:if test="${invoicedetail.product.productMeasurementType.measurementType eq 'unit'}">
                                        <span style="margin-top:0px ; border:0px; text-align:right; background-color: #ccffcc; font-size: 12px;">unit</span>
                                    </c:if>

								</div>
							</td>
	                    	<td nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="center" style="margin-right:1px; margin-left:1px; margin-top:7px; font-family:Verdana; font-size:9px">


									 ${invoicedetail.productCost}


								</div>
							</td>
							<td valign="top" nowrap style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="right" style="margin-right:1px; margin-left:1px; margin-top:7px; font-family:Verdana; font-size:9px">
								<strong	>

								${invoicedetail.dispatching * invoicedetail.productCost}

</strong>
								</div>
							</td>
						</tr>
                      </c:if>
                </c:forEach></c:forEach>
				</table>
			</td>
            </tr>
		<tr>
			<td colspan="6" valign="top" style="background:#ffffff; height:24px; border-left:1px solid #000000;border-top:1px solid #000000; border-right:1px solid #000000; border-bottom:2px  solid #000000;">
				<div align="left" style="margin-left:7px; margin-top:2px; font-family:Verdana; font-size:9px">
					<b>* Remarks :</b>
                 </div>
				<div align="left" style="margin-top: -12px; margin-left:75px; font-family:Verdana; font-size:9px;">

											nill

				</div>
			</td>
		</tr>
		<tr>
				<td colspan="6">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                	<td width="116px" style="background:#ffffff; border-left:2px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                      	<div align="center" style="margin-left:1px; margin-right:1px;margin-top:0px; margin-bottom:2px; font-family:Times New Roman; font-size:9px">
                      		ASSEMBLE VALUE (AS PER SECTION 4)
                      	</div>
                      	</td>
              		<td width="22px" rowspan="4" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
                        <div align="center" style="margin:0px">

                            <img src="images/Other Charges.JPG" align="top" style="margin-left:0px; margin-top:2px;" width="14" height="94">
                          </div>
                    </td>
                    <td width="92px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                      	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:2px; font-family:Times New Roman; font-size:9px">
                      		EXCISE<br>PAYABLE
                      	</div>
                      	<div align="right" style="margin-right:1px; margin-top:2px; margin-bottom:2px; font-family:Verdana; font-size:9px">
                      		1.0%
                      	</div>
                    </td>
                    <td width="78px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                 	  	<div align="left" style="margin-left:1px; margin-top:2px; font-family:Times New Roman; font-size:9px">
                 	  		E.CESS PAYABLE
                 	  	</div>
                 	  	<div align="right" style="margin-right:1px; margin-top:2px; margin-bottom:2px; font-family:Verdana; font-size:9px">
                 	  		2.0%
                 	  	</div>
                 	  </td>
                 	  <td width="75px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                      	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:2px; font-family:Times New Roman; font-size:9px">
                      		S&H EDU CESS PAYABLE
                      	</div>
                      	<div align="right" style="margin-right:1px; margin-top:2px; margin-bottom:0px; font-family:Verdana; font-size:9px">
                      		3.0%
                      	</div>
                      </td>
                      <td width="92px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                      	<div align="center" style="margin-left:1px; margin-left:1px; margin-top:2px; font-family:Times New Roman; font-size:9px">
                      		AMOUNT ON WHICH SALES TAX PAYABLE
                      	</div>
                      </td>
                      <td width="82px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">

                      	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:2px; font-family:Times New Roman; font-size:9px">

                      		OVAT

                      		<br>PAYABLE
                      	</div>
                      	<div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
                      		6.0%
                      	</div>
                      </td>
                      <td width="90px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                      	<div align="center" style="font-family:Times New Roman; font-size:9px">
                      		TOTAL AMOUNT
                      	</div>
                      </td>
                      <td valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:1px solid #000000;">
                      <strong>	<div align="right" style="margin-right:0px; margin-top:0px; margin-bottom:1px; font-family:Verdana; font-size:9px">
                      		10000
                      	</div></strong>
                      </td>
                </tr>
                 <tr>
                    <td rowspan="2" valign="center" width="116px" style="background:#ffffff; border-left:2px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="right" style="margin-right:1px; margin-top:5px; font-family:Verdana; font-size:9px">
                    		<img align="left" style="margin-left:1px;" src="images/Rupee.JPG" width="10" height="13">
                    			10000
                    	</div>
                   </td>
                    <td style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                    <div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
	                    	0
	                    </div>
	                </td>
	                <td style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
                    	<div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
                    		0
                    	</div>
                    </td>
                    <td style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
                    	<div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
                    		0
                    	</div>
                    </td>
                    <td style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
                    	<div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
                    		10000
                    	</div>
                    </td>
                    <td style="background:#ffffff; height:25px; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
                    		600
                    	</div>
                   </td>
                   <td rowspan="2" width="84px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
                    		ADD OTHER CHARGES
                    	</div>
                    </td>
                    <td rowspan="2" valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:1px solid #000000;">
                    	  <strong><div align="right" style="margin-right:0px; margin-top:0px; margin-bottom:1px; font-family:Verdana; font-size:9px">
                    		1342
                    	</div></strong>
                    </td>
                  </tr>
                  <tr>
                	 <td colspan="5" valign="center" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                      	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:5px; font-family:Times New Roman; font-size:9px">
                      		&nbsp;<b>*</b> EXCISE DUTY PAYABLE UNDER RULE-A FOR CENTRAL EXCISE RULES-2002.
                      	</div>
                	</td>
                  </tr>
                  <tr>
                    <td width="116px" valign="top" style="background:#ffffff; border-left:2px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
                    	<div align="left" style="margin-left:1px; margin-top:2px; margin-bottom:0px; font-family:Times New Roman; font-size:9px;">
                    		RATE OF EXCISE DUTY BED-1.0% EDU.CESS-2.0% S & H Edu. CESS-3.0%
                    	</div>
                    </td>

                    <td width="87px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="left" style="margin-left:2px; margin-top:10px; font-family:Times New Roman; font-size:9px">
                    		FREIGHT
                    	</div>
                    	<div align="right" style="margin-right:1px; margin-left:1px; margin-top:5px; font-family:Verdana; font-size:9px">
                    		0.0
                    	</div>
                    </td>
					<td width="72px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="left" style="margin-left:2px; margin-top:10px; font-family:Times New Roman; font-size:9px">
                    		INSURANCE
                    	</div>
                    	<div align="right" style="margin-right:1px; margin-left:1px; margin-top:5px; font-family:Verdana; font-size:9px">
                    		0.0
                    	</div>
                    </td>
                    <td width="80px" colspan="2" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="left" style="margin-left:0px; margin-top:10px; font-family:Times New Roman; font-size:9px">
                    		OTHERS
                    	</div>
                    	<div align="right" style="margin-right:1px; margin-left:0px; margin-top:5px; font-family:Verdana; font-size:9px">
                    		0.0
                    	</div>
                    </td>
                    <td valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="left" style="margin-left:7px; margin-top:10px; font-family:Times New Roman; font-size:9px">
                    		ENTRY TAX&nbsp;&nbsp;7.0%
                    	</div>
                    	<div align="right" style="margin-right:1px; margin-left:1px; margin-top:5px; font-family:Verdana; font-size:9px">
                    		742.0
                    	</div>
                    </td>
                    <td valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Verdana; font-size:9px">
                    		<strong>GRAND TOTAL</strong>
                    	</div>
                    </td>
                    <td valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:1px solid #000000;">
                    	  <strong><div align="right" style="margin-right:0px; margin-top:0px; margin-bottom:1px;  font-family:Verdana; font-size:9px;">
                    		11342
                    	</div></strong>
                    </td>
                 </tr>
                </table>
               </td>
			</tr>

            <tr>
				<td colspan="6">
	              	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                	<tr>
	                		<td width="116px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-left:2px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="left" style="margin-left:1px; margin-left:1px; margin-top:2px; font-family:Times New Roman; font-size:9px">
	                       	  	DEBIT ENTRY NO.
	                       	  </div>
	                       	  <div align="right" style="margin-right:1px; margin-left:1px; margin-top:2px; font-family:Verdana; font-size:9px">

										1

	                    		</div>
	                        </td>
	                    	<td width="88px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                    		<div align="left" style="margin-left:2px; margin-top:2px; font-family:Times New Roman; font-size:9px">
	                    			DATE
	                    		</div>
	                    		<div align="right" style="margin-right:1px; margin-left:1px; margin-top:2px; font-family:Verdana; font-size:9px">

										2012/05/24

	                    		</div>
	                   		</td>
	                        <td style="background:#ffffff; border-right:2px solid #000000; border-bottom:1px solid #000000;">
	                    		<div align="left" style="margin-right:1px; margin-top:2px; font-family:Verdana; font-size:9px">
	                    			<img align="left" style="margin-left:1px;" src="images/Rupee.JPG" width="10" height="13">
	                    			&nbsp;&nbsp;&nbsp;&nbsp;
	                    		<strong>	 Eleven Thousand Three Hundred and Forty Two Only</strong>
	                    		</div>
	                   		</td>
						</tr>
	                </table>
				</td>
            </tr>
			<tr>
            	<td colspan="6">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                	<tr>
	                		<td width="44px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-left:2px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	SALES TAX FORM

	                       	  </div>
	                        </td>
	                        <td width="161px">
	                        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        	<tr>
		                        		<td colspan="4" valign="middle" style="height: 25px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
												SALES TAX CODE
											</div>
		                        		</td>
		                        	</tr>
		                        	<tr>
		                        		<td valign="middle" style="height: 42px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
												&nbsp;
											</div>
		                        		</td>
		                        		<td valign="middle" style="height: 35px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
												&nbsp;
											</div>
		                        		</td>
		                        		<td valign="middle" style="height: 35px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
												&nbsp;
											</div>
		                        		</td>
		                        		<td valign="middle" style="height: 35px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
												&nbsp;
											</div>
		                        		</td>
		                        	</tr>
	                        	</table>
							</td>
							<td width="357px">
	                        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        	<tr>
		                        		<td colspan="3" valign="middle" style="height: 25px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
												ADVANCE / PROGRESS PAYMENT RECEIPT NO. & DATE
											</div>
		                        		</td>
		                        	</tr>
		                        	<tr>
		                        		<td width="135px" valign="middle" style="height: 15px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
												RECEIPT NO.
											</div>
		                        		</td>
		                        		<td width="92px" valign="middle" style="height: 15px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
												DATE
											</div>
		                        		</td>
		                        		<td width="135px" valign="middle" style="height: 15px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
												<img align="left" style="margin-left:1px;" src="images/Rupee.JPG" width="10" height="13">
												AMOUNT
											</div>
		                        		</td>
		                        	</tr>
		                        	<tr>
		                        		<td valign="middle" style="height: 26px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">

													-

											</div>
		                        		</td>
		                        		<td valign="middle" style="height: 25px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">


													-

											</div>
		                        		</td>
		                        		<td valign="middle" style="height: 25px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">

													-

											</div>
		                        		</td>
		                        	</tr>
		                        </table>
							</td>
							<td width="91px" valign="middle" style="height: 25px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
								<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
									LESS ADVANCES
								</div>
							</td>
							<td valign="middle" style="height: 25px; background:#ffffff; border-right:2px solid #000000; border-bottom:1px solid #000000;">
								<strong><div align="right" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
									0.0
								</div></strong>
							</td>
						</tr>
	                </table>
				</td>
            </tr>
            <tr>
            	<td colspan="6">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                	<tr>
	                		<td width="562" valign="middle" style="height:18px; background:#ffffff; border-right:1px solid #000000; border-left:2px solid #000000; border-bottom:2px solid #000000;">
	                       	  <div align="left" style="margin-left:1px; margin-right:5px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	DOCUMENTS THROUGH :
	                       	  </div>
	                       	  <div align="left" style="margin-right:1px; margin-left:120px; margin-top:-13px; font-family:Verdana; font-size:9px">

										90&nbsp;

	                    		</div>
	                        </td>
	                        <td width="91px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:2px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
	                       	  	<strong>NET PAYABLE</strong>
	                       	  </div>
	                        </td>
	                        <td valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:2px solid #000000;">
	                       	 <strong> <div align="right" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
	                       	  	11342
	                       	  </div></strong>
	                        </td>
	                    </tr>
					</table>
            	</td>
            </tr>
			<tr>
            	<td colspan="6">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                	<tr>
	                		<td width="122PX" valign="middle" style="height:18px; background:#ffffff; border-right:1px solid #000000; border-left:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	MODE OF DISPATCH
	                       	  </div>
	                        </td>
	                        <td width="104px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	NO. OF PACKAGES
	                       	  </div>
	                        </td>
	                        <td width="112px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	VEHICLE NO.
	                       	  </div>
	                        </td>
	                        <td width="313" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	RR / GCN NO.
	                       	  </div>
	                        </td>
	                        <td valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	DATE
	                       	  </div>
	                        </td>
	                    </tr>
	                    <tr>
	                		<td width="122PX" valign="middle" style="height:25px; background:#ffffff; border-right:1px solid #000000; border-left:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">

										hi&nbsp;

	                       	  </div>
	                        </td>
	                        <td width="104px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">

										10&nbsp;

	                       	  </div>
	                        </td>
	                        <td width="112px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">

										n123&nbsp;

	                       	  </div>
	                        </td>
	                        <td valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">

										lj&nbsp;

	                       	  </div>
	                        </td>
	                        <td valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
	                       	  	24/05/2012
	                       	  </div>
	                        </td>
	                    </tr>
					</table>
            	</td>
            </tr>
            <tr>

	        	<td colspan="6" valign="middle" style="height:22px; background:#ffffff;border-left:2px solid #000000;border-top:1px solid #000000; border-right:2px solid #000000; border-bottom:1px solid #000000;">
	           		<div align="left" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	            		EXCISE	::
	                </div>
	                <div align="left" style="margin-left:90px; margin-right:1px; margin-top:-13px; font-family:Verdana; font-size:9px">
	                	<img align="left" style="margin-left:1px;" src="images/Rupee.JPG" width="10" height="13">
	                	&nbsp;&nbsp;&nbsp;&nbsp;
	                	<strong> Only</strong>
	            	</div>
	            </td>
			</tr>
			<tr>
	        	<td colspan="6" valign="middle" style="height:20px; background:#ffffff;border-left:2px solid #000000; border-right:2px solid #000000; border-bottom:1px solid #000000;">
	            	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	            		E.CESS ::
	                </div>
	                <div align="left" style="margin-left:90px; margin-right:1px; margin-top:-13px; font-family:Verdana; font-size:9px">
	                	<img align="left" style="margin-left:1px;" src="images/Rupee.JPG" width="10" height="13">
	                	&nbsp;&nbsp;&nbsp;&nbsp;
	                	<strong> Only</strong>
	            	</div>
	            </td>
			</tr>
			<tr>
	        	<td colspan="6" valign="middle" style="height:20px; background:#ffffff;border-left:2px solid #000000; border-right:2px solid #000000; border-bottom:2px solid #000000;">
	            	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	            		S & H EDU.CESS ::
	                </div>
	                <div align="left" style="margin-left:90px; margin-right:1px; margin-top:-13px; font-family:Verdana; font-size:9px">
	                	<img align="left" style="margin-left:1px;" src="images/Rupee.JPG" width="10" height="13">
	                	&nbsp;&nbsp;&nbsp;&nbsp;
	                	<strong> Only</strong>
	            	</div>
	            </td>
			</tr>
			<tr>
				<td colspan="6" valign="middle" style="height:25px; background:#ffffff; border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	            	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px; text-align: justify;">
	            		WE HEREBY CERTIFY THAT OUR REGISTRATION CERTIFICATE UNDER THE ORISSA SALES TAX ACT / IS IN FORCE ON THE DATE ON WHICH THE SALE OF THE GOODS SPECIFIED
	            		IN THIS BILL IS MADE BY US AND THAT THE TRANSACTION OF SALE COVERED BY THIS BILL HAS BEEN EFFECTED BY US IN THE REGULAR COURSE OF OUR BUSINESS.
	            	</div>
	            </td>
			</tr>
			<tr>
				<td colspan="6" valign="middle" style="height:25px; background:#ffffff; border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	            	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px; text-align: justify;">
	            		IF ANY EXEMPTION / REDUCTION OF TAX UNDER ORISSA / CENTRAL SALES TAX ACT IS CLAIMED BY YOU VALID DECLARATION (DUPLICATE IN CASE OF CENTRAL SALES TAX) MUST BE
	            		RECEIVED BY US WITHIN 15 DAYS FAILING WHICH NO ADJUSTMENT WILL BE POSSIBLE IF THE ABOVE SALE IS ASSESSED FOR TAX AT A HIGHER RATE THE EXTRA AMOUNT IS PAYABLE BY YOU.
	            	</div>
	            </td>
			</tr>
			<tr>
				<td colspan="6" valign="middle" style="height:25px; background:#ffffff; border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	            	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px; text-align: justify;">
	            		CERTIFIED THAT THE PARTICULARS GIVEN ABOVE ARE TRUE AND CORRECT AND THE AMOUNT INDICATED PRESENTS THE PRICE ACTUALLY CHARGED AND THAT THERE IS NO FLOW OF
	            		ADDITIONAL CONSIDERATION DIRECTLY OR INDIRECTLY FROM THE BUYER.
	            	</div>
	            </td>
			</tr>
			<tr>
				<td colspan="6">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	            		<tr>
		            		<td width="102" valign="top" style="height:14px; background:#ffffff; border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:3px; font-family:Times New Roman; font-size:9px;">
									AUTHENTICATED
								</div>
							</td>
							<td>
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td colspan="2" width="165" valign="middle" style="height:14px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px;">
												SALES TAX REGN. NO.
											</div>
										</td>
										<td rowspan="3" width="110" valign="top" style="height:14px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:3px; font-family:Times New Roman; font-size:9px;">
												<u>RANGE ADDRESS</u><br>KANSBAHAL<br>CIVIL TOWNSHIP, <br>NNN - 1, <br>ROURKELA - 770034
											</div>
										</td>
										<td rowspan="3" width="115" valign="top" style="height:14px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:3px; font-family:Times New Roman; font-size:9px;">
												<u>DIVISION ADDRESS</u><br>RAJASWA VIHAR<br>NAYA BAZAR, DIV-II<br>ROURKELA - 769010
											</div>
										</td>
										<td rowspan="3" width="115" valign="top" style="height:20px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:3px; font-family:Times New Roman; font-size:9px;">
												<u>COMMISSIONARATE</u><br>BHUBANESHWAR-II
											</div>
										</td>
										<td rowspan="4" width="155" valign="top" style="height:14px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:3px; font-family:Times New Roman; font-size:9px;">
												E. & O.E.<br>FOR WELDTECH ENGINEERS
											</div>
										</td>
									</tr>
									<tr>
										<td valign="middle" style="height:14px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px;">
												ORISSA
											</div>
										</td>
										<td valign="middle" style="height:14px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px;">
												CENTRAL
											</div>
										</td>
									</tr>
									<tr>
										<td valign="middle" style="height:20px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px;">
												TIN NO. ::
											</div>
											<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px;">
												21912001675
											</div>
										</td>
										<td valign="middle" style="height:20px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px;">
												TIN NO. ::
											</div>
					            			<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px;">
												21912001675(C)
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="3" valign="middle" style="height:14px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="left" style="margin-left:1px; margin-left:2px; margin-top:0px; font-family:Times New Roman; font-size:9px;">
												CENTRAL EXCISE REGN. NO. :: AAAFW2808AXM001
											</div>
										</td>
										<td colspan="2" valign="middle" style="height:14px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
					            			<div align="left" style="margin-left:1px; margin-left:2px; margin-top:0px; font-family:Times New Roman; font-size:9px;">
												ECC NO. :: AAAFW2808AXM001
											</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<div align="center" style="margin-left:7px; font-family:Vrinda; font-size:12px">
						INTEREST @ 22% PER ANNUM WILL BE CHARGED ON ALL BILLS NOT PAID BY DUE DATE
					</div>
				</td>
			</tr>
			<tr id="hide">
				<td colspan="6" align="right">
                     <s:hidden name="content" id="content"/>
					   <s:hidden name="invoicenumber" value="${invoice.invoiceNumber}"/>

                    <s:submit name="printpdf" value="Print" id="printPDF"></s:submit> &nbsp;&nbsp;&nbsp;&nbsp;
                    <s:button name="Cancel" value="Cancel" onclick="javascript:window.close();"></s:button>
				</td>
			</tr>
		</table>
</s:form>
</div>
</body>
</html>