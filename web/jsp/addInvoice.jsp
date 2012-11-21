<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 11, 2012
  Time: 11:46:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen" />
<link rel="stylesheet" href="css/jquery-ui-1.8.16.custom.css" type="text/css" media="screen" />
<%--<c:set var = "TR1" value="invoicereceipt"/>
<c:if test="${actionBean.hiddenvalue eq TR1}">
    <script type="text/javascript">
        function OpenPopup(){
            var w = 900;
            var h = 700;
            var winl = (screen.width-w)/2;
            var wint = (screen.height-h)/2;
            if (winl < 0) winl = 0;
            if (wint < 0) wint = 0;
            var page = "invoice?redirectorderpopup=&id="+${actionBean.id}+"";
            windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no," + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
            window.open(page, "Popup", windowprops);
            return;
        }
        window.onLoad =OpenPopup();
    </script>
</c:if >--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<s:useActionBean beanclass="com.inwise.action.InvoiceActionBean" var="invoiceBean" event="pre" ></s:useActionBean>
<%--<%request.setAttribute("prodlst",invoiceBean.getProductcategory());%>--%>

<s:layout-render name="/layout/_base.jsp">

<s:layout-component name="head">
<%--<script type="text/javascript">--%>
<%--
    var t1=0.0;var t2=0.0;var t3=0.0;var t4=0.0;var t5=0.0;var t6=0.0; var t7=0.0;var taxloop=0.0;
    var calinTotalAmount =0.0;//parseFloat(document.getElementById("inTotalAmount").value);
    var calinFright=0.0;
    var calinInsurance=0.0;
    var calinOthers=0.0;
    var calinGrandTotal=0.0;
    var calinNetPayable=0.0;
    var calinAdvance=0.0;
    var inTaxChargesTax=0.0;
    var inOtherChargesTax=0.0;
    var inExciseTax=0.0;
    var inEducationCessTax=0.0;
    var inSecTax=0.0;
    var inOvatnCstTax=0.0;
    var inEntryTaxT=0.0;
    var dropdownname='';
    var floatExp = /^[0-9.]+$/;
     $(document).ready(function() {
         $('#inCSTSval').hide();
         $.get("invoice?getTax", function (result) {
                var data=eval(result);
                  taxloop=data.length;
                 for (var i = 0; i <= data.length; i++) {
                            if(i==0){t1=data[i].taxPercentage;$("#t"+1+"").html(t1);}
                            if(i==1){t2=data[i].taxPercentage;$("#t"+2+"").html(t2);}
                            if(i==2){t3=data[i].taxPercentage;$("#t"+3+"").html(t3);}
                            if(i==3){t4=data[i].taxPercentage;$("#t"+4+"").html(t4);}
                            if(i==4){t5=data[i].taxPercentage;$("#t"+5+"").html(t5);}
                            if(i==5){t6=data[i].taxPercentage;$("#t"+6+"").html(t6);}
                            if(i==6){t7=data[i].taxPercentage;$("#t"+7+"").html(t7);}
             }for (var j = 0; j <= data.length; j++) {
                            if(j==0){document.getElementById("excise").value=data[j].taxPercentage;}
                            if(j==1){document.getElementById("educationCess").value=data[j].taxPercentage;}
                            if(j==2){document.getElementById("secondaryHigherEducationCess").value=data[j].taxPercentage}
                            if(j==5){document.getElementById("cstOvat").value=data[j].taxPercentage;}
                            if(j==6){document.getElementById("inEntryTaxGiven").value=data[j].taxPercentage;}
             }
            });
                    var oo=$('#custorno').html();
                            var oid=$('#custodid').html();


                            var ooid=document.getElementById("inoid");
                            var options=ooid.getElementsByTagName("option");

                            ooid.options[1]=new Option(oo,oid,false,true);




        $('.generatenpreviewbtn').click(function(){

            var countl =$('#inCount').html();
                for(var a=0;a<countl;a++)
                {
                var chkid="chkbx"+a;
            var e=document.getElementById(chkid);

            if(e.checked)
            {
            var inDisp="inDisp"+a;

            var inCsh="inCsh"+a;

            var inDraw="inProdName"+a;

                             if(document.getElementById(inCsh).value=="Enter CSH No")
                             {
                                alert("Enter CSH Number for :"+document.getElementById(inDraw).value);
                                 return false;
                             }
                if(document.getElementById(inCsh).value=="")
                             {

                                 alert("Enter CSH Number for :"+document.getElementById(inDraw).value);
                                  document.getElementById(inCsh).value="Enter CSH No";
                                 return false;
                             }
                if(document.getElementById(inCsh).length>15)
                {

                    alert("CSH Number is too long for :"+document.getElementById(inDraw).value);
                    return false;
                }

                    var chkdisp= /^[0-9]+$/.test(document.getElementById(inDisp).value);

                            if(document.getElementById(inDisp).value=="Enter Dispaching Qty" || document.getElementById(inDisp).value==""){
                                 alert("Enter Dispatching Quantity for "+document.getElementById(inDraw).value);
                                 document.getElementById(inDisp).value="Enter Dispaching Qty";

                                return false;
                             }
                                else if(!chkdisp)
                             {

                                 alert("Enter valid Dispatching Quantity for :"+document.getElementById(inDraw).value);
                                 return false;
                             }
                }

                    }

                      var chk = /^[0-9]+$/.test($('#inpack').val());
                    if(document.getElementById(inpack).value !=""){
                    if (!chk) {
                    alert('please Enter Numeric value for packages');
                        $('#inpack').val("");
                        $('#inpack').focus();
                        return false;
                    }
                    }
           });

      });

----%>
<%--//$(document).ready(function(){--%>
<%----%>
<%----%>
<%--//});--%>


<%--
function Adv()
{

if(document.getElementById('inAdvanceEntered').value=="")
{
    document.getElementById('inAdvanceEntered').value=(0).toFixed(2);
}
else if(!(document.getElementById('inAdvanceEntered').value.match(floatExp)))
{
    alert("Please enter valid float number");
    document.getElementById('inAdvanceEntered').focus();
    return false;
}

var calinAdvanceEntered = parseFloat(document.getElementById("inAdvanceEntered").value);
 calinAdvance = parseFloat(document.getElementById("inAdvance").value);

if(parseFloat(calinAdvanceEntered)>parseFloat(calinAdvance))
{
    alert("Entered value is larger than 'Advance Available'");
    document.getElementById("inAdvanceEntered").value=(0).toFixed(2);
    document.getElementById("inAdvanceEntered").focus();
    return false;
}


calinAdvanceEntered = parseFloat(document.getElementById("inAdvanceEntered").value);
document.getElementById("inAdvanceRemain").value = ((parseFloat(calinAdvance) - parseFloat(calinAdvanceEntered))).toFixed(2);
document.getElementById("inNetPayable").value = ((parseFloat(calinGrandTotal) - parseFloat(calinAdvanceEntered))).toFixed(2);

    return true;
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


document.getElementById("inTotalAmount").value=(0).toFixed(2);
document.getElementById("inValue"+a).value=(0).toFixed(2);
/*document.getElementById("inGrandTotal").value=(0).toFixed(2);
document.getElementById("inOtherCharges").value=(0).toFixed(2);
                 document.getElementById("inNetPayable").value=(0).toFixed(2);
                 document.getElementById("inFright").value=(0).toFixed(2);
                 document.getElementById("inInsurance").value=(0).toFixed(2);
                 document.getElementById("inOthers").value=(0).toFixed(2);
*/

}

