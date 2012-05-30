package com.inwise.action;

import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.ajax.JavaScriptResolution;
import com.google.inject.Inject;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.TaxDao;
import com.inwise.dao.OrderDao;
import com.inwise.dao.InvoiceDao;
import com.inwise.pojo.Customer;
import com.inwise.pojo.Tax;
import com.inwise.pojo.Order;
import com.inwise.pojo.Invoice;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: May 16, 2012
 * Time: 10:12:38 AM
 * To change this template use File | Settings | File Templates.
 */
public class InvoiceActionBean extends BaseActionBean{
      @Inject
       protected TaxDao taxDao;
    @Inject
     CustomerDao customerDao;
    @Inject
     InvoiceDao  invoiceDao;

     @Inject
       protected OrderDao orderDao;

      private List<Customer> customerlst;
          private List<Tax> taxlst;
        private List<Order> orderlst;
        private Order order;
        private Invoice invoice;

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
           taxlst=taxDao.listAll();

     return new ForwardResolution("/jsp/addInvoice.jsp");
    }
     public Resolution getOrderDetail(){
        order=orderDao.find(id);
         invoice=invoiceDao.find(id);
       return new ForwardResolution(InvoiceActionBean.class,"pre");
    }

    

}
