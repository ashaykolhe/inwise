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

        $('#orderdropdown').change(function()
        {
            if($('#orderdropdown').attr('value')!=""){
            this.form.action='order?getOrders';
            this.form.submit();
            }
        });

    });

</script>

<script type="text/javascript">
    function GetItemDetail(button){
        var count=$('#family #tabletr').length;
        var rowid=button.name.substring(button.name.indexOf("[")+1,button.name.indexOf("]"));
        
        var flag=true;
        var check=$('#productName'+rowid+'').val();
        for(var i=1;i<=count;i++)
        {
            if(rowid==i){
                continue;
            }
            var temp=$('#productName'+i+'').val();

            if(check==temp)
            {
                flag=false;
                --rowid;
                alert("This Product has been already added. Please select another product.");
                $('#family #tabletr:eq('+rowid+') select:eq(0)').attr("value","");
                $('#family #tabletr:eq('+rowid+') input').removeAttr("value");
                return false;
            }//end of if
        }//end of for
        if(flag==true)
        {
            $.post('order?productDetailsAjax', {id:button.value}, function (data) {
                var result=eval(data);
                $('#cost'+rowid+'').attr("value",result.productCost);
                $('#productMeasurementType'+rowid+'').attr("value",result.productMeasurementType.measurementType);
            });//end of post funtion
        }//end of flag==true if
    } //end of getItem Funntion
    
    function deletethis(p,a){
        var tr=$('#family #tabletr').length;
        if(tr==1){
            alert("You can not deleted the last row.");
        }
        else{
            var count=$('#family #tabletr').length;
            var rowid=p.name.substring(p.name.indexOf("[")+1,p.name.indexOf("]"))-1;
            $('#family #tabletr:eq('+rowid+') input').removeAttr("value");
            $('#family #tabletr:eq('+rowid+') select:eq(0)').attr("value","");
        }
    }
    $(document).ready(function(){

        $('#add').click(function(){
            var count=$('#family #tabletr').length+1;
            $('#family #tabletr:last').clone(true).insertAfter('#family #tabletr:last');
            $('#family #tabletr:last select:eq(0)').attr("value","");
            $('#family #tabletr:last input').removeAttr("value");
            $('#family #tabletr:last select:eq(0)').attr("name","order.orderDetail["+count+"].product.id");
            $('#family #tabletr:last select:eq(0)').attr("id","productName"+count);
            $('#family #tabletr:last input:eq(0)').attr("id","cost"+count);
            $('#family #tabletr:last input:eq(1)').attr("id","productMeasurementType"+count);
            $('#family #tabletr:last input:eq(2)').attr("name","order.orderDetail["+count+"].orderedQuantity");
            $('#family #tabletr:last input:eq(2)').attr("id","ordqty"+count);
            $('#family #tabletr:last input:eq(3)').attr("name","order.orderDetail["+count+"].amendmentQuantity");
            $('#family #tabletr:last input:eq(3)').attr("id","amendmentQuantity"+count);
            $('#family #tabletr:last input:eq(4)').attr("name","order.orderDetail["+count+"].amendmentCost");
            $('#family #tabletr:last input:eq(4)').attr("id","amendmentCost"+count);
            $('#family #tabletr:last input:eq(5)').attr("name","delete["+count+"]");
            $('#family #tabletr:last input:eq(5)').attr("id","delete"+count);
        });
        $("#updateOrder").click(function(){
            var numeric = /^[0-9]+$/;
            var count=$('#family #tabletr').length;
            if($('#customerName').attr("value")=="0"){
                alert("please select Customer Name");
                $('#customerName').focus();
                return false;
            }else if($('#createDate').attr("value").trim()==""){
                $('#createDate').focus();
                alert("please select a date");
                return false;
            }else if($('#customerOrderNo').attr("value").trim()==""){
                $('#customerOrderNo').focus();
                alert("please enter customer order number");
                return false;
            }else if($('#consigneeName').attr("value").trim()==""){
                $('#consigneeName').focus();
                alert("please enter consignee's name");
                return false;
            }else if($('#invoiceAddress').attr("value").trim()=="0"){
                $('#invoiceAddress').focus();
                alert("please select invoice address");
                return false;
            }else if($('#shipmentAddress').attr("value").trim()=="0"){
                $('#shipmentAddress').focus();
                alert("please select shipment address");
                return false;
            }
            for(var i=0;i<count;i++){
                if(i==0){
                    if($('#family #tabletr:eq('+i+') select:eq(0)').attr("value")==""){
                        alert("please select Product Name")
                        return false;
                    }
                }
            }   //end of for
            return true;
        });
    });
</script>


<s:useActionBean beanclass="com.inwise.action.OrderActionBean" var="orderBean" event="pre"></s:useActionBean>
<s:layout-render name="/layout/_base.jsp">
<s:layout-component name="body">

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
    <tr valign="top"><td >&nbsp;
    </td></tr>
    <tr><td align="left" class="pageheading" valign="top">
        Order > Update Order
    </td></tr>
    <tr valign="top"><td align="center">&nbsp;
    </td></tr>