unCheckedTax();
}
}



function CST()
{

  var val=$('#inCSTSval').val();

inOvatnCstTax = ((calinTotalAmount * parseFloat(val))/100).toFixed(2);
     document.getElementById("inOvatnCst").value=inOvatnCstTax;
         inTaxChargesTax= (parseFloat(inExciseTax)+ parseFloat(inEducationCessTax) + parseFloat(inSecTax) + parseFloat(inOvatnCstTax )).toFixed(2);
         document.getElementById("inTaxCharges").value=inTaxChargesTax;
inOtherChargesTax= (parseFloat(calinFright) + parseFloat(calinInsurance) + parseFloat(calinOthers) + parseFloat(inTaxChargesTax)).toFixed(2);
       document.getElementById("inOtherCharges").value=inOtherChargesTax;
calinGrandTotal=(parseFloat(calinTotalAmount) + parseFloat(inOtherChargesTax)).toFixed(2);
      document.getElementById("inGrandTotal").value=calinGrandTotal;

   calinNetPayable=(parseFloat(calinGrandTotal)).toFixed(2);
      document.getElementById("inNetPayable").value=calinNetPayable;


}
function CSTOVAT()
{
               var vat=$('#inCSTS').val().trim().toString();

               if(vat=="CST")
               {
                   $('#inCSTSval').show();
                       var cst=document.getElementById("inCSTSval");
                                     var options=cst.getElementsByTagName("option");
                                        cst.options[0]=new Option(t4,t4);
                                        cst.options[1]=new Option(t5,t5);
                                 inOvatnCstTax = ((calinTotalAmount * t4)/100).toFixed(2);
   document.getElementById("inOvatnCst").value=inOvatnCstTax;
       inTaxChargesTax= (parseFloat(inExciseTax)+ parseFloat(inEducationCessTax) + parseFloat(inSecTax) + parseFloat(inOvatnCstTax )).toFixed(2);
       document.getElementById("inTaxCharges").value=inTaxChargesTax;


               document.getElementById("inEntryTax").value=(0.0).toFixed(2);
inOtherChargesTax= (parseFloat(calinFright) + parseFloat(calinInsurance) + parseFloat(calinOthers) + parseFloat(inTaxChargesTax)).toFixed(2);
            document.getElementById("inOtherCharges").value=inOtherChargesTax;
                   calinGrandTotal=(parseFloat(calinTotalAmount) + parseFloat(inOtherChargesTax)).toFixed(2);
                         document.getElementById("inGrandTotal").value=calinGrandTotal;

                      calinNetPayable=(parseFloat(calinGrandTotal)).toFixed(2);
                         document.getElementById("inNetPayable").value=calinNetPayable;


                $('#t6').hide();
               }
                  else
               {
                 $('#inCSTSval').hide();
               $('#t6').show();
                   inOvatnCstTax = ((calinTotalAmount * t6)/100).toFixed(2);
document.getElementById("inOvatnCst").value=inOvatnCstTax;
inTaxChargesTax= (parseFloat(inExciseTax)+ parseFloat(inEducationCessTax) + parseFloat(inSecTax) + parseFloat(inOvatnCstTax )).toFixed(2);
document.getElementById("inTaxCharges").value=inTaxChargesTax;
                   inEntryTaxT= (((parseFloat(inTaxChargesTax) + parseFloat(calinTotalAmount))* t7) / 100).toFixed(2);
                           document.getElementById("inEntryTax").value=inEntryTaxT;
inOtherChargesTax= (parseFloat(calinFright) + parseFloat(calinInsurance) + parseFloat(calinOthers) + parseFloat(inEntryTaxT)+parseFloat(inTaxChargesTax)).toFixed(2);
    document.getElementById("inOtherCharges").value=inOtherChargesTax;

                   calinGrandTotal=(parseFloat(calinTotalAmount) + parseFloat(inOtherChargesTax)).toFixed(2);
                         document.getElementById("inGrandTotal").value=calinGrandTotal;

                      calinNetPayable=(parseFloat(calinGrandTotal)).toFixed(2);
                         document.getElementById("inNetPayable").value=calinNetPayable;


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
document.getElementById("inTotalAmount").value=(calinTotalAmount).toFixed(2);
document.getElementById("inValue"+s).value=(0).toFixed(2);

  unCheckedTax();





}

}

function unCheckedTax()
 {
     inExciseTax = ((calinTotalAmount * t1)/100).toFixed(2);
         document.getElementById("inExcise").value=inExciseTax;
         inEducationCessTax= ((inExciseTax * t2)/100).toFixed(2);
         document.getElementById("inEducationCess").value=inEducationCessTax;
         inSecTax= ((inExciseTax * t3)/100).toFixed(2);
         document.getElementById("inSec").value=inSecTax;

     if(calinTotalAmount==0)
     {
    inExciseTax=0.0;
            inEducationCessTax=0.0;
              inSecTax=0.0;
              inOvatnCstTax=0.0;
              inEntryTaxT=0.0;
              calinFright=0.0;
               calinInsurance=0.0;
                calinOthers=0.0;
               calinGrandTotal=0.0;
               calinNetPayable=0.0;
              inTaxChargesTax=0.0;
              inOtherChargesTax=0.0;

         document.getElementById("inGrandTotal").value="00.0";
          document.getElementById("inOtherCharges").value="00.0";
        document.getElementById("inNetPayable").value="00.0";
        document.getElementById("inFright").value=(0).toFixed(2);
        document.getElementById("inInsurance").value=(0).toFixed(2);
        document.getElementById("inOthers").value=(0).toFixed(2);
        document.getElementById("inAdvanceEntered").value=(0).toFixed(2);
         document.getElementById("inAdvanceRemain").value =calinAdvance;
         }
     if($('#inCSTS').val()=="OVAT")
     {
         inOvatnCstTax = ((calinTotalAmount * t6)/100).toFixed(2);
         document.getElementById("inOvatnCst").value=inOvatnCstTax;
             inTaxChargesTax= (parseFloat(inExciseTax)+ parseFloat(inEducationCessTax) + parseFloat(inSecTax) + parseFloat(inOvatnCstTax )).toFixed(2);
             document.getElementById("inTaxCharges").value=inTaxChargesTax;
         inEntryTaxT= (((parseFloat(inTaxChargesTax) + parseFloat(calinTotalAmount))* t7) / 100).toFixed(2);
                                  document.getElementById("inEntryTax").value=inEntryTaxT;

         inOtherChargesTax= (parseFloat(calinFright) + parseFloat(calinInsurance) + parseFloat(calinOthers) + parseFloat(inEntryTaxT)+parseFloat(inTaxChargesTax)).toFixed(2);
         document.getElementById("inOtherCharges").value=inOtherChargesTax;
         calinGrandTotal=(parseFloat(calinTotalAmount) + parseFloat(inOtherChargesTax)).toFixed(2);
               document.getElementById("inGrandTotal").value=calinGrandTotal;

            calinNetPayable=(parseFloat(calinGrandTotal)).toFixed(2);
               document.getElementById("inNetPayable").value=calinNetPayable;


     }
     else if($('#inCSTS').val()=="CST")
     {
         if($('#inCSTSval').val()==t4)
         {
            inOvatnCstTax = ((calinTotalAmount * t4)/100).toFixed(2);
         document.getElementById("inOvatnCst").value=inOvatnCstTax;
             inTaxChargesTax= (parseFloat(inExciseTax)+ parseFloat(inEducationCessTax) + parseFloat(inSecTax) + parseFloat(inOvatnCstTax )).toFixed(2);
             document.getElementById("inTaxCharges").value=inTaxChargesTax;
             inOtherChargesTax= (parseFloat(calinFright) + parseFloat(calinInsurance) + parseFloat(calinOthers) + parseFloat(inTaxChargesTax)).toFixed(2);
                             document.getElementById("inOtherCharges").value=inOtherChargesTax;
             calinGrandTotal=(parseFloat(calinTotalAmount) + parseFloat(inOtherChargesTax)).toFixed(2);
                   document.getElementById("inGrandTotal").value=calinGrandTotal;

                calinNetPayable=(parseFloat(calinGrandTotal)).toFixed(2);
                   document.getElementById("inNetPayable").value=calinNetPayable;

         }
         else if($('#inCSTSval').val()==t5)
         {
             inOvatnCstTax = ((calinTotalAmount * t5)/100).toFixed(2);
         document.getElementById("inOvatnCst").value=inOvatnCstTax;
             inTaxChargesTax= (parseFloat(inExciseTax)+ parseFloat(inEducationCessTax) + parseFloat(inSecTax) + parseFloat(inOvatnCstTax )).toFixed(2);
             document.getElementById("inTaxCharges").value=inTaxChargesTax;
             inOtherChargesTax= (parseFloat(calinFright) + parseFloat(calinInsurance) + parseFloat(calinOthers) + parseFloat(inTaxChargesTax)).toFixed(2);
                             document.getElementById("inOtherCharges").value=inOtherChargesTax;
             calinGrandTotal=(parseFloat(calinTotalAmount) + parseFloat(inOtherChargesTax)).toFixed(2);
                   document.getElementById("inGrandTotal").value=calinGrandTotal;

                calinNetPayable=(parseFloat(calinGrandTotal)).toFixed(2);
                   document.getElementById("inNetPayable").value=calinNetPayable;

         }
}


 }


