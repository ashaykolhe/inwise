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
<c:set var = "TR1" value="receiptOrderSlip"/>
<c:if test="${actionBean.hdnvalue eq TR1}">
    <script type="text/javascript">
        function OpenPopup(){
            var w = 900;
            var h = 700;
            var winl = (screen.width-w)/2;
            var wint = (screen.height-h)/2;
            if (winl < 0) winl = 0;
            if (wint < 0) wint = 0;
            var page = "search?redirectorderpopup=&id="+${actionBean.id}+"";
            windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no," + "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
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
    if($('#menu').val()=='byInvoice')
    {
        var invoice = document.getElementById("submenu");
        var options=invoice.getElementsByTagName("option");
        var i;
        // Loop through the array of options and remove each
        // each one from the parent's childNode list.
        for (i=0; i<options.length; i++)
        {
            invoice.removeChild(options[i]);
        }// end for i
        var invoicevalue=new Array("none","invoiceNumber","invoiceCustomerOrderNo","invoiceCustomerName","invoiceDate");
        var invoiceshow=new Array("--Select Invoice Options--","Invoice Number","Customer Order Number","Customer Name","Invoice Date");
        for(var i=0;i<invoicevalue.length;i++){
            var t=invoicevalue[i];
            if(t==submenuvalue){
                invoice.options[i]=new Option(invoiceshow[i],invoicevalue[i],false,true);
            }
            else
                invoice.options[i]=new Option(invoiceshow[i],invoicevalue[i]);
        }    //end of for
    }
    else if($('#menu').val()=='byOrder')
    {
        var order=document.getElementById("submenu");
        var options=order.getElementsByTagName("option");
        var i;
        for(i=0; i<options.length; i++)
        {
            order.removeChild(options[i]);
        }// end for i
        var ordervalue=new Array("none","orderCustomerOrderNumber","orderCustomerName","orderDate","orderBtwnDates");
        var ordershow=new Array("--Select Order Options--","Customer Order Number","Customer Name","Order Date","Order Between Dates");
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
            var custvalue=new Array("none","custName","custCode","emailId");
            var custshow=new Array("--Select Customer Option --","Customer Name","Customer Code","Email Id");
            for(var i=0;i<custvalue.length;i++){
                var t=custvalue[i];
                if(t==submenuvalue){
                    cust.options[i]=new Option(custshow[i],custvalue[i],false,true);}
                else
                    cust.options[i]=new Option(custshow[i],custvalue[i]);
            }    //end of for
        }
     else if($('#menu').val()=='byProposal')
        {
            var cust=document.getElementById("submenu");
            var options=cust.getElementsByTagName("option");
            var i;
            for (i=0; i<options.length; i++)
            {
                cust.removeChild(options[i]);
            }// end for i
            var custvalue=new Array("none","proposalCustName","proposalOrderDate","proposalBetwnDate");
            var custshow=new Array("--Select Proposal Option --","Customer Name","Proposal Date","Proposal Between Dates");
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
    }   //"none","invoiceNumber","invoiceCustomerOrderNo","invoiceCustomerName","invoiceProductName","invoiceDate"
    if($('#submenu').val() == 'invoiceNumber'){
        $('#myDiv3').hide();
        $('#myDiv2').hide();
        $('#myDiv1').show();
        $.post("search?autoinvoice", {ajaxSubmenu:$('#submenu').val()}, function (result) {
            var availableTags=eval(result);
            $("input#autocomplete").autocomplete({
                source: availableTags
            });
        });

    }
    else if($('#submenu').val() == 'invoiceCustomerOrderNo'){
        $('#myDiv3').hide();
        $('#myDiv2').hide();
        $('#myDiv1').show();
        $.post("search?autoinvoice", {ajaxSubmenu:$('#submenu').val()}, function (result) {
            var availableTags=eval(result);
            $("input#autocomplete").autocomplete({
                source: availableTags
            });
        });
    }
    else if($('#submenu').val() == 'invoiceCustomerName'){
            $('#myDiv3').hide();
            $('#myDiv2').hide();
            $('#myDiv1').show();
            $.post("search?autoinvoice", {ajaxSubmenu:$('#submenu').val()}, function (result) {
                var availableTags=eval(result);
                $("input#autocomplete").autocomplete({
                    source: availableTags
                });
            });
        }

        else if($('#submenu').val() == 'invoiceDate'){
                $('#myDiv3').hide();
                $('#myDiv2').show();
                $('#myDiv1').hide();

            }
            //"none","orderCustomerOrderNumber","orderCustomerName","orderProductName","orderDate"
            else if($('#submenu').val() == 'orderCustomerOrderNumber'){
                    $('#myDiv3').hide();
                    $('#myDiv2').hide();
                    $('#myDiv1').show();
                    $.post("search?autoorder", {ajaxSubmenu:$('#submenu').val()}, function (result) {
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
                        $.post("search?autoorder", {ajaxSubmenu:$('#submenu').val()}, function (result) {

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

                        }
                         else if($('#submenu').val() == 'orderBtwnDates'){
                            $('#myDiv3').show();
                            $('#myDiv2').hide();
                            $('#myDiv1').hide();

                        }
                        //"none","custName","custCode"
                        else if($('#submenu').val() == 'custName'){
                                $('#myDiv3').hide();
                                $('#myDiv2').hide();
                                $('#myDiv1').show();
                                $.post("search?autocust", {ajaxSubmenu:$('#submenu').val()}, function (result) {
                                    /* $.get("/search?autovendor",function(result) {*/
                                    var availableTags=eval(result);
                                    $("input#autocomplete").autocomplete({
                                        source: availableTags

                                    });
                                });
                            }
                              else if($('#submenu').val() == 'emailId'){
                                $('#myDiv3').hide();
                                $('#myDiv2').hide();
                                $('#myDiv1').show();
                                $.post("search?autocust", {ajaxSubmenu:$('#submenu').val()}, function (result) {
                                    /* $.get("/search?autovendor",function(result) {*/
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
                                    $.post("search?autocust", {ajaxSubmenu:$('#submenu').val()}, function (result) {
                                        /* $.get("/search?autovendor",function(result) {*/
                                        var availableTags=eval(result);
                                        $("input#autocomplete").autocomplete({
                                            source: availableTags
                                        });


                                    });
                                }
    else if($('#submenu').val() == 'proposalCustName'){
                                    $('#myDiv3').hide();
                                    $('#myDiv2').hide();
                                    $('#myDiv1').show();
                                    $.post("search?autoproposal", {ajaxSubmenu:$('#submenu').val()}, function (result) {
                                        /* $.get("/search?autovendor",function(result) {*/
                                        var availableTags=eval(result);
                                        $("input#autocomplete").autocomplete({
                                            source: availableTags
                                        });


                                    });
                                }
     else if($('#submenu').val() == 'proposalOrderDate'){
                            $('#myDiv3').hide();
                            $('#myDiv2').show();
                            $('#myDiv1').hide();

                        }
                         else if($('#submenu').val() == 'proposalBetwnDate'){
                            $('#myDiv3').show();
                            $('#myDiv2').hide();
                            $('#myDiv1').hide();

                        }
}
$(document).ready(function() {

    $('#menu').change();

    fillsubmenu();

    $("#textgetbtn").click(function(){
        var varsubmenu=$("#submenu option:selected").val().trim().toString();

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
        else if(varsubmenu=='invoiceNumber')
        {
            var chk = /^[0-9]+$/.test($('#autocomplete').val().trim());
            if (!chk) {
                alert("Enter Number for "+$("#submenu option:selected").text().trim().toString()+"");
                $('#autocomplete').val("");
                return false;
            }
        }

    });
    $("#dategetbtn").click(function(){
        var varsubmenu=$("#submenu option:selected").val().trim().toString();

        if(varsubmenu=='orderDate' || varsubmenu=='invoiceDate')
        {
            if($('#date').val()=="")
            {
                alert("please select date");
                return false;
            }
        }
        var varsubmenu=$("#submenu option:selected").val().trim().toString();
        if(varsubmenu=='none')
        {
            alert("Please,Select Search By Option");
            return false;
        }

    });


});
</script>

<s:useActionBean beanclass="com.inwise.action.SearchActionBean" event="search" var="searchlst"></s:useActionBean>
<%
    request.setAttribute("custlst",searchlst.getCustomer());
    request.setAttribute("invoice",searchlst.getInvoice());
    request.setAttribute("invoicelst",searchlst.getInvoicelst());
    request.setAttribute("order",searchlst.getOrder());
    request.setAttribute("orderlst",searchlst.getOrderlst());
     request.setAttribute("proposallst",searchlst.getProposallst());

%>

<s:layout-render name="/layout/_base.jsp">
  <s:layout-component name="left-menu">

             <ul>
                 <li>&nbsp;</li>
                  <li class="left_menu_heading">Search/Print</li>
                  <li style="margin-top:35px">    <s:link beanclass="com.inwise.action.SearchActionBean" event="searchLink">Search</s:link></li>
                                                     <li><s:link beanclass="com.inwise.action.PrintActionBean" event="printInvoiceLink">Print</s:link></li>
              </ul>

     </s:layout-component>
<s:layout-component name="body">
<s:form beanclass="com.inwise.action.SearchActionBean">
<br>
    <table class="heading_table">

    <tr><td align="left" class="pageheading" valign="top">
      <div class="sub_heading" >Search</div>
    </td></tr>
     </table>
     <table class="second_table"  ><tr><td>
            <table width="100%" cellspacing="0" border="0" cellpadding="0">
                <tr>
                    <td width="13%" align="left" valign="top">Search What ?</td>
                    <td width="87%" align="left" valign="top">
                        <%
                            String[] menu={"byInvoice","byOrder","byCustomer","byProposal"};
                            String[] name={"Invoice","Order","Customer","Proposal"};
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

                        <div id="myDiv1"  align="left" style="display:none;" >
                                <%--Please Enter Search Details first <span style="color:#FF0000"> *</span>--%>
                            &nbsp;&nbsp;<s:text  class="textbox" style="margin-left:0px;" name="name" id="autocomplete" value=""/>
                            <s:submit name="search" id="textgetbtn"  value="Get" class="buttons"></s:submit>
                        </div>

                        <div id="myDiv2"  align="left" style="display:none;" >
                                <%--Please Enter Search Details first <span style="color:#FF0000"> *</span>--%>
                            &nbsp;&nbsp;<s:text id="date" name="date" style="margin-left:0px;"  readonly="readonly" onFocus="showCalendarControl(this);" class="textbox" />
                            <s:submit name="search" id="dategetbtn" value="Get" class="buttons"></s:submit>

                        </div>

                        <div id="myDiv3"  align="left" style="display:none;" >
                                <%--Please Enter Search Details first <span style="color:#FF0000"> *</span>--%>
                            From&nbsp;&nbsp;<s:text name="fromdate" readonly="readonly" style="margin-left:0px;" onFocus="showCalendarControl(this);" class="textbox" />
                            &nbsp;&nbsp;To        <s:text id="betweendate" name="todate"  readonly="readonly" onFocus="showCalendarControl(this);" class="textbox" />
                            <s:submit name="search" id="betgetbtn" value="Get" class="buttons"></s:submit>

                        </div>
                    </td>

                </tr>
            </table>
        </td>
    </tr>
</table>
<c:if test="${actionBean.customer!=null}">
    <c:if test="${actionBean.searchSubmenu eq 'custName'}">

        <table class="t" id="grntable" width="92%"><tr><td>
            <d:table name="custlst" id="c" pagesize="10" class="disp" requestURI="search">
              <d:column property="name" title="Customer Name"/>
                 <d:column property="department" title="Department"  />
                          <d:column property="customerCode" title="Customer Code" />
                  <d:column property="email" title="Email Id" />

                         <d:column property="contactNo1" title="Phone Number" />
            </d:table></td></tr></table>
    </c:if>
     <c:if test="${actionBean.searchSubmenu eq 'emailId'}">

        <table class="t" id="grntable" width="92%"><tr><td>
            <d:table name="custlst" id="c" pagesize="10" class="disp" requestURI="search">
              <d:column property="name" title="Customer Name"/>
                 <d:column property="department" title="Department"  />
                          <d:column property="customerCode" title="Customer Code" />
                  <d:column property="email" title="Email Id" />

                         <d:column property="contactNo1" title="Phone Number" />
            </d:table></td></tr></table>
    </c:if>
    <c:if test="${actionBean.searchSubmenu eq 'custCode'}">
        <table class="t" id="grntable" width="92%"><tr><td>
            <d:table name="custlst" id="c" pagesize="10" class="disp" requestURI="search">
                <d:column property="name" title="Customer Name"/>
                 <d:column property="department" title="Department"  />
                          <d:column property="customerCode" title="Customer Code" />
                  <d:column property="email" title="Email Id" />

                         <d:column property="contactNo1" title="Phone Number" />
            </d:table></td></tr></table>
    </c:if>
</c:if>
<c:if test="${actionBean.invoice!=null and fn:startsWith(actionBean.searchSubmenu,'invoice')}">
    <table class="t" id="grntable" width="92%"><tr><td>
        <d:table name="invoice" id="c" pagesize="10" class="disp" requestURI="search">
            <d:column property="invoiceNumber" title="Invoice Number"/>
            <d:column property="customer.name" title="Customer Name"/>
            <d:column property="createDate" title="Invoice Date"  format="{0,date,yyyy-MM-dd}" sortable="false"/>
             <d:column title="View" class="delete" >
                <s:link beanclass="com.inwise.action.SearchActionBean" event="print" >
                    <s:param name="id" value="${c.invoiceNumber}"></s:param>
                    <s:param name="hdnvalue" value="invoiceno"></s:param>
                    <s:param name="name" value="${c.invoiceNumber}"></s:param>
                    <s:param name="searchMenu" value="${actionBean.searchMenu}"></s:param>
                    <s:param name="searchSubmenu" value="${actionBean.searchSubmenu}"></s:param>

                    <img src="images/view.gif" />
                </s:link>
            </d:column>
        </d:table></td></tr></table>
</c:if>

<c:if test="${actionBean.invoicelst!=null and fn:containsIgnoreCase(actionBean.searchSubmenu,'invoiceCustomerName')}">

    <table class="t" id="grntable" width="92%"><tr><td>
        <d:table name="invoicelst" id="c1" pagesize="10"  class="disp" requestURI="search">
            <d:column property="invoiceNumber" title="Invoice Number"/>
            <d:column property="customer.name" title="Customer Name"/>
            <d:column property="createDate" title="Invoice Date"  format="{0,date,yyyy-MM-dd}" sortable="false"/>
            <d:column title="View" class="delete" >
                <s:link beanclass="com.inwise.action.SearchActionBean" event="print" >
                    <s:param name="id" value="${c1.invoiceNumber}"></s:param>
                    <s:param name="hdnvalue" value="invoicelst"></s:param>
                    <s:param name="name" value="${c1.customer.name}"></s:param>
                    <s:param name="searchMenu" value="${actionBean.searchMenu}"></s:param>
                    <s:param name="searchSubmenu" value="${actionBean.searchSubmenu}"></s:param>

                    <img src="images/view.gif" />
                </s:link>
            </d:column>
        </d:table></td></tr></table>
</c:if>
<c:if test="${actionBean.invoicelst!=null and fn:containsIgnoreCase(actionBean.searchSubmenu,'invoiceCustomerOrderNo')}">

    <table class="t" id="grntable" width="92%"><tr><td>
        <d:table name="invoicelst" id="c" pagesize="10"  class="disp" requestURI="search">
            <d:column property="invoiceNumber" title="Invoice Number"/>
            <d:column property="customer.name" title="Customer Name"/>
            <d:column property="createDate" title="Invoice Date"  format="{0,date,yyyy-MM-dd}" sortable="false"/>
            <d:column title="View" class="delete" >
                <s:link beanclass="com.inwise.action.SearchActionBean" event="print" >
                    <s:param name="id" value="${c.invoiceNumber}"></s:param>
                    <s:param name="hdnvalue" value="invoicelst"></s:param>
                    <s:param name="name" value="${c.order.customerOrderNo}"></s:param>
                    <s:param name="searchMenu" value="${actionBean.searchMenu}"></s:param>
                    <s:param name="searchSubmenu" value="${actionBean.searchSubmenu}"></s:param>

                    <img src="images/view.gif" />
                </s:link>
            </d:column>
        </d:table></td></tr></table>
</c:if>
<c:if test="${actionBean.invoicelst!=null and fn:startsWith(actionBean.searchSubmenu,'invoiceDate' )}">

    <table class="t" id="grntable" width="92%"><tr><td>
        <d:table name="invoicelst" id="c" pagesize="10"  class="disp" requestURI="search">
            <d:column property="invoiceNumber" title="Invoice Number"/>
            <d:column property="customer.name" title="Customer Name"/>
            <d:column property="createDate" title="Invoice Date"  format="{0,date,yyyy-MM-dd}" sortable="false"/>
            <d:column title="View" class="delete" >
                <s:link beanclass="com.inwise.action.SearchActionBean" event="print" >
                    <s:param name="id" value="${c.invoiceNumber}"></s:param>
                    <s:param name="hdnvalue" value="invoicelst"></s:param>

                    <s:param name="searchMenu" value="${actionBean.searchMenu}"></s:param>
                    <s:param name="searchSubmenu" value="${actionBean.searchSubmenu}"></s:param>

                    <img src="images/view.gif" />
                </s:link>
            </d:column>
        </d:table></td></tr></table>
</c:if>

<c:if test="${actionBean.order!=null and fn:containsIgnoreCase(actionBean.searchSubmenu,'orderCustomerOrderNumber')}">

    <table  class="t" id="grntable" width="92%"><tr><td>
        <d:table style="true" name="order" id="order" pagesize="10" class="disp" requestURI="search">
                  <d:column property="customerOrderNo" title="Customer Order No"  />
                 <d:column property="customer.name" title="Customer Name"/>

                 <d:column property="consigneeName" title="Consignee Name"  />
                 <d:column property="createDate" title="Order Date"  format="{0,date,yyyy-MM-dd}" sortable="false"/>
                  <d:column title="Product Name">
                <table>
                    <c:forEach items="${order.orderDetail}" var="products" varStatus="loop" >
                        <tr>
                            <td>${products.product.productName}</td></tr>
                    </c:forEach>
                </table>
            </d:column>

                         <d:column title="Ordered Quantity">
                <table>
                    <c:forEach items="${order.orderDetail}" var="qty" varStatus="loop1" >
                        <tr>
                            <td>${qty.orderedQuantity}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
                        <d:column title="Cost">
                <table>
                    <c:forEach items="${order.orderDetail}" var="cst" varStatus="loop3" >
                        <tr>
                            <td>${cst.cost}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
                          <d:column title="Remaining Quantity">
                <table>
                    <c:forEach items="${order.orderDetail}" var="reqty" varStatus="loop2" >
                        <tr>
                            <td>${reqty.remainingQuantity}</td></tr>
                    </c:forEach>
                </table>
            </d:column>

            <d:column title="View" class="delete" >
                <s:link beanclass="com.inwise.action.SearchActionBean" event="print" >
                    <s:param name="id" value="${invoice.invoiceNumber}"></s:param>
                    <s:param name="hdnvalue" value="orderCustomerOrderNumber"></s:param>
                    <s:param name="name" value="${invoice.order.customerOrderNo}"></s:param>
                    <s:param name="searchMenu" value="${actionBean.searchMenu}"></s:param>
                    <s:param name="searchSubmenu" value="${actionBean.searchSubmenu}"></s:param>

                    <img src="images/view.gif" />
                </s:link>
            </d:column>
        </d:table></td></tr></table>
</c:if>
<c:if test="${actionBean.orderlst!=null and fn:containsIgnoreCase(actionBean.searchSubmenu,'orderCustomerName')}">

    <table  class="t" id="grntable" width="92%"><tr><td>
        <d:table style="true" name="orderlst" id="order" pagesize="10" class="disp" requestURI="search">

                 <d:column property="customer.name" title="Customer Name"/>
                  <d:column property="customerOrderNo" title="Customer Order No"  />
                 <d:column property="consigneeName" title="Consignee Name"  />
                 <d:column property="createDate" title="Order Date"  format="{0,date,yyyy-MM-dd}" sortable="false"/>
                  <d:column title="Product Name">
                <table>
                    <c:forEach items="${order.orderDetail}" var="products" varStatus="loop" >
                        <tr>
                            <td>${products.product.productName}</td></tr>
                    </c:forEach>
                </table>
            </d:column>

                         <d:column title="Ordered Quantity">
                <table>
                    <c:forEach items="${order.orderDetail}" var="qty" varStatus="loop1" >
                        <tr>
                            <td>${qty.orderedQuantity}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
                        <d:column title="Cost">
                <table>
                    <c:forEach items="${order.orderDetail}" var="cst" varStatus="loop3" >
                        <tr>
                            <td>${cst.cost}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
                          <d:column title="Remaining Quantity">
                <table>
                    <c:forEach items="${order.orderDetail}" var="reqty" varStatus="loop2" >
                        <tr>
                            <td>${reqty.remainingQuantity}</td></tr>
                    </c:forEach>
                </table>
            </d:column>

            <d:column title="View" class="delete" >
                <s:link beanclass="com.inwise.action.SearchActionBean" event="print" >
                    <s:param name="id" value="${invoice.invoiceNumber}"></s:param>
                    <s:param name="hdnvalue" value="orderCustomerOrderNumber"></s:param>
                    <s:param name="name" value="${invoice.order.customerOrderNo}"></s:param>
                    <s:param name="searchMenu" value="${actionBean.searchMenu}"></s:param>
                    <s:param name="searchSubmenu" value="${actionBean.searchSubmenu}"></s:param>

                    <img src="images/view.gif" />
                </s:link>
            </d:column>
        </d:table></td></tr></table>
</c:if>
<c:if test="${actionBean.orderlst!=null and fn:containsIgnoreCase(actionBean.searchSubmenu,'orderDate')}">

    <table  class="t" id="grntable" width="92%"><tr><td>
           <d:table style="true" name="orderlst" id="order" pagesize="10" class="disp" requestURI="search">

                 <d:column property="customer.name" title="Customer Name"/>
                  <d:column property="customerOrderNo" title="Customer Order No"  />
                 <d:column property="consigneeName" title="Consignee Name"  />
                 <d:column property="createDate" title="Order Date"  format="{0,date,yyyy-MM-dd}" sortable="false"/>
                  <d:column title="Product Name">
                <table>
                    <c:forEach items="${order.orderDetail}" var="products" varStatus="loop" >
                        <tr>
                            <td>${products.product.productName}</td></tr>
                    </c:forEach>
                </table>
            </d:column>

                         <d:column title="Ordered Quantity">
                <table>
                    <c:forEach items="${order.orderDetail}" var="qty" varStatus="loop1" >
                        <tr>
                            <td>${qty.orderedQuantity}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
                        <d:column title="Cost">
                <table>
                    <c:forEach items="${order.orderDetail}" var="cst" varStatus="loop3" >
                        <tr>
                            <td>${cst.cost}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
                          <d:column title="Remaining Quantity">
                <table>
                    <c:forEach items="${order.orderDetail}" var="reqty" varStatus="loop2" >
                        <tr>
                            <td>${reqty.remainingQuantity}</td></tr>
                    </c:forEach>
                </table>
            </d:column>

            <d:column title="View" class="delete" >
                <s:link beanclass="com.inwise.action.SearchActionBean" event="print" >
                    <s:param name="id" value="${invoice.invoiceNumber}"></s:param>
                    <s:param name="hdnvalue" value="orderCustomerOrderNumber"></s:param>
                    <s:param name="name" value="${invoice.order.customerOrderNo}"></s:param>
                    <s:param name="searchMenu" value="${actionBean.searchMenu}"></s:param>
                    <s:param name="searchSubmenu" value="${actionBean.searchSubmenu}"></s:param>

                    <img src="images/view.gif" />
                </s:link>
            </d:column>
        </d:table></td></tr></table>
</c:if>
 <c:if test="${actionBean.orderlst!=null and fn:containsIgnoreCase(actionBean.searchSubmenu,'orderBtwnDates')}">

    <table  class="t" id="grntable" width="92%"><tr><td>
        <d:table style="true" name="orderlst" id="order" pagesize="10" class="disp" requestURI="search">
                  <d:column property="customerOrderNo" title="Customer Order No"  />
                 <d:column property="customer.name" title="Customer Name"/>

                 <d:column property="consigneeName" title="Consignee Name"  />
                 <d:column property="createDate" title="Order Date"  format="{0,date,yyyy-MM-dd}" sortable="false"/>
                  <d:column title="Product Name">
                <table>
                    <c:forEach items="${order.orderDetail}" var="products" varStatus="loop" >
                        <tr>
                            <td>${products.product.productName}</td></tr>
                    </c:forEach>
                </table>
            </d:column>

                         <d:column title="Ordered Quantity">
                <table>
                    <c:forEach items="${order.orderDetail}" var="qty" varStatus="loop1" >
                        <tr>
                            <td>${qty.orderedQuantity}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
                        <d:column title="Cost">
                <table>
                    <c:forEach items="${order.orderDetail}" var="cst" varStatus="loop3" >
                        <tr>
                            <td>${cst.cost}</td></tr>
                    </c:forEach>
                </table>
            </d:column>
                          <d:column title="Remaining Quantity">
                <table>
                    <c:forEach items="${order.orderDetail}" var="reqty" varStatus="loop2" >
                        <tr>
                            <td>${reqty.remainingQuantity}</td></tr>
                    </c:forEach>
                </table>
            </d:column>

            <d:column title="View" class="delete" >
                <s:link beanclass="com.inwise.action.SearchActionBean" event="print" >
                    <s:param name="id" value="${invoice.invoiceNumber}"></s:param>
                    <s:param name="hdnvalue" value="orderCustomerOrderNumber"></s:param>
                    <s:param name="name" value="${invoice.order.customerOrderNo}"></s:param>
                    <s:param name="searchMenu" value="${actionBean.searchMenu}"></s:param>
                    <s:param name="searchSubmenu" value="${actionBean.searchSubmenu}"></s:param>

                    <img src="images/view.gif" />
                </s:link>
            </d:column>
        </d:table></td></tr></table>
</c:if>
      <%

             org.displaytag.decorator.TotalTableDecorator totals = new org.displaytag.decorator.TotalTableDecorator();
                         totals.setSubtotalLabel("partial amount");
             pageContext.setAttribute("totals", totals);

                %>
 <c:if test="${actionBean.proposallst!=null}">

        <table class="t" id="grntable" width="92%"><tr><td>
             <d:table name="proposallst" id="proposal1" pagesize="5" class="disp" requestURI="/proposal" decorator="totals">
                 <d:column property="id" title="Proposal Id"/>
                 <d:column property="customer.name" title="Customer"/>
                 <d:column property="createDate" title="Propsoal Date" format="{0,date,yyyy-MM-dd}" sortable="false"/>
                        <c:set var="pro" value="${proposal1.proposalDetail}" scope="request"/>
                      <d:column title="Re-Quote">
                              <d:table name="pro" id="proposaldetail" class="disp"   requestURI="/proposal" decorator="totals">

                                     <d:column property="requoteno" group="1" title="ReQuote Order"/>
                                     <d:column property="product.productName" title="Product Name"/>
                                     <d:column property="quantity" title="Quantity"/>
                                     <d:column property="cost" title="Rate"/>
                                     <d:column property="amount" title="Amount" total="true" />
                              </d:table> </d:column></d:table></td></tr></table>
    </c:if>
</s:form>
</s:layout-component>
</s:layout-render>
