package com.inwise.action;

import com.google.inject.Inject;

import com.inwise.dao.*;
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
     @Inject
     PaymentDao paymentdao;


    List<Order> orderNoList;
     List<Invoice> invoiceList;
    List<Object> custNameIdList;
    List<Object> orderFromAdvance;
    private Advance advance;
    private Customer cust;
    private Integer customerOrderNo;
    private Integer receiptNumber;
    private Integer inviceNumber;
    private String showdropdown;
    private boolean popup;
    private String printBy;
    private String setVisibleAdvanceTable;
    private String visibleInvoiceTable;
    private Invoice invoice;

     private static final String PRINTINVOICE="jsp/printInvoice.jsp";
     private static final String ADVANCERECEIPT="jsp/receipt/advanceReceipt.jsp";
     private static final String INVOICERECEIPT="jsp/receipt/viewOrderSlip.jsp";


    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public String getVisibleInvoiceTable() {
        return visibleInvoiceTable;
    }

    public void setVisibleInvoiceTable(String visibleInvoiceTable) {
        this.visibleInvoiceTable = visibleInvoiceTable;
    }

    public Advance getAdvance() {
        return advance;
    }

    public Integer getInviceNumber() {
        return inviceNumber;
    }

    public void setInviceNumber(Integer inviceNumber) {
        this.inviceNumber = inviceNumber;
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

    public CustomerDao getCustomerDao() {
        return customerDao;
    }

    public void setCustomerDao(CustomerDao customerDao) {
        this.customerDao = customerDao;
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

    public String getSetVisibleAdvanceTable() {
        return setVisibleAdvanceTable;
    }

    public void setSetVisibleAdvanceTable(String setVisibleAdvanceTable) {
        this.setVisibleAdvanceTable = setVisibleAdvanceTable;
    }

    public Resolution printInvoiceLink()
    {

        custNameIdList=orderDao.getCustomerForAdvance();
        return new ForwardResolution(PRINTINVOICE);
    }

    public Resolution getOrderDropDown()
    {
        custNameIdList=orderDao.getCustomerForAdvance();
        System.out.println("in print invoice resolution"+custNameIdList);
        orderNoList=orderDao.getCustomerOrderNo(id);
         System.out.println("in print invoice resolution2222222222222"+orderNoList);
        cust=customerDao.find(id);
         System.out.println("in print invoice resolution22222222222223333333"+cust);
        showdropdown="yes";
       return new ForwardResolution(PRINTINVOICE);
    }


    public Resolution lst()
    {
         printBy="byReceipt";
        custNameIdList=orderDao.getCustomerForAdvance();
        orderFromAdvance=orderDao.getOrderForPrint(id);
        System.out.println(orderFromAdvance);
        if(orderFromAdvance.size()>0)
        {
            setVisibleAdvanceTable="yes";
            System.out.println(orderFromAdvance.size());
        }   else{
               setVisibleAdvanceTable="alert";
        }
        getContext().getMessages().add(new SimpleMessage(orderFromAdvance.size()+"  Items are found all are displying"));
        cust=customerDao.find(id);
        return new ForwardResolution(PRINTINVOICE);
    }


    public Resolution invoiceLst()
    {
        System.out.println("in invoice lst...................");
         printBy="byInvoice";
        custNameIdList=orderDao.getCustomerForAdvance();
        orderNoList=orderDao.getCustomerOrderNo(id);
       invoiceList=invoiceDao.listAllwithDueAmount(invoiceDao.findByOrderId(customerOrderNo),paymentdao.listAll());
        if(invoiceList.size()>0)
        {
            visibleInvoiceTable="yes";
        }
        if(invoiceList.size()==0)
        {
         getContext().getMessages().add(new SimpleMessage("  Invoice is not generated for this order.   Please Generate the Invoice First.."));   
        }
        else{
        getContext().getMessages().add(new SimpleMessage(invoiceList.size()+"  Items found, Displying all"));
        }
        showdropdown="yes";
        cust=customerDao.find(id);
        return new ForwardResolution(PRINTINVOICE);
    }
    public Resolution printAdvanceReceipt()
    {
        System.out.println("in print advance receiptyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
         popup=true;
        System.out.println("in printadv receipt"+id);
        return new RedirectResolution(PrintActionBean.class,"lst").addParameter("popup",popup).addParameter("id",id).addParameter("receiptNumber",receiptNumber);
     
    }
    public Resolution printInvoiceReceipt()
    {
        popup=true;
         System.out.println("advance popup resoltuin"+"cust id"+id+"invoice no"+inviceNumber+"order id"+customerOrderNo);
        System.out.println("in print invoice receipt");
        return new RedirectResolution(PrintActionBean.class,"invoiceLst").addParameter("popup",popup).addParameter("id",id).addParameter("inviceNumber",inviceNumber).addParameter("customerOrderNo",customerOrderNo);
       
    }
    public Resolution invoicePopup()
   {

       System.out.println("in invoice popup....................");
       invoice=invoiceDao.findByInvoiceNumber(id);
       System.out.println(invoice);
       return new ForwardResolution(INVOICERECEIPT);
   }


}
