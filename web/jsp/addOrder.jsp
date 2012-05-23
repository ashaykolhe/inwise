<%--
Created by IntelliJ IDEA.
User: Milind
Date: Feb 29, 2012
Time: 5:26:54 PM
To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<s:useActionBean beanclass="com.inwise.action.OrderActionBean" var="orderBean" event="pre"></s:useActionBean>
<%
    //    request.setAttribute("vendorlst",orderBean.getVendorlst());
//    request.setAttribute("itemidlst",orderBean.getItemidlst());

%>
<script type="text/javascript">

    $(document).ready(function(){
        $('#customerName').change(function(){

            $.get("order?addressAjax",{id:$(this).attr("value")}, function (result) {
                var data=eval(result);
                var options = '<option value="0">---Select Address---</option>';
                for (var i = 0; i < data.length; i++) {
                    options += '<option value="' + data[i].id + '">' + data[i].line1+","+ data[i].line2+","+ data[i].city+"-"+data[i].zip +'</option>';
                }
                $("#invoiceAddress").html(options);
                $("#shipmentAddress").html(options);


            });
        });
    });

</script>

<script type="text/javascript">
    function checkCustomerOrderNo() {
        if($('#customerName').attr('value').trim()=="0"){
            alert("please select customer");
            $("#customerOrderNo").attr("value","");
            $('#customerName').focus();
            return false;
        }
        $.get('order?customerOrderNoAlreadyPresent', {id:$("#customerOrderNo").val().trim()}, function (data) {
            var flag=eval(data);
            if(flag)
            {
                alert("this customer order number has already been used");
                $("#customerOrderNo").val("");
                $("#customerOrderNo").focus();
                return false;
            }
            return true;
        });

    }

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
                $('#family #tabletr:eq('+rowid+') select:eq(0)').attr("value","0");
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
    /*the function calculateBalance is use to validate rate textfiled for numeric as well as blank
     this function is called onChange of rate textfield  */
    function calculateBalance(p,i){

        var rowid=p.name.substring(p.name.indexOf("[")+1,p.name.indexOf("]"));

        if(p.value!=0){
            var chk = /^[0-9]+$/.test(p.value);
            if (!chk) {
                alert('please Enter Numeric value for quantity');
                --rowid;
                $('#family #tabletr:eq('+rowid+') input:eq(2)').val("");
                $('#family #tabletr:eq('+rowid+') input:eq(3)').val("");
                $('#family #tabletr:eq('+rowid+') input:eq(2)').focus();
            }//end of chk loop
            else if($('#orderedQuantity'+rowid+'').val().trim()!=""){
                var ordqty=$('#orderedQuantity'+rowid+'').val();
                var valueset=parseFloat(p.value)*parseFloat(ordqty);
                $('#amount'+rowid+'').attr("value",valueset);
            }//end of else if loop
            else{
                --rowid;
                alert("Please enter quantity");
                $('#family #tabletr:eq('+rowid+') input:eq(2)').focus();
            }//ennd of else
        }//end of p.value!=0 if
        else{
            --rowid;
            alert("Please enter valid quantity");
            $('#family #tabletr:eq('+rowid+') input:eq(2)').val("");
            $('#family #tabletr:eq('+rowid+') input:eq(3)').val("");
            $('#family #tabletr:eq('+rowid+') input:eq(2)').focus();
        }

    }//end of function

    function deletethis(p,a){
        var tr=$('#family #tabletr').length;
        if(tr==1){
            alert("You can not deleted the last row.");
        }
        else{
            var count=$('#family #tabletr').length;
            var rowid=p.name.substring(p.name.indexOf("[")+1,p.name.indexOf("]"))-1;
            $('#family #tabletr:eq('+rowid+') input').removeAttr("value");
            $('#family #tabletr:eq('+rowid+') select:eq(0)').attr("value","0");
        }
    }
    $(document).ready(function(){

        $('#add').click(function(){
            var count=$('#family #tabletr').length+1;
            $('#family #tabletr:last').clone(true).insertAfter('#family #tabletr:last');
            $('#family #tabletr:last select:eq(0)').attr("value","0");
            $('#family #tabletr:last input').removeAttr("value");
            $('#family #tabletr:last select:eq(0)').attr("name","order.orderDetail["+count+"].product.id");
            $('#family #tabletr:last select:eq(0)').attr("id","itemcode"+count);
            $('#family #tabletr:last input:eq(0)').attr("id","cost"+count);
            $('#family #tabletr:last input:eq(1)').attr("id","productMeasurementType"+count);
            $('#family #tabletr:last input:eq(2)').attr("name","order.orderDetail["+count+"].orderedQuantity");
            $('#family #tabletr:last input:eq(2)').attr("id","ordqty"+count);
            $('#family #tabletr:last input:eq(3)').attr("id","amount"+count);
            $('#family #tabletr:last input:eq(4)').attr("name","delete["+count+"]");
            $('#family #tabletr:last input:eq(4)').attr("id","delete"+count);
        });
        $("#addOrder").click(function(){
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
                    else if($('#family #tabletr:eq('+i+') input:eq(2)').attr("value").trim()=="" || $('#family #tabletr:eq('+i+') input:eq(2)').attr("value").trim()=="0"){
                        $('#family #tabletr:eq('+i+') input:eq(2)').focus();
                        $('#family #tabletr:eq('+i+') input:eq(2)').attr("value","");
                        alert("please enter valid order quantity");
                        return false;
                    }
                }
            }   //end of for
            return true;
        });
    });