function CalculateAmount(d)
{


var totalamount=0;
var inDisp="inDisp"+d;
var calinDisp = parseFloat(document.getElementById(inDisp).value);


var inRemQty="inRemQty"+d;
var calinRemQty = parseFloat(document.getElementById(inRemQty).value);
var inAmdCost="inAmdCost"+d;
var calinAmdCost = parseFloat(document.getElementById(inAmdCost).value);

var inProdCost="inProdCost"+d;
var calinProdCost = parseFloat(document.getElementById(inProdCost).value);
var inValue="inValue"+d;
var calinValue = parseFloat(document.getElementById(inValue).value);

var chkdisp= /^[0-9]+$/.test(document.getElementById(inDisp).value);

               if(!chkdisp)
                    {

                        alert("Enter valid Dispatching Quantity for :"+document.getElementById("inProdName"+d).value);
                        calinValue = parseFloat(document.getElementById(inValue).value);

                                    calinTotalAmount=parseFloat(calinTotalAmount)-parseFloat(calinValue);

                                    document.getElementById("inTotalAmount").value=(calinTotalAmount).toFixed(2);
                                    unCheckedTax();
                                   $('#'+inValue).val("0.00");

                         document.getElementById(inDisp).value="Enter Dispaching Qty";
                        return false;
                    }
if(parseFloat(calinDisp) > parseFloat(calinRemQty)){
   alert("Dispatching Quantity cannot be greater than remaining quantity");


calinValue = parseFloat(document.getElementById(inValue).value);

     calinTotalAmount=parseFloat(calinTotalAmount)-parseFloat(calinValue);

     document.getElementById("inTotalAmount").value=(calinTotalAmount).toFixed(2);
     unCheckedTax();
    $('#'+inValue).val("0.00");
   $('#'+inDisp).val("Enter Dispaching Qty");
   }
else
{
//This is beccause all variable are globally declared so when onchange of dispached text field data result in adding old total along with new one
                   /*////////////////////////////////////////////////////////////////////////////*/
                   /*////*/        if(parseFloat(calinValue)>0){                         /*////*/
                   /*////*/            calinTotalAmount=calinTotalAmount-calinValue;     /*////*/
                   /*////*/        }                                                     /*////*/
                   /*////////////////////////////////////////////////////////////////////////////*/



  if(calinAmdCost>0)
calinValue=calinDisp * calinAmdCost;
else
calinValue=calinDisp * calinProdCost;


calinTotalAmount=calinTotalAmount +calinValue;

$('#'+inValue).val(calinValue);
$('#inTotalAmount').val(calinTotalAmount.toFixed(2));
/*    var checkbox="chkbx"+s;
var e=document.getElementById(checkbox);
   if(e.checked && parseFloat(calinValue)>parseFloat(0))
   {
       calinTotalAmount=0.0;
   }*/
}
dropdownname=$("#inProType"+d+" option:selected").text().trim().toString();
if(dropdownname=="MFG & Supply" || dropdownname=="Sale" || dropdownname=="None")
{
inExciseTax = ((calinTotalAmount * t1)/100).toFixed(2);
document.getElementById("inExcise").value=inExciseTax;
inEducationCessTax= ((inExciseTax * t2)/100).toFixed(2);
document.getElementById("inEducationCess").value=inEducationCessTax;
inSecTax= ((inExciseTax * t3)/100).toFixed(2);
document.getElementById("inSec").value=inSecTax;
}
else if(dropdownname=="Fabrication" || dropdownname=="Reimbursement")
{
inExciseTax = (0).toFixed(2);
document.getElementById("inExcise").value=inExciseTax;
inEducationCessTax= (0).toFixed(2);
document.getElementById("inEducationCess").value=inEducationCessTax;
inSecTax= (0).toFixed(2);
document.getElementById("inSec").value=inSecTax;
}

var vat=$('#inCSTS').val().trim().toString();
if(vat=="OVAT")
{
inOvatnCstTax = ((calinTotalAmount * t6)/100).toFixed(2);
document.getElementById("inOvatnCst").value=inOvatnCstTax;
inTaxChargesTax= (parseFloat(inExciseTax)+ parseFloat(inEducationCessTax) + parseFloat(inSecTax) + parseFloat(inOvatnCstTax )).toFixed(2);
document.getElementById("inTaxCharges").value=inTaxChargesTax;

inEntryTaxT= (((parseFloat(inTaxChargesTax) + parseFloat(calinTotalAmount))* t7) / 100).toFixed(2);
document.getElementById("inEntryTax").value=inEntryTaxT;

   calinFright=parseFloat(document.getElementById("inFright").value);

   calinInsurance=parseFloat(document.getElementById("inInsurance").value);

 calinOthers=parseFloat(document.getElementById("inOthers").value);

inOtherChargesTax=(parseFloat(calinFright) + parseFloat(calinInsurance) + parseFloat(calinOthers) + parseFloat(inEntryTaxT)+parseFloat(inTaxChargesTax)).toFixed(2);
document.getElementById("inOtherCharges").value=inOtherChargesTax;


 calinGrandTotal=(parseFloat(calinTotalAmount) + parseFloat(inOtherChargesTax)).toFixed(2);
   document.getElementById("inGrandTotal").value=calinGrandTotal;
calinNetPayable=(parseFloat(calinGrandTotal)).toFixed(2);
   document.getElementById("inNetPayable").value=calinNetPayable;


               }
                  else if(vat=="CST")
               {
                   CST();
               }



}
function validateFreight()
{
if(!($('#inFright').val().match(floatExp)))
{
   alert("Please enter valid float number");
   document.getElementById("inFright").value=(0).toFixed(2);
   document.getElementById("inFright").focus();
   return false;
  }
calinFright=$('#inFright').val();
inOtherChargesTax= (parseFloat(inOtherChargesTax) + parseFloat(calinFright)).toFixed(2);
document.getElementById("inOtherCharges").value=inOtherChargesTax;
calinGrandTotal=(parseFloat(calinTotalAmount) + parseFloat(inOtherChargesTax)).toFixed(2);
 document.getElementById("inGrandTotal").value=calinGrandTotal;

calinNetPayable=(parseFloat(calinGrandTotal)).toFixed(2);
 document.getElementById("inNetPayable").value=calinNetPayable;

return true;

}
function validateInsurance()
{
if(!($('#inInsurance').val().match(floatExp)))
{
   alert("Please enter valid float number");
   document.getElementById("inInsurance").value=(0).toFixed(2);
   document.getElementById("inInsurance").focus();
   return false;
  }
calinInsurance=$('#inInsurance').val();
inOtherChargesTax= (parseFloat(inOtherChargesTax) + parseFloat(calinInsurance)).toFixed(2);
document.getElementById("inOtherCharges").value=inOtherChargesTax;
calinGrandTotal=(parseFloat(calinTotalAmount) + parseFloat(inOtherChargesTax)).toFixed(2);
 document.getElementById("inGrandTotal").value=calinGrandTotal;

calinNetPayable=(parseFloat(calinGrandTotal)).toFixed(2);
 document.getElementById("inNetPayable").value=calinNetPayable;

return true;

}
function validateOthers()
{
if(!($('#inOthers').val().match(floatExp)))
{
   alert("Please enter valid float number");
   document.getElementById("inOthers").value=(0).toFixed(2);
   document.getElementById("inOthers").focus();
   return false;
  }
calinOthers=$('#inOthers').val();
inOtherChargesTax= (parseFloat(inOtherChargesTax) + parseFloat(calinOthers)).toFixed(2);
document.getElementById("inOtherCharges").value=inOtherChargesTax;
calinGrandTotal=(parseFloat(calinTotalAmount) + parseFloat(inOtherChargesTax)).toFixed(2);
 document.getElementById("inGrandTotal").value=calinGrandTotal;

calinNetPayable=(parseFloat(calinGrandTotal)).toFixed(2);
 document.getElementById("inNetPayable").value=calinNetPayable;

return true;

}
$(document).ready(function(){
$('#inIssue').timepicker({
              ampm: true,
              hourMin:00,
              hourMax: 24
          });
      $('#inRemoval').timepicker({
              ampm: true,
              hourMin:00,
              hourMax: 24
          });


});
--%>




