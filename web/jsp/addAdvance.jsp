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
            <td width="70%" >
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
                 </div>
                </td>
            </tr>

      <tr>
          <td width="20%" align="left" valign="top"></td>

          <td colspan="5">
        <c:if test="${actionBean.cust!=null}">
             <div id="selectorderdiv"align="left" style="margin-left: 2px;" class="labels">please Select Order No. <span style="color:#FF0000"> *</span>
                     <s:select id="selectorderno" name="id2"  class="dropdown">
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
                 </c:if>
            </div>
          </td>
      </tr>
        <c:if test="${actionBean.customerOrderList!=null}">
            <tr>
              <table border="0" cellspacing="0" cellpadding="0" style="border:1px solid #000000;" align="left" id="family" width="90%">
                    <tr>
                        <td width="5%"  style="border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Sr No.</span></strong></div></td>
                        <td width="10%"  style="border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Product Name</span></strong></div></td>
                        <td width="10%"  style="border-right:1px solid #000000; background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Ordered Quantity</span></strong></div></td>
                        <td width="10%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Rate</span></strong></div></td>
                        <td width="10%"  style="background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Total</span></strong></div></td>    

                       </tr>
                    <c:forEach var="orders" items="${actionBean.customerOrderList}" varStatus="loop">
                    <tr>   
                            <td width="5%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >${loop.index+1}</span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;">${orders.product.productName}</span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;">${orders.orderedQuantity}</span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;">${orders.product.productCost}</span></strong></div></td>
                            <td width="10%" style=""><div align="center"><strong><span style="color:#3B3131;font-size:13px;">${orders.product.productCost*orders.orderedQuantity}</span></strong></div></td>
                   </tr>
                    </c:forEach>
                   <tr>
                            <td colspan="3" style="border-right:1px solid #000000; border-top:1px solid #000000"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" ></span></strong></div></td>
                            <td width="5%" style="border-right:1px solid #000000;border-top:1px solid #000000"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Total</span></strong></div></td>
                            <td width="10%" style="border-top:1px solid #000000"><div align="center"><strong><span style="color:#3B3131;font-size:13px;">${actionBean.total}</span></strong></div></td>
                   </tr>
                </table>
                <table>
                      <tr>
                            <td width="20%" align="left"></td>
                            <td width="18%" align="left"> <div align="left" style="margin-left: 2px;" class="labels">Amount<span style="color:#FF0000"> *</span></div>     </td>
                            <td width="15%" align="left" valign="top"><div align="left"><s:text name="advance.amountReceived" id="advanceamount" class="textbox"></s:text></div> </td>
                            <td width="15%" align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Advance Date<span style="color:#FF0000"> *</span></div></td>
                            <td width="20%" align="left" valign="bottom"><div align="left" ><s:text id="advancedate"  name="advance.createDate" onFocus="showCalendarControl(this);" class="textbox"></s:text>
                      </tr>

                       <tr>
                           <td width="20%" align="left"></td>
                           <td width="18%" align="left" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Payment Mode<span style="color:#FF0000"> *</span></div></td>
                            <td width="15%" align="left" valign="bottom"><div align="left" >
                                <s:select name="advance.paymentMode" id="advancepaymode" class="dropdown">
                                    <option value="0">---Select Payment Mode---</option>
                                    <option value="cash">By Cash</option>
                                     <option value="dd">By DD</option>
                                     <option value="cheque">By Cheque</option>
                                </s:select>
                                </div>

                           <td width="15%" align="right"> <div   align="right" style="margin-left: 2px; display:none" id="chequeddlable" class="labels">Cheque/DD No. <span style="color:#FF0000"> *</span></div>     </td>
                            <td width="20%" align="left" valign="top"><div align="left" style="display:none;" id="advancechequeddno"><s:text name="advance.chequeOrDDNo" id="chequeddno" class="textbox"></s:text></div>
                          <s:hidden name="total" value="${actionBean.total}"></s:hidden>
                                <s:hidden name="advance.deleted" value="0"></s:hidden>
                                <s:hidden name="advance.order.id" value="${actionBean.o.id}"></s:hidden>
                            </td>
                          
                           
                       </tr>

                    <tr>
                        <td width="20%"></td>
                        <td colspan="4" align="left" valign="top"><div align="left">     &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:submit id="addadvancebutton" name="addAdvance" value="Save"></s:submit>     &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:reset name="reset" value="Reset"></s:reset>   &nbsp;&nbsp;&nbsp;&nbsp;
                        <s:submit name="cancel" value="Cancel"></s:submit></div></td>
                        <td >&nbsp;</td>

                    </tr>
                         
              </table>

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