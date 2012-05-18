package com.inwise.dao;

import com.inwise.pojo.Invoice;
import com.inwise.dao.BaseDao;

import java.util.List;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: Milind
 * Date: May 17, 2012
 * Time: 5:12:58 PM
 * To change this template use File | Settings | File Templates.
 */
public class InvoiceDao extends BaseDao<Invoice,Integer>{
    public InvoiceDao() {
        super(Invoice.class);
    }

    public List<Integer> getInvoiceNumberLst() {
        return sessionProvider.get().createQuery("select i.invoiceNumber from Invoice i").list();  //To change body of created methods use File | Settings | File Templates.
    }

    public List<String> getInvoiceOrderNumberLst() {
         return sessionProvider.get().createQuery("select i.order.customerOrderNo from Invoice i").list();  //To change body of created methods use File | Settings | File Templates.
    }

    public List<String> getInvoiceCustomerNameLst() {
         return sessionProvider.get().createQuery("select i.customer.name from Invoice i").list();
    }

    public List<String> getInvoiceProductNameLst() {
         return sessionProvider.get().createQuery("select i.invoiceDetail.product.name from Invoice i").list();
    }


    public Invoice findByInvoiceNumber(int id) {
           return (Invoice)sessionProvider.get().createQuery("select i from Invoice i WHERE i.order.customerOrderNo='"+id+"'").uniqueResult();

    }

    public Invoice findByInvoiceCustomerOrderNo(String customerOrderno) {
      return (Invoice)sessionProvider.get().createQuery("select i from Invoice i WHERE i.order.customerOrderNo='"+customerOrderno+"'").uniqueResult();
    }

    public Invoice findByInvoiceProductName(String productname) {
        return (Invoice) sessionProvider.get().createQuery("select i from Invoice i WHERE i.invoiceDetail.product.productName='"+productname+"'").uniqueResult();
    }


    public Invoice findByInvoiceCustomerName(String name) {
         return (Invoice)sessionProvider.get().createQuery("select i from Invoice i WHERE i.order.customerName='"+name+"'").uniqueResult();
    }

    public Invoice findByInvoiceDate(Date date) {
        return (Invoice)sessionProvider.get().createQuery("select i from Invoice i WHERE i.createDate='"+date+"'").uniqueResult();
    }
}
