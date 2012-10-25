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
  

 <s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.TaxActionBean">
    <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Update Tax</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>


      <table class="second_table"  >


 <%--<tr >    <td width="21%" align="left" valign="top">
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
	</tr>--%>
          <tr ><td width="12%" align="left" valign="top">
     <div align="left" style="margin-left: 2px;" class="labels">Tax Name<span style="color:#FF0000"> *</span></div>   </td>

	<td width="84%" align="left" valign="top" >
       <div align="left" style="margin-left: 2px;" >
           <s:text  name="tax.name"  class="textbox" readonly="readonly"  /></div></td>
	</tr>


 <tr>
    <td align="left"><div align="left" style="margin-left: 2px;" class="labels">Tax Rate<span style="color:#FF0000"> *</span></div>   </td>

	<td  align="left" valign="top" >
       <div align="left" style="margin-left: 2px;" >
     <s:text name="tax.taxPercentage" class="textbox"  id="taxrate"></s:text></div></td>
      <s:hidden name="tax.id" id="idvalue"></s:hidden>
  </tr>


 <tr>
    <td></td>
    <td>&nbsp;</td>

  </tr>

  <tr  >
	<td>&nbsp;</td>
	<td align="left"><div align="left" >   &nbsp;&nbsp;
	<s:submit name="updateTax" value="Update" class="buttons" id="updateTaxButton"></s:submit>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


	 <s:submit name="cancel" value="Cancel" class="buttons"></s:submit>
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
