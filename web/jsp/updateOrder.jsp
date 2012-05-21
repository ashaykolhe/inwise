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
<%--
<script type="text/javascript">

function GetItemDetail(button){

var count=$('#family #tabletr').length;
var rowid=button.name.substring(button.name.indexOf("[")+1,button.name.indexOf("]"));
var flag=true;
var check=$('#itemcode'+rowid+'').val();

for(var i=0;i<=count;i++)
{
if(rowid==i){
continue;
}
var temp=$('#itemcode'+i+'').val();

if(check==temp)
{
flag=false;

//  -- rowid;
//  --i;
alert("This Item has been already added. Please select another item.");
$('#family #tabletr:eq('+rowid+') select:eq(0)').attr("value","0");
$('#family #tabletr:eq('+rowid+') input').removeAttr("value");
return false;
}//end of if
}//end of for
if(flag==true)
{
$.post('PurchaseOrder.action?getItemDetails', {id:button.value}, function (data) {
var result=eval(data);
$('#item'+rowid+'').attr("value",result.itemCode);
$('#uom'+rowid+'').attr("value",result.uom.name);
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
alert('please Enter Numeric value for rate');
rowid;
$('#family #tabletr:eq('+rowid+') input:eq(4)').val("");
$('#family #tabletr:eq('+rowid+') input:eq(5)').val("");
$('#family #tabletr:eq('+rowid+') input:eq(4)').focus();
}//end of chk loop
else if($('#ordqty'+rowid+'').val().trim()!=""){
var ordqty=$('#ordqty'+rowid+'').val();
var valueset=parseFloat(p.value)*parseFloat(ordqty);
$('#amount'+rowid+'').attr("value",valueset);
}//end of else if loop
else{
rowid;
alert("Please enter order quantity");
$('#family #tabletr:eq('+rowid+') input:eq(3)').focus();
}//ennd of else
}//end of p.value!=0 if
else{
rowid;
alert("Please enter valid rate");
$('#family #tabletr:eq('+rowid+') input:eq(4)').val("");
$('#family #tabletr:eq('+rowid+') input:eq(5)').val("");
$('#family #tabletr:eq('+rowid+') input:eq(4)').focus();
}

}//end of function
/*the function calculateBalancechangeorder is use to validate quantity textfiled for numeric as well as blank
this function is called onChange of quantity  textfield  */
function calculateBalancechaneorder(p,i){
var rowid=p.name.substring(p.name.indexOf("[")+1,p.name.indexOf("]"));

if(p.value!=0){
var chk = /^[0-9]+$/.test(p.value);
if (!chk) {

alert('please Enter Numeric value for Order Quantity');
$('#family #tabletr:eq('+rowid+') input:eq(3)').val("");
$('#family #tabletr:eq('+rowid+') input:eq(5)').val("");
$('#family #tabletr:eq('+rowid+') input:eq(3)').focus();
}
else if($('#rate'+rowid+'').val().trim()!=""){
var rate=$('#rate'+rowid+'').val();
var valueset=parseFloat(p.value)*parseFloat(rate);
$('#amount'+rowid+'').attr("value",valueset);
}
}
else{

alert("Please enter valid Quantity");
$('#family #tabletr:eq('+i+') input:eq(3)').val("");
$('#family #tabletr:eq('+i+') input:eq(5)').val("");
$('#family #tabletr:eq('+i+') input:eq(3)').focus();
}
}//end of function

function deletethis(p,a){
var tr=$('#family #tabletr').length;
if(tr==1){
alert("You can not deleted the last row.");
}
else{
var count=$('#family #tabletr').length;
var rowid=p.name.substring(p.name.indexOf("[")+1,p.name.indexOf("]"));
$('#family #tabletr:eq('+rowid+') input').removeAttr("value");
$('#family #tabletr:eq('+rowid+') select:eq(0)').attr("value","0");
}
}
$(document).ready(function(){

$("#updatepopreview").click(function(){
var numeric = /^[0-9]+$/;
var count=$('#family #tabletr').length;
if($('#vendorName').com){
alert("please select Vendor Name");
$('#vendorName').focus();
return false;
}

for(var i=0;i<count;i++){


if($('#family #tabletr:eq('+i+') select:eq(0)').attr("value")!="0"){
if($('#family #tabletr:eq('+i+') input:eq(3)').attr("value").trim()=="" || $('#family #tabletr:eq('+i+') input:eq(3)').attr("value").trim()=="0"){
$('#family #tabletr:eq('+i+') input:eq(5)').val("");
$('#family #tabletr:eq('+i+') input:eq(3)').focus();
alert("please enter ordered valid quantity");
return false;
}
else if($('#family #tabletr:eq('+i+') input:eq(4)').attr("value").trim()=="" || $('#family #tabletr:eq('+i+') input:eq(4)').attr("value").trim()=="0"){
$('#family #tabletr:eq('+i+') input:eq(5)').val("");
$('#family #tabletr:eq('+i+') input:eq(4)').focus();
alert("please enter valid rate");
return false;
}
}
}

/* var rowid=button.name.substring(button.name.indexOf("[")+1,button.name.indexOf("]"));
alert("rowid.val()") ;
if($('#item'+rowid+'').val().trim() !=""&& $('#orderedQty'+rowid+'').val().trim()=="")
{
alert("Fill the ordered quantity");
return false;
}*/

return true;
});
$('#add').click(function(){
var count=$('#family #tabletr').length;
$('#family #tabletr:last').clone(true).insertAfter('#family #tabletr:last');
$('#family #tabletr:last select:eq(0)').attr("value","0");
$('#family #tabletr:last input').removeAttr("value");
$('#family #tabletr:last select:eq(0)').attr("name","purchasedetailarray["+count+"].item.id");
$('#family #tabletr:last select:eq(0)').attr("id","itemcode"+count);
$('#family #tabletr:last input:eq(0)').attr("id","item"+count);
$('#family #tabletr:last input:eq(1)').attr("id","uom"+count);
$('#family #tabletr:last input:eq(2)').attr("name","purchasedetailarray["+count+"].description");
$('#family #tabletr:last input:eq(3)').attr("name","purchasedetailarray["+count+"].orderedQty");
$('#family #tabletr:last input:eq(3)').attr("id","ordqty"+count);
$('#family #tabletr:last input:eq(4)').attr("name","purchasedetailarray["+count+"].rate");
$('#family #tabletr:last input:eq(4)').attr("id","rate"+count);
$('#family #tabletr:last input:eq(5)').attr("name","purchasedetailarray["+count+"].amount");
$('#family #tabletr:last input:eq(5)').attr("id","amount"+count);
$('#family #tabletr:last input:eq(6)').attr("name","delete["+count+"]");
$('#family #tabletr:last input:eq(6)').attr("id","delete"+count);

});
});
</script>
--%>
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
  <table width="50%" border="0"><tr><td width="34%" align="left" valign="top">
   <div align="right" style="margin-left: 1px;" class="labels">Please select Order Number<span style="color:#FF0000"> *</span></div></td>
		  <td width="36%" align="left" valign="top" >
		 <s:select name="id" id="orderdropdown" class="dropdown">
                        <option value="">---Select Order---</option>

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

		  <td width="30%" align="left" valign="top" > <s:submit name="getOrders" id="getOrders" value="Get"/></td>
						</tr></table>        </s:form>
<c:if test="${actionBean.order!=null}">
    <s:form beanclass="com.inwise.action.OrderActionBean">
        <table border="1" width="78%" bgcolor="#FCFCFC" ><tr><td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="16%" align="left" valign="top">
                        <div align="left" style="margin-left: 2px;" class="labels">
                            <div align="right">Name of Customer<span style="color:#FF0000"> *</span></div>
                        </div></td>
                    <td width="21%" align="left" valign="top"><div align="left">
                        <s:select id="customerName" name="order.customer.id" class="dropdown">
                            <option  value="0">---Select Customer---</option>
                            <c:forEach items="${orderBean.customerList}" var="customer" varStatus="loop" >
                                <c:choose>
                                    <c:when test="${orderBean.order.customer.id eq customer.id}">
                                        <option value ="<c:out value="${orderBean.order.customer.id}"/>" selected="selected"> <c:out value="${orderBean.order.customer.name}"/></option>
                                    </c:when>

                                    <c:otherwise>
                                        <option value ="${customer.id}"><c:out value="${customer.name}"/></option>
                                    </c:otherwise>
                                </c:choose>

                            </c:forEach>

                        </s:select>

                    </div></td>
                    <td width="24%" align="left" valign="top">
                        <s:hidden name="order.deleted" value="0"/>
                        <s:hidden name="order.id" value="${order.id}"/>
                        <div align="left" style="margin-left: 2px;" class="labels">
                            <div align="right">Order Date<span style="color:#FF0000"> *</span></div>
                        </div>
                    </td>
                    <td width="30%" align="left" valign="top">
                        <div align="left">
                            <s:text name="order.createDate" id="createDate" value="${orderBean.order.createDate}" readonly="readonly" onFocus="showCalendarControl(this);"  class="textbox"/>
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
                            <s:text name="order.customerOrderNo" id="customerOrderNo" value="${orderBean.order.customerOrderNo}" readonly="readonly" class="textbox" onchange="return checkCustomerOrderNo();"/>
                        </div>
                    </td>
                    <td width="24%" align="left" valign="top">
                        <div align="left" style="margin-left: 2px;" class="labels">
                            <div align="right">Consignee Name<span style="color:#FF0000"> *</span></div>
                        </div>
                    </td>
                    <td width="30%" align="left" valign="top">
                        <div align="left">
                            <s:text name="order.consigneeName" id="consigneeName" value="${orderBean.order.consigneeName}" class="textbox"/>
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
                                    <c:when test="${orderBean.order.orderAddress[0].id eq address.id}">
                                        <option value ="<c:out value="${address.id}"/>" selected="selected"> <c:out value="${address.line1}"/></option>
                                    </c:when>

                                    <c:otherwise>
                                        <option value ="<c:out value="${address.id}"/>" selected="selected"> <c:out value="${address.line1}"/></option>
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
                                    <c:when test="${orderBean.order.orderAddress[1].id eq address.id}">
                                        <option value ="<c:out value="${address.id}"/>" selected="selected"> <c:out value="${address.line1}"/></option>
                                    </c:when>

                                    <c:otherwise>
                                        <option value ="<c:out value="${address.id}"/>" selected="selected"> <c:out value="${address.line1}"/></option>
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
                                    <td width="20%"  style=" border-right:1px solid #000000;background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;">Amount</span></strong></div></td>
                                    <td width="7%"  style=" background:#FFCC66;"><div align="center"><strong><span style="color:#3B3131;font-size:13px;font-weight:bold;"><img src="images/Cfthrow.gif"/></span></strong></div></td>
                            </tr>
                            <c:forEach items="${orderBean.order.orderDetail}" var="orderDetail" varStatus="loop" >
                                <tr id="tabletr">
                                    <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                        <div align="left" style="margin-left:4px;">
                                            <div align="right">
                                                <s:select id="productName${loop.index}" name="orderDetail[${loop.index}].product.id"  onchange= "return GetItemDetail(this);">
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
                                                    <s:text  name="productCost" id="cost${i}" value="${orderDetail.product.productCost}" readonly="readonly" style="text-align:right;margin-right:2px;width:100px; "/>
                                                </div></div></td>
                                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                            <div align="left" style="margin-left:4px;">
                                                <div align="right">
                                                    <s:text name="productMeasurementType" id="productMeasurementType${i}" value="${orderDetail.product.productMeasurementType.measurementType}" readonly="readonly" style="text-align:right;margin-right:2px;width:100px; "/>
                                                </div></div></td>
                                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                            <div align="left" style="margin-left:4px;">
                                                <div align="right">
                                                    <s:text name="order.orderDetail[${i}].orderedQuantity" id="orderedQuantity${i}" value="${orderDetail.orderedQuantity}" onchange="return calculateBalance(this,${i})"  style="text-align:right;margin-right:2px;width:100px; "/>
                                                </div></div></td>
                                        <td style="border-top:1px solid #000000;border-right:1px solid #000000;">
                                            <div align="left" style="margin-left:4px;">
                                                <div align="right">
                                                    <s:text name="amount[${i}]" id="amount${i}" value="${orderDetail.product.productCost * orderDetail.orderedQuantity}" readonly="readonly" style="text-align:right;margin-right:2px;width:100px; "/>
                                                </div></div></td>
                                        <td style="border-top:1px solid #000000;">
                                            <div align="left" style="margin-left:0px;">
                                                <div align="right">
                                                    <s:text name="delete[${i}]"   id="delete${i}" class="delete" style="background:url('images/Cfthrow.gif') no-repeat center;border :none;cursor:auto;"    onclick="return deletethis(this)"/>

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
                        <s:submit name="updateOrder" value="Update" id="update"></s:submit>

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <s:submit name="cancel" value="Cancel"></s:submit>
                    </div></td>
                    <td width="3%" align="left">&nbsp;</td>
                </tr>
            </table></td></tr></table></s:form>   </c:if>

                                 </s:layout-component></s:layout-render>