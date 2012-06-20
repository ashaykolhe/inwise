
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes-dynattr.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/toword.js"></script>
<link rel="stylesheet" type="text/css" href="css/dropdown.css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<s:useActionBean beanclass="com.inwise.action.InvoiceActionBean" var="invoiceBean" event="redirectpreview" ></s:useActionBean>
<%
    request.setAttribute("invoice",invoiceBean.getInvoice());
%>
<c:set var = "TR1" value="invoicepdf"/>

<c:if test="${invoiceBean.hiddenvalue eq TR1}">
    <script type="text/javascript">
        function OpenPopup(){
            var w = 900;
            var h = 700;
            var winl = (screen.width-w)/2;
            var wint = (screen.height-h)/2;
            if (winl < 0) winl = 0;
            if (wint < 0) wint = 0;
            var page = "invoice?printpdf=&id="+${invoiceBean.invoice.id}+"";
            windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no," + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
            window.open(page, "Popup", windowprops);
            return;
        }
        window.onLoad =OpenPopup();
    </script>
</c:if >
<script type="text/javascript" >
        $(document).ready(function() {
       $("#ecess").html(amtInWords(${invoice.educationCessTax}));
       $("#enhcess").html(amtInWords(${invoice.secondaryHigherEducationCessTax}));
       $("#excise").html(amtInWords(${invoice.exciseTax}));
       $("#net").html(amtInWords(${invoice.netPayable}));
            
    });
    function amtInWords(amt)
{

	var decAmount=amt;
	var sUnits=new Array(20);
	var sTens=new Array(8);
	var sHundreds=new Array(6);
	var sAmount;
	var i,iLenAmount,iDecPart,iIntegerPart;

	sUnits[1]  = '';
	sUnits[2]  = 'One';
	sUnits[3]  = 'Two';
	sUnits[4]  = 'Three';
	sUnits[5]  = 'Four';
	sUnits[6]  = 'Five';
	sUnits[7]  = 'Six';
	sUnits[8]  = 'Seven';
	sUnits[9]  = 'Eight';
	sUnits[10] = 'Nine';
	sUnits[11] = 'Ten';
	sUnits[12] = 'Eleven';
	sUnits[13] = 'Twelve';
	sUnits[14] = 'Thirteen';
	sUnits[15] = 'Fourteen';
	sUnits[16] = 'Fifteen';
	sUnits[17] = 'Sixteen';
	sUnits[18] = 'Seventeen';
	sUnits[19] = 'Eighteen';
	sUnits[20] = 'Ninteen';
	sTens[1]   = 'Twenty';
	sTens[2]   = 'Thirty';
	sTens[3]   = 'Forty';
	sTens[4]   = 'Fifty';
	sTens[5]   = 'Sixty';
	sTens[6]   = 'Seventy';
	sTens[7]   = 'Eighty';
	sTens[8]   = 'Ninety';
	sHundreds[1] = 'Hundred';
	sHundreds[2] = 'Thousand';
	sHundreds[3] = 'Lac';
	sHundreds[4] = 'Crore';
	sHundreds[5] = 'Arab';
	sHundreds[6] = 'Kharab';

	if (decAmount == 10000000000000)
	{
		decAmount = 9999999999999.99;
	}
	if (decAmount  == 0)
	{
		return "";
	}

	iDecPart = (decAmount -  Math.round(decAmount)) * 100;
	iDecPart=Math.round(iDecPart);

	//Because Math.round results .50,.52,.53.......98,.99 in negative values

	if(iDecPart<0)
	{
		iDecPart=100+iDecPart;
	}

	if( iDecPart == 0)
	{
		decAmount = decAmount;
	}
	else
	{
		decAmount =Math.round(decAmount - (iDecPart/100));
	}

	iLenAmount = ((String)(decAmount)).length;

	if (iLenAmount == 1)
	{
		var index=parseInt(decAmount)+1;
		sAmount = sUnits[index];
	}
	else
	{
		for(i=iLenAmount;i>0;i--)
		{
			if (i==13 || i==12)
			{
				iIntegerPart = parseInt(decAmount/100000000000);
				decAmount = parseInt(decAmount % 100000000000);
				if(iIntegerPart==0)
				{
					sAmount = sAmount;
				}
				else
				{
					if(iIntegerPart<20)
					{
						sAmount = sUnits[iIntegerPart + 1] +" "+ sHundreds[6]+" ";
					}
					else
					{
					  sAmount = sTens[parseInt(iIntegerPart/10) - 1] +" "+ sUnits[(iIntegerPart - parseInt(iIntegerPart/10)*10) + 1] +" "+ sHundreds[6]+" "
					}
				}
			}
			else if (i==11 || i==10)
			{
				iIntegerPart = parseInt(decAmount/1000000000);
				decAmount = parseInt(decAmount % 1000000000);
				if(iIntegerPart==0)
				{
					sAmount = sAmount;
				}
				else
				{
					if(iIntegerPart<20)
					{
						if(sAmount == null)
						{
							sAmount = sUnits[iIntegerPart + 1] +" "+ sHundreds[5]+" ";
						}
						else
						{
							sAmount = sAmount+" "+sUnits[iIntegerPart + 1] +" "+ sHundreds[5]+" ";
						}
					}
					else
					{
						if(sAmount == null)
						{
							sAmount = sTens[parseInt(iIntegerPart/10) - 1] +" "+ sUnits[(iIntegerPart - parseInt(iIntegerPart/10)*10) + 1] +" "+ sHundreds[5]+" ";
						}
						else
						{
							sAmount = sAmount+" "+sTens[parseInt(iIntegerPart/10) - 1] +" "+ sUnits[(iIntegerPart - parseInt(iIntegerPart/10)*10) + 1] +" "+ sHundreds[5]+" ";
						}
					}
				}
			}
			else if (i==9 || i==8)
			{
				iIntegerPart = parseInt(decAmount/10000000);
				decAmount = parseInt(decAmount % 10000000);
				if(iIntegerPart==0)
				{
				  sAmount = sAmount;
				}
				else
				{
					if(iIntegerPart<20)
					{
						if(sAmount == null)
						{
							sAmount = sUnits[iIntegerPart + 1] +" "+ sHundreds[4]+" ";
						}
						else
						{
							sAmount = sAmount+" "+sUnits[iIntegerPart + 1] +" "+ sHundreds[4]+" ";
						}
					}
					else
					{
						if(sAmount == null)
						{
							  sAmount = sTens[parseInt(iIntegerPart/10) - 1] +" "+ sUnits[(iIntegerPart - parseInt(iIntegerPart/10)*10) + 1] +" "+ sHundreds[4]+" ";
						}
						else
						{
							  sAmount = sAmount+" "+sTens[parseInt(iIntegerPart/10) - 1] +" "+ sUnits[(iIntegerPart - parseInt(iIntegerPart/10)*10) + 1] +" "+ sHundreds[4]+" ";
						}
					}
				}
			}
			else if(i==7 || i==6)
			{
				iIntegerPart = parseInt(decAmount/100000);
				decAmount = (decAmount % 100000);
				if(iIntegerPart==0)
				{
					sAmount = sAmount;
				}
				else
				{
					if(iIntegerPart < 20)
					{
						if(sAmount == null)
						{
							sAmount =sUnits[iIntegerPart + 1]+" "+ sHundreds[3]+" ";
						}
						else
						{
							sAmount = sAmount+" "+sUnits[iIntegerPart + 1]+" "+ sHundreds[3]+" ";
						}
					}
					else
					{
						if(sAmount == null)
						{
							sAmount = sTens[parseInt(iIntegerPart/10) - 1] +" "+ sUnits[(iIntegerPart - parseInt(iIntegerPart/10)*10) + 1] +" "+ sHundreds[3]+" ";
						}
						else
						{
							sAmount = sAmount+" "+sTens[parseInt(iIntegerPart/10) - 1] +" "+ sUnits[(iIntegerPart - parseInt(iIntegerPart/10)*10) + 1] +" "+ sHundreds[3]+" ";
						}
					}
				}
			}
			else if(i==5 || i==4)
			{
				iIntegerPart = parseInt(decAmount/1000);
				decAmount = (decAmount % 1000);
				if(iIntegerPart==0)
				{
					sAmount = sAmount;
				}
				else
				{
					if(iIntegerPart < 20)
					{
						if(sAmount == null)
						{
							sAmount = sUnits[iIntegerPart + 1]+" "+ sHundreds[2]+" ";
						}
						else
						{
							sAmount = sAmount+" "+sUnits[iIntegerPart + 1]+" "+ sHundreds[2]+" ";
						}
					}
					else
					{
						if(sAmount == null)
						{
							sAmount = sTens[parseInt(iIntegerPart/10) - 1] +" "+ sUnits[(iIntegerPart - parseInt(iIntegerPart/10)*10) + 1]+" "+ sHundreds[2]+" ";
						}
						else
						{
							sAmount = sAmount+" "+sTens[parseInt(iIntegerPart/10) - 1] +" "+ sUnits[(iIntegerPart - parseInt(iIntegerPart/10)*10) + 1]+" "+ sHundreds[2]+" ";
						}
					}
				}
			}
            else if(i==3)
			{
				iIntegerPart = parseInt(decAmount/100);
				decAmount = (decAmount % 100);
				if(iIntegerPart==0)
				{
					sAmount = sAmount;
				}
				else
				{
					var index;
					index=parseInt(iIntegerPart)+1;
					if (sAmount == null)
					{
						sAmount = sUnits[index] +" "+ sHundreds[1]+" ";
					}
					else
					{
						sAmount = sAmount+" "+sUnits[index] +" "+ sHundreds[1]+" ";
					}
				}
			}
			else if(i==2)
			{
				decAmount=parseInt(eval(decAmount));
				if(decAmount<20)
				{
					var index=parseInt(decAmount)+1;
					if (sAmount == null)
					{
						sAmount = sUnits[index];
					}
					else
					{
						sAmount = sAmount+" "+sUnits[index];
					}
				}
				else
				{
					var a=parseInt(((decAmount/10) - 1));
					var b=(decAmount%10) + 1;
					if (sAmount == null)
					{
						sAmount = sTens[a] +" "+ sUnits[b];
					}
					else
					{
						sAmount = sAmount+" "+sTens[a] +" "+ sUnits[b];
					}
				}
			}
		}
	}
	if(iDecPart==0)
	{
		sAmount =  sAmount;
	}
	else if(sAmount=="")
	{
		sAmount = "Paise ";
	}
	else
	{
		sAmount = sAmount+" And Paise";
	}

	if(iDecPart < 20)
	{
		sAmount = sAmount+" "+sUnits[iDecPart + 1]+" ";
	}
	else
	{
		var fi = parseInt(((iDecPart/10) - 1));
		var fii = parseInt((iDecPart % 10))+1;
		sAmount = sAmount+" "+sTens[fi] +" "+ sUnits[fii]+" " ;
	}

        sAmount = sAmount + " Only";

        return sAmount;

}
</script><s:layout-render name="/layout/_base.jsp">
<s:layout-component name="body">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>INVOICE</title>
<script type="text/javascript" src="js/jquery.js"></script>
<%--
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
/*
    $(document).ready(function(){
            $('#printPDF').click(function(){
             */
