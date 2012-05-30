<%--
  Created by IntelliJ IDEA.
  User: Atul
  Date: May 16, 2012
  Time: 10:40:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen"/>
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>

<script type="text/javascript">

    $(window).load(function()
        {
            
            if($('#receiptradio').is(':checked'))
            {
               $('#selectnamediv').show();
            }
            if($('#invoiceradio').is(':checked'))
            {
               $('#selectnamediv').show();
                 $('#selectorderdiv').show();
            }
        });
$(document).ready(function()
{
        $('#invoiceradio').click(function()
        {
            $('#selectnamediv').show();
            $('#selectnamediv1').hide();
            $('#selectcutomername').val(0);
            $('#ordertable').hide();
            

          });
        $('#receiptradio').click(function()
        {
           $('#selectnamediv').show();
           $('#selectorderdiv').hide();
           $('#selectcutomername').val(0);
           $('#invoicetable').hide();
        });

        $('#selectorderno').change(function()
        {
            this.form.action='Print.action?invoiceLst';
            this.form.submit();
        });

        $('#selectcutomername').change(function()
        {
            if($('#invoiceradio').is(':checked'))
            {
                $('#selectorderdiv').show();

                $.post("Print.action?getOrderDropDown", {id:$('#selectcutomername').val()}, function (result)
                {
                    var availableTags=eval(result);
                    var options = '<option value="">---Select order No---</option>';
                    for (var i = 0; i < availableTags.length; i++)
                    {
                    options += '<option value="' + availableTags[i].customerOrderNo + '">' + availableTags[i].customerOrderNo + '</option>';
                    }
                    $("#selectorderno").html(options);

                });

            }
            else
            {
                this.form.action='Print.action?lst';
                this.form.submit();
            }
        });
        
 });


</script>                                      
<s:useActionBean beanclass="com.inwise.action.PrintActionBean" event="lst" var="listvar"></s:useActionBean>
<% request.setAttribute("orderlist",listvar.getSelectedOrderList());
%>
<s:useActionBean beanclass="com.inwise.action.PrintActionBean" event="invoiceLst" var="listvar2"></s:useActionBean>
<% request.setAttribute("invoicelist",listvar2.getInvoiceList());
%>

<s:layout-render name="/layout/_base.jsp">
    <s:layout-component name="body">
    <s:form id="formid" beanclass="com.inwise.action.PrintActionBean">


        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
        <tr valign="top"><td >&nbsp;</td>   </tr>
        <tr>
            <td align="left" class="pageheading" valign="top">
            <strong>Print</strong>
            </td>
        </tr>
        <tr valign="top"><td align="center">&nbsp;</td></tr>
        </table>


        <table bordercolor="#FF6600" width="77%" border="1">
        <tr>
            <td width="70%" height="124">
    <table width="100%" cellspacing="1">
                <tr>
                <td width="20%" align="left" valign="top">Search By</td>
                <td width="1%" align="left" valign="top"><s:radio  value="byInvoice" id="invoiceradio"  name="printBy"></s:radio></td>
                <td  align="left" width="20%"  valign="top">Invoice</td>
                <td width="1%" align="left" valign="top"><s:radio value="byReceipt"  id="receiptradio"  name="printBy"></s:radio></td>
                <td align="left"valign="top" width="20%">Receipt</td>
                    <td></td>
                </tr>
           <tr>
                <td width="20%" align="left" valign="top"></td>
         
              <td colspan="5">
                <div id="selectnamediv"align="left" style="margin-left: 2px; display:none;"  class="labels">Please Select Customer <span style="color:#FF0000"> *</span>

                  <s:select id="selectcutomername" name="id"  class="dropdown"  onchange="showorderdropdown();">
                        <option  value="0">---Select Customer---</option>
                        <c:forEach items="${actionBean.orderList}" var="orderno" varStatus="loop" >
                        <c:choose>
                        <c:when test="${actionBean.id eq orderno.customer.id}">
			            <option value ="<c:out value="${actionBean.id}"/>" selected="selected"> <c:out value="${actionBean.cust.name}"/></option>
                        </c:when>
                        <c:otherwise>
                        <option value ="${orderno.customer.id}"><c:out value="${orderno.customer.name}"/></option>
                        </c:otherwise>
                        </c:choose>
		                </c:forEach>
                  </s:select>
                 </div>
                </td>
            </tr>
     
      <tr>
          <td width="20%" align="left" valign="top"></td>

          <td colspan="5">
             <div id="selectorderdiv"align="left" style="margin-left: 2px;display:none;" class="labels">please Select Order No. <span style="color:#FF0000"> *</span>
                <s:select id="selectorderno" name="customerOrderNo"  class="dropdown">
                </s:select>
            </div>
          </td>
      </tr>
      </table>
        </td>
        </tr>
   
   </table>

        <table width="100%"  id="ordertable"><tr><td>
             <c:if test="${actionBean.selectedOrderList!=null}">
                    <d:table name="orderlist" pagesize="10" class="disp"  requestURI="/Print.action">
                    <d:column property="id" title="Order Id"/>
                    <d:column property="customerOrderNo" title="Order No"/>
                    </d:table>
            </c:if>
            </td></tr></table>
            <table width="100%"  id="invoicetable"><tr><td>
             <c:if test="${actionBean.invoiceList!=null}">
                    <d:table name="invoicelist" pagesize="10" class="disp"  requestURI="/Print.action">
                    <d:column property="id" title="Invoice Id"/>
                    <d:column property="invoiceNumber" title="Invoice No"/>
                    </d:table>
            </c:if>

        </td></tr></table>
        </s:form>
        
        </s:layout-component>
</s:layout-render>