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
     $("#addTaxButton").click(function(){
                 
         for(rowid=0;rowid<7;rowid++){
              if ($('#taxrate'+rowid+'').val()==""){

                              alert("Tax Percentage should not be null.");
                                 $('#taxrate'+rowid+'').focus();
                              return false;
                          }
         }
         });
    });
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

 <c:forEach items="<%= EnumTax.values() %>" var="taxloop" varStatus="loop" >
 <tr ><td width="36%" align="left" valign="top">
 	  <div align="right" style="margin-left: 2px;" class="labels"> <s:text  name="taxlst[${loop.index}].name" value="${taxloop}" class="labels" readonly="readonly"  style=" border:none; text-align:right;margin-right:2px;width:280px; "/><span style="color:#FF0000"> *</span></div></td>
	<td width="64%" align="left" valign="top" >
        <s:text name="taxlst[${loop.index}].taxPercentage" class="textbox"  id="taxrate${loop.index}"></s:text></td>
	</tr>
            </c:forEach>
           
 <tr>
    <td></td>
    <td>&nbsp;</td>
    
  </tr>

  <tr>
	<td align="left">&nbsp;</td>
	<td align="left" colspan="2"><div align="left">
	<s:submit name="addTax" value="Add" id="addTaxButton"></s:submit>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="reset"  value="Reset" name="reset"  style="width:80px" />
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
