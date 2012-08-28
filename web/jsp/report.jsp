<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: May 31, 2012
  Time: 4:18:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen"/>
<link rel="stylesheet" type="text/css" href="..css/stylesheet.css"/>
<script type="text/javascript">
       $(function() {

		$.get("report?autocust",function(result) {
        var availableTags=eval(result);
        $("input#autocompletec").autocomplete({
            source: availableTags
        });
               })
		$.get("report?autoprod",function(result) {
        var availableTags=eval(result);
        $("input#autocompletep").autocomplete({
            source: availableTags
        });
               })
		});


$(document).ready(function(){
 $("#invoiceradio").click(function(){
  $(".byinvoice").show();
     $(".prodorcust").hide();
      $(".textboxfromto").hide();
         $(".textyear").hide();
         $(".fortodaydate").hide();
        $(".forselectdate").hide();
          $("#dailytable").hide();
           $(".autocompletecust").hide();
           $(".autocompleteprod").hide();
            $(".textboxmonth").hide();
         $(".prodorcust").hide();
        $("#producttable").hide();
      $("#alltaxtable").hide();
      $("#dailyradio").attr("checked", false);
         $("#fromtoradio").attr("checked", false);
     $("#yearlyradio").attr("checked", false);
         $("#monthlyradio").attr("checked", false);
 });
   $("#taxradio").click(function(){
  $(".byinvoice").show();
        $(".prodorcust").hide();
        $(".textboxfromto").hide();
         $(".textyear").hide();
         $(".fortodaydate").hide();
        $(".forselectdate").hide();
        $("#alltaxtable").hide();
          $("#dailytable").hide();
           $(".autocompletecust").hide();
           $(".autocompleteprod").hide();
            $(".textboxmonth").hide();
         $(".prodorcust").hide();
        $("#producttable").hide();
        $("#dailyradio").attr("checked", false);
         $("#fromtoradio").attr("checked", false);
     $("#yearlyradio").attr("checked", false);
         $("#monthlyradio").attr("checked", false);
 });
    $("#prodradio").click(function(){
  $(".autocompleteprod").show();
        $(".autocompletecust").hide();
         if ($('input[name=radio]:checked').val() == "byfromto" ) {
             $(".textboxfromto").show();
            // $(".textboxfromto").val("");
        }
        if ($('input[name=radio]:checked').val() == "bymonthly" ) {
             $(".textboxmonth").show();
            // $(".textboxmonth").val("");
        }
          if ($('input[name=radio]:checked').val() == "byyearly" ) {
             $(".textyear").show();
        }
 });
    /* $("#alltaxradio").click(function(){
  $(".autocompleteprod").hide();
        $(".autocompletecust").hide();
         $(".textboxfromto").hide();
           $(".textboxmonth").hide();
             $(".textyear").hide();

 })   */
     $("#custradio").click(function(){
  $(".autocompletecust").show();
         $(".autocompleteprod").hide();
          if ($('input[name=radio]:checked').val() == "byfromto" ) {
             $(".textboxfromto").show();
              // $(".textboxfromto").val("");
               //$(".textboxmonth").val("");
        }
          if ($('input[name=radio]:checked').val() == "bymonthly" ) {
             $(".textboxmonth").show();
        }
          if ($('input[name=radio]:checked').val() == "byyearly" ) {
             $(".textyear").show();
        }
 });
     $('input:radio[name="prodorcust"]').change(function(){
          if($(this).val() == 'byprod'){
           // alert("Give the Item Name.");
                      $.get("report?autoprod",function(result) {
	        var availableTags=eval(result);
             //     alert(availableTags)
                     $("input#autocompletep").autocomplete({


                         source: availableTags
                     });
		//$( "#tags" ).autocomplete({
		//	source: availableTags
		});
          }
           else if($(this).val() == 'bycust'){
           //  alert("Give the Grn No.");
               $.get("report?autocust",function(result) {
        var availableTags=eval(result);
        $("input#autocompletec").autocomplete({
            source: availableTags
        });
               });
          }
//$('#autocompletep').change(function()
//{
  // alert("hiii");
    // $(".byinvoice").show();
//});
     })


 $("#dailyradio").click(function(){
    //  if ($('input[name=stock]:checked').val() == "byInvoice" )

   $(".textboxfromto").hide();
   $(".textboxmonth").hide();
        $(".textyear").hide();
          $(".fortodaydate").show();
      $(".forselectdate").hide();
          $("#dailytable").hide();
       $(".prodorcust").hide();
       $(".autocompletecust").hide();
          $(".autocompleteprod").hide();
      $("#radio8").attr("checked", false);
         $("#radio9").attr("checked", false);
      $("#producttable").hide();
      $("#alltaxtable").hide();
      if ($('input[name=stock]:checked').val() == "byTax" )
     {
               $("#inv").hide();
         $("#inta").show();
           $("#radio8").attr("checked", false);
      ;}
           if ($('input[name=stock]:checked').val() == "byInvoice" )
     {

        $("#inv").show();
         $("#inta").hide();
           $("#radio8").attr("checked", false);
      }

 });
    $("#radio9").click(function(){
      $(".forselectdate").show();
     $("#dailytable").hide();
         $("#textboxh").val("");
    });
    $("#radio8").click(function(){
      $(".forselectdate").hide();

    })
    $("#fromtoradio").click(function(){
  //$(".textboxfromto").show();
  // if ($('input[name=stock]:checked').val() == "byInvoice" )
   $("#fromto").val("");
         $("#to").val("");
   $(".textboxmonth").hide();
        $(".textyear").hide();
         $(".fortodaydate").hide();
         $(".forselectdate").hide();
        $("#dailytable").hide();
         $("#alltaxtable").hide();
        $("#producttable").hide();
          $(".autocompletecust").hide();
          $(".autocompleteprod").hide();
         $(".textboxfromto").hide();
         $(".prodorcust").show();
        $("#prodradio").attr("checked", false);
         $("#custradio").attr("checked", false);
        $("#alltaxradio").attr("checked", false);
         $("#custradio").attr("checked", false);

         if ($('input[name=stock]:checked').val() == "byTax" )
     {
     $("#a").show();
     }
           if ($('input[name=stock]:checked').val() == "byInvoice" )
     {
     $("#a").hide();
      }

 });
     $("#monthlyradio").click(function(){
//   if ($('input[name=stock]:checked').val() == "byInvoice" )
  $(".textboxfromto").hide();
         $(".textyear").hide();
         $("#month").val("");
          $(".fortodaydate").hide();
        $(".forselectdate").hide();
          $("#dailytable").hide();
          $("#alltaxtable").hide();
          $("#producttable").hide();
           $(".autocompletecust").hide();
           $(".autocompleteprod").hide();
            $(".textboxmonth").hide();
         $(".prodorcust").show();
         $("#prodradio").attr("checked", false);
         $("#custradio").attr("checked", false);
          $("#alltaxradio").attr("checked", false);

          if ($('input[name=stock]:checked').val() == "byTax" )
     {
     $("#a").show();
     }
          if ($('input[name=stock]:checked').val() == "byInvoice" )
     {
     $("#a").hide();
      }

 });

    $("#yearlyradio").click(function(){
        // if ($('input[name=stock]:checked').val() == "byInvoice" )
  //$(".textyear").show();
  $(".textboxfromto").hide();
         $(".textboxmonth").hide();
         $(".textyear").hide();
        $("#y").val("");
          $(".fortodaydate").hide();
          $(".forselectdate").hide();
          $("#dailytable").hide();
         $("#alltaxtable").hide();
         $("#producttable").hide();
           $(".autocompletecust").hide();
           $(".autocompleteprod").hide();
         $(".prodorcust").show();
         $("#prodradio").attr("checked", false);
         $("#custradio").attr("checked", false);
         $("#alltaxradio").attr("checked", false);

         if ($('input[name=stock]:checked').val() == "byTax" )
     {
     $("#a").show();

      ;}
           if ($('input[name=stock]:checked').val() == "byInvoice" )
     {
     $("#a").hide();

      }

 });
    $("#prodradio").click(function(){
$("#autocompletep").val("");
         $("#fromto").val("");
         $("#to").val("");
         $("#y").val("");
        $("#year").val("");
        $("#month").val("");
         $("#producttable").hide();
         $("#dailytable").hide();
         $("#alltaxtable").hide();

});
    $("#custradio").click(function(){
        $("#autocompletec").val("");
         $("#fromto").val("");
         $("#to").val("");
         $("#y").val("");
        $("#year").val("");
        $("#month").val("");
        $("#producttable").hide();
         $("#dailytable").hide();
         $("#alltaxtable").hide();
});
    $("#alltaxradio").click(function(){
         $(".autocompleteprod").hide();
        $(".autocompletecust").hide();
     if ($('input[name=radio]:checked').val() == "byyearly" )
     {
     $(".textyear").show();
          $(".textboxmonth").hide();
          $(".textboxfromto").hide();
         $("#y").val("");
           $("#alltaxtable").hide();
           $("#dailytable").hide();
          $("#producttable").hide();
     }
    if ($('input[name=radio]:checked').val() == "bymonthly" )
     {
     $(".textboxmonth").show();
          $(".textyear").hide();
          $(".textboxfromto").hide();
             $("#month").val("");
            $("#year").val("");
           $("#alltaxtable").hide();
           $("#dailytable").hide();
          $("#producttable").hide();
     }
         if ($('input[name=radio]:checked').val() == "byfromto" )
     {
     $
             (".textboxmonth").hide();
          $(".textyear").hide();
         $(".textboxfromto").show();
         $(".textboxfromto").val("");
         $("#fromto").val("");
         $("#to").val("");
          $("#alltaxtable").hide();
           $("#dailytable").hide();
          $("#producttable").hide();
     }
    });

    //for validation.....
     $("#getselectbydatebtn").click(function()
                            {

                             if ($("#textboxh").val().trim() ==""){
                                    alert("Select the date.");
                                    $("#addproductname").focus() ;
                                    return false;
                                }
                              return true;
                            });
             $("#getfrom").click(function()
                            {
                              if ($('input[name=prodorcust]:checked').val() == "byprod" ){
                             if ($("#autocompletep").val().trim() ==""){
                                    alert("Select the product.");
                                    $("#autocompletep").focus() ;
                                    return false;
                                }}
                                if ($('input[name=prodorcust]:checked').val() == "bycust" ){
                                  if ($("#autocompletec").val().trim() ==""){
                                    alert("Select the customer.");
                                    $("#autocompletec").focus() ;
                                    return false;
                                }}
                                  if ($("#fromto").val().trim() ==""){
                                    alert("Select the from date.");
                                    $("#fromto").focus() ;
                                    return false;
                                }
                                  if ($("#to").val().trim() ==""){
                                    alert("Select the to date.");
                                    $("#to").focus() ;
                                    return false;
                                }
                              return true;
                            });
    $("#getmonth").click(function()
                               {

                               if ($('input[name=prodorcust]:checked').val() == "byprod" ){
                             if ($("#autocompletep").val().trim() ==""){
                                    alert("Select the product.");
                                    $("#autocompletep").focus() ;
                                    return false;
                                }}
                                if ($('input[name=prodorcust]:checked').val() == "bycust" ){
                                  if ($("#autocompletec").val().trim() ==""){
                                    alert("Select the customer.");
                                    $("#autocompletec").focus() ;
                                    return false;
                                }}
                                     if ($("#month").val().trim() ==""){
                                       alert("Select the month.");

                                       return false;
                                   }
                                     if ($("#year").val().trim() ==""){
                                       alert("Select the year.");

                                       return false;
                                   }
                                 return true;
                               });
     $("#byYear").click(function()
                               {

                               if ($('input[name=prodorcust]:checked').val() == "byprod" ){
                             if ($("#autocompletep").val().trim() ==""){
                                    alert("Select the product.");
                                    $("#autocompletep").focus() ;
                                    return false;
                                }}
                                if ($('input[name=prodorcust]:checked').val() == "bycust" ){
                                  if ($("#autocompletec").val().trim() ==""){
                                    alert("Select the customer.");
                                    $("#autocompletec").focus() ;
                                    return false;
                                }}
                                     if ($("#y").val().trim() ==""){
                                       alert("Select the year.");

                                       return false;
                                   }

                                 return true;
                               });


 });





