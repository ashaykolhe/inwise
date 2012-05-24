<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 23, 2012
  Time: 3:03:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />

<s:useActionBean beanclass="com.inwise.action.PaymentStatusActionBean" var="statusBean" event="getStatus" ></s:useActionBean>
<%
    request.setAttribute("custlst",statusBean.getCustomerlst());
    request.setAttribute("customer",statusBean.getCustomer());
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
                            <s:text name="invoice.invoiceNumber" class="textbox" id="invoiceNumber" ></s:text>   
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Invoice Date  </div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                               <s:text name="invoice.createDate" class="textbox" id="createDate" ></s:text>
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
                            <s:text name="customer.name" class="textbox" id="invoiceNumber" ></s:text>
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Invoice Amount  </div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                               <s:text name="invoice" class="textbox" id="createDate" ></s:text>
                            </div>
                        </td>
                    </tr>
                    
                     <tr>
                        <td width="24%" align="left" valign="top">
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Due Amount</div>
                            </div>
                        </td>
                        <td width="22%" align="left" valign="top"  style="margin-left: 2px;" class="labels">
                            <div align="left">
                            <s:text name="invoice" class="textbox" id="due" ></s:text>
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Mode of Payment</div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                              <s:select  name="mode" id="modedropdown" class="dropdown">
                        <option value="">---Select mode---</option>

				<option value ="1"> <c:out value="Cheque"/></option>
                	<option value ="2"> <c:out value="DD"/></option>
                 <option value ="3"> <c:out value="EFT"/></option>
                </s:select>
                            </div>
                        </td>
                    </tr>
                     <tr>
                        <td width="24%" align="left" valign="top">
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Received Amount</div>
                            </div>
                        </td>
                        <td width="22%" align="left" valign="top"  style="margin-left: 2px;" class="labels">
                            <div align="left">
                            <s:text name="customer.name" class="textbox" id="customername" ></s:text>
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Cheque/DD No.  </div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                               <s:text name="chequedd" class="textbox" id="invoiceamount" ></s:text>
                            </div>
                        </td>
                         <tr>
                        <td width="24%" align="left" valign="top">
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Received Date</div>
                            </div>
                        </td>
                        <td width="22%" align="left" valign="top"  style="margin-left: 2px;" class="labels">
                            <div align="left">
                            <s:text name="customer.name" class="textbox" id="customername" ></s:text>
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Status </div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                                <s:select  name="status" id="statusdropdown" class="dropdown">
                        <option value="">---Select Status---</option>

				<option value ="1"> <c:out value="Open"/></option>
                	<option value ="2"> <c:out value="Closed"/></option>
                 
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
                    <tr>
                        <td  colspan="4"><div align="center">
	<s:submit name="savepaystatus" value="Save" id="save" ></s:submit>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 <s:submit name="delete" value="Delete"></s:submit>
	  </div></td>
                    </tr>


              </table></td></tr></table>


</s:form>
</s:layout-component>
</s:layout-render>