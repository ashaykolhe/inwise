
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
   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
 <tr valign="top"><td >&nbsp;
 </td></tr>
 <tr><td align="left" class="pageheading" valign="top">
Payment Status
 </td></tr>
 <tr valign="top"><td align="center">&nbsp;
 </td></tr>
 </table>
 <table width="70%"  border="1"  cellspacing="0" cellpadding="0"   align="left" bgcolor="#FCFCFC"  >
  <tr>
    <td align="left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">
<tr><td align="left" valign="top" width="14%">
  <div align="right" style="margin-left: 2px;" class="labels"><s:label name="Customer Name"></s:label><span style="color:#FF0000"> *</span></div></td>

		  <td align="left" valign="top" width="21%" > <s:select name="id" id="customerdropdown" class="dropdown" onchange="getstatus()" >
                <c:choose>
                    <c:when test="${payStatusBean.invoicelst!=null && payStatusBean.test=='abc'}">
               <option value ="<c:out value="${payStatusBean.id}"/>" selected="selected" > <c:out value="${payStatusBean.customer.name}"/></option>
                         <option value ="<c:out value="0"/>"> <c:out value="All Customer"/></option>
                <c:forEach items="${payStatusBean.customerlst}" var="cust" varStatus="loop" >
             <option value ="<c:out value="${cust.id}"/>" > <c:out value="${cust.name}" /></option>
		      </c:forEach>
                    </c:when>

                        <c:when test="${payStatusBean.invoicelst!=null}">

                       <option value ="<c:out value="0"/>" selected="selected"> <c:out value="All Customer"/></option>

                <c:forEach items="${payStatusBean.customerlst}" var="cust" varStatus="loop" >
             <option value ="<c:out value="${cust.id}"/>" > <c:out value="${cust.name}" /></option>
		      </c:forEach>
                        </c:when>

                     <c:otherwise>
               <option value ="<c:out value="0"/>"> <c:out value="All Customer"/></option>
                <c:forEach items="${payStatusBean.customerlst}" var="cust" varStatus="loop" >
             <option value ="<c:out value="${cust.id}"/>" > <c:out value="${cust.name}" /></option>
		      </c:forEach>
                </c:otherwise> </c:choose>
                </s:select>
            </td>
    <td width="34%" align="left" valign="top" >
   &nbsp;
    </td>
						</tr> </table>
              </td></tr></table>

             <c:if test="${payStatusBean.invoicelst!=null }">

                 <s:form beanclass="com.inwise.action.PaymentStatusActionBean">
             <table class="t" id="invoicetable" width="100%"><tr><td>
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
   

</s:form>
</s:layout-component>
</s:layout-render>