</script>
<s:useActionBean beanclass="com.inwise.action.ReportActionBean" var="reportBean" event="page" ></s:useActionBean>
<s:layout-render name="/layout/_base.jsp">
    <s:layout-component name="body">
          <s:form beanclass="com.inwise.action.ReportActionBean">
   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
 <tr valign="top"><td >&nbsp;
 </td></tr>
 <tr><td align="left" class="pageheading" valign="top">
Report
 </td></tr>
 <tr valign="top"><td align="center">&nbsp;
 </td></tr>
 </table>
  <table bordercolor="#FF6600" width="90%" border="1">
 <tr>
 <td width="100%" height="200">
      <table width="100%"  cellspacing="1">
          <tr class="firstrow">
                   <td width="8%" height="21"  align="left" valign="top">Search </td>
                   <td width="1%"  align="right" valign="top"><s:radio  value="byInvoice" id="invoiceradio"  name="stock"></s:radio></td>
                   <td width="8%"  align="left" valign="top">By Invoice</td>
                   <td width="1%">&nbsp;</td>
                   <td width="3%"  align="right" valign="top"><s:radio  value="byTax" id="taxradio"  name="stock"></s:radio></td>
                   <td width="9%"  align="left" valign="top">By Tax</td>
                    <td width="1%">&nbsp;</td>
                  <td width="3%">&nbsp;</td>
                 <td width="9%">&nbsp;</td>
                  <td width="1%">&nbsp;</td>
                  <td width="3%">&nbsp;</td>
                 <td width="9%">&nbsp;</td>
                  <td width="1%">&nbsp;</td>
                  <td width="3%">&nbsp;</td>
                 <td width="9%">&nbsp;</td>
                 </tr>

             <tr class="byinvoice" style="display:none;">
                 <td>&nbsp;</td>
                 <td><s:radio  value="bydaily" id="dailyradio"  name="radio"></s:radio></td>
                 <td>Daily</td>
                 <td>&nbsp;</td>
                 <td><s:radio  value="byfromto" id="fromtoradio"  name="radio"></s:radio></td>
                 <td>From To</td>
                 <td width="1%">&nbsp;</td>
                  <td width="3%"><s:radio  value="bymonthly" id="monthlyradio"  name="radio"></s:radio></td>
                 <td width="9%">Monthly</td>
                  <td width="1%">&nbsp;</td>
                  <td width="3%"><s:radio  value="byyearly" id="yearlyradio"  name="radio"></s:radio></td>
                 <td width="9%">Yearly</td>
                  <td width="1%">&nbsp;</td>
                  <%--<td width="3%"><s:radio  value="bydailyledger" id="ledgerradio"  name="radio"></s:radio></td>
                 <td width="9%">Daily Ledger</td>--%>
             </tr>
              <tr class="fortodaydate" style="display:none; border-bottom:1 ">
                   <td width="8%"  align="left" valign="top"></td>
                   <td width="1%"  align="right" valign="top">
                  <div id="inv" style="display:none;">
                      <s:link beanclass="com.inwise.action.ReportActionBean" event="bytoday">

                      <s:param name="stock" value="byInvoice"></s:param>
                       <s:radio  value="byToday" id="radio8"  name="daily"></s:radio>
                       </s:link></div>
                        <%--<div id="inta" style="display:none;"> <s:link beanclass="com.inwise.action.ReportActionBean" event="bytoday">

                            <s:param name="stock" value="byTax"></s:param>
                       <s:radio  value="byToday" id="radio8"  name="daily"></s:radio>
                       </s:link></div>--%>
                   </td>
                   <td width="8%"  align="left" valign="top">By Today</td>
                   <td width="1%">&nbsp;</td>
                   <td width="3%"  align="right" valign="top"><s:radio  value="bySelectDate" id="radio9"  name="daily"></s:radio></td>
                   <td width="10%"  align="left" valign="top">By Date</td>
                 </tr>

                <tr class="forselectdate" style="display:none;" >
                   <td width="8%" height="21" align="left" valign="top"></td>
                   <td width="1%" colspan=""  align="right" valign="top"></td>
                   <td  align="right" colspan="2" valign="top"><strong>Select Date</strong> </td>
                   <td  align="left" colspan="7" valign="top"><s:text name="sdate" id="textboxh" readonly="readonly" onFocus="showCalendarControl(this);" class="textbox"></s:text>
                       &nbsp;&nbsp;<s:submit name="bySelectDate" id="getselectbydatebtn" value="Get"></s:submit></td>
               <td  align="left" colspan="3" valign="top"></td>

                 </tr>
           <tr class="prodorcust" style="display:none;">
                 <td>&nbsp;</td>
                 <td><s:radio  value="byprod" id="prodradio"  name="prodorcust"></s:radio></td>
                 <td>Productwise</td>
                 <td>&nbsp;</td>
                 <td><s:radio  value="bycust" id="custradio"  name="prodorcust"></s:radio></td>
                 <td>Customerwise</td>
               <td>&nbsp;</td>
               <td id="a" style="display:none;" colspan="2"><div><s:radio  value="alltax" id="alltaxradio"  name="prodorcust"></s:radio>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; All Tax</div></td>
           </tr>

          <tr class="autocompleteprod" style="margin-left: 2px; display:none;">
              <td>&nbsp;</td>
                               <td colspan="8" align="left" valign="top">
                    <s:label name="Select Product"></s:label>&nbsp;&nbsp;&nbsp;&nbsp;
             <s:text name="productget" class="textbox" id="autocompletep" ></s:text></td>

          </tr>

          <tr class="autocompletecust" style="margin-left: 2px; display:none;">
              <td>&nbsp;</td>
                               <td colspan="8" align="left" valign="top">
                    <s:label name="Select Customer"></s:label>&nbsp;&nbsp;&nbsp;&nbsp;
             <s:text name="customerget" class="textbox" id="autocompletec" ></s:text></td>

          </tr>


              <tr class="textboxfromto"  style="display:none;">
                  <td>&nbsp;</td>
                  <td colspan="4" align="left" valign="top">
 	  <s:label name="From"></s:label>&nbsp;&nbsp;&nbsp;&nbsp;<s:text name="from" class="textbox" id="fromto" readonly="readonly" onFocus="showCalendarControl(this);" ></s:text></td>

                  <td colspan="3" align="left" valign="top">
 	  <s:label name="To"></s:label>&nbsp;&nbsp;&nbsp;&nbsp;<s:text name="to" class="textbox" id="to" readonly="readonly" onFocus="showCalendarControl(this);" ></s:text></td>
                 <td align="left"><s:submit name="getfromto" value="Show" id="getfrom" ></s:submit></td>
              </tr>
                <tr class="textboxmonth"  style="display:none;">
                  <td>&nbsp;</td>
                  <td colspan="7" align="left" valign="top">
 	  <s:label name="Month"></s:label>&nbsp;&nbsp;&nbsp;&nbsp;
                      <s:select name="monthly" id="month" class="dropdown">
            <option  value="">----Select Month----</option>
            <option value="01">January</option><option value="02">February</option><option value="03">March</option>
       <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
