<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function(){

      $("#getcustomerbutton").click(function(){

              if ($("#cutomerName").val()=="0"){
                              alert("please select the customer name");

                              return false;
                          }
         });

       $("#getcustomerbutton").click(function(){

              if ($("#cutomerName1").val()=="0"){
                              alert("please select customer name.")
                 

                              return false;
                          }
         });
        var phoneval = /^([0-9]{0,10})$/;

           var emailval =  /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

     $("#updatecustomerbutton").click(function(){
        if ($("#updatecustomername").val().trim() ==""){
                              alert("please enter customer name.");
                              $("#updatecustomername").focus() ;
                              return false;
                          }
           if ($("#addressline11").val().trim() ==""){
                              alert("please enter line 1 of address");
                              $("#addressline11").focus() ;
                              return false;
                          }
          if ($("#addressline12").val().trim() ==""){
                              alert("please enter line 2 of address");
                              $("#addressline12").focus() ;
                              return false;
                          }
          if ($("#addresscity1").val().trim() ==""){
                              alert("please enter city");
                              $("#addresscity1").focus() ;
                              return false;
                          }
          if ($("#addressstate1").val().trim() ==""){
                              alert("please enter state");
                              $("#addressstate1").focus() ;
                              return false;
                          }
          if ($("#addresscountry1").val().trim() ==""){
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

       if ($("#updatecustomerphnno1").val().trim() !="")
       {

            if(!phoneval.test($('#updatecustomerphnno1').val())||$('#updatecustomerphnno1').val().length!=10)
             {


                    alert("please give the phone 1 number in number format and upto 10 digits only");
                    $("#updatecustomerphnno1").val("") ;
                    $("#updatecustomerphnno1").focus() ;

                    return false;
            }
     }
      if ($("#updatecustomerphnno2").val().trim() !="")
      {

            if(!phoneval.test($('#updatecustomerphnno2').val())||$('#updatecustomerphnno2').val().length!=10)
            {


                alert("please give the phone 2 number in number format and upto 10 digits only");
                $("#updatecustomerphnno2").val("") ;
                $("#updatecustomerphnno2").focus() ;

                return false;
            }
     }
         if ($("#updatecustomermailid").val().trim() !=""&&!emailval.test($('#updatecustomermailid').val()))
                     {
                                          alert("please give the email address like abc@xyz.com");
                                          $("#updatecustomermailid").val("");
                                          $("#updatecustomermailid").focus() ;
                                          return false;

                      }


     });
    });

</script>
<s:useActionBean beanclass="com.inwise.action.CustomerActionBean" var="customerBean" event="updateCustomerLink"/>
    <%
        request.setAttribute("customerlst",customerBean.getCustomerlst());

    %>



<s:layout-render name="/layout/_base.jsp">
     <s:layout-component name="left-menu">

                 <ul>
                          <li>&nbsp;</li>
                      <li class="left_menu_heading">Customer</li>
                     <li style="margin-top:35px">
                           <li><s:link beanclass="com.inwise.action.CustomerActionBean" event="pageDirect">Add</s:link></li>
                              <li><s:link beanclass="com.inwise.action.CustomerActionBean" event="viewLink">View</s:link></li>
                  </ul>

         </s:layout-component>
      <s:layout-component name="body">
      <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Update customer</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>


      <table class="second_table"  >
 <%--<s:form beanclass="com.inwise.action.CustomerActionBean">
 <tr><td width="23%" align="left" valign="top">
   <div align="left" style="margin-left: 1px;" class="labels">Please select Customer Name<span style="color:#FF0000"> *</span></div></td>
		  <td width="21%" align="left" valign="top" >
