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
<s:useActionBean beanclass="com.inwise.action.AdvanceActionBean" var="advanceBean"/>
<s:form beanclass="com.inwise.action.AdvanceActionBean">
    <table width="760px" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
            <td></td>
        </tr>
        <tr>
            <td><div align="center" class="style2">Weldtech</div></td>
        </tr>
        <tr>
            <td><div align="center" class="style3">Unit-l/Regd.Office :5/1,Industrial Area,Rourkela-769 004</div></td>
        </tr>
        <tr>
            <td><div align="center" class="style3">Unit-ll : Plot No. 1444,1443,1266,1456,San Nuagaon, Chikatmati, Kalunga</div></td>
        </tr>
        <tr>
            <td><div align="center" class="style3" style="margin-top:5px;font-weight:bold; text-decoration:underline">Payment Receipt</div></td>
        </tr>
        <tr>
            <td ><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="90"><div align="left"  >
                        <div align="center" class="style1" style="margin-bottom:2px"><b> Receipt No :</b></div>
                    </div></td>
                    <td width="360"><div align="left">${advanceBean.advance.id}</div></td>
                    <td width="53"><div align="right" class="style1"><b>Date :</b></div></td>
                    <td width="257"><div align="left"><fmt:formatDate value="<%= new Date()%>"/></div> </td>
                </tr>
               
                
            </table>    </td>
        </tr>
        <tr><td>&nbsp;</td></tr>    
     <tr><td align="left"><p align="left">With reference to your PO no. <strong style="text-decoration:underline">${advanceBean.advance.order.proposal.id}</strong>  dated <s:text style="text-decoration:underline;border :none;" name="test" size="8" formatType="date" value="${advanceBean.advance.order.proposal.createDate}" formatPattern="dd/MM/yyyy"/>it is hereby confirmed
         that we have received INR<strong style="text-decoration:underline">  ${advanceBean.advance.amountReceived}</strong>   towards the advance/balance payment through cheque/dd/Online Transfer.</p></td></tr>
<tr><td><p align="left">We thank you for the same and look forward to a long and mutually benefitting relationship.</p></td></tr>
    <tr><td>&nbsp;</td></tr>    
         <tr><td align="left"><div align="left">For</div> </td></tr>      
    </table>
</s:form>
</body>
</html>