<option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option><option value="12">December</option>
         </s:select>&nbsp;&nbsp;&nbsp;&nbsp;
         <s:select id="year" name="year" class="dropdown">
            <%int year = 2011;%>
            <option  value="">---Select Year---</option>
            <c:forEach var="i" begin="<%=year %>" end="<%=year + 20 %>">
                 <option value="<c:out value="${i+1}"/>"><c:out value="${i+1}"/></option>
            </c:forEach>
         </s:select></td>

                  <td colspan="4" align="left" valign="top">
 	  <s:submit name="getmonth" value="Show" id="getmonth" ></s:submit>
                 <td></td>
              </tr>
               <tr class="textyear" style="display:none;">
                  <td>&nbsp;</td>
                  <td colspan="4" align="left" valign="top">
 	  <s:label name="Year"></s:label>&nbsp;&nbsp;&nbsp;&nbsp;
                  <s:select id="y" name="y" class="dropdown">
                            <%int year = 2011;%>
                        <option  value="">---Select Year---</option>

                <c:forEach var="i" begin="<%=year %>" end="<%=year + 20 %>">
                    <option value="<c:out value="${i+1}"/>"><c:out value="${i+1}"/></option>
                </c:forEach>
            </s:select></td>

                  <td colspan="4" align="left" valign="top">
 	  <s:submit name="byYear" value="Show" id="byYear" ></s:submit>
                 <td></td>
              </tr>
         </table></td></tr></table>
              <c:if test="${actionBean.daily eq 'byToday' && actionBean.stock eq 'byTax'}">
