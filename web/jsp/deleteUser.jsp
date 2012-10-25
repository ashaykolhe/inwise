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
                  <li class="left_menu_heading">User Management</li>
                  <li style="margin-top:35px">  <li> <s:link beanclass="com.inwise.action.UserActionBean" event="addUserLink">Add User</s:link></li>
                <li><s:link beanclass="com.inwise.action.UserActionBean" event="updateUserLink" >Update</s:link></li>
                          <li>   <s:link beanclass="com.inwise.action.UserActionBean" event="deleteUserLink" >Delete</s:link>
                              </li>
              </ul>

     </s:layout-component>
    <s:layout-component name="body">
         <br>

    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" style="height:40px">Delete User</div>
       
    </td></tr>
    </table>
    <s:form beanclass="com.inwise.action.UserActionBean">

   <table class="second_table"  ><tr><td>
    <d:table name="userlst" id="user1" pagesize="10" class="disp" requestURI="/User.action">
    <d:column property="user_id" title="Id"/>
    <d:column property="username" title="User Name"  />
    <d:column title="Delete" class="delete">

    <s:link beanclass="com.inwise.action.UserActionBean" event="delete" onclick="return show_confirm();" >
    <s:param name="id" value="${user1.user_id}"></s:param>
    <img src="images/delete.jpg" />   </s:link>

    </d:column>

    </d:table></td></tr></table>

    </s:form></s:layout-component></s:layout-render>