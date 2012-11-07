<%--
Created by IntelliJ IDEA.
User: Admin
Date: Mar 1, 2012
Time: 3:44:59 PM
To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">

    $(document).ready(function(){
        $('#customerName').change(function(){
            $.get("order?getCustomerOrderNo",{id:$(this).attr("value")}, function (result) {
                var data=eval(result);
                var options = '<option value="">---Select Customer Order No---</option>';
                for (var i = 0; i < data.length; i++) {
                    options += '<option value="' + data[i].id + '">' + data[i].customerOrderNo +'</option>';
                }
                $("#orderdropdown").html(options);
            });
        });

        $('#orderdropdown').change(function(){
            if($('#orderdropdown').attr('value')!=""){
                var current=this;
                var orderId=$(this).attr("value");

                        current.form.action='order?getOrdersProforma';
                        current.form.submit();

                                };

            
        });

    });

</script>

<script type="text/javascript">

    $(document).ready(function(){
        $('#radio1').click(function(){
     $('#trpercentage').show();
          $('#tramount').hide();
     });
    $('#radio2').click(function(){
     $('#trpercentage').hide();
          $('#tramount').show();
     });
    });

</script>


<s:useActionBean beanclass="com.inwise.action.OrderActionBean" var="orderBean" event="pre"></s:useActionBean>
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
  <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Proforma Invoice</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>


      <table class="second_table"  >
<s:form beanclass="com.inwise.action.OrderActionBean">

        <tr> 
            <td width="21%" align="left" valign="top">
                <div align="left" style="margin-left: 2px;" class="labels">
                    Name of Customer<span style="color:#FF0000"> *</span></div>
                </td>
            <td width="79%" align="left" valign="top"><div align="left">
                <s:select id="customerName" name="order.customer.id" class="dropdown">
                    <option  value="0">---Select Customer---</option>
                    <c:forEach items="${orderBean.customerList}" var="customer" varStatus="loop" >
                        <c:choose>
                            <c:when test="${orderBean.order.customer.id eq customer.id}">
                                <option value ="<c:out value="${customer.id}"/>" selected="selected"> <c:out value="${customer.name}"/></option>
                            </c:when>

                            <c:otherwise>
                                <option value ="${customer.id}"><c:out value="${customer.name}"/></option>
                            </c:otherwise>
                        </c:choose>
                </c:forEach>
            </s:select>
            </div></td>
       
        </tr>
   <tr><td width="21%" align="left" valign="top">
        <div align="left" style="margin-left: 1px;" class="labels">Customer Order Number<span style="color:#FF0000"> *</span></div></td>
        <td width="79%" align="left" valign="top" >
            <s:select name="id" id="orderdropdown" class="dropdown">
                <option value="">---Select Customer Order No---</option>

                <c:forEach items="${orderBean.orderlst}" var="order" varStatus="loop" >
                    <c:choose>
                        <c:when test="${orderBean.order.customerOrderNo eq order.customerOrderNo}">
                            <option value ="<c:out value="${order.id}"/>" selected="selected"> <c:out value="${order.customerOrderNo}"/></option>
                        </c:when>

                        <c:otherwise>
                            <option value ="<c:out value="${order.id}"/>"> <c:out value="${order.customerOrderNo}"/></option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

            </s:select>

        </td>

       
    </tr>        </s:form>