<script type="text/javascript">
        $(document).ready(function() {
    $('.byinvoice').show();
            $('.fortodaydate').show();
         $('#inta').show();
            $("#inv").hide();
        });
  </script>
    </c:if >
   <c:if test="${actionBean.daily eq 'byToday' && actionBean.stock eq 'byInvoice'}">
<script type="text/javascript">
        $(document).ready(function() {
    $('.byinvoice').show();
            $('.fortodaydate').show();
         $('#inv').show();
            $("#inta").hide();
              $("#radio8").attr("checked", true);
        });
  </script>
    </c:if >
               <c:if test="${actionBean.daily eq 'bySelectDate' && actionBean.stock eq 'byInvoice' }">
<script type="text/javascript">
        $(document).ready(function() {
    $('.byinvoice').show();
            $('.fortodaydate').show();
             $('.forselectdate').show();
             $('#inv').show();
            $("#inta").hide();
        });
  </script>
    </c:if >
    <c:if test="${actionBean.daily eq 'bySelectDate' && actionBean.stock eq 'byTax' }">
<script type="text/javascript">
        $(document).ready(function() {
    $('.byinvoice').show();
            $('.fortodaydate').show();
             $('.forselectdate').show();
             $('#inv').hide();
            $("#inta").show();
        });
  </script>
    </c:if >
              <c:if test="${actionBean.radio eq 'bymonthly' && actionBean.test ne 'c'}">
