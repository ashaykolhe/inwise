<%--
Created by IntelliJ IDEA.
User: Admin
Date: Feb 21, 2012
Time: 10:56:47 AM
To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />

<s:useActionBean beanclass="com.inwise.action.AdvanceActionBean" var="advanceBean" event="pre"></s:useActionBean>
 <c:if test="${advanceBean.popup eq true}">
   <script type="text/javascript">
  function OpenPopup(){
      alert("1");
  var w = 800;
  var h = 480;
  var winl = (screen.width-w)/2;
  var wint = (screen.height-h)/2;
  if (winl < 0) winl = 0;
  if (wint < 0) wint = 0;
  var page = "advance?advancePopup";
  windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,"
  + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
  window.open(page, "Popup", windowprops);
  return;
   }
  window.onload =OpenPopup();
 </script>
   </c:if >

<s:layout-render name="/layout/_base.jsp">
    <s:layout-component name="body">

        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
            <tr valign="top"><td >&nbsp;
            </td></tr>
            <tr><td align="left" class="pageheading" valign="top">
                Order > Advance
            </td></tr>
            <tr valign="top"><td align="center">&nbsp;
            </td></tr>
        </table>

        <c:choose>
            <c:when test="${advanceBean.redirectAdvance eq true}">
<%-- ------------------------------------------------------------------------------------redirect to advance-------------------------------------------------------------- --%>
                <s:form beanclass="com.inwise.action.AdvanceActionBean">
                    <table width="70%"  border="1"  cellspacing="0" cellpadding="0"   align="left" bgcolor="#FCFCFC" id="itemupdate_table">
                        <tr>
                            <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">


                                    <tr>
                                        <td width="24%" align="right"> <div align="right" style="margin-left: 2px;" class="labels">Amount<span style="color:#FF0000"> *</span></div>     </td>
                                        <td width="26%" align="left" valign="top"><div align="left"><s:text name="advance.amountReceived" id="amountReceived" class="textbox"/>
                                            <s:hidden name="advance.deleted" value="0"/>
                                            <s:hidden name="advance.order.id" value="${advanceBean.id}"/>
                                        </div> </td>
                                        <td width="22%" align="left" valign="top" ></td>




                                    <tr>
                                        <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Date<span style="color:#FF0000"> *</span></div></td>
                                        <td align="left" valign="top"><div align="left"><s:text name="advance.createDate" class="textbox" id="createDate" readonly="readonly" onFocus="showCalendarControl(this);"/></div></td>


                                    <tr>
                                        <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Payment Mode<span style="color:#FF0000"> *</span></div></td>
                                        <td align="left" valign="top" >

                                            <s:select name="advance.paymentMode.id" id="paymentmodedropdown" class="dropdown">
                                                <option value="">---Payment Mode---</option>
                                                <c:forEach items="${advanceBean.paymentModeList}" var="paymentMode" varStatus="loop" >
                                                    <option value ="<c:out value="${paymentMode.id}"/>"> <c:out value="${paymentMode.mode}"/></option>
                                                </c:forEach>
                                            </s:select>
                                            </div></td>
                                        <td align="left" valign="top" >
                                            &nbsp;
                                        </td>

                                        <td width="28%" align="left" valign="top" ></td>

                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td  colspan="2" align="left" ><div ><s:submit name="saveAdvance" value="Pay" id="saveAdvance"></s:submit>&nbsp;&nbsp;&nbsp;&nbsp;
                                            <s:reset name="reset" value="Reset"></s:reset>   &nbsp;&nbsp;&nbsp;&nbsp;
                                            <s:submit name="cancel" value="Cancel"></s:submit></div></td></tr>
                                </table>
                            </td>
                        </tr>

                    </table> </tr>
                    </table>     </s:form>
                
<%-- ------------------------------------------------------------------------------------redirect to advance-------------------------------------------------------------- --%>
            </c:when>
            <c:otherwise>
                
            </c:otherwise>
        </c:choose>


    </s:layout-component></s:layout-render>