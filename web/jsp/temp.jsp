<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 11, 2012
  Time: 11:46:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />

     <script type="text/javascript">
       function getCustomerOrder(){
      /*     this.form.action='order?getCustomerOrderNo';
           this.form.submit();*/

           $.post("order?getCustomerOrderNo", {id:$('#incname').val()}, function (result) {

                var data=eval(result);
                var options = '<option value="">---Select Customer Order No---</option>';
                        for (var i = 0; i < data.length; i++) {

                            options += '<option value="' + data[i].id + '">' + data[i].customerOrderNo + '</option>';
                        }
                        $("#inoid").html(options);
             });
       }



     function jqCheckAll1(name)  {

        if($('#allbox').attr('checked'))
    {
        $('#'+name+'[type="checkbox"]').attr('checked', true);
        //var countl = document.getElementById('inCount').value;
        var countl =$('#inCount').html();

	for(q=0;q<countl;q++)
	{
    var chkid="chkbx"+q;



        $('#'+chkid+'[type="checkbox"]').attr('checked', true);


                     var itemno="inDraw"+q;
                  var cshno="inCsh"+q;
                  var disp="inDisp"+q;
    var selectid="inProType"+q;

   document.getElementById(itemno).disabled = false;
   document.getElementById(disp).disabled = false;
   document.getElementById(cshno).disabled = false;
     document.getElementById(selectid).disabled = false;



	}
    }
    else {
            var countl =$('#inCount').html();
        alert("count "+countl);
	for(a=0;a<countl;a++)
	{
    var chkid="chkbx"+a;
   $('#'+chkid+'[type="checkbox"]').attr('checked', false);

                  var itemno="inDraw"+a;
                  var cshno="inCsh"+a;
                  var disp="inDisp"+a;
    var selectid="inProType"+a;


     var emptyitem=document.getElementById(itemno);
        emptyitem.value="Item No";
     var emptydisp=document.getElementById(disp);
        emptydisp.value="Enter Dispaching Qty";
     var emptycsh=document.getElementById(cshno);
        emptycsh.value="Enter CSH No";
        document.getElementById(itemno).disabled = true;
        document.getElementById(cshno).disabled = true;
        document.getElementById(disp).disabled = true;
        document.getElementById(selectid).disabled = true;
        var calv=parseFloat(document.getElementById("inValue"+a).value);
      calinTotalAmount=calinTotalAmount-calv;

      document.getElementById("inTotalAmount").value="0.0";
      document.getElementById("inValue"+a).value="0.0";

        }
   }
     }
</script>
<script type="text/javascript">
function ValidateInvoice(myaction)
{

	if(document.getElementById('inAdvanceEntered').value=="")
	{
		document.getElementById('inAdvanceEntered').value=(0).toFixed(2);
	}

	var countL = document.getElementById('inCount').value;
	var counts=0;
	if(countL==1)
	{
		var e = document.getElementById('chkbx0');
		if(e.checked)
		{
			/* if(document.invoice.incsh0.value=='Enter CSH No')
			{
				alert("Please enter 'CSH No.' for 'Item No':: "+document.getElementById('inItemh0').value);
				document.invoice.incsh0.value="";
				document.invoice.incsh0.focus();
				return false;
			} */

			if(document.invoice.incsh0.value.length > 15)
		    {
				alert("'CSH No.' is too long for 'Item No':: "+document.getElementById('inItemh0').value+". Enter upto 15 digits.");
				document.invoice.incsh0.value="";
			  	document.invoice.incsh0.focus();
			  	return false;
		    }

			if(document.invoice.incsh0.value!="" && document.invoice.incsh0.value!='Enter CSH No' &&   !(document.invoice.incsh0.value.match(numericExp)))
			{
				alert("Please enter valid 'CSH No.' for 'Item No':: "+document.getElementById('inItemh0').value);
				document.invoice.incsh0.value="";
				document.invoice.incsh0.focus();
				return false;
			}

			if(document.getElementById('inDing0').value=="0")
			{
				alert ("Select some quantity for 'Item No':: "+document.getElementById('inItemh0').value);
				document.getElementById('inDing0').focus();
				return false;
			}
			if(document.getElementById('inDing0').value=="")
			{
				alert ("Dispatching quantity cannot be null.");
				document.getElementById('inDing0').focus();
				return false;
			}

		}
		else
		{
			alert("Select any product.");
			document.invoice.allbox.focus();
			return false;
		}
	}
	else {
	for(i=0;i<countL;i++)
	{
		var cbx = 'chkbx'+i;
		var e = document.getElementById(cbx);
		if(e.checked)
		{
			var itemno = 'inItemh'+i;
			var Ding = 'inDing'+i;
			var cshin = 'incsh'+i;
			/* if(document.getElementById(cshin).value=='Enter CSH No')
			{
				alert("Please enter 'CSH No.' for 'Item No':: "+document.getElementById(itemno).value);
				document.getElementById(cshin).value="";
				document.getElementById(cshin).focus();
				return false;
			} */
			if(document.getElementById(cshin).length > 15)
		    {
			  alert("'CSH No.' is too long for 'Item No':: "+document.getElementById(itemno).value+". Enter upto 15 digits.");
			  document.getElementById(cshin).value="";
				document.getElementById(cshin).focus();
			  return false;
		    }

			if(document.getElementById(cshin).value!='Enter CSH No' && document.getElementById(cshin).value!=""  && !(document.getElementById(cshin).value.match(numericExp)))
				{
				alert("Please enter valid 'CSH No.' for 'Item No':: "+document.getElementById(itemno).value);
				document.getElementById(cshin).value="";
				document.getElementById(cshin).focus();
				return false;                                                  use
			 }
			if(document.getElementById(Ding).value=="0")
			{
				alert ("Select some quantity for 'Item No':: "+document.getElementById(itemno).value);
				document.getElementById(Ding).focus();
				return false;
			}
			if(document.getElementById(Ding).value=="")
			{
				alert ("Dispatching quantity cannot be null.");
				document.getElementById(Ding).focus();
				return false;
			}
		}
		else
		{
			counts++;
		}
		if(counts==countL)
		{
			alert("Select any product.");
			document.invoice.allbox.focus();
			return false;
		}
	}
	}
	if(document.invoice.inIssue.value!="")
	{
		if(document.invoice.inIssue.value.length > 5 || !(document.invoice.inIssue.value.match(timeExp)))
		{
			alert("Time Must Be Entered as (hh:mm).");
			document.invoice.inIssue.value="";
			document.invoice.inIssue.focus();
			return false;
		}
		if(document.invoice.inIssue.value.length < 5 || document.invoice.inIssue.value.match(timeExp))
		{
			var valiI = document.invoice.inIssue.value;
			if(document.invoice.inIssueAMPM.value=='AM')
			{
				if(valiI.substring(0,2)>12 || valiI.substring(3,5)>59 || valiI.substring(2,3)!=':' || valiI.substring(0,1)==':' || valiI.substring(1,2)==':' || valiI.substring(3,4)==':' || valiI.substring(4,5)==':')
				{
					alert("Time Must Be Entered as (hh:mm).");
					document.invoice.inIssue.value="";
					document.invoice.inIssue.focus();
					return false;
				}
			}
			if(document.invoice.inIssueAMPM.value=='PM')
			{
				if(valiI.substring(0,2)>11 || valiI.substring(3,5)>59 || valiI.substring(2,3)!=':' || valiI.substring(0,1)==':' || valiI.substring(1,2)==':' || valiI.substring(3,4)==':' || valiI.substring(4,5)==':')
				{
					alert("Time Must Be Entered as (hh:mm).");
					document.invoice.inIssue.value="";
					document.invoice.inIssue.focus();
					return false;
				}
			}
		}
	}
	if(document.invoice.inRemoval.value!="")
	{
		if(document.invoice.inRemoval.value.length > 5 || !(document.invoice.inRemoval.value.match(timeExp)))
	    {
			alert("Time Must Be Entered as (hh:mm).");
			document.invoice.inRemoval.value="";
			document.invoice.inRemoval.focus();
			return false;
		}
		if(document.invoice.inRemoval.value.length < 5 || document.invoice.inRemoval.value.match(timeExp))
	    {
			var valiR = document.invoice.inRemoval.value;
			if(document.invoice.inRemovalAMPM.value=='AM')
			{
				if(valiR.substring(0,2)>12 || valiR.substring(3,5)>59 || valiR.substring(2,3)!=':' || valiR.substring(0,1)==':' || valiR.substring(1,2)==':' || valiR.substring(3,4)==':' || valiR.substring(4,5)==':')
				{
					alert("Time Must Be Entered as (hh:mm).");
					document.invoice.inRemoval.value="";
					document.invoice.inRemoval.focus();
					return false;
				}
			}
			if(document.invoice.inRemovalAMPM.value=='PM')
			{
				if(valiR.substring(0,2)>11 || valiR.substring(3,5)>59 || valiR.substring(2,3)!=':' || valiR.substring(0,1)==':' || valiR.substring(1,2)==':' || valiR.substring(3,4)==':' || valiR.substring(4,5)==':')
				{
					alert("Time Must Be Entered as (hh:mm).");
					document.invoice.inRemoval.value="";
					document.invoice.inRemoval.focus();
					return false;
				}
			}
		}
	}
	if(document.invoice.inst.value!="")
	{
		if(!(document.invoice.inst.value.match(alphaExp)))
		{
			alert("Please Enter Valid Destination");
			document.invoice.inst.value="";
			document.invoice.inst.focus();
			return false;
		}

	}

	if(document.invoice.inmode.value!="")
	{
		if(!(document.invoice.inmode.value.match(alphaExp)))
		{
			alert("Please Enter Valid Mode of Dispatch");
			document.invoice.inmode.value="";
			document.invoice.inmode.focus();
			return false;
		}

	}

	if(document.invoice.inpack.value!="")
	{
		if(document.invoice.inpack.value.length > 4)
	    {
			alert("No of Packages is too Long. Enter upto 4 Digits.");
			document.invoice.inpack.value="";
			document.invoice.inpack.focus();
			return false;
	    }
		if(!(document.invoice.inpack.value.match(numericExp)))
		{
			alert("Please Enter valid  Number");
			document.invoice.inpack.value="";
			document.invoice.inpack.focus();
			return false;
		}

	}

	if(confirm("Are you sure? You want to proceed..!!")==true)
	{
		document.getElementById('hdnAct').value="SubmitForm";
		document.getElementById('myaction').value=myaction;
		document.invoice.submit();
	}
}

