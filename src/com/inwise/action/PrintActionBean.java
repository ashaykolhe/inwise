package com.inwise.action;

import com.google.inject.Inject;

import com.inwise.dao.OrderDao;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.InvoiceDao;
import com.inwise.pojo.Customer;
import com.inwise.pojo.Order;
import com.inwise.pojo.Invoice;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.ajax.JavaScriptResolution;

import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: May 16, 2012
 * Time: 10:14:02 AM
 * To change this template use File | Settings | File Templates.
 */
public class PrintActionBean extends BaseActionBean
{
    @Inject
    CustomerDao customerDao;
     @Inject
     OrderDao orderDao;
    @Inject
    InvoiceDao invoiceDao;
    private String custName;
    private Integer custId;
    List<Order> orderList;
    List<Order> selectedOrderList;
    List<Order> orderNoList;
    List<Invoice> invoiceList;
    private Customer cust;
    private Integer customerOrderNo;

    public List<Invoice> getInvoiceList() {
        return invoiceList;
    }

    public void setInvoiceList(List<Invoice> invoiceList) {
        this.invoiceList = invoiceList;
    }

    public Integer getCustomerOrderNo() {
        return customerOrderNo;
    }

    public void setCustomerOrderNo(Integer customerOrderNo) {
        this.customerOrderNo = customerOrderNo;
    }

    public Customer getCust() {
        return cust;
    }

    public void setCust(Customer cust) {
        this.cust = cust;
    }

    public List<Order> getSelectedOrderList() {
        return selectedOrderList;
    }

    public void setSelectedOrderList(List<Order> selectedOrderList) {
        this.selectedOrderList = selectedOrderList;
    }

    public List<Order> getOrderNoList() {
        return orderNoList;
    }

    public void setOrderNoList(List<Order> orderNoList) {
        this.orderNoList = orderNoList;
    }

    public Integer getCustId() {
        return custId;
    }

    public void setCustId(Integer custId) {
        this.custId = custId;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public List<Order> getOrderList() {
        return orderList;
    }

    public void setOrderList(List<Order> orderList) {
        this.orderList = orderList;
    }

    public Resolution getOrderDropDown()
    {
        orderNoList=orderDao.getOrderNoList(id);
        return new JavaScriptResolution(orderNoList);
    }

    public Resolution lst()
    {

        orderList= orderDao.listAll();
        selectedOrderList= orderDao.getOrderNoList(id);
        System.out.println(selectedOrderList);
        cust=customerDao.find(id);
        return new ForwardResolution("jsp/printInvoice.jsp");
    }
    public Resolution invoiceLst()
    {
        orderList= orderDao.listAll();
        invoiceList=invoiceDao.findByOrderNo(customerOrderNo);
        cust=customerDao.find(id);
        return new ForwardResolution("jsp/printInvoice.jsp");
    }
    public Resolution printInvoiceLink()
    {
         orderList= orderDao.listAll();
         return new ForwardResolution("jsp/printInvoice.jsp");
    }
}
