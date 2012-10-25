
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 23, 2012
  Time: 10:53:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
 <script type="text/javascript">
     $(document).ready(function(){
     $('#customerdropdown').change(function()
{
this.form.action='paymentstatus?getStatus';
this.form.submit();
}); });
 </script>
<s:useActionBean beanclass="com.inwise.action.PaymentStatusActionBean" var="payStatusBean" event="page" ></s:useActionBean>
 <%--<%
    request.setAttribute("invoicelst",payStatusBean.getInvoicelst());
     request.setAttribute("customer",payStatusBean.getCustomer());
     request.setAttribute("invoice",payStatusBean.getInvoice());
     request.setAttribute("customerlst",payStatusBean.getCustomerlst());
      request.setAttribute("id",payStatusBean.getId());
      request.setAttribute("payment",payStatusBean.getPayment());
      request.setAttribute("paymentlst",payStatusBean.getPaymentlst());
%>--%>
<%
    request.setAttribute("invoicelst",payStatusBean.getInvoicelst());
 %>
<s:layout-render name="/layout/_base.jsp">
  
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.PaymentStatusActionBean">
    <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Due Payment</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
     <table class="second_table"  >
              <tr>
              <td>
             <c:if test="${payStatusBean.invoicelst!=null }">

                 <s:form beanclass="com.inwise.action.PaymentStatusActionBean">
             <table class="t" id="invoicetable" width="88%"><tr><td>
        <d:table name="invoicelst" pagesize="10" class="disp" id="inwise" requestURI="paymentstatus">
            <d:column property="invoiceNumber" title="Invoice Number"   />
            <d:column property="customer.name" title="Customer Name"   />
               <d:column property="createDate" title="Invoice Date"   format="{0,date,yyyy-MM-dd}"   />
             <d:column property="netPayable" format="{0,number,0.00}"  title="Invoice Amount"   />
              <d:column property="dueQuantity" format="{0,number,0.00}" title="Due Amount"   />
             <d:column title="Change Status" class="delete" >
             <s:link beanclass="com.inwise.action.PaymentStatusActionBean" event="print" >
                    <s:param name="invoice.invoiceNumber" value="${inwise.invoiceNumber}"></s:param>
                    <s:param name="hdnvalue" value="test"></s:param>
                   <%-- <s:param name="name" value="${purchase.purchaseOrderNo}"></s:param> --%>


                    <img src="images/view.png" />
                </s:link>
            </d:column>
           </d:table>
            </td></tr><table>

 </s:form> </c:if>
              </td>
                     </tr>    </table>


</s:form>
</s:layout-component>
</s:layout-render>