function Validate1()
{
	if(!(document.invoice.inFright.value.match(floatExp)))
	{
		alert("Please enter valid float number");
		document.invoice.inFright.value=(0).toFixed(2);
		CalAmount();
		document.invoice.inFright.focus();
		return false;
   	}
   	CalAmount();
   	return true;
}

function Validate2()
{
	if(!(document.invoice.inInsurance.value.match(floatExp)))
	{
		alert("Please enter valid float number");
		document.invoice.inInsurance.value=(0).toFixed(2);
		CalAmount();
		document.invoice.inInsurance.focus();
		return false;
   	}
	CalAmount();
   	return true;
}

function Validate3()
{
	if(!(document.invoice.inOthers.value.match(floatExp)))
	{
		alert("Please enter valid float number");
		document.invoice.inOthers.value=(0).toFixed(2);
		CalAmount();
		document.invoice.inOthers.focus();
		return false;
   	}
	CalAmount();
   	return true;
}

function CalAmount()
{
	var temp1=0,ex=0,ed=0,taxex=0,taxed=0,se=0,taxse=0,cst=0,taxcst=0,advance=0,other=0,grandtotal=0,netpayable=0;
	var fright=0,insurance=0,others=0,entry=0,taxTemp=0;

	fright = parseFloat(document.getElementById("inFright").value);
	insurance = parseFloat(document.getElementById("inInsurance").value);
	others = parseFloat(document.getElementById("inOthers").value);
	entry = parseFloat(document.getElementById("inEntryTax").value);

	totalTemp = parseFloat(document.getElementById("inTotalAmount").value);
	taxTemp = parseFloat(document.getElementById("inTaxCharges").value);
	otherTemp = fright + insurance + others + entry+taxTemp;

	grandtotal = totalTemp + otherTemp;
	advance = parseFloat(document.getElementById("inAdvanceEntered").value);
	netpayable = grandtotal - advance;

	document.getElementById("inOtherCharges").value = otherTemp.toFixed(2);
	document.getElementById("inGrandTotal").value = grandtotal.toFixed(2);
	document.getElementById("inNetPayable").value = netpayable.toFixed(2);
}

function CheckAll()
{     alert("ssss"+document.invoice.elements.length);
	for(var i=0;i<document.invoice.elements.length;i++)
	{

		var e=document.invoice.elements[i];
		if ((e.name != 'allbox') && (e.type=='checkbox'))
		{       alert("ssss12");
			e.checked=document.invoice.allbox.checked;
		}

	}
	var countl = document.getElementById('inCount').value;
	for(q=0;q<countl;q++)
	{
		Selected(q);
	}
}

