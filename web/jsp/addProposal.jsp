<%--
Created by IntelliJ IDEA.
User: Milind
Date: Feb 29, 2012
Time: 5:26:54 PM
To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />

<s:useActionBean beanclass="com.inwise.action.ProposalActionBean" var="proposalBean" event="addProposalLink"/>

<script type="text/javascript">

function GetItemDetail(button){
    var count=$('#family #tabletr').length;
    var rowid=button.name.substring(button.name.indexOf("[")+1,button.name.indexOf("]"));
    var flag=true;
    var check=$('#productName'+rowid+'').val();
    for(var i=1;i<=count;i++)
    {
        if(rowid==i){
            continue;
        }
        var temp=$('#productName'+i+'').val();

        if(check==temp)
        {
            flag=false;
            --rowid;

            alert("This Product has been already added. Please select another product.");
            $('#family #tabletr:eq('+rowid+') select:eq(0)').attr("value","");
            $('#family #tabletr:eq('+rowid+') input').removeAttr("value");
            return false;
        }//end of if
    }//end of for
    if(flag==true)
    {
        $.post('order?productDetailsAjax', {id:button.value}, function (data) {
            var result=eval(data);

            $('#productMeasurementType'+rowid+'').attr("value",result.unit.name);
        });//end of post funtion
    }//end of flag==true if
} //end of getItem Funntion
/*the function calculateBalance is use to validate rate textfiled for numeric as well as blank
 this function is called onChange of rate textfield  */
function calculateBalance(p,i){

    var rowid=p.name.substring(p.name.indexOf("[")+1,p.name.indexOf("]"));

    if(p.value!=0){
        var chk = /^[0-9]+$/.test(p.value);
        if (!chk) {
            alert('please Enter Numeric value for quantity');

            var amount= $('#amount'+rowid+'').val();
             --rowid;
            $('#family #tabletr:eq('+rowid+') input:eq(1)').val("");
            $('#family #tabletr:eq('+rowid+') input:eq(3)').val("");
             var totalamt= $('#totalAmount').val() ;

         var total=parseFloat(totalamt)-parseFloat(amount);
        $('#totalAmount').attr("value",total);
                      $('#family #tabletr:eq('+rowid+') input:eq(1)').focus();
        }//end of chk loop
        else if($('#cost'+rowid+'').val().trim()!=""){
                    var cost=$('#cost'+rowid+'').val();
                  var amountbeforcal= $('#amount'+rowid+'').val();
            var valueset=parseFloat(p.value)*parseFloat(cost);
            $('#amount'+rowid+'').attr("value",valueset);
                var totalamt= $('#totalAmount').val() ;
        var amount= $('#amount'+rowid+'').val();
        if($('#totalAmount').val().trim()==""){
              totalamt=0;
        }
          if($('#totalAmount').val().trim()==""){
              amountbeforcal=0;
        }

       var total=(parseFloat(totalamt)-parseFloat(amountbeforcal))+parseFloat(amount);
    $('#totalAmount').attr("value",total);
                }//end of else if loop
        /*else{
            --rowid;
            alert("Please enter rate");
            $('#family #tabletr:eq('+rowid+') input:eq(2)').focus();
        }*///ennd of else
    }//end of p.value!=0 if
    else{
        --rowid;
        alert("Please enter valid quantity");
        $('#family #tabletr:eq('+rowid+') input:eq(1)').val("");
        $('#family #tabletr:eq('+rowid+') input:eq(3)').val("");
        $('#family #tabletr:eq('+rowid+') input:eq(1)').focus();
    }

}//end of function
 function calculateBalanceRate(p,i){
    var rowid=p.name.substring(p.name.indexOf("[")+1,p.name.indexOf("]"));

    if(p.value!=0){
    var chk = /^[0-9.]+$/.test(p.value);
    if (!chk) {
    alert('please Enter Numeric value for rate');

         var amount= $('#amount'+rowid+'').val();
        
        alert(amount);
         --rowid;
    $('#family #tabletr:eq('+rowid+') input:eq(2)').val("");
    $('#family #tabletr:eq('+rowid+') input:eq(3)').val("");
            var totalamt= $('#totalAmount').val() ;
                  if($('#totalAmount').val().trim()=="" || $('#totalAmount').val().trim()=="0"){
              totalamt=0;
              amount=0;
        }
         var total=parseFloat(totalamt)-parseFloat(amount);
        $('#totalAmount').attr("value",total);
    $('#family #tabletr:eq('+rowid+') input:eq(2)').focus();
    }//end of chk loop
    else if($('#quantity'+rowid+'').val().trim()!=""){
    var ordqty=$('#quantity'+rowid+'').val();
       var amountbeforcal= $('#amount'+rowid+'').val();
     if($('#amount'+rowid+'').val().trim()==""){

            amountbeforcal=0;
        }
    var valueset=parseFloat(p.value)*parseFloat(ordqty);
    $('#amount'+rowid+'').attr("value",valueset);
        var totalamt= $('#totalAmount').val() ;
        var amount= $('#amount'+rowid+'').val();
        if($('#totalAmount').val().trim()==""){
              totalamt=0;
             amountbeforcal=0;
        }
      
       var total=(parseFloat(totalamt)-parseFloat(amountbeforcal))+parseFloat(amount);
    $('#totalAmount').attr("value",total);

    }//end of else if loop
    else{
    --rowid;
    alert("Please enter  quantity");
    $('#family #tabletr:eq('+rowid+') input:eq(1)').focus();
    }//ennd of else
    }//end of p.value!=0 if
    else{
    --rowid;
    alert("Please enter valid rate");
    $('#family #tabletr:eq('+rowid+') input:eq(2)').val("");
    $('#family #tabletr:eq('+rowid+') input:eq(3)').val("");
    $('#family #tabletr:eq('+rowid+') input:eq(2)').focus();
    }
    }//end of function
