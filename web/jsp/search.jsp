<%--
Created by IntelliJ IDEA.
User: Milind
Date: Mar 2, 2012
Time: 10:21:30 AM
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/includes/_taglibInclude.jsp" %>
<link rel="stylesheet" href="css/general.css" type="text/css" media="screen"/>
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>
<c:set var = "TR1" value="receiptgrn"/>
<c:if test="${actionBean.hdnvalue eq TR1}">
<script type="text/javascript">
        function OpenPopup(){
            var w = 760;
            var h = 450;
            var winl = (screen.width-w)/2;
            var wint = (screen.height-h)/2;
            if (winl < 0) winl = 0;
            if (wint < 0) wint = 0;
            var page = "Search.action?redirectgrnpopup=&id="+${actionBean.id}+"";
            windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no," + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
            window.open(page, "Popup", windowprops);
            return;
        }
        window.onLoad =OpenPopup();
    </script>
</c:if >
<c:set var = "TR2" value="receipt"/>
<c:if test="${actionBean.hdnvalue eq TR2}">
<script type="text/javascript">
        function OpenPopup(){
            var w = 760;
            var h = 450;
            var winl = (screen.width-w)/2;
            var wint = (screen.height-h)/2;
            if (winl < 0) winl = 0;
            if (wint < 0) wint = 0;
            var page = "Search.action?redirectpopup=&id="+${actionBean.id}+"&name=+${actionBean.name}+";
            windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no," + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
            window.open(page, "Popup", windowprops);
            return;
        }
        window.onLoad =OpenPopup();
    </script>
</c:if >
<c:set var = "TR3" value="receiptpurchase"/>
<c:if test="${actionBean.hdnvalue eq TR3}">
    <script type="text/javascript">
        function OpenPopup(){

            var w = 780;
            var h = 450;
            var winl = (screen.width-w)/2;
            var wint = (screen.height-h)/2;
            if (winl < 0) winl = 0;
            if (wint < 0) wint = 0;
            var page = "Search.action?redirectpurchase=&id="+${actionBean.id}+"";
            windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,"
                    + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
            window.open(page, "Popup", windowprops);
            return;
        }
        window.onLoad =OpenPopup();
    </script>
</c:if >
<script type="text/javascript">

function combo(){
    var submenuvalue=$('#hiddenSubMenu').html();
    var aval=$('#autocompleteval').html();

    if(blank !="")
        blank="";
    else
    {
        $('#myDiv1').hide();
            $('#myDiv2').hide();
            $('#myDiv3').hide();
            $('.t').hide();

    }

    if($('#menu').val()=='byInwise')
    {


        var inwise = document.getElementById("submenu");
         var options=inwise.getElementsByTagName("option");
         var i;
         // Loop through the array of options and remove each
         // each one from the parent's childNode list.
         for (i=0; i<options.length; i++)
         {
         inwise.removeChild(options[i]);
         }// end for i
        var inwisevalue=new Array("none","inwiseNumber","inwiseCustomerOrderNo","inwiseCustomerName","inwiseProductName","inwiseDate");
        var inwiseshow=new Array("--Select Inwise Options--","Inwise Number","Customer Order Number","Customer Name","Product Name","Inwise Date");
        for(var i=0;i<inwisevalue.length;i++){
                    var t=inwisevalue[i];
                    if(t==submenuvalue){
                       inwise.options[i]=new Option(inwiseshow[i],inwisevalue[i],false,true);

                    }
                    else
                       inwise.options[i]=new Option(inwiseshow[i],inwisevalue[i]);
               }    //end of for
    }
    else if($('#menu').val()=='byOrder')
    {
        var order=document.getElementById("submenu");
         var options=order.getElementsByTagName("option");
         var i;
          for (i=0; i<options.length; i++)
         {
         order.removeChild(options[i]);
         }// end for i
        var ordervalue=new Array("none","orderCustomerOrderNumber","orderCustomerName","OrderProductName","orderDate");
        var ordershow=new Array("--Select Order Options--","Customer Order Number","Customer Name","Product Name","Order Date");
        for(var i=0;i<ordervalue.length;i++){
                    var t=ordervalue[i];
                    if(t==submenuvalue){
                       order.options[i]=new Option(ordershow[i],ordervalue[i],false,true);}
                    else
                       order.options[i]=new Option(ordershow[i],ordervalue[i]);
               }    //end of for

    }
    else if($('#menu').val()=='byCustomer')
        {
            var cust=document.getElementById("submenu");
            var options=cust.getElementsByTagName("option");
            var i;

            for (i=0; i<options.length; i++)
            {
                cust.removeChild(options[i]);
            }// end for i
            var custvalue=new Array("none","custName","custCode");
                var custshow=new Array("--Select Customer Option --","By Customer Name","By Customer Code");
                for(var i=0;i<custvalue.length;i++){
                    var t=custvalue[i];
                    if(t==submenuvalue){
                       cust.options[i]=new Option(custshow[i],custvalue[i],false,true);}
                    else
                       cust.options[i]=new Option(custshow[i],custvalue[i]);
               }    //end of for

        }

}
  var hide=$('#hiddenSubMenu').html();
  var blank=$('#hiddenSubMenu').html();