<%--</script>--%>

<script type="text/javascript">

function getCustomerOrder(){
    /*     this.form.action='order?getCustomerOrderNo';
     this.form.submit();*/

    $.get("order?getCustomerOrderNo", {id:$('#incname').val()}, function (result) {

        var data=eval(result);

        var options = '<option value="">---Select Customer Order No---</option>';
        for (var i = 0; i < data.length; i++) {

            options += '<option value="' + data[i].id + '">' + data[i].customerOrderNo + '</option>';
        }
        $("#inoid").html(options);
    });
    $('.trid').show();

}

$(document).ready(function(){

    $('#inoid').change(function(){


        if($('#inoid').attr('value')!=""){

            var current=this;
            var orderId=$(this).attr("value");

            $.get("order?checkInvoiceForThisOrderDispatched",{id:orderId}, function (result) {
                var data=eval(result);

                if(data){
                    $('#hide').html("Invoice of Order Id "+orderId+" is dispatched.");
                    $('#hide').css({
                        align:"right",
                        color:"red"
                    });


                }else{
                    current.form.action='invoice?getOrderDetail';
                    current.form.submit();

                }
            });

        }
    });

    $.get("order?InvoiceToAddressAjax",{invoiceToAddressId:$('#custodid').html()}, function (result) {
        var data=eval(result);

        var options='';

        options += data.line1+","+ data.line2+","+ data.city+"-"+data.zip ;

        $("#invoiceAddress").html(options);



    });
    $.get("order?ShipmentToAddressAjax",{shipmentToAddressId:$('#custodid').html()}, function (result) {
        var data=eval(result);

        var options='';

        options += data.line1+","+ data.line2+","+ data.city+"-"+data.zip ;


        $("#shipmentAddress").html(options);


    });

    //check/uncheck individual selected product rows
    $('.productRowCheckBox').change(function(){
        var productRow=$(this);
        productIndividualCheckBox(productRow);
    });


    //check/uncheck all product rows
    $('#allbox').change(function(){
        var allBox=$(this);
        if(allBox.is(':checked')){
            $('.productRowCheckBox').each(function(){
                var checkBox=$(this);
                checkBox.attr("checked","checked");
                productIndividualCheckBox(checkBox);
            });
        }else{
            $('.productRowCheckBox').each(function(){
                var checkBox=$(this);
                checkBox.removeAttr("checked");
                productIndividualCheckBox(checkBox);
            });
        }
    });

    //function to extract row index from selected checkbox id and then enable or disable row
    var productIndividualCheckBox=function(productRow){
        var id=productRow.attr("id");
        var index=id.substring(5);
        if($(productRow).is(':checked')){
            enableProductRow(index);
        }else{
            disableProductRow(index);
        }
    };

    //enable the input of the selected product row
    var enableProductRow=function(index){
        $('#productId'+index).removeAttr("disabled");
        $('#material'+index).removeAttr("disabled").css("background-color","lightblue");
        $('#chapterId'+index).removeAttr("disabled").css("background-color","lightblue");
        $('#dispatching'+index).removeAttr("disabled").attr("value","").css("background-color","lightblue");
    };

    //disable the input of the selected product row
    var disableProductRow=function(index){
        $('#productId'+index).attr("disabled","disabled");
        $('#material'+index).attr("disabled","disabled").attr("value","").css("background-color","#edeeef");
        $('#chapterId'+index).attr("disabled","disabled").attr("value","").css("background-color","#edeeef");
        $('#dispatching'+index).attr("disabled","disabled").attr("value","0").css("background-color","#edeeef").change();
        calculateTotalAmount();
    };

    //calculate amount
    $('.dispatching').change(function(){
        var dispatching=$(this);
        var id=dispatching.attr("id");
        var index=id.substring(11);
        var dispatchingQuantity=parseFloat(dispatching.attr("value"));
        var remainingQuantity=parseFloat($('#remainingQuantity'+index).attr("value"));
        if(dispatchingQuantity > remainingQuantity){
            alert("Dispatching quantity cannot be greater than "+remainingQuantity);
            dispatching.attr("value","").focus();
        }else{
            calculateAmount(index,dispatchingQuantity);
        }
    });


    var calculateAmount=function(index, dispatchingQuantity){
        var productCost=parseFloat($('#productCost'+index).attr("value"));
        var amount=dispatchingQuantity * productCost;
        $('#amount'+index).attr("value",amount.toFixed(2));
        calculateTotalAmount();
    };



    var calculateTotalAmount=function(){
        var totalAmount=0.00;
        $('.amount').each(function(){
            var amountRow=$(this);
            var currentAmount=parseFloat(amountRow.attr("value"));
            totalAmount=totalAmount+currentAmount;
        });
        $('#totalAmount').attr("value",totalAmount.toFixed(2));
        recalculateTaxCharge();
        calculateGrandTotal();
        enableDisableTaxCheckBox();
    };

    var enableDisableTaxCheckBox=function(){
        if($('#totalAmount').attr("value")=="0.00"){
            $('.taxCheckBox').each(function(){
                $(this).attr("disabled","disabled").removeAttr("checked").change();
            });
        }else{
            $('.taxCheckBox').each(function(){
                $(this).removeAttr("disabled");
            });
        }
    };


    //check/uncheck tax row
    $('.taxCheckBox').change(function(){
        var taxRow=$(this);
        taxIndividualCheckBox(taxRow);
    });

    //function to extract row index from selected checkbox id and then enable or disable row
    var taxIndividualCheckBox=function(taxRow){
        var id=taxRow.attr("id");
        var index=id.substring(11);
        if($(taxRow).is(':checked')){
            enableTaxRow(index);
        }else{
            disableTaxRow(index);
        }
    };

    //enable the input of the selected tax row
    var enableTaxRow=function(index){
        $('#applicableOn'+index).removeAttr("disabled").css("background-color","lightblue");
    };

    var taxIndependent=true;
    //disable the input of the selected tax row
    var disableTaxRow=function(index){
        checkDependentTaxes(index);
        if(taxIndependent){
            $('#applicableOn'+index).attr("disabled","disabled").attr("value","0").css("background-color","#edeeef").change();
            $('#taxAmount'+index).attr("value","0.00");
            calculateTotalTaxCharge();
        }
        taxIndependent=true;
    };

    var checkDependentTaxes=function(index){
        var taxName=$('#taxName'+index).attr("value");
        $('.taxCheckBox').each(function(){
            var currentCheckBox=$(this);
            var currentId=currentCheckBox.attr("id");
            var currentIndex=currentId.substring(11);
            if(currentCheckBox.is(':checked')){
                var applicableOn=$('#applicableOn'+currentIndex).attr("value");
                if(applicableOn==taxName){
                    alert("please uncheck dependent taxes.");
                    $('#taxCheckBox'+index).attr("checked","checked");
                    taxIndependent=false;
                }
            }
        });
    };

    var recalculateTaxCharge=function(){
        $('.applicableOn').each(function(){
            $(this).change();
        });
    };

    $('.applicableOn').change(function(){
        var applicableOnRow=$(this);
        var id=applicableOnRow.attr("id");
        var index=id.substring(12);
        var applicableOn=applicableOnRow.attr("value");
        if(applicableOn=="totalAmount"){
            calculateIndividualTax(index,index,applicableOn);
        }else{
            $('.taxCheckBox').each(function(){
                var checkBox=$(this);
                var id=checkBox.attr("id");
                var indexCheckBox=id.substring(11);
                var taxName=$('#taxName'+indexCheckBox).attr("value");
                var taxAmount=parseFloat($('#taxAmount'+indexCheckBox).attr("value"));
                if(applicableOn==taxName){
                    if(!checkBox.is(':checked')){
                        alert(applicableOn+" is not selected.");
                        applicableOnRow.attr("value","0");
                        $('#taxAmount'+indexCheckBox).attr("value","0.00");
                    }else if(taxAmount=="0.00"){
                        alert(applicableOn+" value is zero.");
                        applicableOnRow.attr("value","0");
                    }else{
                        calculateIndividualTax(index,indexCheckBox,applicableOn);
                    }

                }
            });
        }
    });

    var calculateIndividualTax=function(index,indexCheckBox,applicableOn){
        var taxPercentage=parseFloat($('#taxPercentage'+index).attr("value"));
        var totalAmount=0.00;
        if(applicableOn=="totalAmount"){
            totalAmount=parseFloat($("#totalAmount").attr("value"));
        }else{
            totalAmount=parseFloat($("#taxAmount"+indexCheckBox).attr("value"));
        }
        var tax= ((taxPercentage/100)* totalAmount).toFixed(2);
        $('#taxAmount'+index).attr("value",tax);
        calculateTotalTaxCharge();

    };

    var calculateTotalTaxCharge=function(){
        var totalTax=0.00;
        $('.taxAmount').each(function(){
            var taxRox=$(this);
            var currentTax=parseFloat(taxRox.attr("value"));
            totalTax=totalTax+currentTax;
        });
        $('#taxCharges').attr("value",totalTax.toFixed(2));
        calculateGrandTotal();
    };

    var calculateGrandTotal=function(){
        var totalAmount=parseFloat($('#totalAmount').attr("value"));
        var taxCharges=parseFloat($('#taxCharges').attr("value"));
        var grandTotal=totalAmount+taxCharges;
        $('#grandTotal').attr("value",grandTotal.toFixed(2));
        calculateNetPayable();
    };

    $('#advanceEntered').change(function(){
        calculateNetPayable();
    });

    var calculateNetPayable=function(){
        var grandTotal=parseFloat($('#grandTotal').attr("value"));
        var advanceEntered=parseFloat($('#advanceEntered').attr("value"));
        var netPayable=grandTotal-advanceEntered;
        $('#netPayable').attr("value",netPayable.toFixed(2));
    };



});
</script>
</s:layout-component>
<s:layout-component name="left-menu">

    <ul>
        <li>&nbsp;</li>
        <li class="left_menu_heading">Invoice</li>
        <li style="margin-top:35px">
            <s:link beanclass="com.inwise.action.InvoiceActionBean" event="pre">Generate</s:link></li>
        <li><s:link beanclass="com.inwise.action.InvoiceActionBean" event="preupdate">Update</s:link></li>
        <li><s:link beanclass="com.inwise.action.PaymentStatusActionBean" event="page">Payment Status</s:link></li>
    </ul>

