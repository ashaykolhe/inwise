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

<s:useActionBean beanclass="com.inwise.action.TaxActionBean" var="list" event="viewTaxLink"></s:useActionBean>
<% request.setAttribute("taxlst",list.getTaxlst());

%>
<s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="left-menu">

                 <ul>
                          <li>&nbsp;</li>
                      <li class="left_menu_heading">Tax</li>
                     <li style="margin-top:35px">
                               <li ><s:link beanclass="com.inwise.action.TaxActionBean" event="addTaxLink">Add</s:link></li>

                               <li><s:link beanclass="com.inwise.action.TaxActionBean" event="viewTaxLink">View</s:link></li>
                  </ul>

         </s:layout-component>
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.CustomerActionBean">
    <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >View Tax</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center">
    <div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
   <table class="second_table"  ><tr><td>
                    <d:table name="taxlst" id="tax" pagesize="15" class="disp" requestURI="/tax">
                 <d:column property="name" title="Tax Name"/>
                 <d:column property="taxPercentage" title="Tax Percentage"  />
                 
                         <d:column  title="update">
                                                     <s:link beanclass="com.inwise.action.TaxActionBean" event="getTaxById"  >
                                <s:param name="id" value="${tax.id}"></s:param>
                                <img src="images/edit-icon.png" />
                       </s:link>

                  </d:column>
                  

             </d:table></td></tr></table>

 </s:form></s:layout-component></s:layout-render>