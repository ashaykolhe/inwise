package com.inwise.action;

import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;
import com.google.inject.Inject;
import com.inwise.dao.*;
import com.inwise.pojo.*;

import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: May 16, 2012
 * Time: 10:12:38 AM
 * To change this template use File | Settings | File Templates.
 */

@UrlBinding("/invoice")
public class InvoiceActionBean extends BaseActionBean{
      @Inject
        TaxDao taxDao;
    @Inject
     CustomerDao customerDao;
    @Inject
     InvoiceDao  invoiceDao;
    @Inject
    AdvanceDao advanceDao;


     @Inject
       protected OrderDao orderDao;

    private List<Invoice> invoicelst;
      private List<Customer> customerlst;
          private List<Tax> taxlst;
        private List<Order> orderlst;
        private Order order;
        private Invoice invoice;
    private Advance advance;
    private String incname;
    private int in,ad,orid,inid;


    public int getInid() {
        return inid;
    }

    public void setInid(int inid) {
        this.inid = inid;
    }

    public int getOrid() {
        return orid;
    }

    public void setOrid(int orid) {
        this.orid = orid;
    }

    public List<Invoice> getInvoicelst() {
        return invoicelst;
    }

    public void setInvoicelst(List<Invoice> invoicelst) {
        this.invoicelst = invoicelst;
    }

    public int getAd() {
        return ad;
    }

    public void setAd(int ad) {
        this.ad = ad;
    }

    public int getIn() {
        return in;
    }

    public void setIn(int in) {
        this.in = in;
    }

    public Advance getAdvance() {
        return advance;
    }

    public void setAdvance(Advance advance) {
        this.advance = advance;
    }

    public String getIncname() {
        return incname;
    }

    public void setIncname(String incname) {
        this.incname = incname;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public List<Order> getOrderlst() {
        return orderlst;
    }

    public void setOrderlst(List<Order> orderlst) {
        this.orderlst = orderlst;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public List<Tax> getTaxlst() {
        return taxlst;
    }

    public void setTaxlst(List<Tax> taxlst) {
        this.taxlst = taxlst;
    }

    public List<Customer> getCustomerlst() {
        return customerlst;
    }

    public void setCustomerlst(List<Customer> customerlst) {
        this.customerlst = customerlst;
    }

    @DefaultHandler
    public Resolution pre(){
        customerlst=customerDao.listAll();
        orderlst=orderDao.listAll();

        return new ForwardResolution("jsp/addInvoice.jsp");
    }
     public Resolution getOrderDetail(){
         
        order=orderDao.find(id);
        advance=advanceDao.getAdvancedByOrderId(id);
        
        return new ForwardResolution(InvoiceActionBean.class,"pre");
    }
    public Resolution getTax(){
       taxlst=taxDao.listAll();
       return new JavaScriptResolution(taxlst);
    }

    public Resolution generate()
    {
        Integer invoicenum=null;
        if(invoice!=null){
            if (invoice.getCreateDate() == null)
            {
                invoice.setCreateDate(new Date());
            }
            invoicenum=invoiceDao.getMaxInvoiceNumber();
            if(invoicenum==null)
            {
                invoice.setInvoiceNumber(1000);
            }
            else
            {
                invoice.setInvoiceNumber(invoicenum+1);
            }
        }
        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail id=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            id=(InvoiceDetail)i.next();
            if(id==null){
                i.remove();
                continue;
            }
        }
        invoice.setDeleted(0);
        invoice.setDebitEntryDate(new Date());
        invoice.setDebitEntryNo("d12");
        invoice.setInvoiceDetail(invoicedetail);
        System.out.println("invoice Detail :"+invoicedetail);
        invoiceDao.save(invoice);
        advanceDao.setAmountRemained(invoice.getAmountRemained(),advance.getOrder().getId());
        return new RedirectResolution(InvoiceActionBean.class,"pre");
   }
    public Resolution addpreview()
    {
        System.out.println("preview madhe aala ka......");
        Integer invoicenum=null;
            if(invoice!=null){
                   if (invoice.getCreateDate() == null)
                   {
                       invoice.setCreateDate(new Date());
                   }
                   invoicenum=invoiceDao.getMaxInvoiceNumber();
                   if(invoicenum==null)
                   {
                       invoice.setInvoiceNumber(1000);
                   }
                   else
                   {
                           invoice.setInvoiceNumber(invoicenum+1);
                   }
            }
            List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
            InvoiceDetail id=null;
               for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
                   id=(InvoiceDetail)i.next();
                   if(id==null){
                       i.remove();
                       continue;
                   }
                }
            invoice.setDeleted(0);
            invoice.setDebitEntryDate(new Date());
            invoice.setDebitEntryNo("d12");
            invoice.setInvoiceDetail(invoicedetail);
            in=invoice.getInvoiceNumber();
            ad=advance.getOrder().getId();
            invoiceDao.save(invoice);
            advanceDao.setAmountRemained(invoice.getAmountRemained(),advance.getOrder().getId());
            return new RedirectResolution(InvoiceActionBean.class,"redirectpreview").addParameter("in",in).addParameter("ad",ad);
    }
    public Resolution updatepreview()
    {
        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
                   InvoiceDetail id=null;
                      for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
                          id=(InvoiceDetail)i.next();
                          if(id==null){
                              i.remove();
                              continue;
                          }
                       }
                   invoice.setDeleted(0);
                   invoice.setDebitEntryDate(new Date());
                   invoice.setDebitEntryNo("d12");
                   invoice.setInvoiceDetail(invoicedetail);
                   in=invoice.getInvoiceNumber();
                   ad=advance.getOrder().getId();
                   invoiceDao.save(invoice);
                   advanceDao.setAmountRemained(invoice.getAmountRemained(),advance.getOrder().getId());
                       