function deletethis(p,a){
    var tr=$('#family #tabletr').length;
    if(tr==1){
        alert("You can not deleted the last row.");
    }
    else{
        var count=$('#family #tabletr').length;
         var rowidforcal=p.name.substring(p.name.indexOf("[")+1,p.name.indexOf("]"));
        var rowid=p.name.substring(p.name.indexOf("[")+1,p.name.indexOf("]"))-1;
         var amount= $('#amount'+rowidforcal+'').val();

        $('#family #tabletr:eq('+rowid+') input').attr("value","");
        $('#family #tabletr:eq('+rowid+') select:eq(0)').attr("value","");

         var totalamt= $('#totalAmount').val() ;
            if($('#totalAmount').val().trim()=="" || $('#totalAmount').val().trim()=="0"){
              totalamt=0;
              amount=0;
        }
         var total=parseFloat(totalamt)-parseFloat(amount);
        $('#totalAmount').attr("value",total);
    }
}
$(document).ready(function(){

    $('#add').click(function(){
        var count=$('#family #tabletr').length+1;
        $('#family #tabletr:last').clone(true).insertAfter('#family #tabletr:last');
        $('#family #tabletr:last select:eq(0)').attr("value","");
        $('#family #tabletr:last input').removeAttr("value");
        $('#family #tabletr:last select:eq(0)').attr("name","proposal.proposalDetail["+count+"].product.id");
         $('#family #tabletr:last select:eq(0)').attr("id","productName"+count);
        $('#family #tabletr:last input:eq(0)').attr("id","productMeasurementType"+count);
        $('#family #tabletr:last input:eq(1)').attr("name","proposal.proposalDetail["+count+"].quantity");
        $('#family #tabletr:last input:eq(1)').attr("id","quantity"+count);
        $('#family #tabletr:last input:eq(2)').attr("name","proposal.proposalDetail["+count+"].cost");
        $('#family #tabletr:last input:eq(2)').attr("id","cost"+count);
        $('#family #tabletr:last input:eq(3)').attr("id","amount"+count);
        $('#family #tabletr:last input:eq(4)').attr("name","delete["+count+"]");
        $('#family #tabletr:last input:eq(4)').attr("id","delete"+count);
    });
    $("#addProposal").click(function(){
        var numeric = /^[0-9]+$/;
        var count=$('#family #tabletr').length;
        if($('#customerName').attr("value")==""){
            alert("please select Customer Name");
            $('#customerName').focus();
            return false;
        }else if($('#createDate').attr("value").trim()==""){
            $('#createDate').focus();
            alert("please select a date");
            return false;

        }
        for(var i=0;i<count;i++){
            if(i==0){
                if($('#family #tabletr:eq('+i+') select:eq(0)').attr("value")==""){
                    alert("please select Product Name")
                    return false;
                }
                else if($('#family #tabletr:eq('+i+') input:eq(1)').attr("value").trim()=="" || $('#family #tabletr:eq('+i+') input:eq(1)').attr("value").trim()=="0"){
                    $('#family #tabletr:eq('+i+') input:eq(1)').focus();
                    $('#family #tabletr:eq('+i+') input:eq(1)').attr("value","");
                    alert("please enter  quantity");
                    return false;
                }
                 else if($('#family #tabletr:eq('+i+') input:eq(2)').attr("value").trim()=="" || $('#family #tabletr:eq('+i+') input:eq(2)').attr("value").trim()=="0"){
                    $('#family #tabletr:eq('+i+') input:eq(2)').focus();
                    $('#family #tabletr:eq('+i+') input:eq(2)').attr("value","");
                    alert("please enter rate");
                    return false;
                }
            }
        }   //end of for
        return true;
    });


});
</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
      <div class="sub_heading" >Create Proposal</div>
    </td></tr>
    <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
    </td></tr>
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
                        <s:select id="customerName" name="proposal.customer.id" class="dropdown">
                            <option  value="">---Select Customer---</option>
                            <c:forEach items="${proposalBean.customerList}" var="customer" varStatus="loop" >
                                <option value ="${customer.id}"><c:out value="${customer.name}"/></option>
                            </c:forEach>
                        </s:select>
                    </div>
                </td>
                <td width="22%" align="left" valign="top"><s:hidden name="proposal.deleted" value="0"/>
                    <div align="left" style="margin-left: 2px;" class="labels">
                        <div align="right">Proposal Date<span style="color:#FF0000"> *</span></div>
                    </div>
                </td>                                                                                
                <td width="34%" align="left" valign="top">
                    <div align="left">
                        <s:text name="proposal.createDate" id="createDate" readonly="readonly" onFocus="showCalendarControl(this);"  class="textbox"/>
                        <s:hidden name="proposal.requoteStatus" value="requote"/>
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
                            <td width="5%"  class="foreach_table_th"><div align="center"><span class="foreach_th_span"><img src="images/delete.jpg"/></span></div></td>
                        </tr>
                        <c:forEach var="i" begin="1" end="4" step="1" varStatus ="status" >
                            <tr id="tabletr">
                              <td class="foreach_table_firstth">
    <div class="foreach_table_div">
                                        <div align="right">
                                            <s:select id="productName${i}" name="proposal.proposalDetail[${i}].product.id" class="dropdowntable" onchange= "return GetItemDetail(this);">
                                                <option  value="">---Select Product---</option>
                                                <c:forEach items="${proposalBean.productList}" var="product" varStatus="loop" >
                                                    <option value ="<c:out value='${product.id}'/>"><c:out value="${product.productName}"/></option>
                                                </c:forEach>
                                            </s:select>
                                        </div></div></td>
                                 <td class="foreach_table_th"><div class="foreach_table_div"> <div align="right">
                                            <s:text name="productMeasurementType" id="productMeasurementType${i}" readonly="readonly" class="foreach_table_td" style=" width:100px;"/>
                                      </div>  </div></td>
                                <td class="foreach_table_th"><div class="foreach_table_div">    <div align="right">
                                            <s:text name="proposal.proposalDetail[${i}].quantity" id="quantity${i}" onchange="return calculateBalance(this,${i})" onfocus="this.style.background='#edeeef';" onblur="this.style.background='white'"  class="foreach_table_td" style=" width:100px;"/>

                                      </div>  </div></td>
                               <td class="foreach_table_th"><div class="foreach_table_div">
                                   <div align="right">
                                            <s:text  name="proposal.proposalDetail[${i}].cost" id="cost${i}"  class="foreach_table_td" style=" width:100px;" onchange="return calculateBalanceRate(this,${i})" onfocus="this.style.background='#edeeef';" onblur="this.style.background='white'"/>
                                   </div>    </div></td>


                              <td class="foreach_table_th"><div class="foreach_table_div">    <div align="right">
                                            <s:text name="amount[${i}]" id="amount${i}" readonly="readonly" class="foreach_table_td" onfocus="this.style.background='#edeeef';" onblur="this.style.background='white'" style=" width:100px;"/>
                                     </div>   </div></td>
                                <td class="foreach_table_th"><div class="foreach_table_div">     <div align="right">
                                            <s:text name="delete[${i}]"   id="delete${i}" class="delete" style="background:url('images/delete.jpg') no-repeat center;border :none;cursor:auto;"    onclick="return deletethis(this)"/>
                                            
                                    </div>    </div></td>

                            </tr>
                        </c:forEach>
     <tr>
         <td colspan="3"> &nbsp;</td>
              <td class="foreach_table_th" style=" border-left:1px solid #cccccc;font-weight:bold;"><div class="foreach_table_div">    <div align="right">Total Amount</div></div></td>
         <td class="foreach_table_th"><div class="foreach_table_div">    <div align="right">
                                            <s:text name="proposal.totalAmount" id="totalAmount" readonly="readonly" class="foreach_table_td" onfocus="this.style.background='#edeeef';" onblur="this.style.background='white'" style=" width:100px;"/>
                                     </div>   </div></td>
     </tr>
                    </table>
                    <tr><td colspan="4">
    <div style="text-align:right; cursor: pointer;" class="links"><span style="vertical-align: top;text-align: left; " class="addRow" id="add" >Add row</span></div>
    </td></tr>
                </div></td>
            </tr>
              <tr>
                <td align="left"><div align="left" style="margin-left: 2px;" class="labels">
                        <div align="right">Email</div>
                    </div></td>
                <td align="left" ><s:checkbox name="emailbox"/></td>
                <td align="left">&nbsp;</td>
                <td align="left">&nbsp;</td>
            </tr>
            <tr>
                <td align="left">&nbsp;</td>
                <td align="left" colspan="2">&nbsp;</td>
                <td align="left">&nbsp;</td>
            </tr>
            <tr>
                <td align="left">&nbsp;</td>
                <td align="left" colspan="2"><div align="left" style="margin-left:20px"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <s:submit name="addProposal" value="Preview" class="buttons" id="addProposal"></s:submit>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="reset"  value="Reset" name="reset" class="buttons"  style="width:80px" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <s:submit name="cancel" value="Cancel" class="buttons"></s:submit>
                </div></td>
                <td width="34%" align="left">&nbsp;</td>
            </tr>

        </table></td></tr></table>
</s:form>


</s:layout-component>
</s:layout-render>
