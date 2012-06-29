package com.inwise.action;

import com.inwise.pojo.*;
import com.inwise.dao.*;

import com.google.inject.Inject;

import java.util.List;

import net.sourceforge.stripes.action.*;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: May 23, 2012
 * Time: 11:13:45 AM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/paymentstatus")
@HttpCache(allow = false)
public class PaymentStatusActionBean extends BaseActionBean{
     private static final String PAYMENTSTATUS="jsp/paymentStatus.jsp";
    private static final String UPDATEPAYMENTSTATUS="jsp/updatePaymentStatus.jsp";

    @Inject
    CustomerDao customerDao;
     @Inject
     PaymentModeDao paymentmodeDao;
     @Inject
     InvoiceDao invoiceDao;
     @Inject
     UserDao userDao;
     @Inject
     PaymentDao paymentdao;
    private List<Customer> customerlst;
    private Customer customer;
    private List<Invoice> invoicelst;
    private Invoice invoice;
    private String hdnvalue;
     private List<PaymentMode> paymentmode;
     private String test;
    private Payment payment;
    private List<Payment> paymentlst;
   private List<User> userlst;
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<User> getUserlst() {
        return userlst;
    }

    public void setUserlst(List<User> userlst) {
        this.userlst = userlst;
    }

    public List<Payment> getPaymentlst() {
        return paymentlst;
    }

    public void setPaymentlst(List<Payment> paymentlst) {
        this.paymentlst = paymentlst;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public String getTest() {
        return test;
    }

    public void setTest(String test) {
        this.test = test;
    }

    public List<PaymentMode> getPaymentmode() {
        return paymentmode;
    }

    public void setPaymentmode(List<PaymentMode> paymentmode) {
        this.paymentmode = paymentmode;
    }



    public String getHdnvalue() {
        return hdnvalue;
    }

    public void setHdnvalue(String hdnvalue) {
        this.hdnvalue = hdnvalue;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public List<Invoice> getInvoicelst() {
        return invoicelst;
    }

    public void setInvoicelst(List<Invoice> invoicelst) {
        this.invoicelst = invoicelst;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public List<Customer> getCustomerlst() {
        return customerlst;
    }

    public void setCustomerlst(List<Customer> customerlst) {
        this.customerlst = customerlst;
    }

    @DefaultHandler
    public Resolution page()
    {
         // invoice=invoiceDao.find(id);
          invoicelst=invoiceDao.listAllwithDueAmount(invoiceDao.listAll(),paymentdao.listAll());
         customerlst=customerDao.listAll();
        return new ForwardResolution(PAYMENTSTATUS);
    }
    public Resolution getStatus()
    {
        customer=customerDao.find(id);
        
         customerlst=customerDao.listAll();
        if(id!=0 || hdnvalue=="teststatus")
        {
      
        invoicelst=invoiceDao.listAllwithDueAmount(invoiceDao.findByInvoiceCustomerId(id),paymentdao.listAll());
        //paymentlst=paymentdao.listAll();
       // System.out.println(" invoicelst after get is aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa in if"+ payment);
        test="abc";
        }
        else
        {
            //System.out.println(" invoicelst after get is aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa in else"+ invoicelst);
      invoicelst=invoiceDao.listAllwithDueAmount(invoiceDao.listAll(),paymentdao.listAll());
        }  // System.out.println("invoice after get is"+invoicelst);

         return new ForwardResolution(PAYMENTSTATUS);
    }
    public Resolution print()
    {
        invoice=invoiceDao.listwithDueAmount(invoiceDao.findByInvoiceNumber(invoice.getInvoiceNumber()),paymentdao.listAll()) ;
       // customer=customerDao.find(id);
        customerlst=customerDao.listAll();
       paymentlst=paymentdao.listAll();
        paymentmode=paymentmodeDao.listAll();
        userlst=userDao.listAll();
      
      System.out.println("paymentmode after get is aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+id);
        return new ForwardResolution(UPDATEPAYMENTSTATUS);
    }
      
    public Resolution addPayment()
    {

        System.out.println("logged in user "+getContext().getUser());
        payment.setUser(getContext().getUser());
        //test=paymentdao.checkinvoiceid(id);
        //paymentdao.checkinvoiceid(id);
        //if( test=="0")
     paymentdao.save(payment);


/*
            Payment old=paymentdao.findByInvoiceId(id);
            //payment has the new values. we want to merge this NEW payment object with the OLD object.
//            old.setInvoice(payment.getInvoice());
//            old.setPaymentMode(payment.getPaymentMode());
            System.out.println("payment updated without id "+payment);
            payment.setId(old.getId());
            System.out.println(" payment updated with id "+payment);

*/


       // paymentdao.save(paymentdao.findByInvoiceId(id));
             System.out.println("add payment after get is aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+id);
            //
            //    System.out.println("Paymeeeeeeeeeent bbbbbbbbbyyyyyyyyy idddddddd "+paymentdao.findByInvoiceId(id));

      return new RedirectResolution(PaymentStatusActionBean.class,"page");
    }
}
