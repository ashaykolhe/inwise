<%@ page import="com.inwise.enums.EnumTax" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 11, 2012
  Time: 11:46:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />

    <script src="js/popup.js" type="text/javascript"></script>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <script type="text/javascript">

    $(document).ready(function(){
     $("#updateTaxButton").click(function(){


              if ($('#taxValueId').val()==""){

                              alert("Please enter Tax Percentage");
                                 $('#taxValueId').focus();
                              return false;
                          }
         else
                  if ($('#taxValueId').val()=="0"){

                   alert("Please enter Tax Percentage greater than zero.");
                                 $('#taxValueId').focus();
                              return false;

              }

         });
    });
</script>
<s:useActionBean beanclass="com.inwise.action.TaxActionBean" var="listoftax" event="addTaxLink"></s:useActionBean>
<% request.setAttribute("taxlst", listoftax.getTaxlst());
%>
   <script type="text/javascript">
       function checktax(){

           $.post("tax?getTaxById", {id:$('#taxdropdown').val()}, function (result) {

                var taxvalue=eval(result);


             $('#taxper').show();
                 $('#displaybtn').show();
          $('#taxValueId').val(taxvalue.taxPercentage)  ;
             $('#idvalue').val(taxvalue.id)  ;
                $('#namevalue').val(taxvalue.name)  ;


           });
       }
   </script>

 <s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.TaxActionBean">
   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
 <tr valign="top"><td >&nbsp;
 </td></tr>
 <tr><td align="left" class="pageheading" valign="top">
Add Tax
 </td></tr>
 <tr valign="top"><td align="center">&nbsp;
 </td></tr>
 </table>
  <table width="70%"  border="1"  cellspacing="0" cellpadding="0"   align="left" bgcolor="#FCFCFC"  >
  <tr>
    <td align="left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">


 <tr >    <td width="21%" align="left" valign="top">
   <div align="right" style="margin-left: 1px;" class="labels">Please Select Tax<span style="color:#FF0000"> *</span></div></td>
     <td width="79%" align="left" valign="top">
 	  <s:select name="id" id="taxdropdown" class="dropdown" onchange="return checktax()">

                        <option value="">---Select Tax---</option>
            <c:forEach items="${taxlst}" var="taxloop" varStatus="loop" >
                   <c:choose>
                  <c:when test="${actionBean.tax.id eq taxloop.id}">
			            <option value ="<c:out value="${actionBean.tax.id}"/>" selected="selected"> <c:out value="${actionBean.tax.name}"/></option>
                  </c:when>

                  <c:otherwise>
              <option value ="<c:out value="${taxloop.id}"/>"> <c:out value="${taxloop.name}"/></option>
                </c:otherwise>
                  </c:choose>

		      </c:forEach>

                </s:select></td>
	</tr>
<tr style="display:none" id="taxper"><td>
     <div align="right" style="margin-left: 1px;" class="labels">Tax Percentage<span style="color:#FF0000"> *</span></div></td>
    <td  align="left" valign="top" ><s:text name="tax.taxPercentage" class="textbox" id="taxValueId"></s:text>
    <s:hidden name="tax.id" id="idvalue"></s:hidden>          <s:hidden name="tax.name" id="namevalue"></s:hidden>
    </td>
</tr>

 <tr>
    <td></td>
    <td>&nbsp;</td>

  </tr>

  <tr  style="display:none" id="displaybtn">
	<td>&nbsp;</td>
	<td align="left"><div align="left" >   &nbsp;&nbsp;
	<s:submit name="updateTax" value="Update" id="updateTaxButton"></s:submit>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	  
	 <s:submit name="cancel" value="Cancel"></s:submit>
	  </div></td>

	</tr>
 <tr>
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
