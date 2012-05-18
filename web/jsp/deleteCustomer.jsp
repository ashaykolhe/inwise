<%--
  Created by IntelliJ IDEA.
  User: Minal
  Date: Feb 17, 2012
  Time: 3:48:01 PM
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
<s:useActionBean beanclass="com.inwise.action.CustomerActionBean" var="listofcustomer" event="deleteLink"></s:useActionBean>
<% request.setAttribute("customerlst",listofcustomer.getCustomerlst());

%>
<s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.CustomerActionBean">
   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
 <tr valign="top"><td >&nbsp;
 </td></tr>
 <tr><td align="left" class="pageheading" valign="top">
Customer > Delete Customer
 </td></tr>
 <tr valign="top"><td align="center">&nbsp;
 </td></tr>
 </table>
              <table width="100%"><tr><td>
                    <d:table name="customerlst" id="customer1" pagesize="10" class="disp" requestURI="/Customer.action">
                 <d:column property="name" title="Customer Name"/>
                 <d:column property="department" title="Department"  />
                  <d:column property="email" title="Email Id" />
                <d:column property="customerCode" title="Customer Code" />
                  <d:column title="Delete" class="delete">

                              <s:link beanclass="com.inwise.action.CustomerActionBean" event="delete" onclick="return show_confirm();" >
                                <s:param name="id" value="${customer1.id}"></s:param>
                                <img src="/images/Close-2-icon.png" />   </s:link>

                                </d:column>

             </d:table></td></tr></table>

 </s:form></s:layout-component></s:layout-render>