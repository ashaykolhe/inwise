
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
            var page = "invoice?printpdf=&id="+${invoiceBean.invoice.invoiceNumber}+"";
            windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no," + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
            window.open(page, "Popup", windowprops);
            return;
        }
        window.onLoad =OpenPopup();
    </script>
</c:if >
<script type="text/javascript" >
       $(document).ready(function() {
           /*  $('#printPDF').click(function(){
                window.print();
            });*/
       <%--$("#ecess").html(amtInWords(${invoice.educationCessTax}));--%>
       <%--$("#enhcess").html(amtInWords(${invoice.secondaryHigherEducationCessTax}));--%>
       <%--$("#excise").html(amtInWords(${invoice.exciseTax}));--%>
       <%--$("#net").html(amtInWords(${invoice.netPayable}));--%>
            
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

<div align="center" style="margin-left:2px;float:left;" id="printContent">
	<s:form beanclass="com.inwise.action.InvoiceActionBean">
			<table width="760px" align="center" cellspacing="0" cellpadding="0" border="0" style="color:#000000;">            
			<tr>
				<td nowrap style="background:#ffffff; color:#000000; border-left:2px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
					<img style="margin-left:7px;" src="images/WE.jpg" height="40px" width="40px" align="center">
                </td>
				<td width="200" nowrap style="background:#ffffff; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
					<div align="left" style="margin-left:7px; margin-right:7px; font-family:Times New Roman; font-size:14px">
                        <b>${invoiceBean.invoice.customer.addressList[0].line1},${invoiceBean.invoice.customer.addressList[0].line2},
                            ${invoiceBean.invoice.customer.addressList[0].city}-${invoiceBean.invoice.customer.addressList[0].zip},
                            ${invoiceBean.invoice.customer.addressList[0].state}</b>						
					</div>
				</td>
				<td width="250" nowrap style="background:#ffffff; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
					<div align="left" style="margin-left:7px; margin-right:7px; font-family:Times New Roman; font-size:11px;">
						Tel No.  : ${invoiceBean.invoice.customer.contactNo1}

					</div>

                    <div align="left" style="margin-left:7px; margin-right:7px; font-family:Times New Roman; font-size:11px;">
						E-Mail : ${invoiceBean.invoice.customer.email}

					</div>


				</td>				
				<td colspan="3" width="110" nowrap align="left" valign="top" style="background:#ffffff; color:#000000;">
					<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tr>
							<td width="50" nowrap style="background:#ffffff; height:40px; color:#000000; border-top:2px solid #000000; border-bottom:1px  solid #000000;">
								<div align="left" style="margin-left:1px; font-family:Times New Roman; font-size:11px">
									TIN No.
								</div>
							</td>
                            <td nowrap style="background:#ffffff; height:40px; color:#000000; border-top:2px solid #000000; border-right:2px solid #000000; border-bottom:1px  solid #000000;">
                                <div align="right" style="margin-right:1px; font-family:Verdana; font-size:11px;">
										<b>${invoiceBean.invoice.customer.tinNo}</b>
									</div>
                            </td>
						</tr>
						<tr>
							<td width="50" nowrap style="background:#ffffff; height:40px; color:#000000; border-bottom:1px  solid #000000;">
								<div align="left" style="margin-left:2px; font-family:Times New Roman; font-size:9px">
									TAN No.

								</div>
							</td>
                            <td nowrap style="background:#ffffff; height:40px; color:#000000; border-right:2px solid #000000; border-bottom:1px  solid #000000;">
                                <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
										<b>${invoiceBean.invoice.customer.tanNo}</b>
									</div>
                            </td>
						</tr>
					</table>
				</td>
			</tr>
                        <tr>
				<td colspan="6">
					<div align="center" style="margin-left:7px; font-family:Copperplate Gothic Light; font-size:16px">
						INVOICE
					</div>
					<div align="center" style="margin-left:7px; font-family:Vrinda; font-size:15px"></div>
					<div align="right" style="margin-left:7px">
						<input name="buyer" type="text" id="buyer" style="font-family:Vrinda; font-size:15px; border:0px; text-align:right; background-color: white;" value="ORIGINAL FOR BUYER"  size="35" readonly="readonly">
					</div>
				</td>
			</tr>

			<tr>
				<td colspan="6">
					<table width="100%"  align="center" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td width="329" valign="top" style="background:#ffffff; height:37px; color:#000000; height:100px;border-bottom:2px  solid #000000; border-left:2px solid #000000; border-right:1px solid #000000;border-top:2px solid #000000;">
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
								</div>
							</td>
							<td width="315" valign="top" style="background:#ffffff; height:37px; color:#000000;border-bottom:2px  solid #000000; border-right:1px solid #000000; border-top:2px solid #000000;">
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
							<td width="204" valign="top" nowrap style="background:#ffffff; color:#000000;border-top:2px solid #000000;border-bottom:2px  solid #000000;">
								<div align="left">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Order No.													
												</div>
											</td>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:1px solid #000000;">
                                            <div align="right" style="margin-right:7px; font-family:Times New Roman; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.order.customerOrderNo!= null}">
                                                                <b>${invoiceBean.invoice.order.customerOrderNo}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>
													</div></td>

											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Date													
												</div>
											</td>
<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:2px solid #000000; ">
                                            <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
                                                        <c:choose>
                                            <c:when test="${invoiceBean.invoice.order.createDate != null}">
                                        <b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoiceBean.invoice.order.createDate}"/></b>
                                            </c:when>
                                            <c:otherwise>
                                                <b>-</b>
                                            </c:otherwise>
                                        </c:choose>
														
													</div>
                                                    </td>
										</tr>
                                        
                                        <tr>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Bill No.
												</div>
											</td>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:1px solid #000000;">
                                            <div align="right" style="margin-right:7px; font-family:Times New Roman; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.invoiceNumber!= null}">
                                                                <b>${invoiceBean.invoice.invoiceNumber}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>
													</div></td>

											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Date
												</div>
											</td>
<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:2px solid #000000;">
                                            <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
                                                        <c:choose>
                                            <c:when test="${invoiceBean.invoice.createDate != null}">
                                        <b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoiceBean.invoice.createDate}"/></b>
                                            </c:when>
                                            <c:otherwise>
                                                <b>-</b>
                                            </c:otherwise>
                                        </c:choose>

													</div>
                                                    </td>
										</tr>

                                        <tr>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Challan Pass No.
												</div>
											</td>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:1px solid #000000;">
                                            <div align="right" style="margin-right:7px; font-family:Times New Roman; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.challanPassNumber!= null}">
                                                                <b>${invoiceBean.invoice.challanPassNumber}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>
													</div></td>

											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Date
												</div>
											</td>
