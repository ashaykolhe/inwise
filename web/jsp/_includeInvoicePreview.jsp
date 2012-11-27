<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes-dynattr.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<s:useActionBean beanclass="com.inwise.action.InvoiceActionBean" var="invoiceBean" event="redirectorderpopup" ></s:useActionBean>
<tr>
				<td nowrap style="background:#ffffff; color:#000000; border-left:2px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
					<img style="margin-left:7px;" src="images/WE.jpg" height="40px" width="40px" align="center">
                </td>
				<td width="200" nowrap style="background:#ffffff; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
					<div align="left" style="margin-left:7px; margin-right:7px; font-family:Times New Roman; font-size:14px">
                        <b>${invoiceBean.invoice.customer.addressList[0].line1},${invoiceBean.invoice.customer.addressList[0].line2},
                            ${invoiceBean.invoice.customer.addressList[0].city}-${invoiceBean.invoice.customer.addressList[0].zip},
                            ${invoiceBean.invoice.customer.addressList[0].state}</b>
					</div>
				</td>
				<td width="250" nowrap style="background:#ffffff; color:#000000; border-right:1px solid #000000; border-bottom:1px  solid #000000; border-top:2px  solid #000000;">
					<div align="left" style="margin-left:7px; margin-right:7px; font-family:Times New Roman; font-size:11px;">
						Tel No.  : ${invoiceBean.invoice.customer.contactNo1}

					</div>

                    <div align="left" style="margin-left:7px; margin-right:7px; font-family:Times New Roman; font-size:11px;">
						E-Mail : ${invoiceBean.invoice.customer.email}

					</div>


				</td>
				<td colspan="3" width="110" nowrap align="left" valign="top" style="background:#ffffff; color:#000000;">
					<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tr>
							<td width="50" nowrap style="background:#ffffff; height:40px; color:#000000; border-top:2px solid #000000; border-bottom:1px  solid #000000;">
								<div align="left" style="margin-left:1px; font-family:Times New Roman; font-size:11px">
									TIN No.
								</div>
							</td>
                            <td nowrap style="background:#ffffff; height:40px; color:#000000; border-top:2px solid #000000; border-right:2px solid #000000; border-bottom:1px  solid #000000;">
                                <div align="right" style="margin-right:1px; font-family:Verdana; font-size:11px;">
										<b>${invoiceBean.invoice.customer.tinNo}</b>
									</div>
                            </td>
						</tr>
						<tr>
							<td width="50" nowrap style="background:#ffffff; height:40px; color:#000000; border-bottom:1px  solid #000000;">
								<div align="left" style="margin-left:2px; font-family:Times New Roman; font-size:9px">
									TAN No.

								</div>
							</td>
                            <td nowrap style="background:#ffffff; height:40px; color:#000000; border-right:2px solid #000000; border-bottom:1px  solid #000000;">
                                <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
										<b>${invoiceBean.invoice.customer.tanNo}</b>
									</div>
                            </td>
						</tr>
					</table>
				</td>
			</tr>
                        <tr>
				<td colspan="6">
					<div align="center" style="margin-left:7px; font-family:Copperplate Gothic Light; font-size:16px">
						INVOICE
					</div>
					<div align="center" style="margin-left:7px; font-family:Vrinda; font-size:15px"></div>
					<div align="right" style="margin-left:7px">
						<input name="buyer" type="text" id="buyer" style="font-family:Vrinda; font-size:15px; border:0px; text-align:right; background-color: white;" value="ORIGINAL FOR BUYER"  size="35" readonly="readonly">
					</div>
				</td>
			</tr>

			<tr>
				<td colspan="6">
					<table width="100%"  align="center" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td width="329" valign="top" style="background:#ffffff; height:37px; color:#000000; height:100px;border-bottom:2px  solid #000000; border-left:2px solid #000000; border-right:1px solid #000000;border-top:2px solid #000000;">
								<div align="left" style="margin-left:7px; margin-top:4px; font-family:Times New Roman; font-size:9px">
									INVOICE TO :
									<div align="left" style="margin-left:60px; margin-right:7px; font-family:Verdana; font-size:9px;">
										<b>${invoice.order.orderAddress[0].address.line1}
                                           <br>
                                           ${invoice.order.orderAddress[0].address.line2}
                                        <br>
                                           ${invoice.order.orderAddress[0].address.city}
                                        <br>
                                           ${invoice.order.orderAddress[0].address.state}
                                        <br>
                                           ${invoice.order.orderAddress[0].address.country}
                                        <br>
                                           ${invoice.order.orderAddress[0].address.zip}
                                        </b>
									</div>
								</div>
							</td>
							<td width="315" valign="top" style="background:#ffffff; height:37px; color:#000000;border-bottom:2px  solid #000000; border-right:1px solid #000000; border-top:2px solid #000000;">
								<div align="left" style="margin-left:7px; margin-top:5px; font-family:Times New Roman; font-size:9px; ">
									CONSIGNEE :
									<div align="left" style="margin-left:55px; font-family:Verdana; font-size:9px;">
                                        <b>${invoice.order.consigneeName}</b>

									</div>
									<div align="left" style="margin-left:55px; font-family:Verdana; font-size:9px;">
										<b>${invoice.order.orderAddress[1].address.line1}
                                           <br>
                                           ${invoice.order.orderAddress[1].address.line2}
                                        <br>
                                           ${invoice.order.orderAddress[1].address.city}
                                        <br>
                                           ${invoice.order.orderAddress[1].address.state}
                                        <br>
                                           ${invoice.order.orderAddress[1].address.country}
                                        <br>
                                           ${invoice.order.orderAddress[1].address.zip}
                                        </b>
									</div>
								</div>
							</td>
							<td width="204" valign="top" nowrap style="background:#ffffff; color:#000000;border-top:2px solid #000000;border-bottom:2px  solid #000000;">
								<div align="left">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Order No.
												</div>
											</td>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:1px solid #000000;">
                                            <div align="right" style="margin-right:7px; font-family:Times New Roman; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.order.customerOrderNo!= null}">
                                                                <b>${invoiceBean.invoice.order.customerOrderNo}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>
													</div></td>

											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Date
												</div>
											</td>
