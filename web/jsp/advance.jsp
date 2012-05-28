<%--
Created by IntelliJ IDEA.
User: Admin
Date: Feb 21, 2012
Time: 10:56:47 AM
To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<s:useActionBean beanclass="com.inwise.action.AdvanceActionBean" var="advanceBean" event="pre"/>
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
    $(document).ready(function(){
        $('#paymentmodedropdown').change(function(){

            if($('#paymentmodedropdown').attr("value")=="1"){

                $('.hid').css({
                    display:"inline"
                });
                $('#ddOrCheque').html("DD <span style=\"color:#FF0000\">*</span>");
            }else if($('#paymentmodedropdown').attr("value")=="2"){

                $('.hid').css({
                    display:"inline"
                });
                $('#ddOrCheque').html("Cheque <span style=\"color:#FF0000\">*</span>");
            }else{
                $('.hid').css({
                    display:"none"
                });
                $('#ddOrCheque').html("");
            }
        });

        $('#saveAdvance').click(function(){
            if($('#amountReceived').attr("value").trim()==""){
                alert("enter amount");
                $('#amountReceived').focus();
                return false;
            }
            if($('#createDate').attr("value").trim()==""){
                alert("enter date");
                $('#createDate').focus();
                return false;
            }
            if($('#paymentmodedropdown').attr("value").trim()==""){
                alert("select payment mode");
                $('#paymentmodedropdown').focus();
                return false;
            }
            if($('#ddOrCheque').attr("value").trim()==""){
                alert("select DD/Cheque No");
                $('#ddOrCheque').focus();
                return false;
            }

        });

    });
</script>

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
                    <table width="50%"  border="1"  cellspacing="0" cellpadding="0"   align="left" bgcolor="#FCFCFC" id="itemupdate_table">
                        <tr>
                            <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">


                                    <tr>
                                        <td width="20%" align="right"> <div align="right" style="margin-left: 2px;" class="labels">Amount<span style="color:#FF0000"> *</span></div>     </td>
                                        <td width="30%" align="left" valign="top"><div align="left"><s:text name="advance.amountReceived" id="amountReceived" class="textbox"/>
                                            <s:hidden name="advance.deleted" value="0"/>
                                            <s:hidden name="advance.order.id" value="${advanceBean.id}"/>
                                        </div> </td>
                                        <td width="2%" align="left" valign="top" ></td>

                                        <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Date<span style="color:#FF0000"> *</span></div></td>
                                        <td align="left" valign="top"><div align="left"><s:text name="advance.createDate" class="textbox" id="createDate" readonly="readonly" onFocus="showCalendarControl(this);"/></div></td>



                                    <tr>
                                        <td align="right" valign="top">
                                            <div align="right" style="margin-left: 2px;" class="labels">Payment Mode<span style="color:#FF0000"> *</span>
                                            </div>
                                        </td>
                                        <td align="left" valign="top" >
                                            <div>
                                                <s:select name="advance.paymentMode.id" id="paymentmodedropdown" class="dropdown">
                                                    <option value="">---Payment Mode---</option>
                                                    <c:forEach items="${advanceBean.paymentModeList}" var="paymentMode" varStatus="loop" >
                                                        <option value ="<c:out value="${paymentMode.id}"/>"> <c:out value="${paymentMode.mode}"/></option>
                                                    </c:forEach>
                                                </s:select>
                                            </div>
                                        </td>
                                        <td width="2%" align="left" valign="top" ></td>
                                        <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels" id="ddOrCheque"></div></td>
                                        <td align="left" valign="top" ><div align="left" ><s:text name="advance.chequeOrDDNo" class="textbox hid" id="chequeOrDDNo" style="display:none;"/></div></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td  colspan="2" align="left" >
                                            <div>
                                                <s:submit name="saveAdvance" value="Pay" id="saveAdvance"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                                <s:reset name="reset" value="Reset"/>   &nbsp;&nbsp;&nbsp;&nbsp;
                                                <s:submit name="cancel" value="Cancel"/>
                                            </div>
                                        </td>
                                        <td width="14%" align="left" valign="top" ></td>
                                        <td width="28%" align="left" valign="top" ></td>

                                    </tr>
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