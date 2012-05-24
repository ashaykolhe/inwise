package com.inwise.action;

import com.inwise.pojo.Customer;
import com.inwise.pojo.Invoice;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.InvoiceDao;
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
     InvoiceDao invoiceDao;
    private List<Customer> customerlst;
    private Customer customer;
    private List<Invoice> invoicelst;
    private Invoice invoice;

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
          invoicelst=invoiceDao.listAll();
         customerlst=customerDao.listAll();
        return new ForwardResolution(PAYMENTSTATUS);
    }
    public Resolution getStatus()
    {
        customer=customerDao.find(id);
         customerlst=customerDao.listAll();
        if(id!=0)
        {
        invoice=invoiceDao.find(id);
        System.out.println("id after get isaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+id);
        }
        else
        invoicelst=invoiceDao.listAll();
           // System.out.println("invoice after get is"+invoicelst);
         return new ForwardResolution(PAYMENTSTATUS);
    }
    public Resolution print()
    {
         // invoice=invoiceDao.find(id);

        // invoice=invoiceDao.find(id);
          //customer=customerDao.find(id);
        return new ForwardResolution(UPDATEPAYMENTSTATUS);
    }
}