<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:2px solid #000000; ">
                                            <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
                                                        <c:choose>
                                            <c:when test="${invoiceBean.invoice.order.createDate != null}">
                                        <b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoiceBean.invoice.order.createDate}"/></b>
                                            </c:when>
                                            <c:otherwise>
                                                <b>-</b>
                                            </c:otherwise>
                                        </c:choose>

													</div>
                                                    </td>
										</tr>

                                        <tr>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Bill No.
												</div>
											</td>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:1px solid #000000;">
                                            <div align="right" style="margin-right:7px; font-family:Times New Roman; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.invoiceNumber!= null}">
                                                                <b>${invoiceBean.invoice.invoiceNumber}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>
													</div></td>

											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Date
												</div>
											</td>
<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:2px solid #000000;">
                                            <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
                                                        <c:choose>
                                            <c:when test="${invoiceBean.invoice.createDate != null}">
                                        <b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoiceBean.invoice.createDate}"/></b>
                                            </c:when>
                                            <c:otherwise>
                                                <b>-</b>
                                            </c:otherwise>
                                        </c:choose>

													</div>
                                                    </td>
										</tr>

                                        <tr>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Challan Pass No.
												</div>
											</td>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:1px solid #000000;">
                                            <div align="right" style="margin-right:7px; font-family:Times New Roman; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.challanPassNumber!= null}">
                                                                <b>${invoiceBean.invoice.challanPassNumber}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>
													</div></td>

											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Date
												</div>
											</td>
<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:2px solid #000000;">
                                            <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
                                                        <c:choose>
                                            <c:when test="${invoiceBean.invoice.challanDate != null}">
                                        <b><fmt:formatDate pattern="yyyy-MM-dd" value="${invoiceBean.invoice.challanDate}"/></b>
                                            </c:when>
                                            <c:otherwise>
                                                <b>-</b>
                                            </c:otherwise>
                                        </c:choose>

													</div>
                                                    </td>
										</tr>

                                        <tr>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Vehicle No.
												</div>
											</td>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:1px solid #000000;">
                                            <div align="right" style="margin-right:7px; font-family:Times New Roman; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.vehicleNo!= null}">
                                                                <b>${invoiceBean.invoice.vehicleNo}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>
													</div></td>

											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													LOI Number
												</div>
											</td>
<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:2px solid #000000;">
                                            <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.loiNumber!= null}">
                                                                <b>${invoiceBean.invoice.loiNumber}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>

													</div>
                                                    </td>
										</tr>

                                        <tr>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													Transporter
												</div>
											</td>
											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:1px solid #000000;">
                                            <div align="right" style="margin-right:7px; font-family:Times New Roman; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.transporter!= null}">
                                                                <b>${invoiceBean.invoice.transporter}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>
													</div></td>

											<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; ">
												<div align="left" style="margin-left:7px; font-family:Times New Roman; font-size:9px">
													LR Number
												</div>
											</td>
