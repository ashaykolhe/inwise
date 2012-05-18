package com.inwise.dao;

import com.inwise.pojo.Invoice;
import com.inwise.dao.BaseDao;

import java.util.List;

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


}