/*           alert("in pdf creation");

                $('#hide').css("display","none");
                $('#content').attr("value",$('#printContent').html());*/
/*
                var w = 900;
                        var h = 700;
                        var winl = (screen.width-w)/2;
                        var wint = (screen.height-h)/2;
                        if (winl < 0) winl = 0;
                        if (wint < 0) wint = 0;
                        var page = "invoice?printpdf=&id="++"";
                        windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no," + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
                        window.open(page, "Popup", windowprops);

            });
        });
*/

</script>
--%>
</head>
<body style="margin-left:1px;">

<div align="center" style="margin-left:2px;" id="printContent">
	<s:form beanclass="com.inwise.action.InvoiceActionBean">
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
										<b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoice.createDate}"/></b>
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

										<b>${invoiceBean.invoice.issueTime}</b>

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

										<b>${invoice.removalTime}</b>

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
								<div align="left" style="margin-left:7px; margin-top:4px; font-family:Times New Roman; font-size:9px">
									INVOICE TO :
									<div align="left" style="margin-left:60px; margin-right:7px; font-family:Verdana; font-size:9px;">
										<b>${invoice.order.orderAddress[0].address.line1}
                                           <br>
                                           ${invoice.order.orderAddress[0].address.line2} 
                                        <br>
                                           ${invoice.order.orderAddress[0].address.city}
                                        <br>
                                           ${invoice.order.orderAddress[0].address.state}
                                        <br>
                                           ${invoice.order.orderAddress[0].address.country}
                                        <br>
                                           ${invoice.order.orderAddress[0].address.zip} 
                                        </b>
									</div>
									<div align="left" style="margin-left:7px; margin-top:4px; font-family:Times New Roman; font-size:9px">
									Tin No :
									<div align="left" style="margin-left:60px;  margin-top:-14px; margin-right:7px; font-family:Verdana; font-size:9px;">
										<b>
															<b>${invoice.customer.tinNo}</b>
														</b>
									</div>
								</div>
								<div align="left" style="margin-left:7px; margin-top:5px; font-family:Times New Roman; font-size:9px">
									Ecc No :
									<div align="left" style="margin-left:60px;  margin-top:-14px; margin-right:7px; font-family:Verdana; font-size:9px;">
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
										<b>${invoice.order.orderAddress[1].address.line1}
                                           <br>
                                           ${invoice.order.orderAddress[1].address.line2}
                                        <br>
                                           ${invoice.order.orderAddress[1].address.city}
                                        <br>
                                           ${invoice.order.orderAddress[1].address.state}
                                        <br>
                                           ${invoice.order.orderAddress[1].address.country}
                                        <br>
                                           ${invoice.order.orderAddress[1].address.zip}
                                        </b>
									</div>
								</div>
							</td>
							<td nowrap valign="top" style="background:#ffffff; color:#000000;">
								<div align="left">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="50%" nowrap style="background:#ffffff; height:60px; color:#000000; border-right:2px solid #000000;">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Des. Adv. No.
													<div align="right" style="margin-right:7px; margin-top:5px; font-family:Times New Roman; font-size:9px;">

															<b>${invoice.desAdvNo}</b>

													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td width="50%" nowrap style="background:#ffffff; height:60px; color:#000000; border-right:2px solid #000000; border-bottom:1px  solid #000000;">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Date
													<div align="right" style="margin-right:1px; margin-top:5px; font-family:Verdana; font-size:9px;">
															<b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoice.createDate}"/></b>
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
				<td width="100%" colspan="6" style="border-left:1px solid #000000;border-right:1px solid #000000;">
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
								<div align="left" style="margin-left:7px; margin-top:15px; font-family:Times New Roman; font-size:9px">
									DATE :
								</div>

								<div align="right" style="margin-right:7px; margin-top:-15px; font-family:Verdana; font-size:9px; ">
									<b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoice.order.createDate}"/></b>
								</div>
							</td>

                              <td width="250" valign="top" style="background:#ffffff; height:37px; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;">

                                  <div align="left" style="margin-left:7px; margin-top:5px; font-family:Times New Roman; font-size:9px; ">
                                      AMENDMENT NO. :
								</div>
								<div align="right" style="margin-right:7px; margin-left:140px; margin-top:-15px; font-family:Verdana; font-size:9px; ">

											${invoice.order.amendmentNo}

										</div>

								<div align="left" style="margin-left:7px; margin-top:15px; font-family:Times New Roman; font-size:9px">
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
									${invoicedetail.dispatched}
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

								${invoicedetail.dispatched * invoicedetail.productCost}

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
			<td colspan="6" valign="top" style="background:#ffffff; height:24px; color:#000000; border-left:1px solid #000000; border-right:1px solid #000000; border-top:1px solid #000000; border-bottom:2px  solid #000000;">
				<div align="left" style="margin-left:7px; margin-top:2px;  font-family:Verdana; font-size:9px">
					<b>* Remarks :</b>
                 </div>
				<div align="left" style="margin-top: -12px; margin-left:75px; font-family:Verdana; font-size:9px;">
                        ${invoice.remark}
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
                      		${invoice.excise}%
                      	</div>
                    </td>
                    <td width="78px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                 	  	<div align="left" style="margin-left:1px; margin-top:2px; font-family:Times New Roman; font-size:9px">
                 	  		E.CESS PAYABLE
                 	  	</div>
                 	  	<div align="right" style="margin-right:1px; margin-top:2px; margin-bottom:2px; font-family:Verdana; font-size:9px">
                 	  		${invoice.educationCess}%
                 	  	</div>
                 	  </td>
                 	  <td width="75px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                      	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:2px; font-family:Times New Roman; font-size:9px">
                      		S&H EDU CESS PAYABLE
                      	</div>
                      	<div align="right" style="margin-right:1px; margin-top:2px; margin-bottom:0px; font-family:Verdana; font-size:9px">
                      		${invoice.secondaryHigherEducationCess}%
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
                      		${invoice.cstOvat}%
                      	</div>
                      </td>
                      <td width="90px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                      	<div align="center" style="font-family:Times New Roman; font-size:9px">
                      		TOTAL AMOUNT
                      	</div>
                      </td>
                      <td valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:1px solid #000000;">
                      <strong>	<div align="right" style="margin-right:0px; margin-top:0px; margin-bottom:1px; font-family:Verdana; font-size:9px">
                                   ${invoice.totalAmount}
                      	</div></strong>
                      </td>
                </tr>
                 <tr>
                    <td rowspan="2" valign="center" width="116px" style="background:#ffffff; border-left:2px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="right" style="margin-right:1px; margin-top:5px; font-family:Verdana; font-size:9px">
                    		<img align="left" style="margin-left:1px;" src="images/Rupee.JPG" width="10" height="13">
                    			blank
                    	</div>
                   </td>
                    <td style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                    <div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
	                    	${invoice.exciseTax}
	                    </div>
	                </td>
	                <td style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
                    	<div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
                    		${invoice.educationCessTax}
                    	</div>
                    </td>
                    <td style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
                    	<div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
                    		${invoice.secondaryHigherEducationCessTax}
                    	</div>
                    </td>
                    <td style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
                    	<div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
                    		${invoice.taxCharges}
                    	</div>
                    </td>
                    <td style="background:#ffffff; height:25px; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="right" style="margin-right:1px; margin-left:1px; font-family:Verdana; font-size:9px">
                    		${invoice.cstOvatTax}
                    	</div>
                   </td>
                   <td rowspan="2" width="84px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
                    		ADD OTHER CHARGES
                    	</div>
                    </td>
                    <td rowspan="2" valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:1px solid #000000;">
                    	  <strong><div align="right" style="margin-right:0px; margin-top:0px; margin-bottom:1px; font-family:Verdana; font-size:9px">
                    		${invoice.otherCharges}
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
                    		${invoice.freight}
                    	</div>
                    </td>
					<td width="72px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="left" style="margin-left:2px; margin-top:10px; font-family:Times New Roman; font-size:9px">
                    		INSURANCE
                    	</div>
                    	<div align="right" style="margin-right:1px; margin-left:1px; margin-top:5px; font-family:Verdana; font-size:9px">
                    		${invoice.insurance}
                    	</div>
                    </td>
                    <td width="80px" colspan="2" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="left" style="margin-left:0px; margin-top:10px; font-family:Times New Roman; font-size:9px">
                    		OTHERS
                    	</div>
                    	<div align="right" style="margin-right:1px; margin-left:0px; margin-top:5px; font-family:Verdana; font-size:9px">
                    		${invoice.others}
                    	</div>
                    </td>
                    <td valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="left" style="margin-left:7px; margin-top:10px; font-family:Times New Roman; font-size:9px">
                    		ENTRY TAX&nbsp;&nbsp;${invoice.inEntryTaxGiven}%
                    	</div>
                    	<div align="right" style="margin-right:1px; margin-left:1px; margin-top:5px; font-family:Verdana; font-size:9px">
                    		${invoice.entry}
                    	</div>
                    </td>
                    <td valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    	<div align="center" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Verdana; font-size:9px">
                    		<strong>GRAND TOTAL</strong>
                    	</div>
                    </td>
                    <td valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:1px solid #000000;">
                    	  <strong><div align="right" style="margin-right:0px; margin-top:0px; margin-bottom:1px;  font-family:Verdana; font-size:9px;">
                    		${invoice.grandTotal}
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
                                 ${invoice.debitEntryNo}
                                 </div>
	                        </td>
	                    	<td width="88px" valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                    		<div align="left" style="margin-left:2px; margin-top:2px; font-family:Times New Roman; font-size:9px">
	                    			DATE
	                    		</div>
	                    		<div align="right" style="margin-right:1px; margin-left:1px; margin-top:2px; font-family:Verdana; font-size:9px">
                                        	<b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoice.debitEntryDate}"/></b>
	                    		</div>
	                   		</td>
	                        <td style="background:#ffffff; border-right:2px solid #000000; border-bottom:1px solid #000000;">
	                    		<div align="left" style="margin-right:1px; margin-top:2px; font-family:Verdana; font-size:9px">
	                    			<img align="left" style="margin-left:1px;" src="images/Rupee.JPG" width="10" height="13">
	                    			&nbsp;&nbsp;&nbsp;&nbsp;
	                    		<strong><span id="net"></span> </strong>
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
                                                    ${invoiceBean.advance.id}
											</div>
		                        		</td>
		                        		<td valign="middle" style="height: 25px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">


											<b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoiceBean.advance.createDate}"/></b>

											</div>
		                        		</td>
		                        		<td valign="middle" style="height: 25px; background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
		                        			<div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">

												${invoiceBean.advance.amountReceived}

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
									 ${invoiceBean.invoice.amountDetect}
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

										${invoiceBean.invoice.documentsThrough}&nbsp;

	                    		</div>
	                        </td>
	                        <td width="91px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:2px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
	                       	  	<strong>NET PAYABLE</strong>
	                       	  </div>
	                        </td>
	                        <td valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:2px solid #000000;">
	                       	 <strong> <div align="right" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
	                       	  	${invoice.netPayable}
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

										${invoiceBean.invoice.modeOfDispatch}&nbsp;

	                       	  </div>
	                        </td>
	                        <td width="104px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">

										${invoiceBean.invoice.noOfPackages}&nbsp;

	                       	  </div>
	                        </td>
	                        <td width="112px" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">

										${invoiceBean.invoice.vehicleNo}&nbsp;

	                       	  </div>
	                        </td>
	                        <td valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">

										${invoiceBean.invoice.rrgcnNo}&nbsp;

	                       	  </div>
	                        </td>
	                        <td valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
	                       	  	<b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoiceBean.invoice.contNoteDate}"/></b>
	                       	  </div>
	                        </td>
	                    </tr>
					</table>
            	</td>
            </tr>
            <tr>

	        	<td colspan="6" valign="middle" style="height:22px; background:#ffffff;border-left:2px solid #000000;border-top:1px solid #000000; border-right:2px solid #000000; border-bottom:1px solid #000000;">
	           		<div align="left" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	            		EXCISE	:
	                </div>
	                <div align="left" style="margin-left:90px; margin-right:1px; margin-top:-13px; font-family:Verdana; font-size:9px">
	                	<img align="left" style="margin-left:1px;" src="images/Rupee.JPG" width="10" height="13">
	                	 <span id="excise"></span>
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
                           <span id="ecess"></span>

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

                              <span id="enhcess"></span>
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
					   <s:hidden name="pdfinvoicenumber" value="${invoice.invoiceNumber}"/>

					   <s:hidden name="id" value="${invoice.id}"/>
					   <s:hidden name="ad" value="${invoiceBean.advance.order.id}"/>
                       <s:hidden name="invoice.invoiceNumber" value="${invoiceBean.invoice.invoiceNumber}"/>
                       <s:hidden name="invoice.createDate" value="${invoiceBean.invoice.createDate}"/>

                    <s:submit name="redirectinvoicepopup" value="print" id="printPDF"></s:submit> &nbsp;&nbsp;&nbsp;&nbsp;
                    <s:submit name="previewgenerate" value="Generate" ></s:submit> &nbsp;&nbsp;&nbsp;&nbsp;
                    <s:submit name="editinvoice" value="Edit"/>
				</td>
			</tr>
		</table>
</s:form>
</div>
</body>
</html>
</s:layout-component>
</s:layout-render>
