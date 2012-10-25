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


              if ($('#taxrate').val()==""){

                              alert("Tax Percentage should not be null.");
                                 $('#taxrate').focus();
                              return false;
                          }
         
         });
    });
</script>
 <s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="left-menu">

                 <ul>
                          <li>&nbsp;</li>
                      <li class="left_menu_heading">Tax</li>
                     <li style="margin-top:35px">
                               <li ><s:link beanclass="com.inwise.action.TaxActionBean" event="addTaxLink">Add</s:link></li>

                               <li><s:link beanclass="com.inwise.action.TaxActionBean" event="viewTaxLink">View</s:link></li>
                  </ul>

         </s:layout-component>
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.TaxActionBean">
     <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Add Tax</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
     <table class="second_table"  >
  <tr>       <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">


 <tr ><td width="12%" align="left" valign="top">
     <div align="left" style="margin-left: 2px;" class="labels">Tax Name<span style="color:#FF0000"> *</span></div>   </td>

	<td width="84%" align="left" valign="top" >
       <div align="left" style="margin-left: 2px;" >
           <s:text  name="tax.name"  class="textbox"   /></div></td>
	</tr>


 <tr>
    <td align="left"><div align="left" style="margin-left: 2px;" class="labels">Tax Rate<span style="color:#FF0000"> *</span></div>   </td>

	<td  align="left" valign="top" >
       <div align="left" style="margin-left: 2px;" >
     <s:text name="tax.taxPercentage" class="textbox"  id="taxrate"></s:text></div></td>

  </tr>

  <tr>
	<td align="left">&nbsp;</td>
	<td align="left" ><div align="left">
	<s:submit name="addTax" value="Add" id="addTaxButton" class="buttons"></s:submit>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="reset"  value="Reset" name="reset" class="buttons" style="width:80px" />
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