</s:layout-component>
<s:layout-component name="body">
<s:form beanclass="com.inwise.action.InvoiceActionBean">
    <br>
    <table class="heading_table">

        <tr><td align="left" class="pageheading" valign="top">
            <div class="sub_heading" >Generate Invoice</div>
        </td></tr>
            <%-- <tr valign="top"><td align="center"><div class="msg"><s:messages/></div>
            </td></tr>--%>
    </table>
    <table class="second_table"  ><tr><td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">

        <tr>
            <td colspan="4" align="left">
                <div align="left" style="margin-left:15px;text-align:left;" class="labels" >
                    Please Enter Order Details ::				</div>			</td>
        </tr>

        <tr>
            <td width="19%" align="right" valign="top">
                <div align="right"  class="labels">
                    Customer Name				</div>			</td>
            <td width="27%" align="left" valign="top">
                <s:select id="incname"  name="invoice.customer.id" class="dropdown" onchange="getCustomerOrder()">
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
            </td>
            <td width="15%" align="right" valign="top">&nbsp;</td>
            <td width="39%">&nbsp;</td>
        </tr>

        <tr style="display :none;" class="trid">
            <td width="19%" align="right" valign="top">
                <div align="right">
                    <span class="labels" style="margin-left:15px;">Customer Order No.</span></div></td>
            <td width="27%" align="left" valign="top">
                <s:select id="inoid" name="id" class="dropdown">
                    <option  value="0">---Select Customer Order No---</option>
                </s:select>
                <input type="hidden" name="sendorderid" id="sendorderid" value="">
            </td>

            <span style="display:none;"  id="custorno" >${invoiceBean.order.customerOrderNo}</span>
            <span style="display:none;"  id="custodid" >${invoiceBean.id}</span>


        </tr>

    </table>
