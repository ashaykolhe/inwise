<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 14, 2012
  Time: 12:27:02 PM
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
<s:useActionBean beanclass="com.inwise.action.ProductActionBean" var="productactionBean" event="deleteProductLink"></s:useActionBean>
<% request.setAttribute("prodlst",productactionBean.getProdlst());

%>
<s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.ProductActionBean">
   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
 <tr valign="top"><td >&nbsp;
 </td></tr>
 <tr><td align="left" class="pageheading" valign="top">
Delete Product
 </td></tr>
 <tr valign="top"><td align="center">&nbsp;
 </td></tr>
 </table>
              <table width="100%"><tr><td>
                    <d:table name="prodlst" id="prod" pagesize="10" class="disp" requestURI="/Product.action">

                 <d:column property="productName" title="Product Name"  />
                  <d:column property="productCost" title="Product Cost" />
                 <d:column property="productMeasurementType.measurementType" title="Unit" />
                                <d:column title="Delete" class="delete">

                                     <s:link beanclass="com.inwise.action.ProductActionBean" event="deleteProduct" onclick="return show_confirm();" >
                                        <s:param name="id" value="${prod.id}"></s:param>
                                    <img src="images/Close-2-icon.png" />   </s:link>

                                </d:column>

             </d:table></td></tr></table>

 </s:form></s:layout-component></s:layout-render>