<td width="25%" nowrap style="background:#ffffff; height:20px; color:#000000; border-right:2px solid #000000;">
                                            <div align="right" style="margin-right:1px; font-family:Verdana; font-size:9px;">
                                                        <c:choose>
                                                            <c:when test="${invoiceBean.invoice.lrNumber!= null}">
                                                                <b>${invoiceBean.invoice.lrNumber}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b>-</b>
                                                            </c:otherwise>
                                                        </c:choose>

													</div>
                                                    </td>
										</tr>

									</table>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
            <tr>
                <td colspan="6">&nbsp;</td>
            </tr>
            <tr>
            <td colspan="6" style="border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;border-top:2px solid #000000;">
                	<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
                  	<tr>
                          <td width="10%" valign="top" style="background:#ffffff;  border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;"><div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px">
								NO.
							</div>
					  </td>
                    	<td width="15%" valign="top" style="background:#ffffff;  border-right:1px solid #000000; border-bottom:1px  solid #000000;"><div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px">
								Material
							</div>
					  </td>
                    	<td width="15%" valign="top" style="background:#ffffff;  border-right:1px solid #000000; border-bottom:1px  solid #000000;">
			  <div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px; ">
								Chapter ID
							</div>
					  </td>
               		  <td width="20%" valign="top" style="background:#ffffff;  border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style="margin-left:7px; margin-top:2px; font-family:Times New Roman; font-size:9px; ">
								Item Name
						</div>
					  </td>
               		  <td width="10%" nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style="margin-top:2px; font-family:Times New Roman; font-size:9px">
								Quantity
						</div>
					  </td>
                 		<td width="10%" nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style=" margin-top:2px; font-family:Times New Roman; font-size:9px">
								Price
							</div>
					  </td>
                          <td width="5%" nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
<div align="center" style=" margin-top:2px; font-family:Times New Roman; font-size:9px">
								Unit
							</div>
					  </td>
                  		<td width="15%" valign="top" nowrap style="background:#ffffff; border-right:1px solid #000000; border-bottom:1px  solid #000000;">
					  <div align="center" style=" margin-top:2px; font-family:Times New Roman; font-size:9px">
								AMOUNT
							</div>
					  </td>
					</tr>
                       <c:forEach items="${invoice.invoiceDetail}" var="invoicedetail" varStatus="loop" >
                <c:forEach items="${invoice.order.orderDetail}" var="orderdetail" varStatus="loop1"  >
                    <c:if test="${invoicedetail.product.id eq orderdetail.product.id}">

						<tr style="border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px  solid #000000;height:50px">
	                    	<td valign="top" style="background:#ffffff; border-right:1px solid #000000;border-left:1px solid #000000; ">
								<div align="center" style="margin-top:7px; font-family:Verdana; font-size:9px">
                                    ${loop.index+1}
								</div>
							</td>
	                    	<td valign="top" style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="center" style="margin-top:7px; font-family:Verdana; font-size:9px; ">
									${invoicedetail.material}
								</div>
							</td>
							<td valign="top" style="background:#ffffff;  border-right:1px solid #000000; ">
							<strong>	<div align="center" style="margin-left:7px; margin-top:7px; font-family:Verdana; font-size:9px; ">
									${invoicedetail.chapterId}
								</div>
								</strong>
							</td>
                            <td valign="top" style="background:#ffffff;  border-right:1px solid #000000; ">
							<strong>	<div align="center" style="margin-left:7px; margin-top:7px; font-family:Verdana; font-size:9px; ">
									${invoicedetail.product.productName}
								</div>
								</strong>
							</td>
							<td nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000;">
								<div align="center" style="margin-top:7px; font-family:Verdana; font-size:9px">
									${invoicedetail.dispatched}
								</div>
							</td>
	                    	<td nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="center" style="margin-right:1px; margin-left:1px; margin-top:7px; font-family:Verdana; font-size:9px">
                                    <fmt:formatNumber type="number" pattern="##.##" value="${invoicedetail.productCost}"/>
								</div>
							</td>
                            <td nowrap valign="top" style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="center" style="margin-right:1px; margin-left:1px; margin-top:7px; font-family:Verdana; font-size:9px">
                                    ${invoicedetail.product.unit.name}
								</div>
							</td>
							<td valign="top" nowrap style="background:#ffffff; border-right:1px solid #000000; ">
								<div align="right" style="margin-right:1px; margin-left:1px; margin-top:7px; font-family:Verdana; font-size:9px">
								<strong	>
                                                <fmt:formatNumber type="number" pattern="##.##" value="${invoicedetail.dispatched * invoicedetail.productCost}"/>