function fillsubmenu(){

   if(hide != "")
      hide="";
   else
   {
       $('.t').hide();
       $('#autocomplete').val("");
       $('.textbox').val("");

   }   //"none","inwiseNumber","inwiseCustomerOrderNo","inwiseCustomerName","inwiseProductName","inwiseDate"
    if($('#submenu').val() == 'inwiseNumber'){
         $('#myDiv3').hide();
              $('#myDiv2').hide();
              $('#myDiv1').show();
          $.post("Search.action?autoinwise", {ajaxSubmenu:$('#submenu').val()}, function (result) {
            var availableTags=eval(result);
            $("input#autocomplete").autocomplete({
                source: availableTags
            });
        });
    }
    else if($('#submenu').val() == 'inwiseCustomerOrderNo'){
          $('#myDiv3').hide();
              $('#myDiv2').hide();
              $('#myDiv1').show();
          $.post("Search.action?autoinwise", {ajaxSubmenu:$('#submenu').val()}, function (result) {
            var availableTags=eval(result);
            $("input#autocomplete").autocomplete({
                source: availableTags
            });
        });
    }
     else if($('#submenu').val() == 'inwiseCustomerName'){
             $('#myDiv3').hide();
              $('#myDiv2').hide();
              $('#myDiv1').show();
          $.post("Search.action?autoinwise", {ajaxSubmenu:$('#submenu').val()}, function (result) {
            var availableTags=eval(result);
            $("input#autocomplete").autocomplete({
                source: availableTags
            });
        });
    }
    else if($('#submenu').val() == 'inwiseProductName'){
               $('#myDiv3').hide();
              $('#myDiv2').hide();
              $('#myDiv1').show();
          $.post("Search.action?autoinwise", {ajaxSubmenu:$('#submenu').val()}, function (result) {
            var availableTags=eval(result);
            $("input#autocomplete").autocomplete({
                source: availableTags
            });
        });
    }
    else if($('#submenu').val() == 'inwiseDate'){
               $('#myDiv3').hide();
              $('#myDiv2').hide();
              $('#myDiv1').show();
          $.post("Search.action?autoinwise", {ajaxSubmenu:$('#submenu').val()}, function (result) {
            var availableTags=eval(result);
            $("input#autocomplete").autocomplete({
                source: availableTags
            });
        });
    }
      //"none","orderCustomerOrderNumber","orderCustomerName","OrderProductName","orderDate"
    else if($('#submenu').val() == 'orderCustomerOrderNumber'){
                     $('#myDiv3').hide();
              $('#myDiv2').hide();
              $('#myDiv1').show();
          $.post("Search.action?autoorder", {ajaxSubmenu:$('#submenu').val()}, function (result) {
            var availableTags=eval(result);
            $("input#autocomplete").autocomplete({
                source: availableTags
            });
        });
    }
    else if($('#submenu').val() == 'orderCustomerName'){
               $('#myDiv3').hide();
              $('#myDiv2').hide();
              $('#myDiv1').show();
                 $.post("Search.action?autoorder", {ajaxSubmenu:$('#submenu').val()}, function (result) {

                var availableTags=eval(result);
                $("input#autocomplete").autocomplete({
                    source: availableTags
                });
            });
        }
       else if($('#submenu').val() == 'OrderProductName'){
                              $('#myDiv3').hide();
              $('#myDiv2').hide();
              $('#myDiv1').show();
                 $.post("Search.action?autoorder", {ajaxSubmenu:$('#submenu').val()}, function (result) {

                var availableTags=eval(result);
                $("input#autocomplete").autocomplete({
                    source: availableTags
                });
            });
        }
       else if($('#submenu').val() == 'orderDate'){
                $('#myDiv3').hide();
                $('#myDiv2').show();
                $('#myDiv1').hide();
                $.post("Search.action?autoorder", {ajaxSubmenu:$('#submenu').val()}, function (result) {
                var availableTags=eval(result);
                $("input#autocomplete").autocomplete({
                    source: availableTags
                });
            });
        }
     //"none","custName","custCode"
       else if($('#submenu').val() == 'custName'){
                                   $('#myDiv3').hide();
              $('#myDiv2').hide();
              $('#myDiv1').show();
                 $.post("Search.action?autocust", {ajaxSubmenu:$('#submenu').val()}, function (result) {
           /* $.get("/Search.action?autovendor",function(result) {*/
                var availableTags=eval(result);
                $("input#autocomplete").autocomplete({
                    source: availableTags
                });
            });
        }
       else if($('#submenu').val() == 'custCode'){
                      $('#myDiv3').hide();
              $('#myDiv2').hide();
              $('#myDiv1').show();
                 $.post("Search.action?autocust", {ajaxSubmenu:$('#submenu').val()}, function (result) {
           /* $.get("/Search.action?autovendor",function(result) {*/
                var availableTags=eval(result);
                $("input#autocomplete").autocomplete({
                    source: availableTags
                });
            });
        }

}
$(document).ready(function() {

    $('#menu').change();

           fillsubmenu();

    $("#seperategetbtn").click(function(){
        if ($("#autocomplete").val().trim()==""){
            alert("please enter search details.");
            return false;
        }
        var varsubmenu=$("#submenu option:selected").val().trim().toString();
       if(varsubmenu=='none')
        {
        alert("Please,Select Search By Option");
        return false;
        }
        else if(varsubmenu=='grnNumber' || varsubmenu=='siNumber' || varsubmenu=='siRequisitionId')
       {
            var chk = /^[0-9]+$/.test($('#autocomplete').val().trim());
                    if (!chk) {
                            alert("Enter Number for "+$("#submenu option:selected").text().trim().toString()+"");
                            $('#autocomplete').val("");
                            return false;
                            }
       }

    });

});
</script>

