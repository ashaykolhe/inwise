<%--
  Created by IntelliJ IDEA.
  User: Minal
  Date: Feb 17, 2012
  Time: 3:48:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />

<script type="text/javascript">
    function show_confirm()
{
var r=confirm("Are you sure, you want to delete selected record.");
if (r==true)
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

<s:useActionBean beanclass="com.inwise.action.ProposalActionBean" var="list" event="viewProposalLink"></s:useActionBean>
<% request.setAttribute("proposallst",list.getProposallst());

%>
<s:layout-render name="/layout/_base.jsp">
    <s:layout-component name="left-menu">

                     <ul>
                              <li>&nbsp;</li>
                          <li class="left_menu_heading">Proposal</li>
                         <li style="margin-top:35px">
                                 <s:link beanclass="com.inwise.action.ProposalActionBean" event="addProposalLink">Create</s:link></li>
                      <li>     <s:link beanclass="com.inwise.action.ProposalActionBean" event="viewProposalLink">View</s:link></li>


                      </ul>
</s:layout-component>     
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.ProposalActionBean">
    <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >View Proposals</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center">
    <div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
   <table class="second_table"  ><tr><td>
       <%
             org.displaytag.decorator.TotalTableDecorator totals = new org.displaytag.decorator.TotalTableDecorator();
             totals.setSubtotalLabel("partial amount");
             pageContext.setAttribute("totals", totals);

                %>

                    <d:table name="proposallst" id="proposal1" pagesize="5" class="disp" requestURI="/proposal" decorator="totals">
                 <d:column property="id" title="Proposal Id"/>
                 <d:column property="customer.name" title="Customer"/>
                 <d:column property="createDate" title="Propsoal Date" format="{0,date,yyyy-MM-dd}" sortable="false"/>
                        <c:set var="pro" value="${proposal1.proposalDetail}" scope="request"/>
                      <d:column title="Quotation Revision">
                              <d:table name="pro" id="proposaldetail" class="disp"   requestURI="/proposal" decorator="totals">

                                     <d:column property="requoteno" group="1" title="Revision #"/>
                                     <d:column property="product.productName" title="Product Name"/>
                                     <d:column property="quantity" title="Quantity"/>
                                     <d:column property="cost" title="Rate"/>
                                     <d:column property="amount" title="Amount" total="true" />
                              </d:table> </d:column>
                                               <d:column  title="Revise">
                                        <table>             <c:choose>
                            <c:when test="${proposal1.requoteStatus eq 'final'}">
                             <tr>
                                <td>
                                   Order Generated
                                    <br>
                                    <s:link beanclass="com.inwise.action.ProposalActionBean" event="getProposalList" style="font-size:11px;"  >
                                <s:param name="id" value="${proposal1.id}"></s:param>
                               VIEW ORDER
                       </s:link></td>
                                </tr>
                            </c:when> <c:otherwise>
                              <tr>
                                <td> <s:link beanclass="com.inwise.action.ProposalActionBean" event="getProposalList"  >
                                <s:param name="id" value="${proposal1.id}"></s:param>
                                <img src="images/edit-icon.png" />
                       </s:link></td>
                                </tr>
                            </c:otherwise> </c:choose>   </table> 

                        </d:column>
                                </d:table></td></tr></table>

 </s:form></s:layout-component></s:layout-render>