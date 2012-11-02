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
     <s:layout-component name="left-menu">

                 <ul>
                          <li>&nbsp;</li>
                      <li class="left_menu_heading">Product</li>
                     <li style="margin-top:35px">
                             <li><s:link beanclass="com.inwise.action.ProductActionBean" event="addProductLink">Add</s:link></li>
                             <li><s:link beanclass="com.inwise.action.ProductActionBean" event="viewProductLink">View</s:link></li>
                  </ul>

         </s:layout-component>
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.ProductActionBean">
   <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >View Products</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center">
    <div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
   <table class="second_table"  ><tr><td>
                    <d:table name="prodlst" id="prod" pagesize="15" class="disp" requestURI="/product">

                 <d:column property="productName" title="Product Name"  />
                  <d:column property="productCost" title="Product Cost" />
                 <d:column property="unit.name" title="Unit" />

                         <d:column  title="update">
                               <s:link beanclass="com.inwise.action.ProductActionBean" event="getProductButton"  >
                                  <s:param name="id" value="${prod.id}"></s:param>
                                <img src="images/edit-icon.png" />
                       </s:link>

                  </d:column> 

                                <d:column title="Delete" class="delete">

                                     <s:link beanclass="com.inwise.action.ProductActionBean" event="deleteProduct" onclick="return show_confirm();" >
                                        <s:param name="id" value="${prod.id}"></s:param>
                                    <img src="images/delete.jpg" />   </s:link>

                                </d:column>

             </d:table></td></tr></table>

 </s:form></s:layout-component></s:layout-render>