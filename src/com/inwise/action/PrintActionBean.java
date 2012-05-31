package com.inwise.action;

import com.google.inject.Inject;

import com.inwise.dao.OrderDao;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.InvoiceDao;
import com.inwise.dao.AdvanceDao;
import com.inwise.pojo.Customer;
import com.inwise.pojo.Order;
import com.inwise.pojo.Invoice;
import com.inwise.pojo.Advance;
import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;

import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: May 16, 2012
 * Time: 10:14:02 AM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/print")
public class PrintActionBean extends BaseActionBean
{
    @Inject
    CustomerDao customerDao;
    @Inject
    OrderDao orderDao;
    @Inject
    InvoiceDao invoiceDao;
    @Inject
    AdvanceDao advanceDao;


    List<Order> orderNoList;
    List<Invoice> invoiceList;
    List<Object> custNameIdList;
    List<Object> orderFromAdvance;
    private Advance advance;
    private Customer cust;
    private Integer customerOrderNo;
    private Integer receiptNumber;
    private String showdropdown;
    private boolean popup;
    private String printBy;


     private static final String PRINTINVOICE="jsp/printInvoice.jsp";
     private static final String ADVANCERECEIPT="jsp/receipt/advanceReceipt.jsp";


    public Advance getAdvance() {
        return advance;
    }

    public void setAdvance(Advance advance) {
        this.advance = advance;
    }

    public String getPrintBy() {
        return printBy;
    }

    public void setPrintBy(String printBy) {
        this.printBy = printBy;
    }

    public Integer getReceiptNumber() {
        return receiptNumber;
    }

    public void setReceiptNumber(Integer receiptNumber) {
        this.receiptNumber = receiptNumber;
    }

    public boolean isPopup() {
        return popup;
    }

    public void setPopup(boolean popup) {
        this.popup = popup;
    }

    public List<Object> getOrderFromAdvance() {
        return orderFromAdvance;
    }

    public void setOrderFromAdvance(List<Object> orderFromAdvance) {
        this.orderFromAdvance = orderFromAdvance;
    }

    public String getShowdropdown() {
        return showdropdown;
    }

    public void setShowdropdown(String showdropdown) {
        this.showdropdown = showdropdown;
    }

    public List<Object> getCustNameIdList() {
        return custNameIdList;
    }

    public void setCustNameIdList(List<Object> custNameIdList) {
        this.custNameIdList = custNameIdList;
    }

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

    public List<Order> getOrderNoList() {
        return orderNoList;
    }

    public void setOrderNoList(List<Order> orderNoList) {
        this.orderNoList = orderNoList;
    }
    public Resolution printInvoiceLink()
    {
        System.out.println("in print invoice resolution");
        custNameIdList=orderDao.getCustomerForAdvance();
        return new ForwardResolution(PRINTINVOICE);
    }
    public Resolution getOrderDropDown()
    {
        custNameIdList=orderDao.getCustomerForAdvance();
        orderNoList=orderDao.getCustomerOrderNo(id);
        cust=customerDao.find(id);
        showdropdown="yes";
       return new ForwardResolution(PRINTINVOICE);
    }


    public Resolution lst()
    {
         printBy="byReceipt";
        custNameIdList=orderDao.getCustomerForAdvance();
         System.out.println("in lst method"+id);
        getContext().getMessages().add(new SimpleMessage(custNameIdList.size()+"  Items are found all are displying"));
        orderFromAdvance=orderDao.getOrderForPrint(id);
        cust=customerDao.find(id);

        return new ForwardResolution(PRINTINVOICE);
    }
    public Resolution invoiceLst()
    {
        custNameIdList=orderDao.getCustomerForAdvance();
        orderNoList=orderDao.getCustomerOrderNo(id);
        invoiceList=invoiceDao.findByOrderNo(customerOrderNo);
        showdropdown="yes";
        cust=customerDao.find(id);

        return new ForwardResolution(PRINTINVOICE);
    }
    public Resolution printAdvanceReceipt()
    {
         popup=true;
        System.out.println("in printadv receipt"+id);
        return new RedirectResolution(PrintActionBean.class,"lst").addParameter("popup",popup).addParameter("id",id).addParameter("receiptNumber",receiptNumber);
     
    }


}
