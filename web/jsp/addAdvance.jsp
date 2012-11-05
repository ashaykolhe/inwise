<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.inwise.pojo.Customer" %>
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
<s:useActionBean beanclass="com.inwise.action.AdvanceActionBean" var="advanceBean" event="advanceLink"/>
<c:if test="${advanceBean.popup eq true}">
    <script type="text/javascript">
        function OpenPopup(){
            var w = 800;
            var h = 480;
            var winl = (screen.width-w)/2;
            var wint = (screen.height-h)/2;
            if (winl < 0) winl = 0;
            if (wint < 0) wint = 0;
            var page = "advance?advancePopup";
            var windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,"
                    + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
            window.open(page, "Popup", windowprops);

        }
        window.onload =OpenPopup();
    </script>
</c:if >
<script type="text/javascript">



$(document).ready(function()
{
     var phoneval = /^([0-9]{0,10})$/;

      $('#addadvancebutton').click(function()
      {

         if($('#advanceamount').val()==""||!phoneval.test($('#advanceamount').val()))
         {
             alert("please enter the amonut in numeric!");
             $('#advanceamount').focus();
             return false;
         }
         if($('#advancedate').val()=="")
         {
             alert("Please select date for advance payment!");
             $('#advancedate').focus();
             return false;
         }
          if($('#advancepaymode').val()=="0")
          {
              alert("Please select the Payment mode!");
              $('#advancepaymode').focus();
              return false;
          }
          if($('#advancepaymode').val()=="cheque"||$('#advancepaymode').val()=="dd")
           {
               if($('#chequeddno').val()=="")
                {
                    alert("please enter the Cheque or DD no!"+$('#advancechequeddno').val());
                    $('#advancechequeddno').focus();
                    return false;
                }

           }


      });
    $('#paymentmodedropdown').change(function(){

            if($('#paymentmodedropdown').attr("value")=="1"){

                $('#chequeddlable').show();
               $('#advancechequeddno').show();
            }else if($('#paymentmodedropdown').attr("value")=="2"){

                $('#chequeddlable').show();
               $('#advancechequeddno').show();
            }else{
                $('#chequeddlable').hide();
               $('#advancechequeddno').hide();
            }
        });

    $('#advancepaymode').change(function(){
           if($('#advancepaymode').val()=="cheque"||$('#advancepaymode').val()=="dd")
           {

               $('#chequeddlable').show();
               $('#advancechequeddno').show();
           }
            if($('#advancepaymode').val()=="cash")
            {
               $('#chequeddlable').hide();
               $('#advancechequeddno').hide();
            }

        });
    $('#selectorderno').change(function()
        {
            this.form.action='advance?getCustomerOrder';
            this.form.submit();
        });

    $('#selectcutomername').change(function()
        {
            this.form.action='advance?getOrderNumbers';
            this.form.submit();
        });
});
</script>
<s:useActionBean beanclass="com.inwise.action.AdvanceActionBean" event="getCustomerOrder" var="listvar"></s:useActionBean>
<% request.setAttribute("orderlist",listvar.getCustomerOrderList());
 request.setAttribute("customerNameForAdvance",listvar.getCustNameIdList());
 request.setAttribute("cust",listvar.getCust());
%>

