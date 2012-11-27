
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
			<jsp:include page="/jsp/_includeInvoicePreview.jsp"/>
						
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
