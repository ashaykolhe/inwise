<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 11, 2012
  Time: 11:46:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />

    <script  type="text/javascript"></script>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
   <script type="text/javascript">
       $(document).ready(function(){
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

$.post("/Product.action?productAlreadyPresent", {addProductName:$("#addproductname").val().trim()}, function (data) {
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

   </script>
<s:useActionBean beanclass="com.inwise.action.ProductActionBean" var="listofprod" event="addProductLink" ></s:useActionBean>
<%
    request.setAttribute("msrelst",listofprod.getProdmsrelst());
%>
 <s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.ProductActionBean">
   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
 <tr valign="top"><td >&nbsp;
 </td></tr>
 <tr><td align="left" class="pageheading" valign="top">
Add Product
 </td></tr>
 <tr valign="top"><td align="center">&nbsp;
 </td></tr>
 </table>
  <table width="70%"  border="1"  cellspacing="0" cellpadding="0"   align="left" bgcolor="#FCFCFC"  >
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
  <div align="right" style="margin-left: 2px;" class="labels"><s:label name="Product Rate"></s:label><span style="color:#FF0000"> *</span></div></td>
	<td width="21%" align="left" valign="top" ><s:text name="product.productCost" class="textbox" id="addproductcost" ></s:text></td>

		  <td align="left" valign="top" > <s:select name="product.productMeasurementType.id" id="productdropdown" class="dropdown">
                        <option value="">---Select unit---</option>
                <c:forEach items="${msrelst}" var="msre" varStatus="loop" >
				<option value ="<c:out value="${msre.id}"/>"> <c:out value="${msre.measurementType}"/></option>
		      </c:forEach>

                </s:select>
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
	<s:submit name="addProduct" value="Add" id="addProductbutton" ></s:submit>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="reset"  value="Reset" name="reset"  style="width:80px" />
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 <s:submit name="cancel" value="Cancel"></s:submit>
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
</s:layout-component>
 </s:layout-render>