<s:layout-render name="/layout/_base.jsp">
    <s:layout-component name="left-menu">

                 <ul>
                          <li>&nbsp;</li>
                      <li class="left_menu_heading">Order</li>
                     <li style="margin-top:35px">
                               <s:link beanclass="com.inwise.action.OrderActionBean" event="viewOrderLink">View</s:link></li>
                                                   <li><s:link beanclass="com.inwise.action.AdvanceActionBean" event="advanceLink">Advance Payment</s:link></li>
                  </ul>

         </s:layout-component>
    <s:layout-component name="body">
    <s:form id="formid" beanclass="com.inwise.action.AdvanceActionBean">
        <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Add Advance</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
     <table class="second_table"  ><tr><td>
    <table width="100%" cellspacing="0" border="0" cellpadding="0">
                <%--<tr>
                <td width="20%" align="left" valign="top">Please Get Order First</td>
                <td width="1%" align="left" valign="top"></td>
                <td  align="left" width="20%"  valign="top"></td>
                <td width="1%" align="left" valign="top"></td>
                <td align="left"valign="top" width="20%"></td>
                    <td></td>
                </tr>--%>
           <tr>


              <td width="21%" >
                <div id="selectnamediv"align="left" style="margin-left: 2px;"  class="labels">Please Select Customer <span style="color:#FF0000"> *</span>
                                  </div></td>
               <td width="25%">
                 <s:select id="selectcutomername" name="id1"  class="dropdown">
                        <option  value="0">---Select Customer---</option>

                        <%List<Object> temp=(List<Object>)request.getAttribute("customerNameForAdvance");
                               Iterator<Object> it=temp.iterator();
                               while(it.hasNext()){
                               Object[] obj=(Object[])it.next();

                        %>
                       <%-- <option value ="<%=obj[0]%>"> <%=obj[1]%></option>--%>
                     <%Customer customer=(Customer)request.getAttribute("cust");
                        if(customer!=null && customer.getId().toString().equals(obj[0].toString()))
                        {%>
                         <option value ="<%= obj[0]%>" selected="selected"> <%= obj[1]%></option>
                        <%}else{%>
                          <option value ="<%=obj[0]%>"> <%=obj[1]%></option>
                     <%}%>
                     <%}%>

                  </s:select>

                </td><td colspan="2">&nbsp;</td>
            </tr>

      <tr>
         <c:if test="${actionBean.cust!=null}">

          <td >

             <div id="selectorderdiv"align="left" style="margin-left: 2px;" class="labels">please Select Order No. <span style="color:#FF0000"> *</span> </div></td>
                    <td> <s:select id="selectorderno" name="id2"  class="dropdown">
                    <option  value="0">---Select Order No.---</option>
                        <c:forEach items="${actionBean.orderNoList}" var="orderno" varStatus="loop" >
                        <c:choose>
                        <c:when test="${actionBean.id2 eq orderno.customerOrderNo}">
			       <option value ="<c:out value="${actionBean.id}"/>" selected="selected"> <c:out value="${orderno.customerOrderNo}"/></option>
                        </c:when>
                        <c:otherwise>
                   <option value ="${orderno.customerOrderNo}"><c:out value="${orderno.customerOrderNo}"/></option>
                        </c:otherwise>
                        </c:choose>
		                </c:forEach>
                </s:select>


           </td><td colspan="2">&nbsp;</td>   </c:if>
      </tr>   <tr><td>&nbsp;</td></tr>
        <c:if test="${actionBean.customerOrderList!=null}">
            <tr >
                <td colspan="4" style="margin-left:25px;">
              <table width="70%" border="0"  cellspacing="0" cellpadding="0"  align="center" id="family">
    <tr class="foreach_table">
                        <td width="5%"  class="foreach_table_firstth"><div align="center"><span class="foreach_th_span">Sr No.</span></div></td>
                        <td width="10%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">Product Name</span></div></td>
                        <td width="10%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">Ordered Quantity</span></div></td>
                        <td width="10%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">Rate</span></div></td>
                        <td width="10%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">Total</span></div></td>

                       </tr>
                    <c:forEach var="orders" items="${actionBean.customerOrderList}" varStatus="loop">
                    <tr>
                           <td class="foreach_table_firstth"><div align="right"><strong><span class="foreach_table_div" >${loop.index+1}</span></strong></div></td>
                           <td class="foreach_table_th"><div align="right"><strong><span class="foreach_table_div">${orders.product.productName}</span></strong></div></td>
                            <td class="foreach_table_th"><div align="right"><strong><span class="foreach_table_div">${orders.orderedQuantity}</span></strong></div></td>
                           <td class="foreach_table_th"><div align="right"><strong><span class="foreach_table_div">${orders.cost}</span></strong></div></td>
                            <td class="foreach_table_th"><div align="right"><strong><span class="foreach_table_div">${orders.cost*orders.orderedQuantity}</span></strong></div></td>
                   </tr>
                    </c:forEach>
                   <tr>
                            <td colspan="3" style="border-right:1px solid #cccccc;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" ></span></strong></div></td>
                            <td width="5%" style="border-right:1px solid #cccccc;border-bottom:1px solid #cccccc;"><div align="left"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Total</span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #cccccc;border-bottom:1px solid #cccccc;"><div align="right"><strong><span style="color:#3B3131;font-size:13px;">${actionBean.total}</span></strong></div></td>
                   </tr>
                </table>

                      <tr>

                            <td width="21%" align="left"> <div align="left" style="margin-left: 2px;" class="labels">Amount<span style="color:#FF0000"> *</span></div>     </td>
                            <td width="25%" align="left" valign="top"><div align="left"><s:text name="advance.amountReceived" id="advanceamount" class="textbox"></s:text></div> </td>
                            <td width="13%" align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Advance Date<span style="color:#FF0000"> *</span></div></td>
                            <td width="41%" align="left" valign="bottom"><div align="left" ><s:text id="advancedate"  name="advance.createDate" onFocus="showCalendarControl(this);" class="textbox"></s:text>
                      </tr>

                       <tr>

                           <td width="21%" align="left" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Payment Mode<span style="color:#FF0000"> *</span></div></td>
                            <td width="25%" align="left" valign="bottom"><div align="left" >
                                 <s:select name="advance.paymentMode.id" id="paymentmodedropdown" class="dropdown">
                                                    <option value="">---Payment Mode---</option>
                                                    <c:forEach items="${advanceBean.paymentModeList}" var="paymentMode" varStatus="loop" >
                                                        <option value ="<c:out value="${paymentMode.id}"/>"> <c:out value="${paymentMode.mode}"/></option>
                                                    </c:forEach>
                                                </s:select>
                                </div>

                           <td width="13%" align="right"> <div   align="right" style="margin-left: 2px; display:none" id="chequeddlable" class="labels">Cheque/DD No. <span style="color:#FF0000"> *</span></div>     </td>
                            <td width="41%" align="left" valign="top"><div align="left" style="display:none;" id="advancechequeddno"><s:text name="advance.chequeOrDDNo" id="chequeddno" class="textbox"></s:text></div>
                          <s:hidden name="total" value="${actionBean.total}"></s:hidden>
                                <s:hidden name="advance.deleted" value="0"></s:hidden>
                                <s:hidden name="advance.order.id" value="${actionBean.o.id}"></s:hidden>
                            </td>


                       </tr>

                    <tr>
                                      <td>&nbsp;</td>
                        <td colspan="3" align="left" valign="top"><div align="left">     &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:submit id="addadvancebutton" name="addAdvance" class="buttons" value="Save"></s:submit>     &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:reset name="reset" value="Reset" class="buttons"></s:reset>   &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:submit name="cancel" value="Cancel" class="buttons"></s:submit></div></td>
                        <td width="0%" >&nbsp;</td>

                    </tr>

              </table>
                              </td>
            </tr>


        </c:if>
        <c:if test="${actionBean.checkAdvanceMade!=null}">
            <div style="margin-top:25px;margin-left:200px;font-size:13px;font-family:Verdana;color:red;">
             <stripes:messages/>  </div>
            <script type="text/javascript">
                alert("Advance Already Made");
            </script>
        </c:if>

        </table>
       </td>
        </tr>
        </table>

    </s:form>

        </s:layout-component>
</s:layout-render>
<%--
<div>
                                                <s:select name="advance.paymentMode.id" id="paymentmodedropdown" class="dropdown">
                                                    <option value="">---Payment Mode---</option>
                                                    <c:forEach items="${advanceBean.paymentModeList}" var="paymentMode" varStatus="loop" >
                                                        <option value ="<c:out value="${paymentMode.id}"/>"> <c:out value="${paymentMode.mode}"/></option>
                                                    </c:forEach>
                                                </s:select>
                                            </div>--%>