</table>
<s:form beanclass="com.inwise.action.OrderActionBean">
    <table width="50%" border="0">
        <tr> <td width="3%"></td>
            <td width="22%" align="left" valign="top">
                <div align="left" style="margin-left: 2px;" class="labels">
                    Name of Customer<span style="color:#FF0000"> *</span></div>
                </td>
            <td width="21%" align="left" valign="top"><div align="left">
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

            <td width="30%" align="left" valign="top" >

            </td>
        </tr></table>
    <table width="50%" border="0"><tr><td width="3%"></td><td width="22%" align="left" valign="top">
        <div align="left" style="margin-left: 1px;" class="labels">Customer Order Number<span style="color:#FF0000"> *</span></div></td>
        <td width="21%" align="left" valign="top" >
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

        <td width="30%" align="left" valign="top" ></td>
    </tr></table>        </s:form>

<c:if test="${orderBean.order!=null}">
    <s:form beanclass="com.inwise.action.OrderActionBean">
        <table border="1" width="78%" bgcolor="#FCFCFC" ><tr><td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="24%" align="left" valign="top">
                        <s:hidden name="order.deleted" value="0"/>
                        <s:hidden name="order.id" value="${orderBean.order.id}"/>
                        <s:hidden name="order.customer.id" value="${orderBean.order.customer.id}"/>

                        <div align="left" style="margin-left: 2px;" class="labels">
                            <div align="right">Order Date<span style="color:#FF0000"> *</span></div>
                        </div>
                    </td>
                    <td width="30%" align="left" valign="top">
                        <div align="left">
                            <s:text name="order.createDate" id="createDate" readonly="readonly" onFocus="showCalendarControl(this);"  class="textbox"/>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td width="24%" align="left" valign="top">
                        <div align="left" style="margin-left: 2px;" class="labels">
                            <div align="right">Customer Order No.<span style="color:#FF0000"> *</span></div>
                        </div>
                    </td>
                    <td width="22%" align="left" valign="top">
                        <div align="left">
                            <s:text name="order.customerOrderNo" id="customerOrderNo" readonly="readonly" class="textbox" onchange="return checkCustomerOrderNo();"/>
                        </div>
                    </td>
                    <td width="24%" align="left" valign="top">
                        <div align="left" style="margin-left: 2px;" class="labels">
                            <div align="right">Consignee Name<span style="color:#FF0000"> *</span></div>
                        </div>
                    </td>
                    <td width="30%" align="left" valign="top">
                        <div align="left">
                            <s:text name="order.consigneeName" id="consigneeName" class="textbox"/>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td width="24%" align="left" valign="top">
                        <div align="left" style="margin-left: 2px;" class="labels">
                            <div align="right">Invoice Address<span style="color:#FF0000"> *</span></div>
                        </div>
                    </td>
                    <td width="22%" align="left" valign="top">
                        <div align="left">
                            <s:hidden name="order.orderAddress[0].addressType.id" value="1"/>
                            <s:select id="invoiceAddress" name="order.orderAddress[0].address.id" class="dropdown">
                                <option  value="0">---Select Address---</option>
                                <c:forEach items="${orderBean.addressList}" var="address" varStatus="loop" >
                                    <c:choose>
                                        <c:when test="${orderBean.order.orderAddress[0].address.id eq address.id}">
                                            <option value ="<c:out value="${address.id}"/>" selected="selected"> <c:out value="${address.line1}"/></option>
                                        </c:when>

                                        <c:otherwise>
                                            <option value ="<c:out value="${address.id}"/>"> <c:out value="${address.line1}"/></option>
                                        </c:otherwise>
                                    </c:choose>

                                </c:forEach>
                            </s:select>
                        </div>      <%--+', '+address.line2+', 'address.city+'-'+address.zip+', 'address.state+', '+address.country--%>
                    </td>
                    <td width="24%" align="left" valign="top">
                        <div align="left" style="margin-left: 2px;" class="labels">
                            <div align="right">Shipment Address<span style="color:#FF0000"> *</span></div>
                        </div>
                    </td>
                    <td width="30%" align="left" valign="top">
                        <div align="left">
                            <s:hidden name="order.orderAddress[1].addressType.id" value="2"/>
                            <s:select id="shipmentAddress" name="order.orderAddress[1].address.id" class="dropdown">
                                <option  value="0">---Select Address---</option>
                                <c:forEach items="${orderBean.addressList}" var="address" varStatus="loop" >
                                    <c:choose>
                                        <c:when test="${orderBean.order.orderAddress[1].address.id eq address.id}">
                                            <option value ="<c:out value="${address.id}"/>" selected="selected"> <c:out value="${address.line1}"/></option>
                                        </c:when>

                                        <c:otherwise>
                                            <option value ="<c:out value="${address.id}"/>"> <c:out value="${address.line1}"/></option>
                                        </c:otherwise>
                                    </c:choose>

                                </c:forEach>
                            </s:select>
                        </div>
                    </td>


                </tr>
                <tr>
                    <td colspan="4"><br><div align="left" style="margin-left:10px;">
                        <table width="95%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #000000;" align="left" id="family">
                            <tr>
                                <td width="17%" height="28px" style="border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Product</span></strong></div></td>
                                <td width="21%"  style="border-right:1px solid #000000; background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Cost</span></strong></div></td>
                                <td width="18%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">UOM</span></strong></div></td>
                                <td width="17%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Quantity</span></strong></div></td>
                                <td width="20%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Amendment Quantity</span></strong></div></td>
                                <td width="20%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Amendment Cost</span></strong></div></td>
                                <td width="7%"  style=" background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;"><img src="images/Cfthrow.gif"/></span></strong></div></td>
                            </tr>
                            <c:forEach items="${orderBean.order.orderDetail}" var="orderDetail" varStatus="loop" >
                                <tr id="tabletr">
                                    <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                        <div align="left" style="margin-left:4px;">
                                            <s:hidden name="order.orderDetail[${loop.index}].id" id="orderDetailId${loop.index}"/>
                                            <div align="right">
                                                <s:select id="productName${loop.index}" name="order.orderDetail[${loop.index}].product.id"  onchange= "return GetItemDetail(this);">
                                                    <option  value="">---Select Product---</option>
                                                    <c:forEach items="${orderBean.productList}" var="product" >
                                                        <c:choose>
                                                            <c:when test="${orderDetail.product.id eq product.id}">
                                                                <option value ="<c:out value="${orderDetail.product.id}"/>" selected="selected"> <c:out value="${orderDetail.product.productName}"/></option>
                                                            </c:when>

                                                            <c:otherwise>
                                                                <option value ="${product.id}"><c:out value="${product.productName}"/></option>
                                                            </c:otherwise>
                                                        </c:choose>


                                                    </c:forEach>

                                                </s:select>
                                                    <%--               <c:set var="newIndex" value="${loop.index + 1}" scope="page"/>--%>
                                            </div></div></td>
                                    <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                        <div align="left" style="margin-left:4px;">
                                            <div align="right">
                                                <s:text  name="productCost" id="cost${loop.index}" value="${orderDetail.product.productCost}" readonly="readonly" style="text-align:right;margin-right:2px;width:100px; "/>
                                            </div></div></td>
                                    <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                        <div align="left" style="margin-left:4px;">
                                            <div align="right">
                                                <s:text name="productMeasurementType" id="productMeasurementType${loop.index}" value="${orderDetail.product.productMeasurementType.measurementType}" readonly="readonly" style="text-align:right;margin-right:2px;width:100px; "/>
                                            </div></div></td>
                                    <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                        <div align="left" style="margin-left:4px;">
                                            <div align="right">
                                                <s:text name="order.orderDetail[${loop.index}].orderedQuantity" id="orderedQuantity${loop.index}" readonly="readonly" style="text-align:right;margin-right:2px;width:100px; "/>
                                            </div></div></td>
                                    <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                        <div align="left" style="margin-left:4px;">
                                            <div align="right">
                                                <s:text name="order.orderDetail[${loop.index}].amendmentQuantity" id="amendmentQuantity${loop.index}" style="text-align:right;margin-right:2px;width:100px; "/>
                                            </div></div></td>
                                    <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                        <div align="left" style="margin-left:4px;">
                                            <div align="right">
                                                <s:text name="order.orderDetail[${loop.index}].amendmentCost" id="amendmentCost${loop.index}" style="text-align:right;margin-right:2px;width:100px; "/>
                                            </div></div></td>
                                    <td style="border-top:1px solid #000000;">
                                        <div align="left" style="margin-left:0px;">
                                            <div align="right">
                                                <s:text name="delete[${loop.index}]" id="delete${loop.index}" class="delete" style="background:url('images/Cfthrow.gif') no-repeat center;border :none;cursor:auto;"    onclick="return deletethis(this)"/>

                                            </div></div></td>

                                </tr>             </c:forEach>
                        </table>
                        <tr><td colspan="4">
                            <div style="text-align:right; cursor: pointer;" class="links"><span style="vertical-align: top;text-align: left;font-size:medium; " class="addRow" id="add" >Add row</span></div>
                        </td></tr>
                    </div></td>
                </tr>
                <tr>
                    <td align="left">&nbsp;</td>
                    <td align="left" colspan="3">&nbsp;</td>
                    <td align="left">&nbsp;</td>
                </tr>
                <tr>
                    <td align="left">&nbsp;</td>
                    <td align="left" colspan="3"><div align="left" style="margin-left:20px"> &nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;
                        <s:submit name="updateOrder" value="Update" id="updateOrder"/>

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <s:submit name="cancel" value="Cancel"/>
                    </div></td>
                    <td width="3%" align="left">&nbsp;</td>
                </tr>
            </table></td></tr></table></s:form>   </c:if>

</s:layout-component></s:layout-render>