</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<s:layout-render name="/layout/_base.jsp">
    <s:layout-component name="body">
        <s:form beanclass="com.inwise.action.OrderActionBean">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
                <tr valign="top">
                    <td >&nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="left" class="pageheading" valign="top">
                        Order > Add Order
                    </td>
                </tr>
                <tr valign="top"><td align="center">&nbsp;
                </td>
                </tr>
            </table>
            <table border="1" width="65%" bgcolor="#FCFCFC" ><tr><td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="24%" align="left" valign="top">
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Name of Customer<span style="color:#FF0000"> *</span></div>
                            </div>
                        </td>
                        <td width="22%" align="left" valign="top">
                            <div align="left">
                                <s:select id="customerName" name="order.customer.id" class="dropdown">
                                    <option  value="0">---Select Customer---</option>
                                    <c:forEach items="${orderBean.customerList}" var="customer" varStatus="loop" >
                                        <option value ="${customer.id}"><c:out value="${customer.name}"/></option>
                                    </c:forEach>
                                </s:select>
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top"><s:hidden name="order.deleted" value="0"/>
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
                                <s:text name="order.customerOrderNo" id="customerOrderNo" class="textbox" onchange="return checkCustomerOrderNo();"/>
                            </div>
                        </td>
                        <td width="24%" align="left" valign="top">
                            <div align="left" style="margin-left: 2px;" class="labels">
                                <div align="right">Consignee Name<span style="color:#FF0000"> *</span></div>
                            </div>
                        </td>
                        <td width="30%" align="left" valign="top">
                            <div align="left">
                                <s:text name="order.consigneeName" id="consigneeName"  class="textbox"/>
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
                                </s:select>
                            </div>
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
                                </s:select>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4"><br><div align="left" style="margin-left:10px;">

                            <table width="90%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #000000;" align="left" id="family">
                                <tr>
                                    <td width="17%" height="28px" style="border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;" >Product</span></strong></div></td>
                                    <td width="21%"  style="border-right:1px solid #000000; background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Cost</span></strong></div></td>
                                    <td width="18%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">UOM</span></strong></div></td>
                                    <td width="17%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Quantity</span></strong></div></td>
                                    <td width="20%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Amount</span></strong></div></td>
                                    <td width="7%"  style=" background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;"><img src="images/Cfthrow.gif"/></span></strong></div></td>
                                </tr>
                                <c:forEach var="i" begin="1" end="4" step="1" varStatus ="status" >
                                    <tr id="tabletr">
                                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                            <div align="left" style="margin-left:4px;">
                                                <div align="right">
                                                    <s:select id="productName${i}" name="order.orderDetail[${i}].product.id"  onchange= "return GetItemDetail(this);">
                                                        <option  value="">---Select Product---</option>
                                                        <c:forEach items="${orderBean.productList}" var="product" varStatus="loop" >
                                                            <option value ="<c:out value='${product.id}'/>"><c:out value="${product.productName}"/></option>
                                                        </c:forEach>
                                                    </s:select>
                                                </div></div></td>

                                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                            <div align="left" style="margin-left:4px;">
                                                <div align="right">
                                                    <s:text  name="productCost" id="cost${i}" readonly="readonly" style="text-align:right;margin-right:2px;width:100px; "/>
                                                </div></div></td>
                                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                            <div align="left" style="margin-left:4px;">
                                                <div align="right">
                                                    <s:text name="productMeasurementType" id="productMeasurementType${i}" readonly="readonly" style="text-align:right;margin-right:2px;width:100px; "/>
                                                </div></div></td>
                                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                            <div align="left" style="margin-left:4px;">
                                                <div align="right">
                                                    <s:text name="order.orderDetail[${i}].orderedQuantity" id="orderedQuantity${i}" onchange="return calculateBalance(this,${i})"  style="text-align:right;margin-right:2px;width:100px; "/>
                                                </div></div></td>
                                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                            <div align="left" style="margin-left:4px;">
                                                <div align="right">
                                                    <s:text name="amount[${i}]" id="amount${i}" readonly="readonly" style="text-align:right;margin-right:2px;width:100px; "/>
                                                </div></div></td>
                                        <td style="border-top:1px solid #000000;">
                                            <div align="left" style="margin-left:0px;">
                                                <div align="right">
                                                    <s:text name="delete[${i}]"   id="delete${i}" class="delete" style="background:url('images/Cfthrow.gif') no-repeat center;border :none;cursor:auto;"    onclick="return deletethis(this)"/>

                                                </div></div></td>

                                    </tr>
                                </c:forEach>
                            </table>
                            <tr><td colspan="4">
                                <div style="text-align:right; cursor: pointer;" class="links"><span style="vertical-align: top;text-align: left;font-size:medium; " class="addRow" id="add" >Add row</span></div>
                            </td></tr>
                        </div></td>
                    </tr>
                    <tr>
                        <td align="left">&nbsp;</td>
                        <td align="left" colspan="2">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left">&nbsp;</td>
                        <td align="left" colspan="2"><div align="left" style="margin-left:20px"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <s:submit name="addOrder" value="Submit" id="addOrder"></s:submit>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="reset"  value="Reset" name="reset"  style="width:80px" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <s:submit name="cancel" value="Cancel"></s:submit>
                        </div></td>
                        <td width="30%" align="left">&nbsp;</td>
                    </tr>

                </table></td></tr></table>
        </s:form>
    </s:layout-component>
</s:layout-render>
