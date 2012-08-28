<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 23, 2012
  Time: 3:03:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<script type="text/javascript">
         function checkReceived(p){

              /* if(p.value!=0){
                    var chk = /^[0-9]+$/.test(p.value);
                    if (!chk) {
                    alert('please Enter Numeric value');

                    $('#ReceivedAmount').attr("value","");
                            $('#ReceivedAmount').focus();
                        return false;
                    }//end of chk loop
                    else*/
             if($('#ReceivedAmount').val().trim()!=""){

                        if(parseFloat($('#ReceivedAmount').val())>parseFloat($('#netPayable').val()) ){
                            alert("Received amount cannot be greater than invoice amount.");
                            $('#ReceivedAmount').attr("value","");
                             $('#ReceivedAmount').focus();
                             return false;
                        }
                if((parseFloat($('#ReceivedAmount').val())>parseFloat($('#due').val())) && (parseFloat($('#ReceivedAmount').val())<parseFloat($('#netPayable').val()))){
                            alert("Received amount can not be greater than due amount")
                            $('#ReceivedAmount').attr("value","");
                            $('#ReceivedAmount').focus();
                             return false;
                        }

                 return true;
             }




                //end of p.value!=0 if
         }
 $(document).ready(function(){
                 $("#save").click(function()
                            {

                            var numericReg = /^\d*([0-9])(|.\d*[0-9]|,\d*[0-9])?$/;


                                if ($("#modedropdown").val().trim() ==""){
                                    alert("Select the Payment mode");
                                    //$("#addproductname").focus() ;
                                    return false;
                                }




                               /* else
                                {
                                    if(!characterReg.test($('#additemname').val()))
                                    {
                                       alert("Only  characters allowed.") ;
                                          $("#additemname").val("");
                                        $("#additemname").focus() ;
                                        return false;
                                     }
                                }*/
                               if ($("#ReceivedAmount").val().trim() ==""){
                                    alert("Give the received amount");
                                    $("#ReceivedAmount").focus();
                                    return false;
                                }
                                  else
                                {
                                    if(!numericReg.test($('#ReceivedAmount').val()))
                                    {
                                       alert("Only  numbers allowed.") ;
                                          $("#ReceivedAmount").val("");
                                        $("#ReceivedAmount").focus() ;
                                        return false;
                                     }
                                }
                               if ($("#paymentmode").val().trim() ==""){
                                    alert("Give the cheque or DD number");
                                    $("#paymentmode").focus();
                                    return false;
                                }
                                 if ($("#ReceivedDate").val().trim() ==""){
                                    alert("Give the received Date");
                                    $("#ReceivedDate").focus();
                                    return false;
                                }
                                 if ($("#statusdropdown").val().trim() ==""){
                                    alert("Give the payment status");
                                    //$("#ReceivedDate").focus();
                                    return false;
                                }
                                
                               return true;
                            });
       })    
</script>

<s:useActionBean beanclass="com.inwise.action.PaymentStatusActionBean" var="statusBean" event="getStatus" ></s:useActionBean>
<%
    request.setAttribute("custlst",statusBean.getCustomerlst());
    request.setAttribute("customer",statusBean.getCustomer());
    request.setAttribute("invoice",statusBean.getInvoice());
     request.setAttribute("paymodelst",statusBean.getPaymentmode());
%>
<s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.PaymentStatusActionBean">
   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
 <tr valign="top"><td >&nbsp;
 </td></tr>
 <tr><td align="left" class="pageheading" valign="top">
Payment Status
 </td></tr>
 <tr valign="top"><td align="center">&nbsp;
 </td></tr>
 </table>
 <table border="1" width="65%" bgcolor="#FCFCFC" ><tr><td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="24%" align="left" valign="top">
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Invoice Number</div>
                            </div>
                        </td>
                        <td width="22%" align="left" valign="top"  style="margin-left: 2px;" class="labels">
                            <div align="left">
                            <s:text name="invoice.invoiceNumber" class="textbox" id="invoiceNumber" readonly="true" ></s:text>
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Invoice Date  </div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                               <s:text name="invoice.createDate" class="textbox" id="createDate" readonly="true" ></s:text>
                            </div>
                        </td>
                    </tr>
                        <tr>
                        <td width="24%" align="left" valign="top">
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Customer Name</div>
                            </div>
                        </td>
                        <td width="22%" align="left" valign="top"  style="margin-left: 2px;" class="labels">
                            <div align="left">
                            <s:text name="invoice.customer.name" class="textbox" id="customername" readonly="true"></s:text>
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Invoice Amount  </div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                               <s:text name="invoice.netPayable" class="textbox" id="netPayable" readonly="true" ></s:text>
                            </div>
                        </td>
                    </tr>
                    
                     <tr>
                        <td width="24%" align="left" valign="top">
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Due Amount</div>
                            </div>
                        </td>
                        <td width="22%" align="left" valign="top"  style="margin-left: 2px;" class="labels" >
                            <div align="left">
                            <s:text name="invoice.dueQuantity" class="textbox" id="due" readonly="readonly"    ></s:text>
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Mode of Payment<span style="color:#FF0000"> *</span></div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                              <s:select  name="payment.paymentMode.id" id="modedropdown" class="dropdown">
                        <option value="">---Select mode---</option>

				<c:forEach items="${paymodelst}" var="paymode" varStatus="loop" >


                    <option value ="<c:out value="${paymode.id}"/>"> <c:out value="${paymode.mode}"/></option>

                
              </c:forEach>
                </s:select>
                            </div>
                        </td>
                    </tr>
                     <tr>
                        <td width="24%" align="left" valign="top">
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Received Amount<span style="color:#FF0000"> *</span></div>
                            </div>
                        </td>
                        <td width="22%" align="left" valign="top"  style="margin-left: 2px;" class="labels">
                            <div align="left">
                            <s:text name="payment.receivedAmount" class="textbox" id="ReceivedAmount" onchange="return checkReceived(this)"></s:text>
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Cheque/DD No.  <span style="color:#FF0000"> *</span></div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                               <s:text name="payment.chequeordd" class="textbox" id="paymentmode" ></s:text>
                               
                            </div>
                        </td>
                         <tr>
                        <td width="24%" align="left" valign="top">
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Received Date<span style="color:#FF0000"> *</span></div>
                            </div>
                        </td>
                        <td width="22%" align="left" valign="top"  style="margin-left: 2px;" class="labels">
                            <div align="left">
                            <s:text name="payment.receivedDate" class="textbox" id="ReceivedDate" readonly="readonly" onFocus="showCalendarControl(this);"  ></s:text>
                              
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Status <span style="color:#FF0000"> *</span></div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                                <s:select  name="payment.transactionStatus" id="statusdropdown" class="dropdown">
                        <option value="">---Select Status---</option>

				<option value ="open"> <c:out value="Open"/></option>
                	<option value ="closed"> <c:out value="Closed"/></option>
                 
                </s:select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                     <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr><td><s:hidden name="payment.invoice.invoiceNumber" value="${statusBean.invoice.invoiceNumber}"></s:hidden> </td></tr>
                     <%--<tr><td><s:hidden name="payment.user" value="${user.id}"></s:hidden> </td></tr>--%>
                    <tr><td><%--<s:hidden name="id" value="${statusBean.invoice.id}"></s:hidden> --%></td>
                    </tr>
                    <tr>
                        <td  colspan="4"><div align="center">
	<s:submit name="addPayment" value="Save" id="save" ></s:submit>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 <s:submit name="delete" value="Delete"></s:submit>
	  </div></td>
                    </tr>


              </table></td></tr></table>


</s:form>
</s:layout-component>
</s:layout-render>