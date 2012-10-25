<%--
  Created by IntelliJ IDEA.
  User: Atul
  Date: Jul 12, 2012
  Time: 10:35:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/includes/_taglibInclude.jsp" %>
    <link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<script type="text/javascript">

    $(document).ready(function(){
        var temp= $("#count").html();

        $(function(){
            function selectItem()
            {

                var flagchk=0;
                if(!$("#restoreallceckboxid").is(':checked'))
                {

                  for(var i=1;i<=temp;i++)
                    {
                        if($("#singleitemcheckboxid"+i).is(':checked'))
                        {
                             flagchk++;
                        }
                    }
                   if(flagchk==0)
                   {
                         alert("Please select the Customer to Restore.");
                         return false;
                   }
                }


            }
            $("#restoreallbutton").click(selectItem);
            $("#restorebuttonid").click(selectItem);

        });
        for(var i=1;i<=temp;i++)
        {
            $("#singleitemcheckboxid"+i).click(function(){

                if($("#restoreallceckboxid").is(':checked'))
                {
                    $("#restoreallceckboxid").attr("checked",false);
                    $("#restorebuttonid").attr("disabled",false);
                }
                for(var i=1;i<=temp;i++)
                {
                    if($("#singleitemcheckboxid"+i).is(':checked'))
                    {
                        var flag=1;
                    }
                }
                if(flag==1)
                {
                    $("#restoreallbutton").attr("disabled",true);
                }
                else
                {
                    $("#restoreallbutton").attr("disabled",false);
                }
            });

        }

        $("#restoreallceckboxid").click(function()
        {
            for(var i=1;i<=temp;i++)
            {
                if($("#singleitemcheckboxid"+i).is(':checked'))
                {
                    $("#singleitemcheckboxid"+i).attr("checked",false);
                    $("#restoreallbutton").attr("disabled",false);
                }
            }
            if($("#restoreallceckboxid").is(':checked'))
            {
                $("#restorebuttonid").attr("disabled",true);
            }
            else
            {
                 $("#restorebuttonid").attr("disabled",false);
            }
        });


    })     ;
</script>

<s:useActionBean beanclass="com.inwise.action.RestoreActionBean" var="list" event="restoreCustomerLink"></s:useActionBean>
    <% request.setAttribute("custlst",list.getCustomerlst());

    %>
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
    <s:form beanclass="com.inwise.action.RestoreActionBean">
           <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Restore Customer</div>
         <div align="right" ><s:link beanclass="com.inwise.action.RestoreActionBean" event="restoreCustomerLink"  class="pageheading_link">Restore Customer</s:link>
                                   &nbsp;| &nbsp;    <s:link beanclass="com.inwise.action.RestoreActionBean" event="restoreProductLink" class="pageheading_link">Restore Product</s:link>
                                    &nbsp;| &nbsp;    <s:link beanclass="com.inwise.action.RestoreActionBean" event="restoreUserLink" class="pageheading_link">Restore User</s:link>

        </div>
    </td></tr>
   <%-- <tr valign="top"><td align="center">
    <div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
   <table class="second_table"  ><tr><td colspan="2">

               <c:if test="${actionBean.restorelistempty eq false}">
                <d:table name="custlst" id="cust" pagesize="10" class="disp" requestURI="/Customer.action">

                    <d:column title="Select Customer">
                      <s:checkbox name="customerListForRestore[${cust_rowNum}]" value="${cust.id}" id="singleitemcheckboxid${cust_rowNum}" ></s:checkbox>
                    </d:column>

                 <d:column property="name" title="Customer Name"/>
                 <d:column property="department" title="Department"  />
                          <d:column property="customerCode" title="Customer Code" />
                  <d:column property="email" title="Email Id" />

                         <d:column property="contactNo1" title="Phone Number" />

                    </d:table>
                   <div id="count" style="display:none;">${cust_rowNum}</div>

                    <div style="margin-left:6px">
              <s:checkbox name="restoreAll" id="restoreallceckboxid" class="labels" value="restoreall"></s:checkbox>Restore All Customers<span style="color:#FF0000"></span>

                    <s:submit name="restoreCustomer"  value="Restore All" id="restoreallbutton" class="buttonbig" style="margin-left:6px"></s:submit>
                   <s:submit name="restoreCustomer"  value="Restore Selected" id="restorebuttonid" class="buttonbig1" style="margin-left:6px" ></s:submit>
                  </div>
               </c:if>
               <c:if test="${actionBean.restorelistempty eq true}">
                   No Customers Found For Restore.
                   </c:if>

           </td>
        </tr>


    </table>
    </s:form>
     </s:layout-component>
    </s:layout-render>