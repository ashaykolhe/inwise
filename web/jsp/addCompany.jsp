<%@ include file="/includes/_taglibInclude.jsp" %>
    <link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<%--<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>--%>
<%--
  Created by IntelliJ IDEA.
  User: Atul
  Date: Jul 3, 2012
  Time: 3:09:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function(){

         var phoneval = /^([0-9]{0,10})$/;
         var emailval =  /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
        $("#addcompanybutton").click(function(){
            if ($("#addcompanyname").val().trim() =="")
            {
                alert("Please enter the company name.");
                $("#addcompanyname").focus() ;
                return false;
            }
            if ($("#addaddress").val().trim() =="")
            {
                alert("Please enter the company address name.");
                $("#addaddress").focus() ;
                return false;
            }
            if ($("#addcity").val().trim() =="")
            {
                alert("Please enter the city.");
                $("#addcity").focus() ;
                return false;
            }
            if ($("#addstate").val().trim() =="")
            {
                alert("Please enter the state.");
                $("#addstate").focus() ;
                return false;
            }
            if ($("#addcountry").val().trim() =="")
            {
                alert("Please enter the country.");
                $("#addcountry").focus() ;
                return false;
            }
            if ($("#addpin").val().trim() =="")
            {
                alert("Please enter the pin.");
                $("#addpin").focus() ;
                return false;
            }
            if ($("#addphone").val().trim() ==""){
                alert("please enter vendor phone number.");
                $("#addphone").focus() ;
                return false;
                }
                else
                if(!phoneval.test($('#addphone').val()))
                {
                alert("please give the phone number in number format and upto 10 digits only");
                $("#addphone").val("") ;
                $("#addphone").focus() ;

                return false;
                }

                if(!emailval.test($('#addemail').val()) )
                {
                  alert("please give the email address like abc@xyz.com");
                      $("#addemail").val("");
                   $("#addemail").focus() ;
                   return false;
                }

        });
        
    })     ;
