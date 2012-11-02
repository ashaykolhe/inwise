<%--
Created by IntelliJ IDEA.
User: Milind
Date: Feb 29, 2012
Time: 5:26:54 PM
To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />

<s:useActionBean beanclass="com.inwise.action.ProposalActionBean" var="proposalBean" event="previewLink"/>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<s:layout-render name="/layout/_base.jsp">
 <s:layout-component name="left-menu">

                 <ul>
                          <li>&nbsp;</li>
                      <li class="left_menu_heading">Proposal</li>
                     <li style="margin-top:35px">
                             &nbsp;</li>
             


                  </ul>

         </s:layout-component>
<s:layout-component name="body">
<s:form beanclass="com.inwise.action.ProposalActionBean">
      <br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Preview Proposal</div>
    </td></tr>
   <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>--%>
    </table>
     <table class="second_table"  ><tr><td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="22%" align="left" valign="top">
                    <div align="left" style="margin-left: 2px;" class="labels">
                        <div align="right">Name of Customer<span style="color:#FF0000"> *</span></div>
                    </div>
                </td>
                <td width="22%" align="left" valign="top">
                    <div align="left">
                        <s:text id="customerName" name="proposal.customer.name" class="textbox" readonly="readonly"></s:text>
                         <s:hidden name="proposal.id" value="${proposalBean.proposal.id}" />
                        <s:hidden name="proposal.requoteStatus" value="requote"/>
                    </div>
                </td>
                <td width="22%" align="left" valign="top"><s:hidden name="proposal.deleted" value="0"/>
                    <div align="left" style="margin-left: 2px;" class="labels">
                        <div align="right">Proposal Date<span style="color:#FF0000"> *</span></div>
                    </div>
                </td>
                <td width="34%" align="left" valign="top">
                    <div align="left">
                        <s:text name="proposal.createDate" id="createDate" readonly="readonly" formatType="date" formatPattern="yyyy/MM/dd"  class="textbox"/>
                    </div>
                </td>
            </tr>



            <tr>
                <td colspan="4"><br><div align="left" style="margin-left:10px;">
 <table width="95%" border="0"  cellspacing="0" cellpadding="0"  align="left" id="family">
    <tr class="foreach_table">
                            <td width="17%"  class="foreach_table_firstth"><div align="center"><span class="foreach_th_span">Product</span></div></td>
                             <td width="18%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">UOM</span></div></td>
            <td width="17%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">Quantity</span></div></td>
          <td width="21%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">Rate</span></div></td>

                            <td width="20%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span">Amount</span></div></td>
                            
                        </tr>
                        <c:forEach items="${actionBean.proposal.proposalDetail}" var="proposalDetail" varStatus="loop" >
                            <tr id="tabletr">
                              <td class="foreach_table_firstth">
    <div class="foreach_table_div">
                                        <div align="right">
                                          <s:text name="proposal.proposalDetail[${loop.index}].product.name"  id="productName${loop.index}" value="${proposalDetail.product.productName}" readonly="readonly" class="foreach_table_td" style=" width:100px;"/>
                                        </div></div></td>
                                 <td class="foreach_table_th"><div class="foreach_table_div"> <div align="right">
                                            <s:text name="productMeasurementType" id="productMeasurementType${loop.index}" value="${proposalDetail.product.unit.name}" readonly="readonly" class="foreach_table_td" style=" width:100px;"/>
                                      </div>  </div></td>
                                <td class="foreach_table_th"><div class="foreach_table_div">    <div align="right">
                                            <s:text name="proposal.proposalDetail[${loop.index}].quantity"   id="quantity${loop.index}"   readonly="readonly"  class="foreach_table_td removeValue" style=" width:100px;"/>

                                      </div>  </div></td>
                               <td class="foreach_table_th"><div class="foreach_table_div">
                                   <div align="right">
                                            <s:text  name="proposal.proposalDetail[${loop.index}].cost"  id="cost${loop.index}" readonly="readonly" class="foreach_table_td removeValue" style=" width:100px;" />
                                   </div>    </div></td>


                              <td class="foreach_table_th"><div class="foreach_table_div">    <div align="right">

                                            <s:text name="amount[${loop.index}]" id="amount${loop.index}"  value="${proposalDetail.cost * proposalDetail.quantity}" readonly="readonly" class="foreach_table_td"  style=" width:100px;"/>
                                             <s:hidden name="proposal.proposalDetail[${loop.index}].product.id"  id="productid${loop.index}" value="${proposalDetail.product.id}" />

                              </div>   </div></td>

                            </tr>
                        </c:forEach>
     <tr>
         <td colspan="3"> &nbsp;</td>
              <td class="foreach_table_th" style=" border-left:1px solid #cccccc;font-weight:bold;"><div class="foreach_table_div">    <div align="right">Total Amount</div></div></td>
         <td class="foreach_table_th"><div class="foreach_table_div">    <div align="right">
                                            <s:text name="proposal.totalAmount" id="totalAmount" readonly="readonly" class="foreach_table_td"  style=" width:100px;"/>
                                     </div>   </div></td>
     </tr>
                    </table>
                    
                </div></td>
            </tr>
            <tr>
                <td align="left">&nbsp;</td>
                <td align="left" colspan="2">&nbsp;</td>
                <td align="left">&nbsp;</td>
            </tr>
            <tr>
                <td align="left">&nbsp;</td>
                <td align="left" colspan="2"><div align="left" style="margin-left:20px"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <s:submit name="redirectProposalLink" value="Submit" class="buttons" id="addProposal"></s:submit>&nbsp;&nbsp;&nbsp;&nbsp;
                    <s:submit name="editProposalLink" value="Edit" class="buttons" ></s:submit>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <s:submit name="cancel" value="Cancel" class="buttons"></s:submit>
                </div></td>
                <td width="34%" align="left">&nbsp;</td>
            </tr>

        </table></td></tr></table>
</s:form>


</s:layout-component>
</s:layout-render>
