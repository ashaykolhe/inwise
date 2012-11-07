<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ page import="com.inwise.pojo.Customer" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Atul
  Date: May 16, 2012
  Time: 10:40:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen"/>
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<s:useActionBean beanclass="com.inwise.action.PrintActionBean" var="printBean" event="lst"/>
<c:if test="${printBean.receiptNumber ne null}">
    <script type="text/javascript">
        function OpenPopup(){
            var w = 800;
            var h = 480;
            var winl = (screen.width-w)/2;
            var wint = (screen.height-h)/2;
            if (winl < 0) winl = 0;
            if (wint < 0) wint = 0;
           var page = "advance?advancePopupViaReceiptNo=&id="+${printBean.receiptNumber};

            var windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,"
                    + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
            window.open(page, "Popup", windowprops);

        }
        window.onload =OpenPopup();
    </script>
</c:if >
<c:if test="${printBean.inviceNumber ne null}">
    <script type="text/javascript">
        function OpenPopup(){
            var w = 800;
            var h = 480;
            var winl = (screen.width-w)/2;
            var wint = (screen.height-h)/2;
            if (winl < 0) winl = 0;
            if (wint < 0) wint = 0;
            var page = "print?invoicePopup=&id="+${printBean.inviceNumber};
            var windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,"
                    + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
            window.open(page, "Popup", windowprops);

        }
        window.onload =OpenPopup();
    </script>
</c:if >
<script type="text/javascript">

    $(window).load(function()
        {

            if($('#receiptradio').is(':checked'))
            {  $('#selectcutomername').show();
               $('#selectnamediv').show();
            }
            if($('#invoiceradio').is(':checked'))
            {   $('#selectcutomername').show();
               $('#selectnamediv').show();
                 $('#selectorderdiv').show();
            }
        });
$(document).ready(function()
{
        $('#invoiceradio').click(function()
        {       $('#selectcutomername').show();
            $('#selectnamediv').show();
            $('#selectnamediv1').hide();
            $('#selectcutomername').val(0);
            $('#ordertable').hide();
            $('#msgtable').hide();


          });
        $('#receiptradio').click(function()
        {
             $('#selectcutomername').show();
           $('#selectnamediv').show();
           $('#selectorderdiv').hide();
           $('#selectcutomername').val(0);
           $('#invoicetable').hide();
            $('#msgtable').hide();
        });

        $('#selectorderno').change(function()
        {
            this.form.action='print?invoiceLst';
            this.form.submit();
        });

        $('#selectcutomername').change(function()
        {
            if($('#invoiceradio').is(':checked'))
            {
                 this.form.action='print?getOrderDropDown';
                this.form.submit();
                $('#selectorderdiv').show();

                /*$.post("Print.action?getOrderDropDown", {id:$('#selectcutomername').val()}, function (result)
                {
                    var availableTags=eval(result);
                    var options = '<option value="">---Select order No---</option>';
                    for (var i = 0; i < availableTags.length; i++)
                    {
                    options += '<option value="' + availableTags[i].customerOrderNo + '">' + availableTags[i].customerOrderNo + '</option>';
                    }
                    $("#selectorderno").html(options);

                });*/

            }
            else
            {
                this.form.action='print?lst';
                this.form.submit();
            }
        });

 });


</script>
<s:useActionBean beanclass="com.inwise.action.PrintActionBean" event="lst" var="listvar"></s:useActionBean>
<%
    request.setAttribute("customerNameForAdvance",listvar.getCustNameIdList());
    request.setAttribute("orederListFromAdvance",listvar.getOrderFromAdvance());
 request.setAttribute("cust",listvar.getCust());
    request.setAttribute("invoiceLst",listvar.getInvoiceList());
%>
<%--<s:useActionBean beanclass="com.inwise.action.PrintActionBean" event="invoiceLst" var="listvar2"></s:useActionBean>
<%
%>--%>

