package com.inwise.dao;

import com.inwise.pojo.Invoice;
import com.inwise.dao.BaseDao;

import java.util.List;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;

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

    public List<Invoice> findByOrderNo(Integer orderNo) {
        return (List<Invoice>)sessionProvider.get().createQuery("from Invoice i where i.order.id='"+orderNo+"'").list();
    }
    public List<Integer> getInvoiceNumberLst() {
        return sessionProvider.get().createQuery("select distinct i.invoiceNumber from Invoice i").list();  //To change body of created methods use File | Settings | File Templates.
    }

    public List<String> getInvoiceOrderNumberLst() {
         return sessionProvider.get().createQuery("select distinct i.order.customerOrderNo from Invoice i").list();  //To change body of created methods use File | Settings | File Templates.
    }

    public List<String> getInvoiceCustomerNameLst() {
         return sessionProvider.get().createQuery("select distinct i.customer.name from Invoice i").list();
    }

    public List<String> getInvoiceProductNameLst() {
         return sessionProvider.get().createQuery("select distinct i.product.productName from InvoiceDetail i").list();
    }


    public Invoice findByInvoiceNumber(int id) {
       Invoice ii=null;
        try{
           ii= (Invoice)sessionProvider.get().createQuery("select distinct i from Invoice i WHERE i.invoiceNumber='"+id+"'").uniqueResult();
            System.out.println("ii from dao :"+ii);
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
        return ii;
    }

    public List<Invoice> findByInvoiceCustomerOrderNo(String customerOrderno) {
      return (List<Invoice>)sessionProvider.get().createQuery("select distinct i from Invoice i WHERE i.order.customerOrderNo='"+customerOrderno+"'").list();
    }

    public List<Invoice> findByInvoiceCustomerName(String name) {
         return (List<Invoice>)sessionProvider.get().createQuery("select distinct i from Invoice i WHERE i.customer.name='"+name+"'").list();
    }

    public List<Invoice> findByInvoiceDate(String sdate) {
          sdate=sdate.replace("/","-");
        try{
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = (Date)formatter.parse(sdate);
            sdate = formatter.format(date);

        }
        catch (ParseException e)
        {
            System.out.println("Exception :"+e);
        }
        return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE i.createDate LIKE '"+sdate+"%'").list();
    }
}