function Adv()
{
	if(document.getElementById('inAdvanceEntered').value=="")
	{
		document.getElementById('inAdvanceEntered').value=(0).toFixed(2);
	}
	else if(!(document.invoice.inAdvanceEntered.value.match(floatExp)))
	{
		alert("Please enter valid float number");
		document.invoice.inAdvanceEntered.value=0.00;
		document.invoice.inAdvanceEntered.focus();
		return false;
	}
	var t13 = parseFloat(document.getElementById("inGrandTotal").value);
	var t14 = parseFloat(document.getElementById("inAdvanceEntered").value);
	var t15 = parseFloat(document.getElementById("inAdvance").value);
	if(t14>t15)
	{
		alert("Entered value is larger than 'Advance Available'");
		document.invoice.inAdvanceEntered.value=0.00;
		document.invoice.inAdvanceEntered.focus();

	}
	if(t14>t13){
		alert("Entered value is larger than 'Net Payable'");
		document.invoice.inAdvanceEntered.value=0.00;
		document.getElementById("inNetPayable").value=t13;
		document.invoice.inAdvanceEntered.focus();
		return false;
	}
	var t14 = parseFloat(document.getElementById("inAdvanceEntered").value);
	document.getElementById("inAdvanceRemain").value = ((t15 - t14)).toFixed(2);
	document.getElementById("inNetPayable").value = ((t13 - t14)).toFixed(2);
	return true;
}

function CSTOVAT()
{

                        var vat=$('#inCSTS').val().trim().toString();

                        if(vat=="CST")
                        {

                            $('#inCSTSval').show();
                            $.get("Invoice.action?getTax", function (result) {
                                            var data=eval(result);
                                                var i3='';
                                                 var i4='';
                                             for (var i = 0;i < data.length; i++) {
                                                  if(i==3 )
                                                 i3=data[i].taxPercentage;
                                                 if(i==4 )
                                                 i4=data[i].taxPercentage;
                                             }
                                var cst=document.getElementById("inCSTSval");
                                              var options=cst.getElementsByTagName("option");
                                                 cst.options[0]=new Option(i3,i4);
                                                 cst.options[1]=new Option(i4,i4);
                                        });

                         $('#t5').hide();
                        }
                           else
                        {
                          $('#inCSTSval').hide();
                        $('#t5').show();
                        }


}
function Selected(s)
{

     var chkid="chkbx"+s;


    var e=document.getElementById(chkid);

    if(e.checked)
    {

    var selectid="inProType"+s;
                     var itemno="inDraw"+s;
                  var cshno="inCsh"+s;
                  var disp="inDisp"+s;




     document.getElementById(itemno).disabled = false;
     document.getElementById(cshno).disabled = false;
     document.getElementById(disp).disabled = false;
     document.getElementById(selectid).disabled = false;
	var tex = parseFloat(document.getElementById("inExcise").value);
    var ted = parseFloat(document.getElementById("inEducationCess").value);
    var tse = parseFloat(document.getElementById("inSec").value);
	var tcst1 = parseFloat(document.getElementById("inCST1").value);
	var tcst2 = parseFloat(document.getElementById("inCST2").value);
	var tovat = parseFloat(document.getElementById("inOVAT").value);
    }
    else
    {

    var selectid="inProType"+s;
                     var itemno="inDraw"+s;
                  var cshno="inCsh"+s;
                  var disp="inDisp"+s;
         var emptyitem=document.getElementById(itemno);
        emptyitem.value="Item No";
      var emptydisp=document.getElementById(disp);
        emptydisp.value="Enter Dispaching Qty";
     var emptycsh=document.getElementById(cshno);
        emptycsh.value="Enter CSH No";
        document.getElementById(itemno).disabled = true;
        document.getElementById(disp).disabled = true;
        document.getElementById(cshno).disabled = true;
        document.getElementById(selectid).disabled = true;
          var calv=parseFloat(document.getElementById("inValue"+s).value);
        calinTotalAmount=calinTotalAmount-calv;

        document.getElementById("inTotalAmount").value=calinTotalAmount;
        document.getElementById("inValue"+s).value="0.0";
    }

}


var calinTotalAmount =0.0;//parseFloat(document.getElementById("inTotalAmount").value);