</script>
    <s:layout-render name="/layout/_base.jsp">
          <s:layout-component name="left-menu">

                 <ul>
                     <li>&nbsp;</li>
                      <li class="left_menu_heading">Setting</li>
                      <li style="margin-top:35px">  <li> <s:link beanclass="com.inwise.action.CompanyActionBean" event="pre">Setup</s:link></li>
                      <li ><s:link beanclass="com.inwise.action.UserActionBean" event="addUserLink">User</s:link></li>
                                 <li><s:link beanclass="com.inwise.action.TermActionBean" event="termsPageRedirect">Terms & Condition</s:link></li>
                                <li><s:link beanclass="com.inwise.action.UserActionBean" event="changePasswordLink">Change Password</s:link></li>
                                   <li><s:link beanclass="com.inwise.action.RestoreActionBean" event="restoreCustomerLink">Restore</s:link> </li>
                  </ul>

         </s:layout-component>
    <s:layout-component name="body">
    <s:form beanclass="com.inwise.action.CompanyActionBean">
      <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Company Information</div>
    </td></tr>
  <%--  <tr valign="top"><td align="center">&nbsp;
    <div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
    <table class="second_table"  >
    <tr>
    <td align="left">
    <table width="100%" border="0" cellspacing="0" >

    <tr>
    <td width="20%" align="right"> <div align="left" style="margin-left: 2px;" class="labels">Company Name<span style="color:#FF0000"> *</span></div>     </td>
    <td width="17%" align="left" valign="top"><div align="left"><s:text name="companyInfo.compName" id="addcompanyname" class="textbox"/></div> </td>
    <td width="19%" align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Logo<span style="color:#FF0000"> *</span></div> </td>

    <td width="17%" align="left" valign="bottom"><div align="left" ><s:file name="logo"></s:file>
    <s:hidden name="vendor.deleted" value="0"/>
    </div></td>
    <td width="13%" align="left" valign="bottom">&nbsp;</td>
    <td width="13%" align="left" valign="bottom">&nbsp;</td>
    </tr>
        <tr>
          <td align="left" colspan="6"><b style="border-bottom:solid 2px">CONTACT DETAILS</b></td>
         
        </tr>
        <tr>
          <td  align="right"> <div align="left" style="margin-left: 2px;" class="labels">Address<span style="color:#FF0000"> *</span></div>     </td>
          <td  align="left" valign="top"><div align="left"><s:text name="companyInfo.address[0].line1" id="addaddress" class="textbox"/></div> </td>
          <td  align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">City<span style="color:#FF0000"> *</span></div></td>
          
          <td  align="left" valign="bottom"><div align="left" ><s:text id="addcity"  name="companyInfo.address[0].city" class="textbox"/>
            
            </div></td>
          <td align="right" valign="bottom"><div align="left" style="margin-left: 2px;" class="labels">State<span style="color:#FF0000"> *</span></div></td>
          <td  align="left" valign="bottom"><div align="left"><s:text name="companyInfo.address[0].state" id="addstate" class="textbox"/></div></td>
        </tr>
        <tr>
    <td  align="right"> <div align="left" style="margin-left: 2px;" class="labels">Country<span style="color:#FF0000"> *</span></div>     </td>
    <td  align="left" valign="top"><div align="left"><s:text id="addcountry"  name="companyInfo.address[0].country" class="textbox"/></div> </td>
    <td  align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Pincode<span style="color:#FF0000"> *</span></div></td>

    <td  align="left" valign="bottom"><div align="left" ><s:text name="companyInfo.address[0].zip" id="addpin" class="textbox"/>

    </div></td>
    <td  align="left" valign="bottom"><div align="let" style="margin-left: 2px;" class="labels">Phone</div></td>
    <td  align="left" valign="bottom"><div align="left" ><s:text id="addphone"  name="companyInfo.compPhone" class="textbox"/>

    </div></td>
        </tr>
       
        <tr>
    <td  align="right"> <div align="left" style="margin-left: 2px;" class="labels">Email</div>     </td>
    <td  align="left" valign="top"><div align="left"><s:text name="companyInfo.compEmail" id="addemail" class="textbox"/></div> </td>
    <td  align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Fax</div></td>

    <td  align="left" valign="bottom"><div align="left" ><s:text id="addfax"  name="companyInfo.compFax" class="textbox"/>

    </div></td>
    <td  align="left" valign="bottom"><div align="left" style="margin-left: 2px;" class="labels">Website</div></td>
    <td  align="left" valign="bottom"><div align="left"><s:text name="companyInfo.compWebsite" id="addwebsite" class="textbox"/></div></td>
        </tr>
     
    <tr>
          <td align="left" colspan="6"><b style="border-bottom:solid 2px">WORKS DETAILS</b></td>
         
        </tr>