            return new RedirectResolution(InvoiceActionBean.class,"redirectpreview").addParameter("in",in).addParameter("ad",ad);
    }
    public Resolution redirectpreview()
    {
        int no=Integer.parseInt(getContext().getRequest().getParameter("in"));
        int adid=Integer.parseInt(getContext().getRequest().getParameter("ad"));
        
            invoice=invoiceDao.findByInvoiceNumber(no);
            advance=advanceDao.getAdvancedByOrderId(adid);
        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
                InvoiceDetail id=null;
                   for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
                       id=(InvoiceDetail)i.next();
                       if(id==null){
                           i.remove();
                           continue;
                       }
                       else if(id.getDispatched()==0)
                       {
                           i.remove();
                           continue;
                       }
                    }
                    
        return new ForwardResolution("jsp/receipt/InvoicePreviewPage.jsp");
    }
    public Resolution editinvoice()
    {
        
        invoice=invoiceDao.find(getId());
        
        advance=advanceDao.getAdvancedByOrderId(ad);
        return new ForwardResolution("jsp/editInvoice.jsp");
    }
    public Resolution reviewupdate()
    {
        System.out.println("reviewUpdate invoice"+invoice);
        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
                InvoiceDetail id=null;
                   for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
                       id=(InvoiceDetail)i.next();
                       if(id==null){
                           i.remove();
                           continue;
                       }
                    }
                invoice.setDeleted(0);
                invoice.setDebitEntryDate(new Date());
                invoice.setDebitEntryNo("d12");
                invoice.setInvoiceDetail(invoicedetail);
                in=invoice.getInvoiceNumber();
                invoiceDao.save(invoice);
                advanceDao.save(advance);
        System.out.println("in :"+in);
        return new RedirectResolution(InvoiceActionBean.class,"redirectpreview").addParameter("in",in).addParameter("ad",ad);
    }
    public Resolution preupdate()
    {
        customerlst=customerDao.listAll();
          orderlst=orderDao.listAll();
        return new ForwardResolution("jsp/updateInvoice.jsp");
    }
    public Resolution getinvoicenumber()
    {
        invoicelst=invoiceDao.findByOrderId(orid);
        return new JavaScriptResolution(invoicelst);
    }
    public Resolution getinvoicedetail()
    {

        invoice=invoiceDao.find(inid);
       
        return new ForwardResolution("jsp/updateInvoice.jsp");
    }
}