function CalculateAmount(d)
{
    var totalamount=0;

    var inDisp="inDisp"+d;
    var calinDisp = parseFloat(document.getElementById(inDisp).value);
    var inProdCost="inProdCost"+d;
        var calinProdCost = parseFloat(document.getElementById(inProdCost).value);

    var inRemQty="inRemQty"+d;
    var calinRemQty = parseFloat(document.getElementById(inRemQty).value);

    var inProdCost="inProdCost"+d;
    var calinProdCost = parseFloat(document.getElementById(inProdCost).value);
    var inValue="inValue"+d;
var calinValue = parseFloat(document.getElementById(inValue).value);
    if(parseFloat(calinDisp) > parseFloat(calinRemQty)){
            alert("Dispatching Quantity cannot be greater than remaining quantity");

            $('#'+inValue).val("0.0");
            $('#'+inDisp).val("Enter Dispaching Qty");

            }
    else
    {


         calinValue=calinDisp * calinProdCost;
         calinTotalAmount=calinTotalAmount +calinValue;

         $('#'+inValue).val(calinValue);
         $('#inTotalAmount').val(calinTotalAmount);

    }
 var dropdownname=$("#inProType"+d+" option:selected").text().trim().toString();

var inCal = "inCal"+d;
    var calinCal = parseFloat(document.getElementById(inCal).value);

	var pdctwghtorqty='productwghtorqty'+d;
	var def = 'inProType'+d;

	var mno,strtemp;
	strtemp='amndFlag'+d;
	if(document.getElementById(strtemp).value=="t")
	{
		mno = 'inCosth'+d;
	}
	else
	{
		mno = 'inamndCosth'+d;
	}
	var pqr = 'inAmount'+d;
	var uvw = 'inExch'+d;
	var xyz = 'inRemQty'+d;
	var xyzh = 'inRemQtyh'+d;
	var amdntqty='inRemQtyamd'+d;
		if(parseFloat(document.getElementById(abc).value)>parseFloat(document.getElementById(amdntqty).value)){
		alert("Dispatching Quantity cannot be greater than remaining quantity");
		document.getElementById(abc).value="";
		document.getElementById(abc).focus();
		}

	var tex = parseFloat(document.getElementById("inExcisetax").value);
	var ted = parseFloat(document.getElementById("inEducationCesstax").value);
	var tse = parseFloat(document.getElementById("inSectax").value);
	var tcst1 = parseFloat(document.getElementById("inCST1tax").value);
	var tcst2 = parseFloat(document.getElementById("inCST2tax").value);
	var tovat = parseFloat(document.getElementById("inOVATtax").value);
	var productwghtorqty=document.getElementById(pdctwghtorqty).value;
	var dispatchedQuantity=document.getElementById(abc).value;
	if(productwghtorqty=="perkg")
		{
		dispatchedQuantity=document.getElementById(abc).value*1000;
		}

	document.getElementById(xyz).value = parseFloat(document.getElementById(xyzh).value - dispatchedQuantity).toFixed(2);

	if(document.getElementById(def).value=="Fabrication" || document.getElementById(def).value=="Reimbursement")
	{
		document.getElementById(pqr).value = (parseFloat(document.getElementById(mno).value) * dispatchedQuantity).toFixed(2);
	}
	else if(document.getElementById(def).value=="Sale" || document.getElementById(def).value=="MFG & Supply" || document.getElementById(def).value=="None" )
	{
		var pType = parseFloat(document.getElementById(mno).value) * dispatchedQuantity;
		var exc = Math.round((pType * tex)/100);
		document.getElementById(uvw).value = exc;
		document.getElementById(pqr).value = pType.toFixed(2);
	}
	var temp3 = 0;
	var temp4 = parseFloat(document.getElementById(pqr).value);
	var exc = 0;

	var lcount = document.getElementById('inCount').value;
	for(p=0;p<lcount;p++)
	{
		var temp5 = 'inAmount'+p;
		var temp6 = 'inProType'+p;
		var temp7 = 'inExch'+p;
		temp3 = temp3 + parseFloat(document.getElementById(temp5).value);
		if(document.getElementById(temp6).value=="Sale" || document.getElementById(temp6).value=="MFG & Supply" || document.getElementById(temp6).value=="None")
		{
			exc = exc + parseFloat(document.getElementById(temp7).value);
		}
		else
		{
			document.getElementById(temp7).value = (0).toFixed(2);
		}
	}
	document.getElementById("inTotalAmount").value = temp3.toFixed(2);
	var t1 = parseFloat(document.getElementById("inTotalAmount").value);
	document.getElementById("inExcise").value = (exc).toFixed(2);
	var t2 = parseFloat(document.getElementById("inExcise").value);
	var toentrytax = parseFloat(document.getElementById("inentrytaxhdn").value);
	document.getElementById("inEducationCess").value = Math.round(((t2 * ted)/100)).toFixed(2);
	var t3 = parseFloat(document.getElementById("inEducationCess").value);
	document.getElementById("inSec").value = Math.round(((t2 * tse)/100)).toFixed(2);
	var t4 = parseFloat(document.getElementById("inSec").value);

	if(document.getElementById("inCSTS").value=="OVAT")
	{
		document.getElementById("inCST").value = Math.round((((t1+t2+t3+t4) * tovat)/100)).toFixed(2);
		var t6 = parseFloat(document.getElementById("inCST").value);
		document.getElementById("inEntryTax").value = Math.round((((t1+t2+t3+t4+t6) * toentrytax)/100)).toFixed(2);
	}
	else if(document.getElementById("inCSTS").value=="CST")
	{
		document.getElementById("inEntryTax").value = (0).toFixed(2);
		if(document.getElementById("inCSTTaxS").value==tcst1)
		{
			document.getElementById("inCST").value = Math.round((((t1+t2+t3+t4) * tcst1)/100)).toFixed(2);
		}
		else if(document.getElementById("inCSTTaxS").value==tcst2)
		{
			document.getElementById("inCST").value = Math.round((((t1+t2+t3+t4) * tcst2)/100)).toFixed(2);
		}
	}
	var t5 = parseFloat(document.getElementById("inCST").value);
	document.getElementById("inTaxCharges").value = (t2+t3+t4+t5).toFixed(2);
	var t7 = parseFloat(document.getElementById("inTaxCharges").value);
	var t8 = parseFloat(document.getElementById("inEntryTax").value);
	var t9 = parseFloat(document.getElementById("inFright").value);
	var t10 = parseFloat(document.getElementById("inInsurance").value);
	var t11 = parseFloat(document.getElementById("inOthers").value);
	document.getElementById("inOtherCharges").value = ((t8+t9+t10+t11+t7)).toFixed(2);
	var t12 = parseFloat(document.getElementById("inOtherCharges").value);
	document.getElementById("inGrandTotal").value = ((t1+t12)).toFixed(2);
	var t13 = parseFloat(document.getElementById("inGrandTotal").value);
	var t14 = parseFloat(document.getElementById("inAdvanceEntered").value);
	document.getElementById("inNetPayable").value = ((t13 - t14)).toFixed(2);
}



</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

 <s:useActionBean beanclass="com.inwise.action.InvoiceActionBean" var="invoiceBean" event="pre" ></s:useActionBean>


 <s:layout-render name="/layout/_base.jsp">
      <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.InvoiceActionBean">
   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
 <tr valign="top"><td >&nbsp;
 </td></tr>
 <tr><td align="left" class="pageheading" valign="top">