<s:useActionBean beanclass="com.inwise.action.SearchActionBean" event="search" var="searchlst"></s:useActionBean>
<%
    request.setAttribute("custlst",searchlst.getCustomer());


%>

<s:layout-render name="/layout/_base.jsp">
<s:layout-component name="body">
    <s:form beanclass="com.inwise.action.SearchActionBean">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
    <tr valign="top"><td >&nbsp;
    </td></tr>
    <tr><td align="left" class="pageheading" valign="top">
        <strong>Search</strong>
    </td></tr>
    <tr valign="top"><td align="center">&nbsp;
    </td></tr>
</table>
        <table bordercolor="#FF6600" width="77%" border="1">
            <tr>
                <td width="70%" height="124">
                    <table width="100%" cellspacing="1">
                        <tr>
                            <td width="13%" align="left" valign="top">Search What ?</td>
                            <td width="87%" align="left" valign="top">
                                <%
                                    String[] menu={"byInwise","byOrder","byCustomer"};
                                    String[] name={"Inwise","Order","Customer"};
                                %>
                                <s:select name="searchMenu" id="menu" class="dropdown" onchange="combo()">
                                    <option value="0">----Select Menu----</option>
                                    <%for(int i=0;i<menu.length;i++){%>
                                    <c:set var="temp" value="<%=menu[i] %>"/>
                                    <c:choose>
                                        <c:when test="${actionBean.searchMenu eq temp}">
                                            <option value="<%= menu[i]%>" selected="selected"><%=name[i]%></option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="<%= menu[i]%>"><%=name[i]%></option>
                                        </c:otherwise>

                                    </c:choose>
                                    <%}%>

                                </s:select>
                            </td>
                        </tr>
                        <tr>
                            <td>Search By</td>
                            <td align="left" valign="top">
                                <s:select id="submenu" name="searchSubmenu" class="dropdown" onchange="fillsubmenu()">
                                     <option  value="0">---Select Submenu---</option>
                                </s:select>
                            </td>

                        </tr>
                        <tr>

                            <td>&nbsp;<span style="visibility:hidden;" id="hiddenSubMenu">${actionBean.searchSubmenu}</span></td>
                            <%--<td>&nbsp;<span style="visibility:hidden;" id="autocompleteval">${actionBean.name}</span></td>--%>
                            <td align="left" valign="top">

                                <div id="myDiv1"  align="left" style="display:none;" class="labels">
                                        <%--Please Enter Search Details first <span style="color:#FF0000"> *</span>--%>
                                    &nbsp;&nbsp;<s:text style="border:1px solid #FFCC66;height: 23px; width: 173px;" name="name" id="autocomplete" value=""/>
                                    <s:submit name="search" id="seperategetbtn" value="Get" ></s:submit>

                                </div>

                                <div id="myDiv2"  align="left" style="display:none;" class="labels">
                                        <%--Please Enter Search Details first <span style="color:#FF0000"> *</span>--%>
                                    &nbsp;&nbsp;<s:text name="date" style="height: 23px; width: 173px;" readonly="readonly" onFocus="showCalendarControl(this);" class="textbox" />
                                    <s:submit name="search" id="seperategetbtn" value="Get" ></s:submit>

                                </div>

                                <div id="myDiv3"  align="left" style="display:none;" class="labels">
                                        <%--Please Enter Search Details first <span style="color:#FF0000"> *</span>--%>
                                    &nbsp;&nbsp;<s:text name="fromdate" style="height: 23px; width: 173px;" readonly="readonly" onFocus="showCalendarControl(this);" class="textbox" />
                                    &nbsp;&nbsp;        <s:text name="todate" style="height: 23px; width: 173px;" readonly="readonly" onFocus="showCalendarControl(this);" class="textbox" />
                                    <s:submit name="search" id="seperategetbtn" value="Get" ></s:submit>

                                </div>
                            </td>

                        </tr>
                  </table>
                </td>
            </tr>
        </table>
        <c:if test="${actionBean.customer!=null}">
        <c:if test="${actionBean.searchSubmenu eq 'custName'}">
            <table class="t" id="grntable" width="100%"><tr><td>
                <d:table name="custlst" id="c" pagesize="10" class="disp" requestURI="Search.action?search">
                      <d:column property="customerCode" title="Customer Code"/>
                    <d:column property="name" title="Name"/>
                    <d:column property="contactPerson" title="Contact Person Name"/>
                    <d:column property="contactNo1" title="Contact No :1"/>
                    <d:column property="contactNo2" title="Contact No :2"/>


                  </d:table></td></tr></table>
        </c:if>
         <c:if test="${actionBean.searchSubmenu eq 'custCode'}">
            <table class="t" id="grntable" width="100%"><tr><td>
                <d:table name="custlst" id="c" pagesize="10" class="disp" requestURI="Search.action?search">
                      <d:column property="customerCode" title="Customer Code"/>
                    <d:column property="name" title="Name"/>
                    <d:column property="contactPerson" title="Contact Person Name"/>
                    <d:column property="contactNo1" title="Contact No :1"/>
                    <d:column property="contactNo2" title="Contact No :2"/>


                  </d:table></td></tr></table>
        </c:if>
         </c:if>
    </s:form>
</s:layout-component>
</s:layout-render>
