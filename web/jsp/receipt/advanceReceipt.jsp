<%@ page import="java.util.Date" %>
<%@ include file="/includes/_taglibInclude.jsp"%>
<%@page contentType="text/html"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Weldtech</title>
    <link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
</head>
<body >
<script language="javascript">
	function callPrint()
	{
		document.getElementById('inPrint').style.display='none';
		document.getElementById('inClose').style.display='none';
		wait(500);
		window.print();
		wait(500);
		document.getElementById('inPrint').style.display='inline';
		document.getElementById('inClose').style.display='inline';
		return true;
	}
	function wait(msecs)
	{
		var start = new Date().getTime();
		var cur = start;
		while(cur - start < msecs)
		{
			cur = new Date().getTime();
		}
	}
</script>
<s:useActionBean beanclass="com.inwise.action.AdvanceActionBean" var="advanceBean"/>
<s:form beanclass="com.inwise.action.AdvanceActionBean">
    <table width="760px" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
            <td></td>
        </tr>
        
        <tr>
            <td>
            <table><tr>
              <td width="46" rowspan="4"><img src="images/companyLogo.jpg" title="picture" alt="logo"    height="150px" width="100px" /></td>
              <td width="702">
            <div align="center" class="style2" style="text-align:left;">${advanceBean.companyInfo.compName}</div></td>
        </tr>
        <tr>
          <td><div align="center" class="style3" style="text-align:left;">${advanceBean.companyInfo.address[0].line1} <span>,</span> ${advanceBean.companyInfo.address[0].city}<span>,</span>${advanceBean.companyInfo.address[0].state} <span>,</span> ${advanceBean.companyInfo.address[0].country}<span>,</span> ${advanceBean.companyInfo.address[0].zip}</div></td>
        </tr>
        <tr>
          <td><div align="center" class="style3" style="text-align:left;">Ph:${advanceBean.companyInfo.compPhone}</div></td>
        </tr>
          <tr>
            <td><div align="center" class="style3" style="text-align:left;">Email:${advanceBean.companyInfo.compEmail}</div></td>
        </tr></table></td></tr>
        <tr>
            <td>
            <table border="0" cellpadding="0" cellspacing="0"><tr><td>
            <div align="center" class="style3" style="margin-top:5px;font-weight:bold; text-decoration:underline">Payment Receipt</div></td>
        </tr>
        <tr>
            <td ><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="90"><div align="left"  >
                        <div align="center" class="style1" style="margin-bottom:2px"><b> Receipt No :</b></div>
                    </div></td>
                    <td width="382"><div align="left">${advanceBean.advance.id}</div></td>
                    <td width="46"><div align="right" class="style1"><b>Date :</b></div></td>
                    <td width="242"><div align="left"><fmt:formatDate value="<%= new Date()%>"/></div> </td>
                </tr>
               
                
            </table>    </td>
        </tr>
        <tr><td>&nbsp;</td></tr>   <c:set value="dd" var="TRI"/> <c:set value="cheque" var="TR2"/>
     <tr><td align="left"><p align="left">With reference to your PO no. <strong style="text-decoration:underline">${advanceBean.advance.order.proposal.id}</strong>  dated <s:text style="text-decoration:underline;border :none;" name="test" size="8" formatType="date" value="${advanceBean.advance.order.proposal.createDate}" formatPattern="dd/MM/yyyy"/>it is hereby confirmed
         that we have received INR<strong style="text-decoration:underline">  ${advanceBean.advance.amountReceived}</strong>   towards the advance/balance payment through ${advanceBean.advance.paymentMode.mode}.
        <c:if test="${advanceBean.advance.paymentMode.mode eq TRI or advanceBean.advance.paymentMode.mode eq TR2}">Cheque/DD No${advanceBean.advance.chequeOrDDNo}</c:if>
     </p></td></tr>
<tr><td><p align="left">We thank you for the same and look forward to a long and mutually benefitting relationship.</p></td></tr>
    <tr><td>&nbsp;</td></tr>    
         <tr><td align="left"><div align="left">For (${advanceBean.companyInfo.compName})</div> </td></tr>
        <tr><td>&nbsp;</td></tr>
      <tr>
		<td>
			<div align="center" style="margin-top: 20px;">
			<s:button type="button" class="buttons" style="width:80px;" value="Print" name="inPrint" id="inPrint" onClick="return callPrint();"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<s:button type="button" class="buttons" style="width:80px;" name="inClose" value="Close" id="inClose" onClick="javascript: window.close();"/>
	</div>
		</td>
	</tr></table></td></tr>
    </table>
</s:form>
</body>
</html>