Generate Invoice
 </td></tr>
 <tr valign="top"><td align="center">&nbsp;
 </td></tr>
 </table>
  <table width="70%"  border="1"  cellspacing="0" cellpadding="0"   align="left" bgcolor="#FCFCFC"  >
  <tr>
    <td align="left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">

 	<tr>
			<td colspan="4" align="left">
				<div align="left" style="margin-left:15px;" class="labels">
					Please Enter Order Details ::				</div>			</td>
		</tr>

		<tr>
			<td width="19%" align="right" valign="top">
			  <div align="right"  class="labels">
			    Customer Name				</div>			</td>
	  <td width="27%" align="left" valign="top">
          <s:select id="incname"  name="incname" class="dropdown" onchange="getCustomerOrder()">
                <option  value="0">---Select Customer Name---</option>
                <c:forEach items="${invoiceBean.customerlst}" var="orderloop" varStatus="loop" >
                    <c:choose>
                        <c:when test="${invoiceBean.order.customer.id eq orderloop.id}">
                            <option value ="<c:out value="${invoiceBean.order.customer.id}"/>" selected="selected"> <c:out value="${invoiceBean.order.customer.name}"/></option>
                        </c:when>
                        <c:otherwise>
                            <option value ="<c:out value="${orderloop.id}"/>"> <c:out value="${orderloop.name}"/></option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </s:select>
     <%--<s:select id="incname" name="incname" class="dropdown" onchange="getCustomerOrder()">
                        <option  value="0">---Select Customer Name---</option>
              <c:forEach items="${invoiceBean.orderlst}" var="orderloop" varStatus="loop" >
                      <option value ="${orderloop.customer.id}"><c:out value="${orderloop.customer.name}"/></option>
    	      </c:forEach>
            </s:select>--%>
  <%--<s:select   id="incname" class="dropdown" name="incname" style="width:185px; margin-left:0px;" onchange="return getCustomerOrder()">
    <option value="0">---Select Customer Name---</option>


      <c:forEach items="${invoiceBean.orderlst}" var="orderloop" varStatus="loop" >

           <option value ="<c:out value="${orderloop.customer.id}"/>"> <c:out value="${orderloop.customer.name}"/></option>   </c:forEach>

  </s:select>		--%>	</td>
          <td width="15%" align="right" valign="top">&nbsp;</td>
            <td width="39%">&nbsp;</td>
		</tr>

		<tr>
			<td width="19%" align="right" valign="top">
            <div align="right">
            <span class="labels" style="margin-left:15px;">Customer Order No.</span></div></td>
	  <td width="27%" align="left" valign="top">
              <s:select id="inoid" name="id" class="dropdown" onchange="getOrderDetail()">
                             <option  value="0">---Select Customer Order No---</option>
                        </s:select>
  <%--<s:select class="dropdown"  id="inoid" name="id" style="width:185px; margin-left:0px;" onchange="return getOrderDetail()">
    <option value="0"> ---Select Customer Order No--- </option>
    </s:select>--%><input type="hidden" name="sendorderid" id="sendorderid" value="">
	    </td>
			<td width="15%" align="right" valign="top"  >
			 <s:submit name="getOrderDetail" id="getOrderDetail"  value="Get"/>		</td>
	  <td align="left" valign="top" style="margin-left:10px;" >
			 <span style="display:none;"  id="custorno" >${invoiceBean.order.customerOrderNo}</span>
			 <span style="display:none;"  id="custodid" >${invoiceBean.id}</span>
			</td>
		</tr>
       </s:form>
           </table>
           <c:if test="${actionBean.order!=null}">
                     <script type="text/javascript">
                        $(document).ready(function() {
                            var oo=$('#custorno').html();
                            var oid=$('#custodid').html();


                            var ooid=document.getElementById("inoid");
                            var options=ooid.getElementsByTagName("option");

                            ooid.options[1]=new Option(oo,oid,false,true);

                         $.get("order?InvoiceToAddressAjax",{id:$('#custodid').html()}, function (result) {
                var data=eval(result);

                var options='';

                    options += data.line1+","+ data.line2+","+ data.city+"-"+data.zip ;

                $("#invoiceAddress").html(options);



            });
            $.get("order?ShipmentToAddressAjax",{id:$('#custodid').html()}, function (result) {
                var data=eval(result);

                var options='';

                    options += data.line1+","+ data.line2+","+ data.city+"-"+data.zip ;


                $("#shipmentAddress").html(options);


            });
              $.get("Invoice.action?getTax", function (result) {
                var data=eval(result);

                  $('#inCSTSval').hide();
                  var options='';
                 for (var i = 0; i <= 6; i++) {


                     $("#t"+i+"").html(data[i].taxPercentage);

                 }



            });



                         });

                     </script>
                  <s:form beanclass="com.inwise.action.InvoiceActionBean">
          <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">


		<tr >
			<td align="left" valign="top" colspan="4">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
           <tr>
                <td>
               <div align="right" style="margin-left:15px;" class="labels">
			    Order Date 				</div>
			</td>
	 		<td width="25%" align="left" valign="top">
			<div align="left">

				<%
					String sst = null,stt=null;

							/*	sst = (inrowData41[2].toString()).substring(0,10);
								stt = sst.substring(8,10)+"/"+sst.substring(5,7)+"/"+sst.substring(0,4);*/
					%>
					<s:text  value="<%= stt %>" name="order.createDate" id="inodate" size="8" style="border:0px;background-color:#FCFCFC;" class="textbox"  readonly="readonly" />

				</div>
            </td>
		 	<td width="19%">&nbsp;

			</td>

			<td align="left" style="margin-left:10px;">&nbsp;

			</td>
		</tr>
            <tr>
                <td>
                <div align="right">
				<span class="labels" style="margin-left:15px;">
					Amendment No.
				</span></div>
			</td>
	 		<td width="24%" align="left" valign="top">
				<s:text name="order.amendmentNo" id="txtamndNo" readonly="readonly" class="textbox"  style="border:0px;background-color:#FCFCFC;"/>
            </td>
		 	<td width="19%">
		  		<div align="right" style="margin-left:15px;" class="labels">
					Amendment Date
				</div>
			</td>

			<td align="left" style="margin-left:10px;">
				<div align="left">
					<s:text name="order.amendmentDate" id="txtamnddate" class="textbox" size="8" style="border:0px;
													background-color: #FCFCFC;" readonly="readonly"/>
				</div>
			</td>
		</tr>





		<tr>
        	<td align="right" valign="top">
            	<div align="right" style="margin-left:15px;" class="labels">
					Sales Rep. Code.				</div>			</td>
		  <td colspan="2" align="left" valign="top">
				<s:text name="insrepcode" id="insrepcode" type="text" class="textbox" readonly="readonly" style="border:0px;background-color:#FCFCFC;"
											   size="9"/>			</td>
		</tr>

		<tr>
			<td width="18%" align="right" valign="top">
			  <div align="right"  style="margin-bottom:20px;margin-left:15px;" class="labels">
			    Invoice To				</div>			</td>
	  <td width="24%" align="left" valign="bottom">


					<s:textarea readonly="readonly"  name="sdfs"  id="invoiceAddress"  style="height: 100px; width:180px;resize:none;border:1px solid #FFCC66"/>

							</td>
			<td width="19%" align="right" valign="top">
			  <div align="right" style="margin-bottom:20px;margin-left:15px;" class="labels">
			    Consignee					</div>				</td>
  <td width="39%" align="left" valign="bottom">
  <div align="left"><s:textarea readonly="readonly" name="zfa" id="shipmentAddress" style="height: 100px; width:180px;resize:none;border:1px solid #FFCC66" />


  </div>				</td>
	  </tr>

			<tr>
				<td>&nbsp;				</td>
			</tr>
			<tr>
				<td align="left" colspan="2">
					<div align="left" style="margin-left:15px;" class="labels">
						<b style="color:#888888;">(&nbsp;&nbsp;) fields are mandatory</b>					</div>
					<div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:-10px; margin-left:19px;">
						*					</div>				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4">

					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center" width="4%" style="border-right:1px solid #000000; border-left:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<s:checkbox name="allbox" id="allbox" value="chekbx" onclick="jqCheckAll1('chkbx');"/>
							</td>
							<td nowrap="nowrap" width="5%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; margin-left:1px; margin-right:1px; font-size: 11px;" class="labels">
									<b>ITEM NO.</b>
									<br>&nbsp;
								</div>
							</td>
							<td nowrap="nowrap" width="9%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px;  margin-left:1px; margin-right:1px; font-size: 11px;" class="labels">
									<b>TARIFF ITEM No.</b>
									<br>&nbsp;
								</div>
							</td>
							<td width="10%" nowrap="nowrap" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels">
									<b>Product Name</b>
									<br>&nbsp;
								</div>
							</td>
							<td nowrap="nowrap" width="11%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels">
									<b>Product Type</b>
									<br>&nbsp;
								</div>
							</td>
							<td nowrap="nowrap" width="6%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels">
									<b>Ordered<br>Quantity</b>
								</div>
							</td>
 							<td nowrap="nowrap" width="9%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels">
									<b>Remaining<br>Quantity</b>
								</div>
							</td>

							<td nowrap="nowrap" width="8%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels">
									<b>Product<br>Rate</b>
								</div>
							</td>
							<td nowrap="nowrap" width="7%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels">
									<b>Amendment<br>Quantity</b>
								</div>
							</td>
							<td nowrap="nowrap" width="9%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels">
									<b>Amendment<br> Product<br>
