<%--
Created by IntelliJ IDEA.
User: Atul
Date: Feb 17, 2012
Time: 4:28:07 PM
To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<script src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">
    
/*
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
          if ($("#addresszip1").val().trim() !=""&&!phoneval.test($('#addresszip1').val()))
          {
                              alert("please enter the zip in numeric  only");
                              $("#addresszip1").focus() ;
                              return false;
          }

       if ($("#addcustomerphnno1").val().trim() !="")
       {

            if(!phoneval.test($('#addcustomerphnno1').val())||$('#addcustomerphnno1').val().length!=10)
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
*/

</script>

<s:layout-render name="/layout/_base.jsp">
    <s:layout-component name="body">
        <s:form beanclass="com.inwise.action.CustomerActionBean">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
                <tr valign="top"><td >&nbsp;
                </td></tr>
                <tr><td align="left" class="pageheading" valign="top">
                    Customer > Add Customer
                </td></tr>
                <tr valign="top"><td align="center">&nbsp;
                </td></tr>
            </table>
            <table border="1" width="66%" bgcolor="#FCFCFC" ><tr><td>
            <table width="100%" border="0" cellspacing="1" bordercolor="#FCFCFC">
            <%-- <tr>
           <td align="left"  valign="top" colspan="2"><div align="left" class="labels" style="margin-left:2px"><span style="border-bottom-color:#000">Vendor</span></div></td>

           <td align="left" valign="top" colspan="2"><div align="left" class="labels" style="margin-left:2px">Product Supplied</div></td>

           </tr> --%>
            <tr>
                <td width="18%" align="right"> <div align="right" style="margin-left: 2px;" class="labels">Customer Name<span style="color:#FF0000"> *</span></div>     </td>
                <td width="32%" align="left" valign="top"><div align="left"><s:text name="customer.name" id="addcustomername" class="textbox"></s:text></div> </td>
                <td width="18%" align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Department<span style="color:#FF0000"> </span></div></td>

                <td width="32%" align="left" valign="bottom"><div align="left" ><s:text id="addcustomerdepartment"  name="customer.department" class="textbox"></s:text>
                    <s:hidden name="customer.deleted" value="0"/>
                </div></td>



            <tr>
                <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Contact Person<span style="color:#FF0000"> </span></div></td>
                <td align="left" valign="top"><div align="left"><s:text name="customer.contactPerson" id="addcustomercp" class="textbox"></s:text></div></td>

            </tr>
            <tr>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Address 1<span style="color:#FF0000"> </span></div></td>
            <td align="left" valign="top"><div align="left">
<%--
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
--%>

            </div></td>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Address 2</div></td>
            <td align="left" valign="top"><div align="left">
            <table width="100%">
            <tr>
            <td><%-- <table width="70%" cellspacing="0" cellpadding="0">
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

        </table>--%>
        </td>
        </tr>
        </table>

        </div></td>
        </tr>
        <tr>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Phone No 1</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.contactNo1" id="addcustomerphnno1" class="textbox"></s:text></div></td>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Phone No 2</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.contactNo2" class="textbox" id="addcustomerphnno2"></s:text></div></td>
        </tr>
        <tr>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Email Id</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.email" id="addcustomermailid" class="textbox"></s:text></div></td>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">TIN No.</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.tinNo" class="textbox"></s:text></div></td>
        </tr>

        <tr>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">ECC No.</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.eccNo" id="addvendorservicetax" class="textbox"></s:text></div></td>

        </tr>

        <tr>
            <td >&nbsp;</td>
            <td colspan="2" align="right" valign="top"><div align="center">     &nbsp;&nbsp;&nbsp;&nbsp;
                <s:submit id="addcustomerbutton" name="addCustomer" value="Add"></s:submit>     &nbsp;&nbsp;&nbsp;&nbsp;
                <s:reset name="reset" value="Reset"></s:reset>   &nbsp;&nbsp;&nbsp;&nbsp;
                <s:submit name="cancel" value="Cancel"></s:submit></div></td>
            <td >&nbsp;</td>

        </tr>
        </table></td></tr>
            </table>
    </s:form>
</s:layout-component>
</s:layout-render>