<script type="text/javascript">
        $(document).ready(function() {
    $('.byinvoice').show();
           $('.textboxmonth').show();
            $('.fortodaydate').hide();
             $('.forselectdate').hide();
             var fromact=${actionBean.monthly};
                        if(fromact<9)
                        {
                        var m="0"+${actionBean.monthly};
                        $('#month').attr("value",m);
                        }
                         else
                           $('#month').attr("value",fromact);

            $('#year').attr("value",${actionBean.year});

             if ($('input[name=radio]:checked').val() == "bymonthly" && $('input[name=prodorcust]:checked').val() == "bycust"  ) {
             $(".autocompletecust").show();
              $(".prodorcust").show();
             }
            if ($('input[name=radio]:checked').val() == "bymonthly" && $('input[name=prodorcust]:checked').val() == "byprod"  ) {
             $(".autocompleteprod").show();
              $(".prodorcust").show();
             }
              if ($('input[name=stock]:checked').val() == "byTax" )
     {
     $("#a").show();

      ;}
           if ($('input[name=stock]:checked').val() == "byInvoice" )
     {
     $("#a").hide();

      }

        });
  </script>
    </c:if >
    <c:if test="${actionBean.radio eq 'bymonthly' && actionBean.test eq 'c'}">
<script type="text/javascript">
        $(document).ready(function() {
    $('.byinvoice').show();
              $('.textyear').hide();
           $('.textboxmonth').show();
            $('.fortodaydate').hide();
             $('.forselectdate').hide();
             var fromact=${actionBean.monthly};
                        if(fromact<9)
                        {
                        var m="0"+${actionBean.monthly};
                        $('#month').attr("value",m);
                        }
                         else
                           $('#month').attr("value",fromact);
            $('#year').attr("value",${actionBean.year});
                    $("#a").show();
             $(".prodorcust").show();
             $("#alltaxradio").attr("checked", true);


        });
  </script>
    </c:if >
    <c:if test="${actionBean.radio eq 'byyearly' && actionBean.test eq 'c'}">
