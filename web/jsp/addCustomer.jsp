<%--
Created by IntelliJ IDEA.
User: Atul
Date: Feb 17, 2012
Time: 4:28:07 PM
To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />

<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">

    $(document).ready(function(){
    var phoneval = /^([0-9]{0,10})$/;

     var emailval =  /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
     $("#addcustomerbutton").click(function()
     {
        if ($("#addcustomername").val().trim() =="")
        {
            alert("please enter customer name.");
             $("#addcustomername").focus() ;
            return false;
        }


        if ($("#addressline11").val().trim() =="")
          {
                              alert("please enter line 1 of address");
                              $("#addressline11").focus() ;
                              return false;
                          }

       if ($("#addressline12").val().trim() =="")
       {
                              alert("please enter line 2 of address");
                              $("#addressline12").focus() ;
                              return false;
                          }
          if ($("#addresscity1").val().trim() =="")
          {
                              alert("please enter city");
                              $("#addresscity1").focus() ;
                              return false;
                          }
          if ($("#addressstate1").val().trim() =="")
          {
                              alert("please enter state");
                              $("#addressstate1").focus() ;
                              return false;
                          }
          if ($("#addresscountry1").val().trim() =="")
          {
                              alert("please enter country");
                              $("#addresscountry1").focus() ;
                              return false;
          }
         if ($("#addresszip1").val().trim() =="")
          {
                              alert("please enter zip code");
                            $("#addresszip1").focus() ;
                              return false;
          }
          else if ($("#addresszip1").val().trim() !=""&&!phoneval.test($('#addresszip1').val()))
          {
                              alert("please enter the zip in numeric only");
                              $("#addresszip1").focus() ;
                              $("#addresszip1").val("") ;
                              return false;
          }
            else if ($("#addresszip2").val().trim() !=""&&!phoneval.test($('#addresszip2').val()))
          {
                              alert("please enter the zip in numeric only for address 2");
                              $("#addresszip2").focus() ;
                              $("#addresszip2").val("") ;
                              return false;
          }

       if ($("#addcustomerphnno1").val().trim() !="")
       {

            if(!phoneval.test($('#addcustomerphnno1').val()) || $('#addcustomerphnno1').val().trim().length !=10)
             {


                    alert("please give the phone 1 number in number format and upto 10 digits only");
                    $("#addcustomerphnno1").val("") ;
                    $("#addcustomerphnno1").focus() ;

                    return false;
            }
     }
     if ($("#addcustomerphnno2").val().trim() !="")
      {

            if(!phoneval.test($('#addcustomerphnno2').val())||$('#addcustomerphnno2').val().length!=10)
            {


                alert("please give the phone 2 number in number format and upto 10 digits only");
                $("#addcustomerphnno2").val("") ;
                $("#addcustomerphnno2").focus() ;

                return false;
            }
          }
             if ($("#addcustomermailid").val().trim() !=""&&!emailval.test($('#addcustomermailid').val()))
            {
                                 alert("please give the email address like abc@xyz.com");
                                 $("#addcustomermailid").val("");
                                 $("#addcustomermailid").focus() ;
                                 return false;

             }





     });
     });


</script>