<div id="hide">
<c:if test="${orderBean.order!=null}">

    <s:form beanclass="com.inwise.action.OrderActionBean">



                <tr>
                    <td width="20%" align="left" valign="top">
                        <s:hidden name="order.deleted" value="0"/>
                        <s:hidden name="proforma.order.id" value="${orderBean.order.id}"/>
                        <s:hidden name="proforma.customer.id" value="${orderBean.order.customer.id}"/>

                       <div align="left" style="margin-left: 2px;" class="labels">
                            <div align="left" style="text-align:right">Consignee Name<span style="color:#FF0000"> *</span></div>
                        </div>
                    </td>
                    <td width="80%" align="left" valign="top">
                         <div align="left">
                            <s:text name="order.consigneeName" id="consigneeName" class="textbox"/>
                        </div>
                    </td>
                </tr>

                

                <tr>
                    <td colspan="2"><br><div align="left" style="margin-left:10px;">
                        <table width="95%" border="0"  cellspacing="0" cellpadding="0"  align="left" id="family">
    <tr class="foreach_table">

                            <td width="17%"  class="foreach_table_firstth"><div align="center"><span class="foreach_th_span">Product</span></div></td>

                            <td width="18%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">UOM</span></div></td>
                            <td width="17%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">Quantity</span></div></td>
                            <td width="21%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">Rate</span></div></td>
                            <td width="20%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">Amount</span></div></td>

                       
                            </tr>

                                <c:forEach var="orders" items="${orderBean.order.orderDetail}" varStatus="loop">
                    <tr>
                           <td class="foreach_table_firstth"><div align="right"><strong><span class="foreach_table_div" >${loop.index+1}</span></strong></div></td>
                           <td class="foreach_table_th"><div align="right"><strong><span class="foreach_table_div">${orders.product.productName}</span></strong></div></td>
                            <td class="foreach_table_th"><div align="right"><strong><span class="foreach_table_div">${orders.orderedQuantity}</span></strong></div></td>
                           <td class="foreach_table_th"><div align="right"><strong><span class="foreach_table_div">${orders.cost}</span></strong></div></td>
                            <td class="foreach_table_th"><div align="right"><strong><span class="foreach_table_div">${orders.cost*orders.orderedQuantity}</span></strong></div></td>
                   </tr>
                              <tr>
         <td colspan="3"> &nbsp;</td>
              <td class="foreach_table_th" style=" border-left:1px solid #cccccc;font-weight:bold;"><div class="foreach_table_div">    <div align="right">Total Amount</div></div></td>
         <td class="foreach_table_th"><div class="foreach_table_div">    <div align="right">
                                            <s:text name="proposal.totalAmount" id="totalAmount" readonly="readonly" value="${orderBean.total}" class="foreach_table_td" style=" width:100px;"/>
                                     </div>   </div></td>
     </tr>
                    </c:forEach>         
                        </table></div></td> </tr>
                  <tr>
<td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Enter the value to be raised through Proforma Invoice<span style="color:#FF0000"> *</span></div></td>
<td  align="left" valign="top" class="labels"><div align="left">
    <s:radio  value="Percentage" id="radio1"  name="grn.status"></s:radio>
    Percentage&nbsp;
    <s:radio  value="Specific Amount" id="radio2"   name="grn.status"></s:radio>
    Specific Amount</div></td>
        </tr>
                       <tr id="trpercentage" style="display:none;">

                            <td width="20%" align="left"> <div align="left" style="margin-left: 2px;" class="labels">Enter Percentage<span style="color:#FF0000"> *</span></div>     </td>
                            <td width="80%" align="left" valign="top"><div align="left"><s:text name="proforma.percentage"  id="amountinpercentage" class="textbox"/>%</div> </td>

                      </tr>
                     <tr id="tramount" style="display:none;">

                            <td width="20%" align="left"> <div align="left" style="margin-left: 2px;" class="labels">Enter Amount<span style="color:#FF0000"> *</span></div>     </td>
                            <td width="80%" align="left" valign="top"><div align="left"><s:text name="proforma.amount"  id="amount" class="textbox"/></div> </td>
                            
                      </tr>       
                <tr>
                    <td align="left">&nbsp;</td>
                    <td align="left" >&nbsp;</td>
                   
                </tr>
                <tr>
                    <td align="left">&nbsp;</td>
                    <td align="left" ><div align="left">     &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:submit id="addadvancebutton" name="addProforma" class="buttons" value="Save"/>     &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:reset name="reset" value="Reset" class="buttons"/>   &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:submit name="cancel" value="Cancel" class="buttons"/></div></td>
                    
                </tr>
           </s:form>   </c:if></div>
                   </table>
</s:layout-component></s:layout-render>