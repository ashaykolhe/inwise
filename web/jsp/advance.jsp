<%--
  Created by IntelliJ IDEA.
  User: Atul
  Date: May 23, 2012
  Time: 10:52:57 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen"/>
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<script type="text/javascript">



$(document).ready(function()
{
    $('#selectorderno').change(function()
        {
            this.form.action='Advance.action?getCustomerOrder';
            this.form.submit();
        });
    
    $('#selectcutomername').change(function()
        {
                
            this.form.action='Advance.action?getOrderNumbers';
            this.form.submit();
        });
});
</script>
<s:useActionBean beanclass="com.inwise.action.AdvanceActionBean" event="getCustomerOrder" var="listvar"></s:useActionBean>
<% request.setAttribute("orderlist",listvar.getCustomerOrderList());
%>

<s:layout-render name="/layout/_base.jsp">
    <s:layout-component name="body">
    <s:form id="formid" beanclass="com.inwise.action.AdvanceActionBean">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
        <tr valign="top"><td >&nbsp;</td>   </tr>
        <tr>
            <td align="left" class="pageheading" valign="top">
            <strong>Advance</strong>
            </td>
        </tr>
        <tr valign="top"><td align="center">&nbsp;</td></tr>
        </table>


        <table bordercolor="#FF6600" width="77%" border="1">
        <tr>
            <td width="70%" height="124">
    <table width="100%" cellspacing="1">
                <tr>
                <td width="20%" align="left" valign="top">Please Get Order First</td>
                <td width="1%" align="left" valign="top"></td>
                <td  align="left" width="20%"  valign="top"></td>
                <td width="1%" align="left" valign="top"></td>
                <td align="left"valign="top" width="20%"></td>
                    <td></td>
                </tr>
           <tr>
                <td width="20%" align="left" valign="top"></td>

              <td colspan="5">
                <div id="selectnamediv"align="left" style="margin-left: 2px;"  class="labels">Please Select Customer <span style="color:#FF0000"> *</span>

                 <s:select id="selectcutomername" name="id1"  class="dropdown">
                        <option  value="0">---Select Customer---</option>
                        <c:forEach items="${actionBean.orderList}" var="orderno" varStatus="loop" >
                        <c:choose>
                        <c:when test="${actionBean.id1 eq orderno.customer.id}">
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
        <c:if test="${actionBean.id1!=null}">
             <div id="selectorderdiv"align="left" style="margin-left: 2px;" class="labels">please Select Order No. <span style="color:#FF0000"> *</span>
                     <s:select id="selectorderno" name="id2"  class="dropdown">
                    <option  value="0">---Select Order No.---</option>
                        <c:forEach items="${actionBean.orderNoList}" var="orderno" varStatus="loop" >
                        <c:choose>
                        <c:when test="${actionBean.id2 eq orderno.customerOrderNo}">
			       <option value ="<c:out value="${actionBean.id}"/>" selected="selected"> <c:out value="${actionBean.cust.name}"/></option>
                        </c:when>
                        <c:otherwise>
                   <option value ="${orderno.id}"><c:out value="${orderno.customerOrderNo}"/></option>
                        </c:otherwise>
                        </c:choose>
		                </c:forEach>
                </s:select>
                 </c:if>
            </div>
          </td>
      </tr>
      </table>
        </td>
        </tr>

   </table>
         <table width="100%"  id="ordertable"><tr><td>
             <c:if test="${actionBean.customerOrderList!=null}">
                    <d:table name="orderlist" pagesize="10" class="disp"  requestURI="/Print.action">
                    <d:column property="id" title="Order Id"/>
                    <d:column property="customerOrderNo" title="Order No"/>
                    </d:table>
            </c:if>
            </td></tr></table>
    </s:form>

        </s:layout-component>
</s:layout-render>