</s:form>
<div id="hide">
<c:if test="${actionBean.order!=null}">
<script type="text/javascript">
    $(document).ready(function() {
        if($('#custodid').html()!=null)
        {
            $('.trid').show();
        }

    });

</script>
<s:form beanclass="com.inwise.action.InvoiceActionBean">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">
<tr>
<td colspan="4"><table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td valign="top" class="foreach_table_th"><div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">
<tr></tr>
<tr>
    <td><div align="right" style="margin-left:15px;" class="labels"> Order Date </div></td>
    <td width="25%" align="left" valign="top"><div align="left">
        <s:text  value="" name="order.createDate" id="inodate" size="8" style="border:0px;background-color:#FCFCFC;" class="textbox"  readonly="readonly" />
    </div></td>
    <td width="19%">&nbsp;</td>
    <td align="left" style="margin-left:10px;">&nbsp;</td>
</tr>

<tr>
    <td align="right" valign="top">&nbsp;</td>
    <td colspan="2" align="left" valign="top"></td>
</tr>
<tr valign="top">
    <td width="18%" align="right" valign="top"><div align="right"  style="margin-left:15px;" class="labels"> Invoice To </div></td>
    <td width="24%" align="left" valign="bottom"><s:hidden name="invoice.order.orderAddress[0].addressType.id" value="1"/>
        <s:textarea readonly="readonly"  name="ksjkdf"  id="invoiceAddress"  style="height: 100px; width:180px;resize:none;border:1px solid #ccccff"/></td>
    <td width="19%" align="right" valign="top"><div align="right" style="margin-left:15px;" class="labels"> Consignee </div></td>
    <td width="39%" align="left" valign="bottom"><div align="left">
        <s:hidden name="invoice.order.orderAddress[1].addressType.id" value="2"/>
        <s:textarea readonly="readonly" name="sdffgdsfg" id="shipmentAddress" style="height: 100px; width:180px;resize:none;border:1px solid #ccccff" />
    </div></td>
</tr>
<tr>
    <td>&nbsp;</td>
</tr>
<tr>
    <td align="left" ><div align="left" style="margin-right:38px" class="labels"> <b style="color:#888888;">(&nbsp;&nbsp;) fields are mandatory</b></div>
        <div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:-11px; margin-left:19px;">*</div></td>
    <td>&nbsp;</td>
</tr>
<tr>
    <td colspan="4">&nbsp;</td>
</tr>
<tr>
    <td colspan="4"><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr class="foreach_table">
            <td align="center" width="3%"class="foreach_table_firstth"><s:checkbox name="allbox" id="allbox" value="chekbx"/></td>
            <td nowrap="nowrap" width="4%" class="foreach_table_th"><div align="center" style="margin-top:5px; margin-bottom:5px; margin-left:1px; margin-right:1px; font-size: 11px;" class="labels"> <b>Sr. No.</b> <br />
                &nbsp; </div></td>
            <td nowrap="nowrap" width="11%" class="foreach_table_th"><div align="center" style="margin-top:5px; margin-bottom:5px;  margin-left:1px; margin-right:1px; font-size: 11px;" class="labels"> <b>Material Code</b></div></td>
            <td nowrap="nowrap" width="11%" class="foreach_table_th"><div align="center" style="margin-top:5px; margin-bottom:5px;  margin-left:1px; margin-right:1px; font-size: 11px;" class="labels"> <b>Chapter ID</b></div></td>
            <td width="8%" nowrap="nowrap" class="foreach_table_th"><div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels"> <b>Material Name</b> <br />
                &nbsp; </div></td>
            <td nowrap="nowrap" width="5%" class="foreach_table_th"><div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels"> <b>Ordered<br />
                Quantity</b></div></td>
            <td nowrap="nowrap" width="6%" class="foreach_table_th"><div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels"> <b>Remaining<br />
                Quantity</b></div></td>
            <td nowrap="nowrap" width="12%" class="foreach_table_th"><div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels"> <b>Product<br />
                Rate</b></div></td>
            <td nowrap="nowrap" width="17%" class="foreach_table_th"><div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels"> <b>Unit</b></div></td>

            <td nowrap="nowrap" width="13%" class="foreach_table_th"><div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels"> <b>Dispatching<br />
                Quantity</b></div></td>
            <td nowrap="nowrap" width="10%" class="foreach_table_th"><div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels"><b>Amount</b></div></td>
        </tr>
        <c:forEach items="${invoiceBean.order.orderDetail}" var="orderdetailarray" varStatus="loop">
            <tr>
                <td align="center" valign="top" class="foreach_table_firstth"><div style="margin-top:5px;">
                    <s:checkbox name="chkbx" id="chkbx${loop.index}" class="productRowCheckBox"/>
                    <s:hidden name="invoice.invoiceDetail[${loop.index}].product.id" id="productId${loop.index}" disabled="disabled" value="${orderdetailarray.product.id}"/>
                </div></td>
                <td valign="top"  class="foreach_table_th"><div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:5px; margin-right:3px; font-size: 12px;" class="labels">  <b>${loop.index+1}</b>
                </div></td>
                <td valign="top" class="foreach_table_th"><div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:5px; margin-right:3px; font-size: 12px;" class="labels">
                    <s:text name="invoice.invoiceDetail[${loop.index}].material" id="material${loop.index}" disabled="disabled" size="15" maxlength="10" style="margin-top:0px ;background-color:#edeeef; border:0px; text-align:right; font-size: 12px;"/>
                </div></td>
                <td valign="top" class="foreach_table_th"><div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:5px; margin-right:3px; font-size: 12px;" class="labels">
                    <s:text name="invoice.invoiceDetail[${loop.index}].chapterId" id="chapterId${loop.index}" disabled="disabled" size="15" maxlength="20" style="margin-top:0px ;background-color:#edeeef; border:0px; text-align:right; font-size: 12px;"/>
                </div></td>
                <td valign="top" class="foreach_table_th"><div align="left" style="margin-top:5px; margin-bottom:5px; margin-right:3px;  margin-left:3px; font-size: 12px;" class="labels">
                    <s:text name="invoice.invoiceDetail[${loop.index}].product.productName" disabled="disabled" value="${orderdetailarray.product.productName}"  id="inProdName${loop.index}" size="15" readonly="readonly" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
                </div></td>
                <td valign="top" class="foreach_table_th"><div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
                    <s:text name="invoice.invoiceDetail[${loop.index}].dispatching" value="${orderdetailarray.orderedQuantity}" id="inOrdQty${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
                </div></td>
                <td valign="top" class="foreach_table_th"><div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
                    <s:text name="invoice.order.orderDetail[${loop.index}].remainingQuantity" value="${orderdetailarray.remainingQuantity}" id="remainingQuantity${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
                </div></td>
                <td valign="top" class="foreach_table_th"><div align="right"   style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
                    <s:text name="invoice.invoiceDetail[${loop.index}].productCost" value="${orderdetailarray.cost}" id="productCost${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
                </div></td>
                <td valign="top" class="foreach_table_th"><div align="right"   style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
                    <span id="mtype${loop.index}" style="margin-top:0px ; border:0px; text-align:right; font-size: 12px;">${orderdetailarray.product.unit.name}</span></div></td>
                <td valign="top" class="foreach_table_th"><div align="left" style="margin-top:5px; margin-bottom:5px; margin-right:1px; margin-left:1px; font-size: 12px;" class="labels">
                    <s:text name="invoice.invoiceDetail[${loop.index}].dispatched" id="dispatching${loop.index}" value="0" size="20" class="dispatching"
                            disabled="disabled" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;background-color:#edeeef;   font-size: 12px;"/>
                    <div style="color: #ff0000; font-size:10px;">*</div>
                </div></td>
                <td valign="top" class="foreach_table_th"><div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
                    <s:text name="invoice.invoiceDetail[${loop.index}].dueQuantity" value="0.00" id="amount${loop.index}" class="amount" size="20" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
                    <s:hidden name="inCount" id="inCount" value="${loop.index}"/>
                </div></td>
            </tr>
            <c:if test="${loop.last}"> <span style="visibility:hidden;" id="inCount">${loop.count}</span></c:if>
        </c:forEach>
        <tr>
            <td colspan="8">&nbsp;</td>
            <td colspan="2"  nowrap style="border-right:1px solid #ccccff"><div align="center" class="labels"> <b>Total Amount ( A )</b></div></td>
            <td style="border-right:1px solid #ccccff; border-bottom:1px solid #ccccff;height:24px; "><div align="right" style="color: #ff0000; font-family: Verdana; font-size:10px; margin-right:3px;">
                <s:text name="invoice.totalAmount" id="totalAmount" size="20"  readonly="readonly" value="0.00" style="margin-top:0px ;background-color:#edeeef; border:0px; text-align:right;"/>
            </div></td>
        </tr>
    </table></td>