<s:layout-render name="/layout/_base.jsp">
 <s:layout-component name="left-menu">

             <ul>
                 <li>&nbsp;</li>
                  <li class="left_menu_heading">Search/Print</li>
                  <li style="margin-top:35px">    <s:link beanclass="com.inwise.action.SearchActionBean" event="searchLink">Search</s:link></li>
                                                     <li><s:link beanclass="com.inwise.action.PrintActionBean" event="printInvoiceLink">Print</s:link></li>
              </ul>

     </s:layout-component>
    <s:layout-component name="body">
    <s:form id="formid" beanclass="com.inwise.action.PrintActionBean">

<br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Print</div>
    </td></tr>
     </table>
     <table class="second_table"  ><tr><td>
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr>
                <td width="13%" align="left" valign="top">Search By</td>
                <td width="1%" align="left" valign="top"><s:radio  value="byInvoice" id="invoiceradio"  name="printBy"></s:radio></td>
                <td  align="left" width="8%"  valign="top">Invoice</td>
                <td width="2%" align="left" valign="top"><s:radio value="byReceipt"  id="receiptradio"  name="printBy"></s:radio></td>
                <td align="left"valign="top" width="9%">Receipt</td>
                    <td width="67%"></td>
                </tr>
           <tr>


              <td colspan="3">
                <div id="selectnamediv"align="left" style="margin-left: 2px; display:none;"  class="labels">Please Select Customer <span style="color:#FF0000"> *</span>
                  </div></td><td colspan="2">
                    <s:select id="selectcutomername" name="id" style="display :none ;"  class="dropdown"  onchange="showorderdropdown();">
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
                                </td>
            </tr>

      <tr>
          <td width="13%" align="left" valign="top"></td>

          <td colspan="5">
              <c:if test="${actionBean.showdropdown!=null}">
             <div id="selectorderdiv"align="left" style="margin-left: 2px;" class="labels">please Select Order No. <span style="color:#FF0000"> *</span>
                <s:select id="selectorderno" name="customerOrderNo"  class="dropdown">
                    <option  value="0">---Select Order No.---</option>
                        <c:forEach items="${actionBean.orderNoList}" var="orderno" varStatus="loop" >
                        <c:choose>
                        <c:when test="${actionBean.customerOrderNo eq orderno.id}">
			       <option value ="<c:out value="${actionBean.customerOrderNo}"/>" selected="selected"> <c:out value="${orderno.customerOrderNo}"/></option>
                        </c:when>
                        <c:otherwise>
                   <option value ="${orderno.id}"><c:out value="${orderno.customerOrderNo}"/></option>
                        </c:otherwise>
                        </c:choose>
		                </c:forEach>
                </s:select>
            </div>
              </c:if>
          </td>
      </tr>
      </table>
        </td>
        </tr>

   </table>

        <%--<table bordercolor="#FF6600" width="77%" id="msgtable">
        <tr>
            <td width="70%" >
                <table width="100%" cellspacing="1">
                    <tr>
                        <div style="margin-top:05px;margin-left:150px;font-size:13px;font-family:Verdana;">
             <stripes:messages/>  </div>

                    </tr>
                </table>
            </td>
           </tr>
         </table>--%>

               <c:set var = "TR1" value="yes"/>
                <c:if test="${actionBean.setVisibleAdvanceTable eq TR1}">
                <table width="87%" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <d:table name="orederListFromAdvance" id="order" pagesize="10" class="disp" requestURI="/print">

                                <d:column property="customer_order_no" title="Order Number"/>
                                <d:column property="receipt_no" title="Receipt Number"/>
                                <d:column property="amount_received" title="Advance Amount"/>
                                <d:column title="View">
                                    <div align="center"><strong><s:link beanclass="com.inwise.action.PrintActionBean" event="printAdvanceReceipt">
                                <s:param name="id" value="${order.customer_id}"/>
                                <s:param name="receiptNumber" value="${order.receipt_no}"/>
                                <img src="images/view.gif" alt=""></s:link></strong></div>

                                </d:column>
                            </d:table>
                        </td>

                        <%--<table border="0" cellspacing="0" cellpadding="0" style="border:1px solid #000000;" align="left" id="ordertable" width="77%">
                    <tr>
                        <td width="5%"  style="border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Sr No.</span></strong></div></td>
                        <td width="10%"  style="border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Order No.</span></strong></div></td>
                        <td width="10%"  style="border-right:1px solid #000000; background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Receipt No.</span></strong></div></td>
                        <td width="10%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Advance Amount</span></strong></div></td>
                        <td width="10%"  style=" background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">View</span></strong></div></td>

                       </tr>

                            <%List<Object> temp=(List<Object>)request.getAttribute("orederListFromAdvance");
                                int i=1;
                               Iterator<Object> it=temp.iterator();
                               while(it.hasNext()){
                               Object[] obj=(Object[])it.next();

                                %>

                    <tr>
                            <td width="5%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;" ><%=i%></span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;"><%=obj[0]%></span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;"><%=obj[1]%></span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;"><%=obj[2]%></span></strong></div></td>
                            <td width="10%" style=""><div align="center"><strong><s:link beanclass="com.inwise.action.PrintActionBean" event="printAdvanceReceipt">
                                <s:param name="id" value="<%=obj[3]%>"/>
                                <s:param name="receiptNumber" value="<%=obj[1]%>"/>
                                <img src="images/view.gif" alt=""></s:link></strong></div>

                            </td>
                   </tr>
                            <% i++;}%>

                            </table>--%>

                    </tr>
                </table>

        </c:if>
             <c:if test="${actionBean.visibleInvoiceTable!=null}">


                <table width="77%" cellspacing="1">
                    <tr>
                        <td>
                             <d:table name="invoiceLst" id="invoice" pagesize="10" class="disp" requestURI="/print">

                                <d:column property="invoiceNumber" title="Invoice Number"/>
                                <d:column property="createDate" title="Invoice Date"/>
                                <d:column property="netPayable" title="Invoice Amount"/>
                                <d:column property="dueQuantity" title="Due Amount"/>
                                <d:column title="View">
                                    <div align="center"><strong><s:link beanclass="com.inwise.action.PrintActionBean" event="printInvoiceReceipt">
                                <s:param name="id" value="${invoice.customer.id}"/>
                                <s:param name="customerOrderNo" value="${invoice.order.id}"/>
                                <s:param name="inviceNumber" value="${invoice.invoiceNumber}"/>
                                <img src="images/view.gif" alt=""></s:link></strong></div>

                                </d:column>
                            </d:table>
                        </td>
                        <%--<table border="0"width="77%" cellspacing="0" cellpadding="0" style="border:1px solid #000000;" align="left" id="invoicetable" width="100%">
                    <tr>
                        <td width="5%"  style="border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Sr No.</span></strong></div></td>
                        <td width="10%"  style="border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Invoice No.</span></strong></div></td>
                        <td width="10%"  style="border-right:1px solid #000000; background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Invoice Date</span></strong></div></td>
                        <td width="10%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Invoice Amount</span></strong></div></td>
                        <td width="10%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Due Amount</span></strong></div></td>
                        <td width="10%"  style="background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">View</span></strong></div></td>

                       </tr>

                          <c:forEach items="${actionBean.invoiceList}" var="invoices" varStatus="loop" >

                    <tr>
                            <td width="5%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;" >${loop.index+1}</span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;">${invoices.invoiceNumber}</span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;">${invoices.createDate}</span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;"><fmt:formatNumber type="number" pattern="##.##" value="${invoices.netPayable}"/></span></strong></div></td>
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;"><fmt:formatNumber type="number" pattern="##.##" value="${invoices.dueQuantity}"/></span></strong></div></td>
                            <td width="10%" style=""><div align="center"><strong><s:link beanclass="com.inwise.action.PrintActionBean" event="printInvoiceReceipt">
                                <s:param name="id" value="${invoices.customer.id}"/>
                                <s:param name="customerOrderNo" value="${invoices.order.id}"/>
                                <s:param name="inviceNumber" value="${invoices.invoiceNumber}"/>
                                <img src="images/view.gif" alt=""></s:link></strong></div>

                            </td>
                   </tr>
                     </c:forEach>
                            </table>--%>
                    </tr>
                </table>



            </c:if>

        </s:form>
         <c:set var = "TR1" value="alert"/>
                <c:if test="${actionBean.setVisibleAdvanceTable eq TR1}">
                    <script type="text/javascript">
                         alert("Advance payment has not done for selected customer.");
                    </script>
                                        </c:if>
        </s:layout-component>
</s:layout-render>