Rate</b>
								</div>
							</td>
							<td nowrap="nowrap" width="11%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels">
									<b>Dispatching<br>Quantity</b>
								</div>
							</td>
							<td nowrap="nowrap" width="11%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels">
									<b>Assessable Value</b>
									<br>&nbsp;
								</div>
							</td>
						</tr>
                          <c:forEach items="${invoiceBean.order.orderDetail}" var="orderdetailarray" varStatus="loop" >
						<tr>
							<td align="center" valign="top" style="border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px;">
								<div style="margin-top:5px;">

									<s:checkbox name="chkbx" id="chkbx${loop.index}" onClick="return Selected(${loop.index});"/>
								</div>
							</td>
							<td valign="top"  style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:5px; margin-right:3px; font-size: 12px;" class="labels">
									<%--<input  name="orderdetailarray[${loop.index}].product.name" id="inDraw${loop.index}" type="text" size="5" disabled="disabled" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;" value="Item No" onFocus="if(this.value=='Item No'){this.value='';}" >--%>
								<s:text  id="inDraw${loop.index}" value="Item No" onFocus="if(this.value=='Item No'){this.value='';}"  name="invoice.invoiceDetail[${loop.index}].drawingNo" disabled="disabled" size="15" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
								</div>
							</td>
							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:5px; margin-right:3px; font-size: 12px;" class="labels">
								<s:text  id="inCsh${loop.index}" value="Enter CSH No" onFocus="if(this.value=='Enter CSH No'){this.value='';}"  name="invoice.invoiceDetail[${loop.index}].cshNo" disabled="disabled" size="15" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
								</div>
							</td>
							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="left" style="margin-top:5px; margin-bottom:5px; margin-right:3px;  margin-left:3px; font-size: 12px;" class="labels">
							    <s:text name="orderdetailarray[${loop.index}].product.productName" value="${orderdetailarray.product.productName}"  id="inDraw${loop.index}" size="15" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
								</div>
							</td>
							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="left" style="margin-top:5px; margin-bottom:5px; margin-right:1px;  margin-left:1px; font-size: 12px;" class="labels">
									<s:select id="inProType${loop.index}" name="inProType" disabled="disabled" style="width:100px; margin-left:0px; font-size: 12px;" onChange="javascript: CalculateAmount(${loop.index});">
										<option value="MFG & Supply">MFG. & Supply</option>
										<option value="Sale">Sale</option>
										<option value="Fabrication">Fabrication</option>
										<option value="Reimbursement">Reimbursement</option>
										<option value="None">None</option>
									</s:select>
								</div>
							</td>

							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">

								<div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
							      <s:text name="orderdetailarray[${loop.index}].orderedQuantity" value="${orderdetailarray.orderedQuantity}" id="inOrdQty${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>

                                </div>

							</td>
   							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
								<s:text name="orderdetailarray[${loop.index}].remainingQuantity" value="${orderdetailarray.remainingQuantity}" id="inRemQty${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
                                </div>
							</td>

							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="right"   style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
                                <s:text name="orderdetailarray[${loop.index}].product.productCost" value="${orderdetailarray.product.productCost}" id="inProdCost${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>

                                    <c:if test="${orderdetailarray.product.productMeasurementType.measurementType eq 'MT'}">
                                        <span id="mtype${loop.index}" style="margin-top:0px ; border:0px; text-align:right; background-color: #ccffcc; font-size: 12px;">MT</span>
                                    </c:if>
                                    <c:if test="${orderdetailarray.product.productMeasurementType.measurementType eq 'unit'}">
                                        <span id="utype${loop.index}" style="margin-top:0px ; border:0px; text-align:right; background-color: #ccffcc; font-size: 12px;">unit</span>
                                    </c:if>
                                </div>
							</td>
							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
								    <s:text name="orderdetailarray[${loop.index}].amendmentQuantity" value="${orderdetailarray.amendmentQuantity}" id="inAmdQty${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>

								</div>
							</td>
							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
							<div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
									<s:text name="orderdetailarray[${loop.index}].amendmentCost" value="${orderdetailarray.amendmentCost}" id="inAmdCost${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
								</div>
							</td>

							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="left" style="margin-top:5px; margin-bottom:5px; margin-right:1px; margin-left:1px; font-size: 12px;" class="labels">
                            			<s:text name="orderdetailarray[${loop.index}].dispatchedQuantity" value="Enter Dispaching Qty" id="inDisp${loop.index}" size="20" onFocus="if(this.value=='Enter Dispaching Qty'){this.value='';}"
                                                disabled="disabled" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;" onchange="javascript: CalculateAmount(${loop.index});"/>
                                </div>

							</td>

							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
                                			<s:text name="avalue[${loop.index}]" value="0.0" id="inValue${loop.index}" size="20" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
                        		<s:hidden name="inCount" id="inCount" value="${loop.index}"/>								</div>							</td>
						</tr>
                              <c:if test="${loop.last}">
                                 <span style="visibility:hidden;" id="inCount">${loop.count}</span>
                              </c:if>

                      </c:forEach>
						<tr>


							<td>&nbsp;<%--<s:hidden name="inCount" id="inCount" value="${loop.index}"/>--%>

                            </td>
							<td>&nbsp;							</td>
							<td>&nbsp;							</td>
							<td>&nbsp;							</td>
							<td>&nbsp;							</td>
							<td>&nbsp;							</td>
							<td>&nbsp;							</td>
							<td>&nbsp;							</td>
                            	<td>&nbsp;							</td>
							<td colspan="2"  nowrap style="border-right:1px solid #000000">
					        	<div align="center" class="labels">
									<b>Total Amount ( A )</b>								</div>							</td>
							<td style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">

								<div align="right" style="color: #ff0000; font-family: Verdana; font-size:10px; margin-right:3px;">
									<s:text name="inTotalAmount" id="inTotalAmount"  size="11"  readonly="readonly" value="0.00" style="margin-top:0px ; border:0px; text-align:right;"/>
								</div>							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="left" colspan="2">
					<div align="left" style="margin-left:15px;" class="labels">
						<b style="color:#888888">Taxes are applicable on ' Total Amount + Other Charges '</b>					</div>				</td>
			</tr>

			<tr>
				<td>&nbsp;				</td>
			</tr>

			<tr>
	            <td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						Excise @ <span id="t0"></span>%				</div>				</td>
              <td align="left" valign="top">
					<s:text name="inExcise" id="inExcise" class="textbox" value="0.00"  size="22" readonly="readonly" style="text-align:right;" />
					<s:hidden name="inExcisetax" id="inExcisetax"  size="5" readonly="readonly"/>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Education_Cess @ <span id="t1"></span>%				</div>				</td>
			  <td align="left" valign="top">
					<div align="left">
						<s:text name="inEducationCess" class="textbox" id="inEducationCess"  size="22" readonly="readonly" style="text-align:right;" value="0.00"/>
						<s:hidden name="inEducationCesstax" id="inEducationCesstax"  size="5" readonly="readonly"/>
					</div>				</td>
			</tr>

			<tr>
            	<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Secondary & Higher Edu_Cess @ <span id="t2"></span>	% </div>				</td>
              <td align="left">
					<s:text name="inSec" id="inSec" class="textbox"  size="22" readonly="readonly" style="text-align:right;" value="0.00"/>
					<s:hidden name="inSectax" id="inSectax"  size="5" readonly="readonly"/>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						<s:select name="inCSTS" id="inCSTS"  class="dropdown" style="width:70px; margin-left:0px; font-size: 12px;" onchange="CSTOVAT();">
										<option value="OVAT">OVAT</option>
										<option value="CST">CST</option>
						</s:select>

                        @
                        <s:select name="inCSTSval" id="inCSTSval"  class="dropdown" style="width:70px; margin-left:0px; font-size: 12px;">


						</s:select>
                        <span id="t5"></span> %

						<div id="ovatid" style="display: inline;">

						</div>
					<%--	<select name="inCSTTaxS" id="inCSTTaxS" style="width:45px; margin-left:0px; font-size: 12px; display: none;" onChange="javascript: CSTOVAT();">
										<option value="<%= cst1 %>">
											<%= cst1 %>										</option>
										<option value="<%= cst2 %>">
											<%= cst2 %>										</option>
						</select>--%>

											</div>				</td>
              <td align="left" valign="top">
					    <s:text name="inOvatnCst" id="inOvatnCst" class="textbox"  size="22" readonly="readonly" style="text-align:right;" value="0.00"/>
							</td>
			</tr>

			<tr>
				<td>&nbsp;				</td>
				<td>&nbsp;				</td>
				<td align="right" valign="top" nowrap>
					<div align="right" style="margin-left:15px;" class="labels">
						<b>Tax Charges ( B )<br> (Sum of Taxes)</b>					</div>				</td>
			  <td colspan="3" align="left" valign="top" >
					<s:text name="inTaxCharges" id="inTaxCharges"   size="22"  style="text-align:right; "  class="textbox" readonly="readonly" value="0.00"/>				</td>
			</tr>

			<tr>
				<td align="right" valign="top">
                	<div align="right" style="margin-left:15px;" class="labels">
						Entry Tax (Appl. for OVAT) @<span id="t6"></span> %
					</div>
				</td>
                <td align="left" valign="top">
					<s:text name="inEntryTax" class="textbox" id="inEntryTax"  value="0.00" readonly="readonly" size="22" style="text-align:right;"/>
				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Freight
					</div>
				</td>
                <td align="left">
					<div align="left">
						<s:text name="inFright" class="textbox" id="inFright"  value="0.00" size="22" onChange="return Validate1();" style="text-align:right;"/>
					</div>
				</td>
			</tr>

			<tr>
            	<td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						Insurance
					</div>
				</td>
                <td align="left" valign="top">
					<s:text name="inInsurance" class="textbox" id="inInsurance"  value="0.00" size="22" onChange="return Validate2();" style="text-align:right;"/>
				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Others
					</div>
				</td>
                <td align="left">
					<div align="left">
						<s:text name="inOthers" id="inOthers" class="textbox"  value="0.00" size="22" onChange="return Validate3();" style="text-align:right;"/>
					</div>
				</td>
			</tr>

			<tr>
				<td>&nbsp;

			    </td>
				<td>&nbsp;

			    </td>
				<td nowrap>
					<div align="right" style="margin-left:15px;" class="labels">
						<b>Other Charges ( C )</b>
					</div>
				</td>
				<td align="left" colspan="3" >
					<s:text name="inOtherCharges" id="inOtherCharges"  class="textbox" type="text" size="22" readonly="readonly" value="0.00"  style="text-align:right;"/>
				</td>
			</tr>

			<tr>
				<td>&nbsp;

				</td>
			</tr>
			<tr>
				<td colspan="4">
					<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
						<tr>
							<td width="5%" nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-top: 1px solid #000000;">
								<div align="center" class="labels">
									<b><u>Grand Total ( A+B+C )</u></b>								</div>							</td>
							<td width="2%" align="left" valign="top">
								<div align="center" class="labels" style="margin-top:10px;">
									<b>_</b>								</div>							</td>
							<td width="8%" nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-top: 1px solid #000000;">
								<div align="center" class="labels">
								<%--	<b><u>Advance Available</u> &nbsp;</b>
									<img src="images/Rupee.JPG"></img>&nbsp;
									<% double ddd2 =  (Double)advAmount; DecimalFormat dff2 = new DecimalFormat("0.00");%>
									<input name="inAdvance" id="inAdvance" size="11" type="text" readonly="readonly" style="border:0px; text-align:right;"
											value="<%= dff2.format(ddd2) %>">--%>
								</div>
							</td>
							<td width="2%" align="left" valign="top">
								<div align="center" class="labels" style="margin-top: 17px;">
									<b>=</b>								</div>							</td>
							<td width="5%" nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-top: 1px solid #000000;">
								<div align="center" class="labels">
									<b><u>Net Payable</u></b>								</div>							</td>
						</tr>
						<tr>
							<td nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
								<div align="center">

									<s:text name="inGrandTotal" id="inGrandTotal"  class="textbox" size="15"  readonly="readonly" style="border:0px; text-align:right;background-color:#FCFCFC;" value="0.00"/>
								</div>
							</td>
							<td align="left" valign="top">
							</td>
							<td nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000;">
								<div align="center" class="labels">
									<b><u>Deduct Advance</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>

									<s:text name="inAdvanceEntered" class="textbox" id="inAdvanceEntered"  value="0.00" size="11" style="text-align:right;" onFocus="if(this.value==''){this.value='0.00';}" onChange="return Adv();if(this.value==''){this.value='0.00';}"/>
								</div>
							</td>
							<td align="left" valign="top">
							</td>
							<td nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
								<div align="center">

									<s:text name="inNetPayable" class="textbox" id="inNetPayable" size="15"  readonly="readonly" style="border:0px; text-align:right;background-color:#FCFCFC;" value="0.00"/>
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;

							</td>
							<td>&nbsp;

							</td>
							<td nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
								<%--<div align="center" class="labels" style="margin-top: 10px;">
									<b><u>Advance Remain</u>&nbsp;&nbsp;&nbsp;&nbsp;</b>
								&nbsp;&nbsp;
									<input name="inAdvanceRemain" id="inAdvanceRemain" type="text" value="<%= dff2.format(ddd2) %>" size="11" readonly="readonly" style="border:0px; text-align:right;">
								</div>--%>&nbsp;
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td>&nbsp;				</td>
			</tr>
			<tr>
				<td align="right" valign="top">
                	<div align="right" style="margin-left:15px;" class="labels">
						Issue Time					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="inIssue" id="inIssue" class="textbox"  size="12" style="text-align:right;"/>
						<s:select name="inIssueAMPM" class="dropdown" id="inIssueAMPM" style="width:58px; margin-left:0px;">
							<option value="AM">
								AM							</option>
							<option value="PM">
								PM							</option>
						</s:select>					</div>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Removal Time					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="inRemoval" class="textbox"  id="inRemoval" type="text" size="12" style="text-align:right;"/>
						<s:select name="inRemovalAMPM" class="dropdown" id="inRemovalAMPM" style="width:58px; margin-left:0px;">
							<option value="AM">
								AM							</option>
							<option value="PM">
								PM							</option>
						</s:select>					</div>				</td>
			</tr>

			<tr>
				<td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						Station from					</div>				</td>
			  <td align="left">
					<s:text name="insf" id="insf"  class="textbox" value="Kansbahal" size="22" style="border:0px;
											background-color:#FCFCFC;" readonly="readonly"/>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Station To					</div>				</td>
			  <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="inst" class="textbox"  id="inst"  size="22" value=""/>				</div>				</td>
			</tr>

			<tr>
				<td align="right" valign="top">
                	<div align="right" style="margin-left:15px;" class="labels">
						Des Adv No.					</div>				</td>
              <td align="left">
						<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
							<s:text name="indesno" class="textbox"  id="indesno"  value="" size="22"/>					</div>					</td>
					<td>
						<div align="right" style="margin-left:15px;" class="labels">
						FGN No.					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="infgnno" class="textbox"  id="infgnno"  value="" size="22"/>				</div>				</td>
			</tr>
            <tr>
            	<td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						Mode of Dispatch					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="inmode" id="inmode"  value="" size="22" class="textbox" />					</div>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Vehicle No.					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="invehicle" id="invehicle" type="text" value=""  size="22" class="textbox" />					</div>				</td>
			</tr>
            <tr>
				<td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						No. of Packages					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="inpack" id="inpack"  value="" class="textbox"  size="22" style="text-align:right;"/>				</div>				</td>
			</tr>

			<%-- <tr>
				<td>
					<div align="left" style="margin-left:15px;" class="labels">
						Debit Entry No.					</div>				</td>
                <td width="3%" align="center" valign="top">
