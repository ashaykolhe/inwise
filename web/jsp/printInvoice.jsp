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
<c:if test="${printBean.popup eq true}">
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
<script type="text/javascript">

    $(window).load(function()
        {
            
            if($('#receiptradio').is(':checked'))
            {
               $('#selectnamediv').show();
            }
            if($('#invoiceradio').is(':checked'))
            {
               $('#selectnamediv').show();
                 $('#selectorderdiv').show();
            }
        });
$(document).ready(function()
{
        $('#invoiceradio').click(function()
        {
            $('#selectnamediv').show();
            $('#selectnamediv1').hide();
            $('#selectcutomername').val(0);
            $('#ordertable').hide();
            $('#msgtable').hide();
            

          });
        $('#receiptradio').click(function()
        {
           $('#selectnamediv').show();
           $('#selectorderdiv').hide();
           $('#selectcutomername').val(0);
           $('#invoicetable').hide();
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
<%  request.setAttribute("invoicelist",listvar.getInvoiceList());
    request.setAttribute("customerNameForAdvance",listvar.getCustNameIdList());
    request.setAttribute("orederListFromAdvance",listvar.getOrderFromAdvance());
 request.setAttribute("cust",listvar.getCust());
%>
<%--<s:useActionBean beanclass="com.inwise.action.PrintActionBean" event="invoiceLst" var="listvar2"></s:useActionBean>
<%
%>--%>

<s:layout-render name="/layout/_base.jsp">
    <s:layout-component name="body">
    <s:form id="formid" beanclass="com.inwise.action.PrintActionBean">


        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
        <tr valign="top"><td >&nbsp;</td>   </tr>
        <tr>
            <td align="left" class="pageheading" valign="top">
            <strong>Print</strong>
            </td>
        </tr>
        <tr valign="top"><td align="center">&nbsp;</td></tr>
        </table>


        <table bordercolor="#FF6600" width="77%" border="1">
        <tr>
            <td width="70%" height="124">
    <table width="100%" cellspacing="1">
                <tr>
                <td width="20%" align="left" valign="top">Search By</td>
                <td width="1%" align="left" valign="top"><s:radio  value="byInvoice" id="invoiceradio"  name="printBy"></s:radio></td>
                <td  align="left" width="20%"  valign="top">Invoice</td>
                <td width="1%" align="left" valign="top"><s:radio value="byReceipt"  id="receiptradio"  name="printBy"></s:radio></td>
                <td align="left"valign="top" width="20%">Receipt</td>
                    <td></td>
                </tr>
           <tr>
                <td width="20%" align="left" valign="top"></td>
         
              <td colspan="5">
                <div id="selectnamediv"align="left" style="margin-left: 2px; display:none;"  class="labels">Please Select Customer <span style="color:#FF0000"> *</span>

                    <s:select id="selectcutomername" name="id"  class="dropdown"  onchange="showorderdropdown();">
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


                  <%--<s:select id="selectcutomername" name="id"  class="dropdown"  onchange="showorderdropdown();">
                        <option  value="0">---Select Customer---</option>
                        <c:forEach items="${actionBean.orderList}" var="orderno" varStatus="loop" >
                        <c:choose>
                        <c:when test="${actionBean.id eq orderno.customer.id}">
			            <option value ="<c:out value="${actionBean.id}"/>" selected="selected"> <c:out value="${actionBean.cust.name}"/></option>
                        </c:when>
                        <c:otherwise>
                        <option value ="${orderno.customer.id}"><c:out value="${orderno.customer.name}"/></option>
                        </c:otherwise>
                        </c:choose>
		                </c:forEach>
                  </s:select>--%>

                 </div>
                </td>
            </tr>
     
      <tr>
          <td width="20%" align="left" valign="top"></td>

          <td colspan="5">
              <c:if test="${actionBean.showdropdown!=null}">
             <div id="selectorderdiv"align="left" style="margin-left: 2px;" class="labels">please Select Order No. <span style="color:#FF0000"> *</span>
                <s:select id="selectorderno" name="customerOrderNo"  class="dropdown">
                    <option  value="0">---Select Order No.---</option>
                        <c:forEach items="${actionBean.orderNoList}" var="orderno" varStatus="loop" >
                        <c:choose>
                        <c:when test="${actionBean.customerOrderNo eq orderno.customerOrderNo}">
			       <option value ="<c:out value="${actionBean.id}"/>" selected="selected"> <c:out value="${orderno.customerOrderNo}"/></option>
                        </c:when>
                        <c:otherwise>
                   <option value ="${orderno.customerOrderNo}"><c:out value="${orderno.customerOrderNo}"/></option>
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
        <c:if test="${actionBean.orderFromAdvance!=null}">
        <table bordercolor="#FF6600" width="77%" id="msgtable">
        <tr>
            <td width="70%" >
                <table width="100%" cellspacing="1">
                    <tr>
                        <s:messages></s:messages>
                    </tr>
                </table>
            </td>
           </tr>
         </table>

       <table bordercolor="#FF6600" width="77%" border="1" id="ordertable">
        <tr>
            <td width="70%" >
                <table width="100%" cellspacing="1">
                    <tr>
                        <table border="0" cellspacing="0" cellpadding="0" style="border:1px solid #000000;" align="left" id="family" width="100%">
                    <tr>
                        <td width="5%"  style="border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Sr No.</span></strong></div></td>
                        <td width="10%"  style="border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Order No.</span></strong></div></td>
                        <td width="10%"  style="border-right:1px solid #000000; background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Receipt No.</span></strong></div></td>
                        <td width="10%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Advance Amount</span></strong></div></td>
                        <td width="10%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">View</span></strong></div></td>

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
                            <td width="10%" style="border-right:1px solid #000000;"><div align="center"><strong><s:link beanclass="com.inwise.action.PrintActionBean" event="printAdvanceReceipt">
                                <s:param name="id" value="<%=obj[3]%>"/>
                                <s:param name="receiptNumber" value="<%=obj[1]%>"/>
                                <img src="images/view.gif" alt=""></s:link></strong></div>
                                
                            </td>
                   </tr>
                            <% i++;}%>
                    
                            </table>

                    </tr>
                </table>
            </td>
        </tr>
       </table>
        </c:if>

       <%-- <table width="100%"  id="ordertable"><tr><td>
             <c:if test="${actionBean.selectedOrderList!=null}">
                    <d:table name="orderlist" pagesize="10" class="disp"  requestURI="/Print.action">
                    <d:column property="id" title="Order Id"/>
                    <d:column property="customerOrderNo" title="Order No"/>
                    </d:table>
            </c:if>
            </td></tr></table>--%>
            <table width="100%"  id="invoicetable"><tr><td>
             <c:if test="${actionBean.invoiceList!=null}">
                    <d:table name="invoicelist" pagesize="10" class="disp"  requestURI="/Print.action">
                    <d:column property="id" title="Invoice Id"/>
                    <d:column property="invoiceNumber" title="Invoice No"/>
                    </d:table>
            </c:if>

        </td></tr></table>
        </s:form>
        
        </s:layout-component>
</s:layout-render>