<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: Feb 23, 2012
  Time: 11:52:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<s:useActionBean beanclass="com.inwise.action.OrderActionBean" var="orderBean" event="pre"></s:useActionBean>
<% request.setAttribute("orderlst",orderBean.getOrderlst());

%>

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

<s:layout-render name="/layout/_base.jsp">
    <s:layout-component name="left-menu">

                 <ul>
                          <li>&nbsp;</li>
                      <li class="left_menu_heading">Order</li>
                     <li style="margin-top:35px">
                                         <s:link beanclass="com.inwise.action.OrderActionBean" event="viewOrderLink">View</s:link></li>
                     <li><s:link beanclass="com.inwise.action.OrderActionBean" event="proformaLink">Create Proforma Invoice</s:link></li>
                                                   <li><s:link beanclass="com.inwise.action.AdvanceActionBean" event="advanceLink">Advance Payment</s:link></li>
                  </ul>

         </s:layout-component>
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.OrderActionBean">
  <br>
    <table class="heading_table" >

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >View Order</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>


      <table class="second_table"  ><tr><td>
                    <d:table name="orderlst" id="order" pagesize="10" class="disp" requestURI="/order">
                 <d:column property="customer.name" title="Customer Name"/>
                 <d:column property="customerOrderNo" title="Customer Order No"  />
                 <d:column property="consigneeName" title="Consignee Name"  />
                 <d:column property="createDate" title="Order Date"  format="{0,date,yyyy-MM-dd}" sortable="false"/>
                  <d:column title="Product Name">
                <table>
                    <c:forEach items="${order.orderDetail}" var="products" varStatus="loop" >
                        <tr>
                            <td>${products.product.productName}</td></tr>
                    </c:forEach>
                </table>
            </d:column>

                         <d:column title="Ordered Quantity">
                <table>
                    <c:forEach items="${order.orderDetail}" var="qty" varStatus="loop1" >
                        <tr>
                            <td>${qty.orderedQuantity}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
                        <d:column title="Cost">
                <table>
                    <c:forEach items="${order.orderDetail}" var="cst" varStatus="loop3" >
                        <tr>
                            <td>${cst.cost}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
                          <d:column title="Remaining Quantity">
                <table>
                    <c:forEach items="${order.orderDetail}" var="reqty" varStatus="loop2" >
                        <tr>
                            <td>${reqty.remainingQuantity}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
             </d:table></td></tr></table>

 </s:form></s:layout-component></s:layout-render>