<div align="center" class="labels">
						<b>:</b>					</div>				</td>
<td align="left">
					<div align="left">
						<input name="inDebitEntry" id="inDebitEntry" type="text" value="" size="22">
					</div>				</td>
				<td>
					<div align="left" style="margin-left:15px;" class="labels">
						Date					</div>				</td>
                <td width="3%" align="center" valign="top">
<div align="center" class="labels">
			  <b>:</b> </div>				</td>
<td align="left">
					<div align="left">
	<input type="text" readonly="readonly" size="22" name="inDebitEntryDate" id="inDebitEntryDate" <% if(d1!=null){ %> value="<%= d1 %>" <% } %>>
											</div>				</td>
			</tr> --%>
			<tr>
				<td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						Region & BR A/C Code					</div>				</td>
			  <td align="left">
					<div align="left">
						<s:text name="inbrcode" id="inbrcode" class="textbox"   value="" size="22"/>
					</div>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Contract Note No. & Date					</div>				</td>
              <td align="left">
					<div align="left">
						<s:text name="incontract" id="incontract" class="textbox"   value="" size="22"/>
					</div>				</td>
			</tr>
            <tr>
				<td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						RR/GCN No.						</div>					</td>
			  <td align="left">
							<div align="left">
								<s:text name="inrrgcn" id="inrrgcn" class="textbox"   value="" size="22"/>
						</div>						</td>
					<td>
						<div align="right" style="margin-left:15px;" class="labels">
							Documents Through							</div>						</td>
              <td align="left">
							<div align="left">
						  		<s:text name="inDocuments" class="textbox"  id="inDocuments"  value="" size="22"/>
			  	        </div>						</td>
				</tr>
					<tr>
				<td>&nbsp;				</td>
			</tr>
				<tr>
					<td valign="top">
				  <div align="right" style="margin-left:15px;" class="labels">
				  Remarks						</div>					</td>
				  <td align="left" colspan="3">

						<s:textarea name="inremark" wrap="off" id="inremark" style="height: 60px; width:694px;border:1px solid #FFCC66; text-align: left;resize:none"/>
												</td>
					</tr>
				  	<tr>
						<td>&nbsp;						</td>
					</tr>
					<tr>
						<td>&nbsp;						</td>
                        <td align="left" colspan="2">
							<s:hidden  name="hdnAct" id="hdnAct" value=""/>
							<input type="button" value="Preview" class="buttons" name="inpreview" id="inpreview"  style="width:80px; margin-left: 60px;" onClick="return ValidateInvoice('Preview');">

							<input type="button" value="Generate" class="buttons" name="ingenerate" id="ingenerate" style="width:80px; margin-left: 20px;" onClick="return ValidateInvoice('Print');">
													&nbsp;&nbsp;
							<input type="button" value="Cancel" class="buttons" name="Cancel" style="width:80px; margin-left: 10px;" onClick="javascript: cancel();">
						</td>

				</tr>    </table></td></tr>
</table>

 </s:form>
          </c:if>

</s:layout-component>
 </s:layout-render>