<s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="left-menu">

                 <ul>
                          <li>&nbsp;</li>
                      <li class="left_menu_heading">Customers</li>
                     <li style="margin-top:35px">
                               <li ><s:link beanclass="com.inwise.action.CustomerActionBean" event="pageDirect">Add</s:link></li>
                             <%--   <li><s:link beanclass="com.inwise.action.CustomerActionBean" event="updateCustomerLink">Update</s:link></li>
                                <li><s:link beanclass="com.inwise.action.CustomerActionBean" event="deleteLink">Delete</s:link></li>--%>
                               <li><s:link beanclass="com.inwise.action.CustomerActionBean" event="viewLink">View</s:link></li>
                  </ul>

         </s:layout-component>
    <s:layout-component name="body">
        <s:form beanclass="com.inwise.action.CustomerActionBean">
            <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Add Customer</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
     <table class="second_table"  ><tr><td>
            <table width="100%" border="0" cellspacing="0" bordercolor="#FCFCFC">
            <tr>
                <td width="18%" align="right"> <div align="left" style="margin-left: 2px;" class="labels">Customer Name<span style="color:#FF0000"> *</span></div>     </td>
                <td width="22%" align="left" valign="top"><div align="left"><s:text name="customer.name" id="addcustomername" class="textbox"></s:text></div> </td>
                <td width="18%" align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Department<span style="color:#FF0000"> </span></div></td>

                <td width="40%" align="left" valign="bottom"><div align="left" ><s:text id="addcustomerdepartment"  name="customer.department" class="textbox"></s:text>
                    <s:hidden name="customer.deleted" value="0"/>
                </div></td>



            <tr>
                <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Contact Person<span style="color:#FF0000"> </span></div></td>
                <td align="left" valign="top"><div align="left"><s:text name="customer.contactPerson" id="addcustomercp" class="textbox"></s:text></div></td>

            </tr>
            <tr>
            <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Address 1<span style="color:#FF0000"> </span></div></td>
            <td align="left" valign="top"><div align="left">
                <table width="100%">
                    <tr>
                        <td> <table width="70%" cellspacing="0" cellpadding="0">
                            <tr>

                                <td>Line 1</td>
                                <td><div align="left"><s:text name="addresslst[0].line1"  class="textbox" id="addressline11"></s:text></div></td>
                            </tr>
                            <tr>

                                <td>Line 2</td>
                                <td><div align="left"><s:text name="addresslst[0].line2"  class="textbox" id="addressline12"></s:text></div></td>
                            </tr>
                            <tr>

                                <td>City</td>
                                <td><div align="left"><s:text name="addresslst[0].city"  class="textbox" id="addresscity1"></s:text></div></td>
                            </tr>
                            <tr>

                                <td>State</td>
                                <td><div align="left"><s:text name="addresslst[0].state"  class="textbox" id="addressstate1"></s:text></div></td>
                            </tr>
                            <tr>

                                <td>Country</td>
                                <td><div align="left"><s:text name="addresslst[0].country"  class="textbox" id="addresscountry1"></s:text></div></td>
                            </tr>
                            <tr>

                                <td>Zip</td>
                                <td><div align="left"><s:text name="addresslst[0].zip"  class="textbox" id="addresszip1"></s:text></div></td>
                            </tr>

                        </table>
                        </td>
                    </tr>
                </table>

            </div></td>
            <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Address 2</div></td>
            <td align="left" valign="top"><div align="left">
            <table width="100%">
            <tr>
            <td> <table width="70%" cellspacing="0" cellpadding="0">
            <tr>

                <td>Line 1</td>
                <td><div align="left"><s:text name="addresslst[1].line1" class="textbox" id="addressline21"></s:text></div></td>
            </tr>
            <tr>

                <td>Line 2</td>
                <td><div align="left"><s:text name="addresslst[1].line2" class="textbox" id="addressline22"></s:text></div></td>
            </tr>
            <tr>

                <td>City</td>
                <td><div align="left"><s:text name="addresslst[1].city"  class="textbox" id="addresscity2"></s:text></div></td>
            </tr>
            <tr>

                <td>State</td>
                <td><div align="left"><s:text name="addresslst[1].state"  class="textbox" id="addressstate2"></s:text></div></td>
            </tr>
            <tr>

            <td>Country</td>
            <td>
                <div align="left">
                    <s:text name="addresslst[1].country"  class="textbox" id="addresscountry2"/>
                    </div>
                    </td>
    </tr>
        <tr><td>Zip</td>
                <td><div align="left">
                    <s:text name="addresslst[1].zip"  class="textbox" id="addresszip2"/>
        </div></td> </tr>

        </table>
        </td>
        </tr>
        </table>

        </div></td>
        </tr>
        <tr>
            <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Phone No 1</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.contactNo1" id="addcustomerphnno1" class="textbox"></s:text></div></td>
            <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Phone No 2</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.contactNo2" class="textbox" id="addcustomerphnno2"></s:text></div></td>
        </tr>
        <tr>
            <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Email Id</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.email" id="addcustomermailid" class="textbox"></s:text></div></td>
            <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">TIN No.</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.tinNo" class="textbox"></s:text></div></td>
        </tr>

        <tr>
            <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">ECC No.</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.eccNo" id="addvendorservicetax" class="textbox"></s:text></div></td>
             <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">Pan Card No.</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.PanNo" class="textbox"></s:text></div></td>
        </tr>
                  <tr>
            <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">TAN No.</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.tanNo" id="addvendorservicetax" class="textbox"></s:text></div></td>

        </tr>

        <tr>
            <td >&nbsp;</td>
            <td colspan="2" align="right" valign="top"><div align="center">     &nbsp;&nbsp;&nbsp;&nbsp;
                <s:submit id="addcustomerbutton" class="buttons" name="addCustomer" value="Add"></s:submit>     &nbsp;&nbsp;&nbsp;&nbsp;
                <s:reset name="reset" class="buttons" value="Reset"></s:reset>   &nbsp;&nbsp;&nbsp;&nbsp;
                <s:submit name="cancel" class="buttons" value="Cancel"></s:submit></div></td>
            <td >&nbsp;</td>

        </tr>
        </table></td></tr>
            </table>
    </s:form>
</s:layout-component>
</s:layout-render>