</strong>
								</div>
							</td>
						</tr>
                      </c:if>

                </c:forEach></c:forEach>
				</table>
			</td>
            </tr>
            <tr>
                <td colspan="4" valign="middle" style="background:#ffffff; border-left:2px solid #000000; border-bottom:2px solid #000000;">&nbsp;</td>
            <td valign="middle" style="background:#ffffff; border-bottom:2px solid #000000;">
                      	<div align="center" style="font-family:Times New Roman; font-size:9px">
                      		TOTAL AMOUNT
                      	</div>
                      </td>
                      <td valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:2px solid #000000;">
                      <strong>	<div align="right" style="margin-right:0px; margin-top:0px; margin-bottom:1px; font-family:Verdana; font-size:9px">
                          <c:choose>
                                                                      <c:when test="${invoice.totalAmount!= null}">
                                                                      <b><fmt:formatNumber type="number" pattern="##.##" value="${invoice.totalAmount}"/>  </b>
                                                                      </c:when>
                                                                      <c:otherwise>
                                                                          <b>-</b>
                                                                      </c:otherwise>
                                                                  </c:choose>

                      	</div></strong>
                      </td>
            </tr>


			<tr>
            	<td colspan="2" width="30%">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                	<tr>
	                		<td width="50%" valign="middle" style="height:18px; background:#ffffff; border-right:1px solid #000000; border-left:2px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
                                Payment
	                       	  </div>
	                        </td>
	                        <td width="50%" valign="middle" style="background:#ffffff; border-right:2px solid #000000; ">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
								<b>${invoiceBean.advance.paymentMode.mode}</b>
	                       	  </div>
	                        </td>
                         </tr>
                        <tr>
	                        <td width="50%" valign="middle" style="background:#ffffff; border-right:1px solid #000000; border-left:2px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	Due Date
	                       	  </div>
	                        </td>
	                        <td width="50%" valign="middle" style="background:#ffffff; border-right:2px solid #000000; ">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	<b><s:format value="${invoiceBean.invoice.dueDate}" formatPattern="dd/MM/yyyy"/> </b>
	                       	  </div>
	                        </td>
                        </tr>
                            <tr>
	                        <td valign="middle" width="50%" style="background:#ffffff; border-right:1px solid #000000; border-bottom:2px solid #000000;border-left:2px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	Freight
	                       	  </div>
	                        </td>
                                <td valign="middle" width="50%" style="background:#ffffff; border-right:2px solid #000000; border-bottom:2px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
	                       	  	<b>${invoiceBean.invoice.freight}</b>
	                       	  </div>
	                        </td>
	                    </tr>
					</table>
            	</td>
                <td colspan="2">&nbsp;</td>
                <td colspan="3">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <c:forEach items="${invoiceBean.invoice.taxes}" var="tax" varStatus="status">
	                	<tr>
	                		<td width="40%" valign="middle" style="height:18px; background:#ffffff;border-top:2px solid #000000;  border-right:1px solid #000000; border-left:2px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
                                ${tax.taxName}
	                       	  </div>
	                        </td>
	                        <td width="10%" valign="middle" style="background:#ffffff;border-top:2px solid #000000;   border-right:1px solid #000000; border-bottom:1px solid #000000;">
	                       	  <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Times New Roman; font-size:9px">
								${tax.previousTaxPercent}
	                       	  </div>
	                        </td>
                            <td width="40%" valign="middle" style="background:#ffffff; border-top:2px solid #000000;  border-right:2px solid #000000; border-bottom:1px solid #000000;">
                                <strong> <div align="right" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
                                <b><fmt:formatNumber type="number" pattern="##.##" value="${tax.taxAmount}"/>	</b>
                                 </div></strong>
                            </td>
                         </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="2" valign="middle" style="background:#ffffff;border-left:2px solid #000000;  border-right:1px solid #000000; border-bottom:2px solid #000000;">
                                 <div align="center" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
                                     <strong>NET PAYABLE</strong>
                                 </div>
                            </td>
                            <td valign="middle" style="background:#ffffff; border-right:2px solid #000000; border-bottom:2px solid #000000;">
                                <strong> <div align="right" style="margin-left:1px; margin-right:1px; margin-top:0px; font-family:Verdana; font-size:9px">
                                      <c:choose>
                                <c:when test="${invoice.netPayable!= null}">
                                <b><fmt:formatNumber type="number" pattern="##.##" value="${invoice.netPayable}"/>	</b>
                                </c:when>
                                <c:otherwise>
                                    <b>-</b>
                                </c:otherwise>
                            </c:choose>
                                 </div></strong>
                            </td>
                        </tr>

					</table>
            	</td>
            </tr>


			<tr>
				<td colspan="6" valign="middle" style="height:25px; background:#ffffff; border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;border-top:1px solid #000000;">
	            	<div align="left" style="margin-left:1px; margin-left:1px; margin-top:0px; font-family:Times New Roman; font-size:9px; text-align: justify;">
	            		${invoiceBean.term.terms}
	            	</div>
	            </td>
			</tr>