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
  <script type="text/javascript">
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


      });


    function getCustomerOrder(){
   /*     this.form.action='order?getCustomerOrderNo';
        this.form.submit();*/
        $('.trid').show();
        $.get("order?getCustomerOrderNo", {id:$('#incname').val()}, function (result) {

             var data=eval(result);
             var options = '<option value="">---Select Customer Order No---</option>';
                     for (var i = 0; i < data.length; i++) {

                         options += '<option value="' + data[i].id + '">' + data[i].customerOrderNo + '</option>';
                     }
                     $("#inoid").html(options);
          });

    }

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
        emptycsh.value="Enter CSH No *";
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
        emptycsh.value="Enter CSH No *";
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


</script>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

 <s:useActionBean beanclass="com.inwise.action.InvoiceActionBean" var="invoiceBean" event="pre" ></s:useActionBean>
<%request.setAttribute("prodlst",invoiceBean.getProductcategory());%>

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
                <td>
               <div align="right" style="margin-left:15px;" class="labels">
			    Order Date 				</div>
			</td>
	 		<td width="25%" align="left" valign="top">
			<div align="left">


					<s:text  value="" name="order.createDate" id="inodate" size="8" style="border:0px;background-color:#FCFCFC;" class="textbox"  readonly="readonly" />

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
				<s:text name="invoice.order.amendmentNo" value="${invoiceBean.order.amendmentNo}" id="txtamndNo" readonly="readonly" class="textbox"  style="border:0px;background-color:#FCFCFC;"/>
            </td>
		 	<td width="19%">
		  		<div align="right" style="margin-left:15px;" class="labels">
					Amendment Date
				</div>
			</td>

			<td align="left" style="margin-left:10px;">
				<div align="left">
					<s:text name="invoice.order.amendmentDate" value="${invoiceBean.order.amendmentDate}" id="txtamnddate" class="textbox" size="8" style="border:0px;
													background-color: #FCFCFC;" readonly="readonly"/>
				</div>
			</td>
		</tr>





		<tr>
        	<td align="right" valign="top">
            	<div align="right" style="margin-left:15px;" class="labels">
					Sales Rep. Code.				</div>			</td>
		  <td colspan="2" align="left" valign="top">
				<s:text name="invoice.salesRepCode" value="1" id="insrepcode" type="text" class="textbox" readonly="readonly" style="border:0px;background-color:#FCFCFC;"
											   size="9"/>			</td>
		</tr>

		<tr>
			<td width="18%" align="right" valign="top">
			  <div align="right"  style="margin-bottom:20px;margin-left:15px;" class="labels">
			    Invoice To				</div>			</td>
	  <td width="24%" align="left" valign="bottom">

                       <s:hidden name="invoice.order.orderAddress[0].addressType.id" value="1"/>
					<s:textarea readonly="readonly"  name="ksjkdf"  id="invoiceAddress"  style="height: 100px; width:180px;resize:none;border:1px solid #FFCC66"/>

							</td>
			<td width="19%" align="right" valign="top">
			  <div align="right" style="margin-bottom:20px;margin-left:15px;" class="labels">
			    Consignee					</div>				</td>
  <td width="39%" align="left" valign="bottom">
  <div align="left">
                         <s:hidden name="invoice.order.orderAddress[1].addressType.id" value="2"/>
      <s:textarea readonly="readonly" name="sdffgdsfg" id="shipmentAddress" style="height: 100px; width:180px;resize:none;border:1px solid #FFCC66" />


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
 							<td nowrap="nowrap" width="6%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
								<div align="center" style="margin-top:5px; margin-bottom:5px; font-size: 11px; margin-left:1px; margin-right:1px; " class="labels">
									<b>Remaining<br>Quantity</b>
								</div>
							</td>

							<td nowrap="nowrap" width="12%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#FFCC66;">
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
								<s:text name="invoice.invoiceDetail[${loop.index}].cshNo" id="inCsh${loop.index}" value="Enter CSH No *" onFocus="if(this.value=='Enter CSH No *'){this.value='';}"   disabled="disabled" size="15" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
								</div>
							</td>
							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">

                                <div align="left" style="margin-top:5px; margin-bottom:5px; margin-right:3px;  margin-left:3px; font-size: 12px;" class="labels">
							        <s:hidden name="invoice.invoiceDetail[${loop.index}].product.id" value="${orderdetailarray.product.id}"/>
                                    <s:text name="invoice.invoiceDetail[${loop.index}].product.productName" value="${orderdetailarray.product.productName}"  id="inDraw${loop.index}" size="15" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
								</div>
							</td>
							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="left" style="margin-top:5px; margin-bottom:5px; margin-right:1px;  margin-left:1px; font-size: 12px;" class="labels">
							<%--		<s:hidden name="invoice.invoiceDetail[${loop.index}].productCategory.id" value="1"/>
                                    <s:select id="inProType${loop.index}" name="invoice.invoiceDetail[${loop.index}].productCategory.type" disabled="disabled" style="width:100px; margin-left:0px; font-size: 12px;" onChange="javascript: CalculateAmount(${loop.index});">
										<option value="MFG & Supply">MFG. & Supply</option>
										<option value="Sale">Sale</option>
										<option value="Fabrication">Fabrication</option>
										<option value="Reimbursement">Reimbursement</option>
										<option value="None">None</option>
									</s:select>--%>
                                <s:select id="inProType${loop.index}" name="invoice.invoiceDetail[${loop.index}].productCategory.id" disabled="disabled" onChange="javascript: CalculateAmount(${loop.index});">


                                                    <c:forEach items="${prodlst}" var="ploop" >

                                                                   <c:choose>
                                                                 <c:when test="${invoicedetail.productCategory.id eq ploop.id}">
                                                                       <option value ="<c:out value="${invoicedetail.productCategory.id}"/>" selected="selected"> <c:out value="${invoicedetail.productCategory.type}"/></option>
                                                                 </c:when>

                                                                 <c:otherwise>
                                                               <option value ="${ploop.id}"><c:out value="${ploop.type}"/></option>
                                                                 </c:otherwise>
                                                                 </c:choose>


                                                             </c:forEach>


                                          </s:select>


								</div>
							</td>

							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">

								<div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
							      <s:text name="invoice.invoiceDetail[${loop.index}].dispatching" value="${orderdetailarray.orderedQuantity}" id="inOrdQty${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
                                </div>
                        	</td>
   							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
								<s:text name="invoice.order.orderDetail[${loop.index}].remainingQuantity" value="${orderdetailarray.remainingQuantity}" id="inRemQty${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
                                </div>
							</td>

							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="right"   style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
                                <s:text name="invoice.invoiceDetail[${loop.index}].productCost" value="${orderdetailarray.product.productCost}" id="inProdCost${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>

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
								    <s:text name="invoice.order.orderDetail[${loop.index}].amendmentQuantity" value="${orderdetailarray.amendmentQuantity}" id="inAmdQty${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>

								</div>
							</td>
							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
							<div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
									<s:text name="invoice.order.orderDetail[${loop.index}].amendmentCost" value="${orderdetailarray.amendmentCost}" id="inAmdCost${loop.index}" size="10" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
                                 <c:if test="${orderdetailarray.amendmentCost != null}">
                                <c:if test="${orderdetailarray.product.productMeasurementType.measurementType eq 'MT'}">
                                    <span id="mtype${loop.index}" style="margin-top:0px ; border:0px; text-align:right; background-color: #ccffcc; font-size: 12px;">MT</span>
                                </c:if>
                                <c:if test="${orderdetailarray.product.productMeasurementType.measurementType eq 'unit'}">
                                    <span id="utype${loop.index}" style="margin-top:0px ; border:0px; text-align:right; background-color: #ccffcc; font-size: 12px;">unit</span>
                                </c:if>
                                   </c:if>
									</div>
							</td>

							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="left" style="margin-top:5px; margin-bottom:5px; margin-right:1px; margin-left:1px; font-size: 12px;" class="labels">
                            			<s:text name="invoice.invoiceDetail[${loop.index}].dispatched" value="Enter Dispaching Qty" id="inDisp${loop.index}" size="20" onFocus="if(this.value=='Enter Dispaching Qty'){this.value='';}"
                                                disabled="disabled" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;" onchange="javascript: CalculateAmount(${loop.index});"/>
                                </div>

							</td>

							<td valign="top" style="border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px; ">
								<div align="right" style="margin-top:5px; margin-bottom:5px; margin-right:3px; font-size: 12px;" class="labels">
                                			<s:text name="invoice.invoiceDetail[${loop.index}].dueQuantity" value="0.00" id="inValue${loop.index}" size="20" readonly="readonly" maxlength="10" style="margin-top:0px ; border:0px; text-align:right;   font-size: 12px;"/>
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
									<s:text name="invoice.totalAmount" id="inTotalAmount"  size="20"  readonly="readonly" value="0.00" style="margin-top:0px ;background-color:#FFCC66; border:0px; text-align:right;"/>
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
						Excise @ <span id="t1"></span>%				</div>				</td>
              <td align="left" valign="top">
					<s:text name="invoice.exciseTax" id="inExcise" class="textbox" value="0.00"  size="22" readonly="readonly" style="text-align:right;" />
					<s:hidden name="invoice.excise" id="excise"/>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Education_Cess @ <span id="t2"></span>%				</div>				</td>
			  <td align="left" valign="top">
					<div align="left">
						<s:text name="invoice.educationCessTax" class="textbox" id="inEducationCess"  size="22" readonly="readonly" style="text-align:right;" value="0.00"/>
						<s:hidden name="invoice.educationCess" id="educationCess"/>
					</div>				</td>
			</tr>

			<tr>
            	<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Secondary & Higher <br>Edu_Cess @ <span id="t3"></span>	% </div>				</td>
              <td align="left">
					<s:text name="invoice.secondaryHigherEducationCessTax" id="inSec" class="textbox"  size="22" readonly="readonly" style="text-align:right;" value="0.00"/>
					<s:hidden name="invoice.secondaryHigherEducationCess" id="secondaryHigherEducationCess"/>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						<s:select name="invoice.cstOvatType" id="inCSTS"  class="dropdown" style="width:70px; margin-left:0px; font-size: 12px;" onchange="CSTOVAT();">
										<option value="OVAT">OVAT</option>
										<option value="CST">CST</option>
						</s:select>

                        @
                        <s:select name="invoice.cstOvat" id="inCSTSval"  class="dropdown" style="width:70px; margin-left:0px; font-size: 12px;" onchange="CST();">


						</s:select>
                        <span id="t6"></span> %

						<div id="ovatid" style="display: inline;">

						</div>

											</div>				</td>
              <td align="left" valign="top">
                           <s:hidden name="invoice.cstOvat" id="cstOvat"/>

					    <s:text name="invoice.cstOvatTax" id="inOvatnCst" class="textbox"  size="22" readonly="readonly" style="text-align:right;" value="0.00"/>
							</td>
			</tr>

			<tr>
				<td>&nbsp;				</td>
				<td>&nbsp;				</td>
				<td align="right" valign="top" nowrap>
					<div align="right" style="margin-left:15px;" class="labels">
						<b>Tax Charges ( B )<br> (Sum of Taxes)</b>					</div>				</td>
			  <td colspan="3" align="left" valign="top" >
					<s:text name="invoice.taxCharges" id="inTaxCharges"   size="22"  style="text-align:right;background-color:#FFCC66; "  class="textbox" readonly="readonly" value="0.00"/>				</td>
			</tr>

			<tr>
				<td align="right" valign="top">
                	<div align="right" style="margin-left:15px;" class="labels">
						Entry Tax (Appl. for OVAT) @<span id="t7"></span> %
					</div>
				</td>
                <td align="left" valign="top">
                    <s:hidden name="invoice.inEntryTaxGiven" id="inEntryTaxGiven"/>
					<s:text name="invoice.entry" class="textbox" id="inEntryTax"  value="0.00" readonly="readonly" size="22" style="text-align:right;"/>
				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Freight
					</div>
				</td>
                <td align="left">
					<div align="left">
						<s:text name="invoice.freight" class="textbox" id="inFright"  value="0.00" size="22" onchange="return validateFreight();" style="text-align:right;"/>
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
					<s:text name="invoice.insurance" class="textbox" id="inInsurance"  value="0.00" size="22" onchange="return validateInsurance();" style="text-align:right;"/>
				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Others
					</div>
				</td>
                <td align="left">
					<div align="left">
						<s:text name="invoice.others" id="inOthers" class="textbox"  value="0.00" size="22" onchange="return validateOthers();" style="text-align:right;"/>
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
					<s:text name="invoice.otherCharges" id="inOtherCharges"  class="textbox" type="text" size="22" readonly="readonly" value="0.00"  style="text-align:right;background-color:#FFCC66;"/>
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
									<b><u>Advance Available</u> &nbsp;</b>
									<img src="images/Rupee.JPG"/>&nbsp;

									<s:text name="invoice.amountReceived" value="${invoiceBean.advance.amountRemained}" id="inAdvance" size="11" readonly="readonly" style="border:0px; text-align:right;"/>

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

									<s:text name="invoice.grandTotal" id="inGrandTotal"  class="textbox" size="15"  readonly="readonly" style="border:0px; text-align:right;background-color:#FCFCFC;" value="0.00"/>
								</div>
							</td>
							<td align="left" valign="top">
							</td>
							<td  nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000;">
								<div align="center" class="labels">
									<b><u>Deduct Advance</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
                    		<s:text name="invoice.amountDetect"  value="0.00" id="inAdvanceEntered"  size="12" style="text-align:right;border:1px solid #FFCC66;" onFocus="if(this.value==''){this.value='0.00';}" onChange="return Adv();if(this.value==''){this.value='0.00';}"/>
								</div>
							</td>
							<td align="left" valign="top">
							</td>
							<td nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
								<div align="center">
        		<s:text name="invoice.netPayable" class="textbox" id="inNetPayable" size="15"  readonly="readonly" style="border:0px; text-align:right;background-color:#FCFCFC;" value="0.00"/>
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;

							</td>
							<td>&nbsp;

							</td>
							<td nowrap style="border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
								<div align="center" class="labels" style="margin-top: 10px;">
									<b><u>Advance Remain</u>&nbsp;&nbsp;&nbsp;&nbsp;</b>
								&nbsp;&nbsp;
									<s:text name="invoice.amountRemained" id="inAdvanceRemain"  size="11" readonly="readonly" style="border:0px; text-align:right;"/>
								</div>&nbsp;
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
						<s:text name="invoice.issueTime" id="inIssue" class="textbox" readonly="readonly"   style="text-align:right;"/>
								</div>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Removal Time					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="invoice.removalTime" class="textbox"  id="inRemoval" readonly="readonly"  style="text-align:right;"/>
										</div>				</td>
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
						<s:text name="invoice.stationto" class="textbox"  id="inst"  size="22" value=""/>				</div>				</td>
			</tr>

			<tr>
				<td align="right" valign="top">
                	<div align="right" style="margin-left:15px;" class="labels">
						Des Adv No.					</div>				</td>
              <td align="left">
						<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
							<s:text name="invoice.desAdvNo" class="textbox"  id="indesno"  value="" size="22"/>					</div>					</td>
					<td>
						<div align="right" style="margin-left:15px;" class="labels">
						FGN No.					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="invoice.fgnNo" class="textbox"  id="infgnno"  value="" size="22"/>				</div>				</td>
			</tr>
            <tr>
            	<td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						Mode of Dispatch					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="invoice.modeOfDispatch" id="inmode"  value="" size="22" class="textbox" />					</div>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Vehicle No.					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="invoice.vehicleNo" id="invehicle" type="text" value=""  size="22" class="textbox" />					</div>				</td>
			</tr>
            <tr>
				<td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						No. of Packages					</div>				</td>
              <td align="left">
					<div style="color: #ff0000; font-family: Verdana; font-size:10px ;">
						<s:text name="invoice.noOfPackages" id="inpack"  value="" class="textbox"  size="22" style="text-align:right;"/>				</div>				</td>
			</tr>
			<tr>
				<td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						Region & BR A/C Code					</div>				</td>
			  <td align="left">
					<div align="left">
						<s:text name="invoice.regBr" id="inbrcode" class="textbox"   value="" size="22"/>
					</div>				</td>
				<td>
					<div align="right" style="margin-left:15px;" class="labels">
						Contract Note No. & Date					</div>				</td>
              <td align="left">
					<div align="left">
						<s:text name="invoice.contNoteDate" id="incontract" readonly="readonly" onFocus="showCalendarControl(this);" class="textbox"  />
					</div>				</td>
			</tr>
            <tr>
				<td align="right" valign="top">
					<div align="right" style="margin-left:15px;" class="labels">
						RR/GCN No.						</div>					</td>
			  <td align="left">
							<div align="left">
								<s:text name="invoice.rrgcnNo" id="inrrgcn" class="textbox"   value="" size="22"/>
						</div>						</td>
					<td>
						<div align="right" style="margin-left:15px;" class="labels">
							Documents Through							</div>						</td>
              <td align="left">
							<div align="left">
						  		<s:text name="invoice.documentsThrough" class="textbox"  id="inDocuments"  value="" size="22"/>
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

						<s:textarea name="invoice.remark" wrap="off" id="inremark" style="height: 60px; width:694px;border:1px solid #FFCC66; text-align: left;resize:none"/>
												</td>
					</tr>
				  	<tr>
						<td>&nbsp;						</td>
					</tr>
					<tr>
						<td>&nbsp;						</td>
                        <td align="left" colspan="2">
							<%--<s:hidden  name="hdnAct" id="hdnAct" value=""/>--%>
							<%--<input type="button" value="Preview" class="buttons" name="inpreview" id="inpreview"  style="width:80px; margin-left: 60px;" onClick="return ValidateInvoice('Preview');">--%>

                      <s:hidden name="invoice.order.id" value="${invoiceBean.order.id}"/>


                      <s:hidden name="advance.order.id" value="${invoiceBean.advance.order.id}"/>


                      <s:hidden name="invoice.customer.id" value="${invoiceBean.order.customer.id}"/>

							<s:submit name="addgenerate" value="Generate" />
													&nbsp;&nbsp;
							<%--<input type="button" value="Cancel" class="buttons" name="Cancel" style="width:80px; margin-left: 10px;" onClick="javascript: cancel();">--%>

                            &nbsp;&nbsp; <s:submit name="addpreview" value="Preview"></s:submit>
                        </td>

				</tr>
</table>

 </s:form>
          </c:if>
      </div>

</s:layout-component>
 </s:layout-render>
