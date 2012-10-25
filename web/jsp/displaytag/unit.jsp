<%@ taglib prefix="d" uri="http://displaytag.sf.net/el"%>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes-dynattr.tld" %>
  <s:useActionBean beanclass="com.inwise.action.ProductActionBean" var="listofuser" event="addProductLink"></s:useActionBean>
<% request.setAttribute("unitlst",listofuser.getUnitlst());


%>
 <div style="height:250px;overflow-y:auto">
<d:table name="unitlst"  class="disp" id="unit" requestURI="/unit?paginationUnit">
<d:column property="name" title="Unit"/>
                  <d:column  title="update">
                        <s:link beanclass="com.inwise.action.UnitActionBean" event="readname" onclick= "return updateLink(this);">
                          <s:param name="id" value="${unit.id}"></s:param>
                      <img src="images/edit-icon.png" />
                       </s:link>

                  </d:column>
                   <d:column title="Delete" class="delete">
                       <s:link beanclass="com.inwise.action.UnitActionBean" event="delete" onclick= "return ajaxLink(this,'#unit_table');">
                           <s:param name="id" value="${unit.id}"></s:param>
                       <img src="images/delete.jpg" />
                       </s:link>
                   </d:column>
	 </d:table>
    </div>