<s:select id="cutomerName" name="id"  class="dropdown">
                        <option  value="0">---Select Customer---</option>
              <c:forEach items="${customerlst}" var="customer" varStatus="loop" >
                    <c:choose>
                  <c:when test="${customerBean.customer.id eq customer.id}">
			            <option value ="<c:out value="${actionBean.customer.id}"/>" selected="selected"> <c:out value="${actionBean.customer.name}"/></option>
                      </c:when>
                  <c:otherwise>
               <option value ="${customer.id}"><c:out value="${customer.name}"/></option>
                  </c:otherwise>
                  </c:choose>
		      </c:forEach>
           </s:select> </td>

		  <td width="15%"  align="left" valign="top" > <s:submit name="updateCustomer" class="buttons" id="getcustomerbutton"  value="Get"/>
    <td>&nbsp;</td>
						</tr>
           </s:form>--%>
              <c:if test="${actionBean.customer!=null}">
                  <s:form beanclass="com.inwise.action.CustomerActionBean">



            <tr>
                <td width="23%" align="right"> <div align="right" style="margin-left: 2px;" class="labels">Customer Name<span style="color:#FF0000"> *</span></div>     </td>
                <td width="21%" align="left" valign="top"><div align="left"><s:text name="customer.name" id="updatecustomername" class="textbox"></s:text></div> </td>
                <td width="15%" align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Department</div></td>

                <td width="41%" align="left" valign="bottom"><div align="left" ><s:text id="updatecustomerdepartment"  name="customer.department" class="textbox"></s:text>
                    <s:hidden name="customer.deleted" value="1"/>
                    <s:hidden name="customer.id" value="${customerBean.id}"/>
                </div></td>



            <tr>
                <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Contact Person<span style="color:#FF0000"> </span></div></td>
                <td align="left" valign="top"><div align="left"><s:text name="customer.contactPerson" id="updatecustomercp" class="textbox"></s:text></div></td>

            </tr>
            <tr>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Address 1<span style="color:#FF0000"> </span></div></td>
            <td align="left" valign="top"><div align="left">
                <table width="100%">
                    <tr>
                        <td> <table width="70%" cellspacing="0" cellpadding="0">
                            <tr>

                                <td>Line 1</td>
                                <td><div align="left"><s:text name="customer.addressList[0].line1"  class="textbox" id="addressline11"></s:text></div></td>
                            </tr>
                            <tr>

                                <td>Line 2</td>
                                <td><div align="left"><s:text name="customer.addressList[0].line2"  class="textbox" id="addressline12"></s:text></div></td>
                            </tr>
                            <tr>

                                <td>City</td>
                                <td><div align="left"><s:text name="customer.addressList[0].city"  class="textbox" id="addresscity1"></s:text></div></td>
                            </tr>
                            <tr>

                                <td>State</td>
                                <td><div align="left"><s:text name="customer.addressList[0].state"  class="textbox" id="addressstate1"></s:text></div></td>
                            </tr>
                            <tr>

                                <td>Country</td>
                                <td><div align="left"><s:text name="customer.addressList[0].country"  class="textbox" id="addresscountry1"></s:text></div></td>
                            </tr>
                            <tr>

                                <td>Zip</td>
                                <td><div align="left"><s:text name="customer.addressList[0].zip"  class="textbox" id="addresszip1"></s:text></div></td>
                            </tr>

                        </table>
                        </td>
                    </tr>
                </table>

            </div></td>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Address 2</div></td>
            <td align="left" valign="top"><div align="left">
            <table width="100%">
            <tr>
            <td> <table width="70%" cellspacing="0" cellpadding="0">
            <tr>

                <td>Line 1</td>
                <td><div align="left"><s:text name="customer.addressList[1].line1" class="textbox" id="addressline21"></s:text></div></td>
            </tr>
            <tr>

                <td>Line 2</td>
                <td><div align="left"><s:text name="customer.addressList[1].line2" class="textbox" id="addressline22"></s:text></div></td>
            </tr>
            <tr>

                <td>City</td>
                <td><div align="left"><s:text name="customer.addressList[1].city"  class="textbox" id="addresscity2"></s:text></div></td>
            </tr>
            <tr>

                <td>State</td>
                <td><div align="left"><s:text name="customer.addressList[1].state"  class="textbox" id="addressstate2"></s:text></div></td>
            </tr>
            <tr>

            <td>Country</td>
            <td>
                <div align="left">
                    <s:text name="customer.addressList[1].country"  class="textbox" id="addresscountry2"/>
                    </div>
                    </td>
    </tr>
        <tr><td>Zip</td>
                <td><div align="left">
                    <s:text name="customer.addressList[1].zip"  class="textbox" id="addresszip2"/>
        </div></td> </tr>

        </table>
        </td>
        </tr>
        </table>

        </div></td>
        </tr>
        <tr>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Phone No 1</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.contactNo1" id="updatecustomerphnno1" class="textbox"></s:text></div></td>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Phone No 2</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.contactNo2" class="textbox" id="updatecustomerphnno2"></s:text></div></td>
        </tr>
        <tr>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">Email Id</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.email" id="updatecustomermailid" class="textbox"></s:text></div></td>
            <td align="right" valign="top"><div align="right" style="margin-left: 2px;" class="labels">TIN No.</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.tinNo" class="textbox"></s:text></div></td>
        </tr>

      
          <tr>
            <td align="right" valign="top"><div align="left" style="margin-left: 2px;" class="labels">ECC No.</div></td>
            <td align="left" valign="top"><div align="left"><s:text name="customer.eccNo" id="updatevendorservicetax" class="textbox"></s:text></div></td>
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
                <s:submit id="updatecustomerbutton" class="buttons" name="update" value="Update"></s:submit>
                <s:hidden name="customer.customerCode" value="${customerBean.customer.customerCode}"/>&nbsp;&nbsp;&nbsp;&nbsp;
                <s:reset name="reset" value="Reset" class="buttons"></s:reset>   &nbsp;&nbsp;&nbsp;&nbsp;
              <%--  <s:submit name="cancel" value="Cancel" class="buttons"></s:submit></div></td>--%>
            <td >&nbsp;</td>

        </tr>
        </table>

    </s:form>
          </c:if>
      </s:layout-component>
</s:layout-render>
