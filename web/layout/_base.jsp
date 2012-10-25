<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>

<%@ include file="/includes/_taglibInclude.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<body>
<s:layout-definition>
<s:layout-component name="head">
    <head>
        <title>Inwise</title>
        <script type="text/javascript">
            function MakeArrayday(size) {
                this.length = size;
                for(var i = 1; i <= size; i++) {
                    this[i] = "";
                }
                return this;
            }
            function MakeArraymonth(size) {
                this.length = size;
                for(var i = 1; i <= size; i++) {
                    this[i] = "";
                }
                return this;
            }
            function funClock() {
                var runTime = new Date();
                var hours = runTime.getHours();
                var minutes = runTime.getMinutes();
                var seconds = runTime.getSeconds();
                var dn = "AM";

                if (hours >= 12) {

                    dn = "PM";
                    hours = hours - 12;
                }
                if (hours == 0) {
                    hours = 12;
                }
                if (minutes <= 9) {
                    minutes = "0" + minutes;
                }
                if (seconds <= 9) {
                    seconds = "0" + seconds;
                }
                movingtime = ""+ hours + ":" + minutes + ":" + seconds + " " + dn + "";

                document.getElementById("clock").innerHTML = movingtime;
                setTimeout("funClock()", 1000);
            }
            setTimeout("funClock()", 100);
        </script>
    </head>

</s:layout-component>
    <table width="100%" height="100%" border="0" align="center"  style="background-color:white;">
        <tr >
            <td height="30" colspan="2" align="right"><s:layout-component name="header"><div align="right" style="margin-right: 5px;color:black;font-size:10px;font-family:sans-serif; font-weight: bold;">WELCOME
                <s:link beanclass="com.inwise.action.LoginActionBean" event="logout" class="links" style="font-size:11px;">(Logout)</s:link></a></div>
                <div align="right" style="margin-right:5px;color:black;" class="labels">
                    <%	Date date = Calendar.getInstance().getTime();
                        DateFormat formatter = new SimpleDateFormat("dd MMMM, yyyy");
                    %>
                    <%= formatter.format(date) %>
                    <input type="hidden" name="inDate1" id="inDate1" value="<%= formatter.format(date) %>"/>
                    <span id="clock" style="position:relative;"></span>
                </div>
            </s:layout-component></td>
        </tr>
          <tr style=" background-color:#396a9c;">
            <td height="20" colspan="2"> <s:layout-component name="menu">
                <div class="menu">
                    <ul>
                          <li><s:link beanclass="com.inwise.action.CustomerActionBean" event="pageDirect">Customers</s:link>
                        </li>
                                              <li><s:link beanclass="com.inwise.action.ProductActionBean" event="addProductLink">Products</s:link>

                                             </li>
                                          <li><s:link beanclass="com.inwise.action.TaxActionBean" event="addTaxLink">Taxes</s:link></li>
                                 <li><s:link beanclass="com.inwise.action.OrderActionBean" event="pre">Orders</s:link>

                                             </li>
                        <li><s:link beanclass="com.inwise.action.InvoiceActionBean" event="pre">Invoice</s:link>

                                             </li>
                        <li><s:link beanclass="com.inwise.action.SearchActionBean" event="searchLink">Search/Print</s:link>

                                             </li>

                           <li><s:link beanclass="com.inwise.action.ReportActionBean" event="addreportlink">Reports</s:link> 
                                                                             </li>
                           <li>
                         <s:link beanclass="com.inwise.action.CompanyActionBean"  event="pre">Settings</s:link>

                      </li>
                    </ul>


                </div>

           </s:layout-component></td>
        </tr>
        <tr valign="top">
                <%--<td width="15%" height="432">${left_menu}</td>--%>
              <td valign="top"  class="leftMenuCss">
                  <s:layout-component name="left-menu"></s:layout-component>
                        </td>
                  <td width="80%">
            <s:layout-component name="body"></s:layout-component>
              </td>

        </tr>
       <%-- <tr >
            <td height="30" colspan="2" ><s:layout-component name="footer"></s:layout-component></td>
        </tr>--%>
    </table>
</s:layout-definition>
</body>
</html>