<script type="text/javascript">
        $(document).ready(function() {

    $('.byinvoice').show();
           $('.textboxmonth').hide();
           $('.textyear').show();
            $('.fortodaydate').hide();
             $('.forselectdate').hide();
               $("#a").show();
             $(".prodorcust").show();
            $('#y').attr("value",${actionBean.y});
            $("#alltaxradio").attr("checked", true);

        });</script>
    </c:if >
              <c:if test="${actionBean.radio eq 'byyearly' && actionBean.test ne 'c'}">
<script type="text/javascript">
        $(document).ready(function() {
    $('.byinvoice').show();
           $('.textyear').show();
            $('.fortodaydate').hide();
             $('.forselectdate').hide();


            $('#y').attr("value",${actionBean.y});
             if ($('input[name=radio]:checked').val() == "byyearly" && $('input[name=prodorcust]:checked').val() == "bycust"  ) {
             $(".autocompletecust").show();
              $(".prodorcust").show();
             }
            if ($('input[name=radio]:checked').val() == "byyearly" && $('input[name=prodorcust]:checked').val() == "byprod"  ) {
             $(".autocompleteprod").show();
              $(".prodorcust").show();
             }
              if ($('input[name=stock]:checked').val() == "byTax" )
     {
     $("#a").show();

      ;}
           if ($('input[name=stock]:checked').val() == "byInvoice" )
     {
     $("#a").hide();

      }
        });
  </script>
    </c:if >

              <c:if test="${actionBean.radio eq 'byfromto'  && actionBean.test eq 'c'}">
