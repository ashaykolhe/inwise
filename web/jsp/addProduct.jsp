<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 11, 2012
  Time: 11:46:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
 
<script src="js/popup.js" type="text/javascript"/>



 <script type="text/javascript">



 </script>
   <script type="text/javascript">
    var unitname;
       function submitForm(button,update) {

         var form = button.form;
         var resolution=button.name;
         var params = $(form).serializeArray();
         if ($("#unittxt").val().trim() ==""){
         alert("Please enter unit");
         $("#unittxt").focus() ;
         return false;
         }
         else{

         $.post("unit?checkUnitAlreadyPresent", {addUnitName:$("#unittxt").val().trim()}, function (data) {
         var flag=eval(data);

         var updatename=$('#unittxt').val().trim().toString();


         if(updatename == unitname)
         {
         params.push({name: '_eventName' , value: button.name});
         $.post("unit?resolution", params, function (data) {
         $( update ).html(data);
         $(update).show();
         $('#unittxt').val("");
         $('#saveunitbtn').show();
         $('#updateunitbtn').hide();
             unitname=null;
         });
         return true;
         }
         else if(flag)
         {
         alert("Unit Already Exist !");
         $("#unittxt").val("");
         $("#unittxt").focus();
         }
         else
         {
         params.push({name: '_eventName' , value: button.name});
         $.post("unit?resolution", params, function (data) {
         $( update ).html(data);
         $(update).show();
         $('#unittxt').val("");
         $('#saveunitbtn').show();
         $('#updateunitbtn').hide();
         });
         }

         });


         }
         return false;
         }
          function ajaxLink(link, update) {

    if (confirm("Are you sure, you want to delete selected record."))
    {

    $.post(link, function (data) {
    $(update).html(data);
    $(update).show();
    });

    }
    return false;
    }
       $(document).ready(function(){
           $("#unitbutton").click(function(){
        
    //centering with css

    centerPopup();
    //load popup

    loadPopup();
    });
         $("#popupContactClose").click(function(){
    disablePopup();
    $.get("unit?paginationUnit", function (result) {
    var data=eval(result);
    var options = '<option value="">---Select Unit---</option>';
    for (var i = 0; i < data.length; i++) {
    options += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
    }
    $("#productdropdown").html(options);


    });
    $("#unittxt").val("");
    $("#unithdnid").val("");
    $('#saveunitbtn').show();
    $('#updateunitbtn').hide();
    });
            $("#closePopUpUnit").click(function(){

           disablePopup();
    $.get("unit?paginationUnit", function (result) {
    var data=eval(result);
    var options = '<option value="">---Select Unit---</option>';
    for (var i = 0; i < data.length; i++) {
    options += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
    }
    $("#productdropdown").html(options);


    });
    $("#unittxt").val("");
    $("#unithdnid").val("");
    $('#saveunitbtn').show();
    $('#updateunitbtn').hide();
          });


    //Press Escape event!
    $(document).keypress(function(e){
    if(e.keyCode==27 && popupStatus==1){
    disablePopup();
    }
    });








                 $("#addProductbutton").click(function()
                            {

                            var numericReg = /^\d*[0-9](|.\d*[0-9]|,\d*[0-9])?$/;


                                if ($("#addproductname").val().trim() ==""){
                                    alert("please enter Product name.");
                                    $("#addproductname").focus() ;
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
                               if ($("#addproductcost").val().trim() ==""){
                                    alert("please give the rate of product");
                                    $("#addproductcost").focus();
                                    return false;
                                }
                                  else
                                {
                                    if(!numericReg.test($('#addproductcost').val()))
                                    {
                                       alert("Only  numbers allowed.") ;
                                          $("#addproductcost").val("");
                                        $("#addproductcost").focus() ;
                                        return false;
                                     }
                                }
                               if ($("#productdropdown").val().trim() ==""){
                                    alert("please select the unit of product");
                                    $("#productdropdown").focus();
                                    return false;
                                }

                                return true;
                            });
       })
       function checkProduct() {

$.post("product?productAlreadyPresent", {addProductName:$("#addproductname").val().trim()}, function (data) {
                                         var flag=eval(data);
                                         if(flag)
                                         {
                                            alert("Product already exist !");
                                             $("#addproductname").val("");
                                             $("#addproductname").focus();
                                              return false;
                                         }
                          });

}


       function updateLink(link) {

    $ .get(link, function (data) {

    var result=eval(data);

    $('#unittxt').attr("value",result.name);
    $('#unithdnid').attr("value",result.id);
    unitname=$('#unittxt').val().trim().toString();
    $('#saveunitbtn').hide();
    $('#updateunitbtn').show();
    });
    return false;
    }
   </script>
<s:useActionBean beanclass="com.inwise.action.ProductActionBean" var="listofprod" event="addProductLink" ></s:useActionBean>
<%
    request.setAttribute("msrelst",listofprod.getUnitlst());
%>
 <s:layout-render name="/layout/_base.jsp">
         <s:layout-component name="left-menu">

                 <ul>
                          <li>&nbsp;</li>
                      <li class="left_menu_heading">Product</li>
                     <li style="margin-top:35px">
                             <li><s:link beanclass="com.inwise.action.ProductActionBean" event="addProductLink">Add</s:link></li>
                       <li><s:link beanclass="com.inwise.action.ProductActionBean" event="viewProductLink">View</s:link></li>
                           <%--  <li><s:link beanclass="com.inwise.action.ProductActionBean" event="updateProductLink">Update</s:link></li>
                                        <li><s:link beanclass="com.inwise.action.ProductActionBean" event="deleteProductLink">Delete</s:link></li>--%>
                  </ul>

         </s:layout-component>
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.ProductActionBean">
      <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Add Product</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
     <table class="second_table"  >
  <tr>
    <td align="left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">

 	<tr ><td width="14%" align="left" valign="top">
 	  <div align="right" style="margin-left: 2px;" class="labels"><s:label name="Product Name"></s:label><span style="color:#FF0000"> *</span></div></td>
	<td width="21%" align="left" valign="top" ><s:text name="product.productName" class="textbox" id="addproductname" onchange="return checkProduct()"></s:text></td>
	<td width="34%" align="left" valign="top" >
    <s:hidden name="product.deleted" value="0"/>
    </td>

	</tr>
  <tr><td align="left" valign="top">
  <div align="right" style="margin-left: 2px;" class="labels"><s:label name="Basic Rate"></s:label><span style="color:#FF0000"> *</span></div></td>
	<td width="21%" align="left" valign="top" ><s:text name="product.productCost" class="textbox" id="addproductcost" ></s:text></td>

		  <td align="left" valign="top" > <s:select name="product.unit.id" id="productdropdown" class="dropdown">
<option value="">---Select unit---</option>
<c:forEach items="${actionBean.unitlst}" var="unit" varStatus="loop" >
<c:choose>
<c:when test="${actionBean.product.unit.id eq unit.id}">
<option value ="<c:out value="${actionBean.product.unit.id}"/>" selected="selected"> <c:out value="${actionBean.product.unit.name}"/></option>
</c:when>

<c:otherwise>
<option value ="<c:out value="${unit.id}"/>"> <c:out value="${unit.name}"/></option>
</c:otherwise>
</c:choose>

</c:forEach></s:select>

                   <s:button name="add" style="margin-left: 2px;" class="links" id="unitbutton" value="Add/Update Unit"></s:button>
            </td>
						</tr>
 <tr>
    <td></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
	<td align="left">&nbsp;</td>
	<td align="left" colspan="3"><div align="left">
	<s:submit name="addProduct" value="Add" class="buttons" id="addProductbutton" ></s:submit>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="reset"  value="Reset" name="reset" class="buttons" style="width:80px" />
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 <s:submit name="cancel" value="Cancel" class="buttons"></s:submit>
	  </div></td>
	<td width="3%" align="left">&nbsp;</td>
	</tr>
 <tr>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
  </tr>
</table>
</td>
      </tr>

</table>
           </s:form>
           <div id="popupContact" >
    <a id="popupContactClose">x</a>

    <h1>Add Unit</h1>
    <p id="contactArea">
    <s:form beanclass="com.inwise.action.UnitActionBean" id="saveunit" >
    <table width="100%" border="0" style="vertical-align:top;"><tr><td>
    <s:label name="Unit Name"></s:label><span style="color:#FF0000"> *</span></td>
    <td width="27%" align="left" valign="top" ><s:text name="unit.name"  id="unittxt" class="textbox"></s:text>
    <s:hidden name="unit.deleted" value="0"/>
    </td>

    <td id="saveunitbtn"><s:hidden name="unit.id" id="unithdnid"></s:hidden>
    <s:submit name="addunit"  value="Save" onclick= "return submitForm(this,'#unit_table');"/>

    </td>
    <td id="updateunitbtn" style="display:none;">
    <s:submit name="update"  value="Update"  onclick= "return submitForm(this,'#unit_table');"/>
    </td>
    </tr>
    <tr><td colspan="4" >

    <div  id="unit_table">
    <%@include file="/jsp/displaytag/unit.jsp"%>
    </div>

    </td></tr>
          <tr><td colspan="4" align="right"><div align="right"><s:button name="Done" id="closePopUpUnit" value="Done"></s:button></div>
          </td></tr>
    </table>
    </s:form>
    </p>
    </div>
          <div id="backgroundPopup"></div>
</s:layout-component>
 </s:layout-render>
