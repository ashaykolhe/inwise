    <%--
    Created by IntelliJ IDEA.
    User: Admin
    Date: Feb 23, 2012
    Time: 11:52:37 AM
    To change this template use File | Settings | File Templates.
    --%>
    <%@ include file="/includes/_taglibInclude.jsp" %>
    <link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
    <script type="text/javascript">
    function show_confirm()
    {
    var r=confirm("You are attempting to delete a record.Are you sure, you want to delete selected record?");
    if (r)
    {
    return true;
    }
    else
    {
    return false;
    }
    return false;
    }
    </script>
    <s:useActionBean beanclass="com.inwise.action.UserActionBean" var="listofusers" event="addUserLink"></s:useActionBean>
    <% request.setAttribute("userlst",listofusers.getUserlst());

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
                                   <li><s:link beanclass="com.inwise.action.RestoreActionBean" event="restoreItemLink">Restore</s:link> </li>
                  </ul>

         </s:layout-component>
    <s:layout-component name="body">
         <br>

    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" style="height:40px">View User</div>
       <div align="right" ><s:link beanclass="com.inwise.action.UserActionBean" event="addUserLink" class="pageheading_link">Add</s:link>
                               &nbsp;| &nbsp;    <s:link beanclass="com.inwise.action.UserActionBean" event="viewUserLink" class="pageheading_link">View</s:link>
      &nbsp;| &nbsp;    <s:link beanclass="com.inwise.action.UserActionBean" event="rolePermissionLink" class="pageheading_link">Role Permission</s:link>
                                &nbsp;| &nbsp;          <s:link beanclass="com.inwise.action.UserActionBean" event="userPermissionLink" class="pageheading_link">User Permission</s:link>
    </div>
    </td></tr>
         <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>
    </table>
    <s:form beanclass="com.inwise.action.UserActionBean">

   <table class="second_table"  ><tr><td>
    <d:table name="userlst" id="user1" pagesize="10" class="disp" requestURI="/User.action">
    <d:column property="username" title="User Name"  />
       <d:column property="name" title="Name"  />
       <d:column property="empId" title="Employee Id"  />
       <d:column property="role.name" title="Role"  />
        <d:column title="Update" >

    <s:link beanclass="com.inwise.action.UserActionBean" event="userlist"  >
    <s:param name="id" value="${user1.user_id}"></s:param>
        <img src="images/edit-icon.png" />
      </s:link>
    </d:column>
    <d:column title="Delete" class="delete">

    <s:link beanclass="com.inwise.action.UserActionBean" event="delete" onclick="return show_confirm();" >
    <s:param name="id" value="${user1.user_id}"></s:param>
    <img src="images/delete.jpg" />   </s:link>

    </d:column>

    </d:table></td></tr></table>

    </s:form></s:layout-component></s:layout-render>