<script type="text/javascript">
        $(document).ready(function() {
    $('.byinvoice').show();
           $('.textboxfromto').show();
            $('.fortodaydate').hide();
             $('.forselectdate').hide();
          $("#a").show();
             $(".prodorcust").show();
             $("#alltaxradio").attr("checked", true);
             $('.textyear').hide();

        });
  </script>
    </c:if >
    <c:if test="${actionBean.radio eq 'byfromto'  && actionBean.test ne 'c'}">
<script type="text/javascript">
        $(document).ready(function() {
    $('.byinvoice').show();
           $('.textboxfromto').show();
            $('.fortodaydate').hide();
             $('.forselectdate').hide();
          if ($('input[name=radio]:checked').val() == "byfromto" && $('input[name=prodorcust]:checked').val() == "bycust"   ) {
             $(".autocompletecust").show();
              $(".prodorcust").show();
        }
             if ($('input[name=radio]:checked').val() == "byfromto" && $('input[name=prodorcust]:checked').val() == "byprod"  ) {
             $(".autocompleteprod").show();
              $(".prodorcust").show();
             }
         if ($('input[name=stock]:checked').val() == "byTax" )
     {
     $("#a").show();

      ;}
           if ($('input[name=stock]:checked').val() == "byInvoice" )
     {
     $("#a").hide();

      }


        });
  </script>
    </c:if >

             <s:useActionBean beanclass="com.inwise.action.ReportActionBean" event="bytoday" var="list"></s:useActionBean>
            <%
                request.setAttribute("invoicelst",list.getInvoicelst());
                request.setAttribute("lst",list.getLst());
            %>

            <c:if test="${actionBean.invoicelst!=null && list.test=='a'}">
           <table id="dailytable"  width="100%"><tr><td>
          <d:table name="invoicelst" id="v" pagesize="10" class="disp" requestURI="/report">
              <d:column property="invoiceNumber" title="Invoice Number"/>
                  <d:column  property="createDate" format="{0,date,yyyy-MM-dd}" sortable="false" title="Create Date"/>
              <d:column property="netPayable" format="{0,number,0.00}" title="Net Payable Amount"/>


           </d:table></td></tr>
           </table>  </c:if>
   <%

       org.displaytag.decorator.TotalTableDecorator totals = new org.displaytag.decorator.TotalTableDecorator();
       totals.setTotalLabel("full total");
       totals.setSubtotalLabel("partial amount");
       pageContext.setAttribute("totals", totals);

          %>
    


                      <c:if test="${actionBean.lst!=null && list.test=='a'}">

                     <table id="producttable"  width="100%"><tr><td>

          <d:table name="lst" id="v" pagesize="10" class="disp" requestURI="report">
               <d:column property="invoice_number" title="Invoice Number"/>
                  <d:column  property="create_date" format="{0,date,yyyy-MM-dd}" sortable="false" title="Create Date"/>
              <d:column property="net_payable" format="{0,number,0.00}" title="Net Payable Amount"/>


           </d:table></td></tr>
           </table>
                   </c:if>
           <c:if test="${actionBean.invoicelst!=null && list.test=='b'}">
           <table id="dailytable"  width="100%"><tr><td>
          <d:table name="invoicelst" id="v" pagesize="10" class="disp" requestURI="/report" decorator="totals">
              <d:column property="invoiceNumber" title="Invoice Number"/>
                  <d:column  property="createDate" format="{0,date,yyyy-MM-dd}" sortable="false" title="Create Date"/>
              <d:column property="excise" title="Excise Tax" format="{0,number,0.00}" total="true" class="r"/>
               <d:column property="educationCess" title="Education Cess" format="{0,number,0.00}" total="true" class="r"/>
               <d:column property="secondaryHigherEducationCess" format="{0,number,0.00}" title="Secondary Higher Education Cess" total="true" class="r"/>
               <d:column property="cstOvat" format="{0,number,0.00}" title="Cst Ovat" total="true" class="r"/>

           </d:table></td></tr>
           </table>  </c:if>

           <c:if test="${actionBean.lst!=null && list.test=='b'}">
           <table id="producttable"  width="100%"><tr><td>
          <d:table name="lst" id="v" pagesize="10" class="disp" requestURI="/report" decorator="totals">
              <d:column property="invoice_number" title="Invoice Number" />
                  <d:column  property="create_date" format="{0,date,yyyy-MM-dd}" sortable="false" title="Create Date"/>
              <d:column property="excise" title="Excise Tax" total="true" format="{0,number,0.00}" class="r"/>
               <d:column property="education_cess" title="Education Cess" format="{0,number,0.00}" total="true" class="r"/>
               <d:column property="secondary_higher_education_cess_tax" format="{0,number,0.00}" title="Secondary Higher Education Cess" total="true" class="r"/>
               <d:column property="cst_ovat" title="Cst Ovat" format="{0,number,0.00}" total="true" class="r"/>

           </d:table></td></tr>
           </table>  </c:if>
          <c:if test="${actionBean.invoicelst!=null && list.test=='c'}">
           <table id="alltaxtable"  width="100%"><tr><td>
          <d:table name="invoicelst" id="v" pagesize="10" class="disp" requestURI="/report" decorator="totals">
              <d:column property="invoiceNumber" title="Invoice Number"/>
                  <d:column  property="createDate" format="{0,date,yyyy-MM-dd}" sortable="false" title="Create Date"/>
              <d:column property="excise" format="{0,number,0.00}" title="Excise Tax" total="true" class="r"/>
               <d:column format="{0,number,0.00}" property="educationCess" title="Education Cess" total="true" class="r"/>
               <d:column format="{0,number,0.00}" property="secondaryHigherEducationCess" title="Secondary Higher Education Cess" total="true" class="r"/>
               <d:column property="cstOvat" format="{0,number,0.00}" title="Cst Ovat" total="true" class="r"/>

           </d:table></td></tr>
           </table>  </c:if>

 </s:form>
 </s:layout-component>
 </s:layout-render>