<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:2px solid #000000;">
                                            <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
                                                        <c:choose>
                                            <c:when test="${invoiceBean.invoice.challanDate != null}">
                                        <b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoiceBean.invoice.challanDate}"/></b>
                                            </c:when>
                                            <c:otherwise>
                                                <b>-</b>
                                            </c:otherwise>
                                        </c:choose>

													</div>
                                                    </td>
										</tr>

                                        <tr>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Vehicle No.
												</div>
											</td>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:1px solid #000000;">
                                            <div align="right" style="margin-right:7px; font-family:Times New Roman; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.vehicleNo!= null}">
                                                                <b>${invoiceBean.invoice.vehicleNo}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>
													</div></td>

											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													LOI Number
												</div>
											</td>
<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:2px solid #000000;">
                                            <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.loiNumber!= null}">
                                                                <b>${invoiceBean.invoice.loiNumber}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>

													</div>
                                                    </td>
										</tr>

                                        <tr>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Transporter
												</div>
											</td>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:1px solid #000000;">
                                            <div align="right" style="margin-right:7px; font-family:Times New Roman; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.transporter!= null}">
                                                                <b>${invoiceBean.invoice.transporter}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>
													</div></td>

											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													LR Number
												</div>
											</td>
<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:2px solid #000000;">
                                            <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.lrNumber!= null}">
                                                                <b>${invoiceBean.invoice.lrNumber}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>

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
                <td colspan="6">&nbsp;</td>
            </tr>
            <tr>
            <td colspan="6" style="border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;border-top:2px solid #000000;">
                	<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
                  	<tr>
                          <td width="10%" valign="top" style="background:#ffffff;  border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;"><div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px">
								NO.
							</div>
					  </td>
                    	<td width="15%" valign="top" style="background:#ffffff;  border-right:1px solid #000000; border-bottom:1px  solid #000000;"><div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px">
								Material
							</div>
					  </td>
                    	<td width="15%" valign="top" style="background:#ffffff;  border-right:1px solid #000000; border-bottom:1px  solid #000000;">
			  <div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px; ">
								Chapter ID
							</div>
					  </td>
               		  <td width="20%" valign="top" style="background:#ffffff;  border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px; ">
								Item Name
						</div>
					  </td>
               		  <td width="10%" nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style="margin-top:2px; font-family:Times New Roman; font-size:9px">
								Quantity
						</div>
					  </td>
                 		<td width="10%" nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style=" margin-top:2px; font-family:Times New Roman; font-size:9px">
								Price								
							</div>
					  </td>
                          <td width="5%" nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style=" margin-top:2px; font-family:Times New Roman; font-size:9px">
								Unit								
							</div>
					  </td>
                  		<td width="15%" valign="top" nowrap style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
					  <div align="center" style=" margin-top:2px; font-family:Times New Roman; font-size:9px">
								AMOUNT								
							</div>
					  </td>
					</tr>
                       <c:forEach items="${invoice.invoiceDetail}" var="invoicedetail" varStatus="loop" >
                <c:forEach items="${invoice.order.orderDetail}" var="orderdetail" varStatus="loop1"  >
                    <c:if test="${invoicedetail.product.id eq orderdetail.product.id}">

						<tr style="border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;height:50px">
	                    	<td valign="top" style="background:#ffffff; border-right:1px solid #000000;border-left:1px solid #000000; ">
								<div align="center" style="margin-top:7px; font-family:Verdana; font-size:9px">
                                    ${loop.index+1}
								</div>
							</td>
	                    	<td valign="top" style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="center" style="margin-top:7px; font-family:Verdana; font-size:9px; ">
									${invoicedetail.material}
								</div>
							</td>
							<td valign="top" style="background:#ffffff;  border-right:1px solid #000000; ">
							<strong>	<div align="center" style="margin-left:7px; margin-top:7px; font-family:Verdana; font-size:9px; ">
									${invoicedetail.chapterId}
								</div>
								</strong>
							</td>
                            <td valign="top" style="background:#ffffff;  border-right:1px solid #000000; ">
							<strong>	<div align="center" style="margin-left:7px; margin-top:7px; font-family:Verdana; font-size:9px; ">
									${invoicedetail.product.productName}
								</div>
								</strong>
							</td>
							<td nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000;">
								<div align="center" style="margin-top:7px; font-family:Verdana; font-size:9px">
									${invoicedetail.dispatched}                                    
								</div>
							</td>
	                    	<td nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="center" style="margin-right:1px; margin-left:1px; margin-top:7px; font-family:Verdana; font-size:9px">
                                    <fmt:formatNumber type="number" pattern="##.##" value="${invoicedetail.productCost}"/>
								</div>
							</td>
                            <td nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="center" style="margin-right:1px; margin-left:1px; margin-top:7px; font-family:Verdana; font-size:9px">
                                    ${invoicedetail.product.unit.name}
								</div>
							</td>
							<td valign="top" nowrap style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="right" style="margin-right:1px; margin-left:1px; margin-top:7px; font-family:Verdana; font-size:9px">
								<strong	>
                                                <fmt:formatNumber type="number" pattern="##.##" value="${invoicedetail.dispatched * invoicedetail.productCost}"/>


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
                <td colspan="4" valign="middle" style="background:#ffffff; border-left:2px solid #000000; border-bottom:2px solid #000000;">&nbsp;</td>
            <td valign="middle" style="background:#ffffff; border-bottom:2px solid #000000;">
                      	<div align="center" style="font-family:Times New Roman; font-size:9px">
                      		TOTAL AMOUNT
                      	</div>
                      </td>
                      <td valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:2px solid #000000;">
                      <strong>	<div align="right" style="margin-right:0px; margin-top:0px; margin-bottom:1px; font-family:Verdana; font-size:9px">
                          <c:choose>
                                                                      <c:when test="${invoice.totalAmount!= null}">
                                                                      <b><fmt:formatNumber type="number" pattern="##.##" value="${invoice.totalAmount}"/>  </b>
                                                                      </c:when>
                                                                      <c:otherwise>
                                                                          <b>-</b>
                                                                      </c:otherwise>
                                                                  </c:choose>
                                   
                      	</div></strong>
                      </td>
            </tr>
            
			
			<tr>
            	<td colspan="2" width="30%">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                	<tr>
	                		<td width="50%" valign="middle" style="height:18px; background:#ffffff; border-right:1px solid #000000; border-left:2px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
                                Payment
	                       	  </div>
	                        </td>
	                        <td width="50%" valign="middle" style="background:#ffffff; border-right:2px solid #000000; ">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
								<b>${invoiceBean.advance.paymentMode.mode}</b>
	                       	  </div>
	                        </td>
                         </tr>
                        <tr>
	                        <td width="50%" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-left:2px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	Due Date
	                       	  </div>
	                        </td>
	                        <td width="50%" valign="middle" style="background:#ffffff; border-right:2px solid #000000; ">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	<b><s:format value="${invoiceBean.invoice.dueDate}" formatPattern="dd/MM/yyyy"/> </b>
	                       	  </div>
	                        </td>
                        </tr>
                            <tr>
	                        <td valign="middle" width="50%" style="background:#ffffff; border-right:1px solid #000000; border-bottom:2px solid #000000;border-left:2px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	Freight
	                       	  </div>
	                        </td>
                                <td valign="middle" width="50%" style="background:#ffffff; border-right:2px solid #000000; border-bottom:2px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	<b>${invoiceBean.invoice.freight}</b>
	                       	  </div>
	                        </td>
	                    </tr>
					</table>
            	</td>
                <td colspan="2">&nbsp;</td>
                <td colspan="3">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <c:forEach items="${invoiceBean.invoice.taxes}" var="tax" varStatus="status">
	                	<tr>
	                		<td width="40%" valign="middle" style="height:18px; background:#ffffff;border-top:2px solid #000000;  border-right:1px solid #000000; border-left:2px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
                                ${tax.taxName}
	                       	  </div>
	                        </td>
	                        <td width="10%" valign="middle" style="background:#ffffff;border-top:2px solid #000000;   border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
								${tax.previousTaxPercent}
	                       	  </div>
	                        </td>
                            <td width="40%" valign="middle" style="background:#ffffff; border-top:2px solid #000000;  border-right:2px solid #000000; border-bottom:1px solid #000000;">
                                <strong> <div align="right" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
                                <b><fmt:formatNumber type="number" pattern="##.##" value="${tax.taxAmount}"/>	</b>                                
                                 </div></strong>
                            </td>
                         </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="2" valign="middle" style="background:#ffffff;border-left:2px solid #000000;  border-right:1px solid #000000; border-bottom:2px solid #000000;">
                                 <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
                                     <strong>NET PAYABLE</strong>
                                 </div>
                            </td>
                            <td valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:2px solid #000000;">
                                <strong> <div align="right" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
                                      <c:choose>
                                <c:when test="${invoice.netPayable!= null}">
                                <b><fmt:formatNumber type="number" pattern="##.##" value="${invoice.netPayable}"/>	</b>
                                </c:when>
                                <c:otherwise>
                                    <b>-</b>
                                </c:otherwise>
                            </c:choose>
                                 </div></strong>
                            </td>
                        </tr>

					</table>
            	</td>
            </tr>


			<tr>
				<td colspan="6" valign="middle" style="height:25px; background:#ffffff; border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;border-top:1px solid #000000;">
	            	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px; text-align: justify;">
	            		${invoiceBean.term.terms}
	            	</div>
	            </td>
			</tr>
						
			<tr id="hide">
				<td colspan="6" align="right">
                     <s:hidden name="content" id="content"/>
					   <s:hidden name="pdfinvoicenumber" value="${invoice.invoiceNumber}"/>


					   <s:hidden name="advance.order.id" value="${invoiceBean.advance.order.id}"/>
					   <s:hidden name="ad" value="${invoiceBean.advance.order.id}"/>
                       <s:hidden name="invoice.invoiceNumber" value="${invoiceBean.invoice.invoiceNumber}"/>
                       <s:hidden name="invoice.amountReceived" value="${invoiceBean.advance.amountReceived}"/>
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
