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
            <td><div align="center" class="style3" style="margin-top:5px; text-decoration:underline">ADVANCE RECEIPT</div></td>
        </tr>
        <tr>
            <td><table width="760px" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="83"><div align="left"  style="margin-top:5px;">
                        <div align="center" class="style1" style="margin-bottom:2px"><b>DATE :</b></div>
                    </div></td>
                    <td width="192"><div align="left"><fmt:formatDate value="<%= new Date()%>"/> </div></td>
                    <td width="309"><div align="right" class="style1"><b>No.  :</b></div></td>
                    <td width="176">${advanceBean.advance.id}</td>
                </tr>
                <tr>
                    <td width="83"><div align="left"  style="margin-top:5px;">
                        <div align="center" class="style1" style="margin-bottom:2px"><b>Customer Order No. :</b></div>
                    </div></td>
                    <td width="192"><div align="left">${advanceBean.advance.order.customerOrderNo}</div></td>
                    <td width="309"><div align="right" class="style1"><b>Received From  :</b></div></td>
                    <td width="176">${advanceBean.advance.order.customer.name}</td>
                </tr>
                <tr>
                    <td width="83"><div align="left"  style="margin-top:5px;">
                        <div align="center" class="style1" style="margin-bottom:2px"><b>Payment Amount:</b></div>
                    </div></td>
                    <td width="192"><div align="left">${advanceBean.advance.amountReceived}</div></td>
                    <td width="309"><div align="right" class="style1"><b>Payment Mode  :</b></div></td>
                    <td width="176">${advanceBean.advance.paymentMode.mode}</td>
                </tr>
            </table>    </td>
        </tr>
        <tr>
            <td><table width="730px" border="1" cellspacing="0" cellpadding="0" align="center">
                <tr>
                    <td width="12%" height="30" valign="middle"><div align="center" class="style3">No.</div></td>
                    <td width="40%" valign="middle"><div align="center" class="style3">Product Name</div></td>
                    <td width="14%" valign="middle"><div align="center" class="style3">Quantity</div></td>
                    <td width="11%" valign="middle"><div align="center" class="style3">Amount</div></td>
                </tr>
                <c:forEach items="${advanceBean.advance.order.orderDetail}" var="orderDetail" varStatus="loop" >


                    <tr id="tabletr">
                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                            <div align="left" style="margin-left:4px;">
                                <div align="right">
                                        ${loop.index+1}
                                </div></div></td>
                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;"><div align="left" style="margin-left:4px;">
                            <div align="right">
                                    ${orderDetail.product.productName}
                            </div></div></td>

                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                            <div align="left" style="margin-left:4px;">
                                <div align="right">
                                        ${orderDetail.orderedQuantity}
                                </div></div></td>

                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;"><div align="left" style="margin-left:4px;">
                            <div align="right">
                                    ${orderDetail.product.productCost * orderDetail.orderedQuantity}
                            </div></div></td>

                    </tr>
                </c:forEach>
            </table></td>
        </tr>

        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="13%" height="27" class="style1"><div align="left" style="margin-left:2px">
                        <div align="right">Prepared By :</div>
                    </div></td>
                    <td width="16%" class="style1">&nbsp;</td>
                    <td width="12%" class="style1">Received By :</td>
                    <td width="12%" class="style1">&nbsp;</td>
                    <td width="12%" class="style1">Verified By :</td>
                    <td width="11%" class="style1">&nbsp;</td>
                    <td width="12%" class="style1">Checked By :</td>
                    <td width="12%" class="style1">&nbsp;</td>
                </tr>
            </table></td>
        </tr>
    </table>
</s:form>
</body>
</html>
