<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 11, 2012
  Time: 3:41:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />

    <script  type="text/javascript"></script>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
   <script type="text/javascript">
       $(document).ready(function(){
                 $("#updateProductbutton").click(function()
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
           $("#getproductbutton").click(function(){

                       if ($("#productdropdown1").val()=="0"){
                                       alert("Select the product name");

                                       return false;
                                   }
                  });

       })
       function checkProduct() {

$.post("product?productAlreadyPresent", {addProductName:$("#addproductname").val().trim()}, function (data) {
                                         var flag=eval(data);
                                        var updatename=$('#addproductname').val().trim().toString();
                                    var dropdownname=$("#productdropdown1 option:selected").text().trim().toString();

                                        if(updatename == dropdownname)
                                        {
                                          return true;
                                        }
                                         else if(flag)
                                         {
                                            alert("Product already exist !");
                                             $("#addproductname").val("");
                                             $("#addproductname").focus();
                                              return false;
                                         }
                          });

}

   </script>
<s:useActionBean beanclass="com.inwise.action.ProductActionBean" var="productBean" event="updateProductLink" ></s:useActionBean>
<%
    request.setAttribute("msrelst",productBean.getProdmsrelst());
    request.setAttribute("prodlst",productBean.getProdlst());
%>
<s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="body">

   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
 <tr valign="top"><td >&nbsp;
 </td></tr>
 <tr><td align="left" class="pageheading" valign="top">
Update Product
 </td></tr>
 <tr valign="top"><td align="center">&nbsp;
 </td></tr>
 </table>
 <s:form beanclass="com.inwise.action.ProductActionBean">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">

 	<tr ><td width="14%" align="left" valign="top">
 	  <div align="right" style="margin-left: 2px;" class="labels">Please select Product Name<span style="color:#FF0000"> *</span></div></td>
		  <td width="21%" align="left" valign="top" >
		 <s:select name="id" id="productdropdown1" class="dropdown">
                        <option value="0">---Select Product---</option>

              <c:forEach items="${prodlst}" var="prodloop" varStatus="loop" >
               <c:choose>
                 <c:when test="${productBean.product.productName eq prodloop.productName}">
			            <option value ="<c:out value="${productBean.product.id}"/>" selected="selected"> <c:out value="${productBean.product.productName}"/></option>
                  </c:when>
                <c:otherwise> 
                 <option value ="<c:out value="${prodloop.id}"/>"> <c:out value="${prodloop.productName }"/></option>
                </c:otherwise></c:choose>
		      </c:forEach> </s:select>
     </td>

		  <td width="34%" align="left" valign="top" > <s:submit name="getProductButton" id="getproductbutton"  value="Get"/> </td>
						</tr></table>
             </s:form>
          <s:useActionBean beanclass="com.inwise.action.ProductActionBean" var="productBean" event="getProductButton" ></s:useActionBean>
<%
    request.setAttribute("msrelst",productBean.getProdmsrelst());

%>
             <c:if test="${productBean.product ne null}">
             <s:form beanclass="com.inwise.action.ProductActionBean">
              <table width="70%"  border="1"  cellspacing="0" cellpadding="0"   align="left" bgcolor="#FCFCFC"  >
  <tr>
    <td align="left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">

 	<tr ><td width="14%" align="left" valign="top">
 	  <div align="right" style="margin-left: 2px;" class="labels"><s:label name="Product Name"></s:label><span style="color:#FF0000"> *</span></div></td>
	<td width="21%" align="left" valign="top" ><s:text name="product.productName" class="textbox" id="addproductname" onchange="return checkProduct()"></s:text></td>
	<td width="34%" align="left" valign="top" >
    <s:hidden name="product.deleted" value="0"/>
    <s:hidden name="product.id" value="${productBean.id}"/>
    </td>

	</tr>
  <tr><td align="left" valign="top">
  <div align="right" style="margin-left: 2px;" class="labels"><s:label name="Product Rate"></s:label><span style="color:#FF0000"> *</span></div></td>
	<td width="21%" align="left" valign="top" ><s:text name="product.productCost" class="textbox" id="addproductcost" ></s:text></td>

		  <td align="left" valign="top" > <s:select name="product.productMeasurementType.id" id="productdropdown" class="dropdown">
                 <c:forEach items="${msrelst}" var="msre" varStatus="loop" >
             <c:choose>
                 <c:when test="${msre.id eq productBean.product.productMeasurementType.id}">
              <option value="<c:out value="${msre.id}"/>" selected="selected"><c:out value="${msre.measurementType}"/></option>
                </c:when>
                <c:otherwise>

                    <option value ="<c:out value="${msre.id}"/>"> <c:out value="${msre.measurementType}"/></option>

                  </c:otherwise></c:choose>
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
	<s:submit name="updateProduct" value="Update" id="updateProductbutton" ></s:submit>
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
 </s:form>    </c:if>
 </s:layout-component>
 </s:layout-render>