<tr>
          <td  align="right"> <div align="left" style="margin-left: 2px;" class="labels">Address</div>     </td>
          <td  align="left" valign="top"><div align="left"><s:text name="companyInfo.address[1].line1" id="addaddress" class="textbox"/></div> </td>
          <td  align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">City</div></td>
          
          <td  align="left" valign="bottom"><div align="left" ><s:text id="addcity"  name="companyInfo.address[1].city" class="textbox"/>
            
            </div></td>
          <td align="right" valign="bottom"><div align="left" style="margin-left: 2px;" class="labels">State</div></td>
          <td  align="left" valign="bottom"><div align="left"><s:text name="companyInfo.address[1].state" id="addstate" class="textbox"/></div></td>
        </tr>
        <tr>
    <td  align="right"> <div align="left" style="margin-left: 2px;" class="labels">Country</div>     </td>
    <td  align="left" valign="top"><div align="left"><s:text id="addcountry"  name="companyInfo.address[1].country" class="textbox"/></div> </td>
    <td  align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Pincode</div></td>

    <td  align="left" valign="bottom"><div align="left" ><s:text name="companyInfo.address[1].zip" id="addpin" class="textbox"/>

    </div></td>
    <td  align="left" valign="bottom"><div align="let" style="margin-left: 2px;" class="labels">Phone</div></td>
    <td  align="left" valign="bottom"><div align="left" ><s:text id="addphone"  name="companyInfo.workPhone" class="textbox"/>

    </div></td>
        </tr>
       
        <tr>
    <td  align="right"> <div align="left" style="margin-left: 2px;" class="labels">Email</div>     </td>
    <td  align="left" valign="top"><div align="left"><s:text name="companyInfo.workEmail" id="addemail" class="textbox"/></div> </td>
    <td  align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Fax</div></td>

    <td  align="left" valign="bottom"><div align="left" ><s:text id="addfax"  name="companyInfo.workFax" class="textbox"/>

    </div></td>
    <td  align="left" valign="bottom"><div align="left" style="margin-left: 2px;" class="labels">Website</div></td>
    <td  align="left" valign="bottom"><div align="left"><s:text name="companyInfo.workWebsite" id="addwebsite" class="textbox"/></div></td>
        </tr>
       
        <tr>
          <td align="LEFT" colspan="6"><b style="border-bottom:solid 2px">TAX DETAILS</b></td>
         
        </tr>
        <tr>
    <td  align="right"> <div align="left" style="margin-left: 2px;" class="labels">TIN Number</div>     </td>
    <td  align="left" valign="top"><div align="left"><s:text name="companyInfo.compTin" id="addtin" class="textbox"/></div> </td>
    <td  align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">PAN Number</div></td>

    <td  align="left" valign="bottom"><div align="left" ><s:text id="addpan"  name="companyInfo.compPan" class="textbox"/>

    </div></td>
    <td  align="left" valign="bottom"><div align="left" style="margin-left: 2px;" class="labels">Excise</div> </td>
    <td  align="left" valign="bottom"><div align="left"><s:text name="companyInfo.compExcise" id="addexcise" class="textbox"/></div> </td>
        </tr>
        <tr>
    <td  align="right"><div align="left" style="margin-left: 2px;" class="labels">ECC No</div>     </td>
    <td  align="left" valign="top"><div align="left" ><s:text id="addecc"  name="companyInfo.compEcc" class="textbox"/>

    </div></td>
    <td  align="left" valign="top"><div align="left" style="margin-left: 2px;text-align:left" class="labels" >Sales Tax Regn No</div></td>

    <td  align="left" valign="bottom"><div align="left"><s:text name="companyInfo.salesTax" id="addlicense" class="textbox"/></div></td>
    <td  align="left" valign="bottom"><div align="left" style="margin-left: 2px;" class="labels">CST Regn No</div></td>
    <td  align="left" valign="bottom"><div align="left" ><s:text id="addecc"  name="companyInfo.cstNo" class="textbox"/>

    </div></td>
        </tr>
       
        <tr>
    <td  align="right" > <div align="left" style="margin-left: 0px;text-align:left;" class="labels">Service Tax Regn No</div>     </td>
    <td  align="left" valign="top"><div align="left"><s:text name="companyInfo.serviceTax" id="addlicense" class="textbox"/></div> </td>
     <td  align="right" valign="top" colspan="4"></td>
    </tr>
    <tr>
    <td  align="right"> <div align="left" style="margin-left: 2px;" class="labels">Range Address</div>     </td>
    <td  align="left" valign="top"><div align="left"><s:text name="companyInfo.rangeAddress" id="addlicense" class="textbox"/></div> </td>
     <td  align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Division Address</div></td>

    <td  align="left" valign="bottom"><div align="left" ><s:text id="addecc"  name="companyInfo.divisionAddress" class="textbox"/>

    </div></td>
    <td  align="right"> <div align="left" style="margin-left: 2px;" class="labels">Commissionerate</div>     </td>
    <td  align="left" valign="top"><div align="left"><s:text name="companyInfo.commissionerate" id="addlicense" class="textbox"/></div> </td>
    </tr>
     
<tr><td colspan="3">&nbsp;</td></tr>
        <tr>
    <td >&nbsp;</td>
    <td colspan="2" align="right" valign="top"><div align="left"><s:submit id="addcompanybutton" class="buttons" name="addCompany" value="Add"/>&nbsp;&nbsp;&nbsp;&nbsp;
    <s:reset name="reset" value="Reset" class="buttons"/>   &nbsp;&nbsp;&nbsp;&nbsp;
    <s:submit name="cancel" value="Cancel" class="buttons"/></div></td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>

        </tr>
        
      </table> </td> </tr>
        </table>
        </s:form>
        </s:layout-component>
        </s:layout-render>