</tr>
<tr>
    <td align="left" colspan="2"><div align="left" style="margin-left:15px;" class="labels"> <b style="color:#888888">Taxes are applicable on ' Total Amount + Other Charges '</b></div></td>
</tr>
<tr>
    <td colspan="4">&nbsp;</td>
</tr>



<tr>
    <td colspan="4"><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <c:forEach items="${invoiceBean.taxlst}" var="tax" varStatus="loop">
            <tr><td width="40%" align="left" valign="top">&nbsp;</td>
                <td width="3%" align="center" valign="top" class="foreach_table_firstth"><div style="margin-top:5px;">
                    <s:checkbox name="taxchkbx" id="taxCheckBox${loop.index}" class="taxCheckBox" disabled="disabled"/>
                </div></td>
                <td width="11%" valign="top"  class="foreach_table_th"><div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:5px; margin-right:3px; font-size: 12px;" class="labels">
                    <s:text name="invoice.taxes[${loop.index}].taxName" value="${tax.name}" id="taxName${loop.index}" size="15" readonly="readonly" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/></div></td>
                <td width="5%" valign="top" class="foreach_table_th"><div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:5px; margin-right:3px; font-size: 12px;" class="labels">
                    <s:text name="invoice.taxes[${loop.index}].previousTaxPercent" value="${tax.taxPercentage}" id="taxPercentage${loop.index}" readonly="readonly" size="15" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>                                  </div></td>
                <td width="10%" valign="top" class="foreach_table_th"><div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:5px; margin-right:3px; font-size: 12px;" class="labels">
                    <b>applied on</b>
                </div></td>

                <td width="13%" valign="top" class="foreach_table_th"><div style="color: #ff0000; font-family: Verdana; font-size:10px; margin-top:5px; margin-right:3px; font-size: 12px;" class="labels">

                    <s:select id="applicableOn${loop.index}" name="invoice.taxes[${loop.index}].applicableOn" disabled="disabled" class="dropdown applicableOn">
                        <option  value="0">---Select Applicable On---</option>
                        <option  value="totalAmount">Total Amount</option>
                        <c:forEach items="${invoiceBean.taxlst}" var="orderloop" >
                            <c:choose>
                                <c:when test="${orderloop.name ne tax.name}">
                                    <option value="<c:out value="${orderloop.name}"/>"><c:out value="${orderloop.name}"/></option>
                                </c:when>
                            </c:choose>

                        </c:forEach>
                    </s:select>
                </div>
                </td>
                <td width="20%" valign="top" class="foreach_table_th"><div align="left" style="margin-top:5px; margin-bottom:5px; margin-right:3px;  margin-left:3px; font-size: 12px;" class="labels">
                    <s:text name="invoice.taxes[${loop.index}].taxAmount" id="taxAmount${loop.index}" class="taxAmount" value="0.00" size="15" readonly="readonly" style="margin-top:0px ;background-color:#edeeef; border:0px; text-align:right; font-size: 12px;"/>
                </div></td>
            </tr>
            <c:if test="${loop.last}"> <span style="visibility:hidden;" id="inCount">${loop.count}</span></c:if>
        </c:forEach>
        <tr>
            <td colspan="4">&nbsp;</td>
            <td colspan="2"  nowrap style="border-right:1px solid #ccccff"><div align="right" style="margin-left:15px;" class="labels"> <b>Tax Charges ( B )<br />
                (Sum of Taxes)</b></div></td>
            <td style="border-right:1px solid #ccccff; border-bottom:1px solid #ccccff;height:24px; "><div align="right" style="color: #ff0000; font-family: Verdana; font-size:10px; margin-right:3px;">
                <s:text name="invoice.taxCharges" id="taxCharges"   size="22"  style="text-align:right;background-color:#ccccff; "  class="textbox" readonly="readonly" value="0.00"/>
            </div></td>
        </tr>
    </table></td>
</tr>
<tr>
    <td></td>
    <td align="left"></td>
    <td></td>
    <td align="left" valign="top"></td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right" valign="top" nowrap>&nbsp;</td>
    <td colspan="3" align="left" valign="top" >&nbsp;</td>
</tr>
<tr>
    <td align="right" valign="top"></td>
    <td align="left" valign="top"></td>
    <td></td>
    <td align="left"></td>
