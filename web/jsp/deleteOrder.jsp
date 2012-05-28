<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: Feb 23, 2012
  Time: 11:52:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<script type="text/javascript">
    function show_confirm()
{
var r=confirm("Are you sure, you want to delete selected record.");
if (r==true)
  {
    return true;
  }
else
  {
    return false;
  }
    return false;
}
</script>
<s:useActionBean beanclass="com.inwise.action.OrderActionBean" var="orderBean" event="pre"></s:useActionBean>
<% request.setAttribute("orderlst",orderBean.getOrderlst());

%>
<s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.OrderActionBean">
   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
 <tr valign="top"><td >&nbsp;
 </td></tr>
 <tr><td align="left" class="pageheading" valign="top">
Order > Delete Order
 </td></tr>
 <tr valign="top"><td align="center">&nbsp;
 </td></tr>
 </table>
              <table width="100%"><tr><td>
                    <d:table name="orderlst" id="order" pagesize="10" class="disp" requestURI="/order">
                 <d:column property="id" title="Id"/>
                 <d:column property="customerOrderNo" title="Customer Order No"  />
                 <d:column title="Delete" class="delete">

                                     <s:link beanclass="com.inwise.action.OrderActionBean" event="delete" onclick="return show_confirm();" >
                                        <s:param name="id" value="${order.id}"></s:param>
                                    <img src="images/Close-2-icon.png" />   </s:link>

                                </d:column>

             </d:table></td></tr></table>

 </s:form></s:layout-component></s:layout-render>