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
    <s:layout-component name="left-menu">

                 <ul>
                          <li>&nbsp;</li>
                      <li class="left_menu_heading">Customer</li>
                     <li style="margin-top:35px">
                               <li><s:link beanclass="com.inwise.action.CustomerActionBean" event="pageDirect">Add</s:link></li>
                              <li><s:link beanclass="com.inwise.action.CustomerActionBean" event="viewLink">View</s:link></li>

                  </ul>

         </s:layout-component>
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.CustomerActionBean">
    <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >View Customer</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center">
    <div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
   <table class="second_table"  ><tr><td>
                    <d:table name="customerlst" id="customer1" pagesize="15" class="disp" requestURI="/customer">
                 <d:column property="name" title="Customer Name"/>
                 <d:column property="department" title="Department"  />
                          <d:column property="customerCode" title="Customer Code" />
                  <d:column property="email" title="Email Id" />

                         <d:column property="contactNo1" title="Phone Number" />

                         <d:column  title="update">
                                                     <s:link beanclass="com.inwise.action.CustomerActionBean" event="updateCustomer"  >
                                <s:param name="id" value="${customer1.id}"></s:param>
                                <img src="images/edit-icon.png" />
                       </s:link>

                  </d:column>
                  <d:column title="Delete" class="delete">

                              <s:link beanclass="com.inwise.action.CustomerActionBean" event="delete" onclick="return show_confirm();" >
                                <s:param name="id" value="${customer1.id}"></s:param>
                                <img src="images/delete.jpg" />   </s:link>

                                </d:column>

             </d:table></td></tr></table>

 </s:form></s:layout-component></s:layout-render>