</tr>
<tr>
    <td align="right" valign="top"></td>
    <td align="left" valign="top"></td>
    <td></td>
    <td align="left"></td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td nowrap></td>
    <td align="left" colspan="3" ></td>
</tr>
<tr>
    <td>&nbsp;</td>
</tr>
<tr>
    <td colspan="4"><table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
            <td width="5%" nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-top: 1px solid #000000;"><div align="center" class="labels"> <b><u>Grand Total ( A+B )</u></b></div></td>
            <td width="2%" align="left" valign="top"><div align="center" class="labels" style="margin-top:10px;"> <b>_</b></div></td>
            <td width="8%" nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-top: 1px solid #000000;"><div align="center" class="labels"> <b><u>Advance Available</u> &nbsp;</b> <img src="images/Rupee.JPG"/>&nbsp;
                <c:choose>
                    <c:when test="${invoiceBean.advance.amountRemained != null}">
                        <s:text name="invoice.amountReceived"   value="${invoiceBean.advance.amountRemained}"   id="inAdvance" size="11" readonly="readonly" style="border:0px; text-align:right;"/>
                    </c:when>
                    <c:otherwise>
                        <s:text name="invoice.amountReceived"   value="0.00"   id="inAdvance" size="11" readonly="readonly" style="border:0px; text-align:right;"/>
                    </c:otherwise>
                </c:choose>
            </div></td>
            <td width="2%" align="left" valign="top"><div align="center" class="labels" style="margin-top: 17px;"> <b>=</b></div></td>
            <td width="5%" nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-top: 1px solid #000000;"><div align="center" class="labels"> <b><u>Net Payable</u></b></div></td>
        </tr>
        <tr>
            <td nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000;"><div align="center">
                <s:text name="invoice.grandTotal" id="grandTotal" formatType="number" formatPattern="##.##" class="textbox" size="15"  readonly="readonly" style="border:0px; text-align:right;background-color:#FCFCFC;" value="0.00"/>
            </div></td>
            <td align="left" valign="top"></td>
            <td  nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000;"><div align="center" class="labels"> <b><u>Deduct Advance</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
                <s:text name="invoice.amountDetect"  value="0.00" id="advanceEntered"  size="12" style="text-align:right;border:1px solid #ccccff;" onFocus="if(this.value==''){this.value='0.00';}" onChange="if(this.value==''){this.value='0.00';}"/>
            </div></td>
            <td align="left" valign="top"></td>
            <td nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000;"><div align="center">
                <s:text name="invoice.netPayable" class="textbox" id="netPayable" size="15"  readonly="readonly" style="border:0px; text-align:right;background-color:#FCFCFC;" value="0.00"/>
            </div></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000;"><div align="center" class="labels" style="margin-top: 10px;"> <b><u>Advance Remain</u>&nbsp;&nbsp;&nbsp;&nbsp;</b>
                <c:choose>
                    <c:when test="${invoiceBean.advance.amountRemained != null}">
                        <s:text name="invoice.amountRemained" id="inAdvanceRemain"  size="11" readonly="readonly" style="border:0px; text-align:right;"/>
                    </c:when>
                    <c:otherwise>
                        <s:text name="invoice.amountRemained" id="inAdvanceRemain" value="0.00"  size="11" readonly="readonly" style="border:0px; text-align:right;"/>
                    </c:otherwise>
                </c:choose>
            </div>
                &nbsp; </td>
        </tr>
    </table></td>
</tr>
<tr>
    <td>&nbsp;</td>
</tr>
<tr>
    <td align="right" valign="top">
        <div align="right" style="margin-left:15px;" class="labels">
            Challan Pass Number					</div>
    </td>
    <td align="left"><div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
        <s:text name="invoice.challanPassNumber" id="challanPassNumber" class="textbox"  />
    </div>	</td>
    <td><div align="right" style="margin-left:15px;" class="labels">
        Challan Date					</div></td>
    <td align="left"><div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
        <s:text name="invoice.challanDate" id="challanDate" readonly="readonly" onFocus="showCalendarControl(this);" class="textbox"  />
    </div></td>
</tr>
<tr>
    <td align="right" valign="top">
        <div align="right" style="margin-left:15px;" class="labels">
            LOI Number					</div>
    </td>
    <td align="left"><div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
        <s:text name="invoice.loiNumber" id="loiNumber" class="textbox"  />
    </div>	</td>
    <td><div align="right" style="margin-left:15px;" class="labels">
        LR Number					</div></td>
    <td align="left"><div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
        <s:text name="invoice.lrNumber" id="lrNumber" class="textbox"  />
    </div></td>
</tr>
<tr>
    <td align="right" valign="top">
        <div align="right" style="margin-left:15px;" class="labels">
            Transporter					</div>
    </td>
    <td align="left"><div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
        <s:text name="invoice.transporter" id="transporter" class="textbox"  />
    </div>	</td>
    <td><div align="right" style="margin-left:15px;" class="labels">
        Vehicle Number					</div></td>
    <td align="left"><div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
        <s:text name="invoice.vehicleNo" id="vehicleNo" class="textbox"  />
    </div></td>
</tr>
<tr>
    <td align="right" valign="top">
        <div align="right" style="margin-left:15px;" class="labels">
            Freight					</div>
    </td>
    <td align="left"><div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
        <s:text name="invoice.freight" id="freight" class="textbox"  />
    </div>	</td>
    <td><div align="right" style="margin-left:15px;" class="labels">
        Due Date					</div></td>
    <td align="left"><div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
        <s:text name="invoice.dueDate" id="dueDate" readonly="readonly" onFocus="showCalendarControl(this);"  class="textbox"  />
    </div></td>
</tr>
<tr>
    <td align="right" valign="top"></td>
    <td align="left"></td>
</tr>
<tr>
    <td valign="top">
        <div align="right" style="margin-left:15px;" class="labels">
            Remarks						</div>					</td>
    <td align="left" colspan="3">

        <s:textarea name="invoice.remark" wrap="off" id="inremark" style="height: 60px; width:650px;border:1px solid #ccccff; text-align: left;resize:none"/>
    </td>
</tr>
<tr>
    <td align="right" valign="top"></td>
    <td align="left"></td>
    <td></td>
    <td align="left"></td>
</tr>
<tr>
    <td>&nbsp;</td>
</tr>
<tr>
    <td valign="top"></td>
    <td align="left" colspan="3"></td>
</tr>
<tr>
    <td>&nbsp;</td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td align="left" colspan="2">
        <s:hidden name="invoice.order.id" value="${invoiceBean.order.id}"/>
        <s:hidden name="advance.order.id" value="${invoiceBean.advance.order.id}"/>
        <s:hidden name="invoice.customer.id" value="${invoiceBean.order.customer.id}"/>
        <s:submit class="generatenpreviewbtn" name="addgenerate"  value="Generate" />
        &nbsp;&nbsp;
        &nbsp;&nbsp;
        <s:submit class="generatenpreviewbtn" name="addpreview" value="Preview"/>
        &nbsp;&nbsp;
        <s:submit name="cancel" class="buttons" value="Cancel"/></td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">
</table>
</div></td>
</tr>
</table></td>
</tr>
</table>
</s:form>
</c:if>
</div>

</s:layout-component>
</s:layout-render>
