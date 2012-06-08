package com.inwise.dao;

import com.inwise.pojo.Invoice;
import com.inwise.pojo.Payment;
import com.inwise.dao.BaseDao;

import java.util.List;
import java.util.Date;
import java.util.Iterator;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;

import org.hibernate.Criteria;
import org.hibernate.Query;

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

    public List<Invoice> findByOrderId(Integer orderid)
    {                 System.out.println("order id f");

      return (List<Invoice>) sessionProvider.get().createQuery("from Invoice i where i.order.id="+orderid).list();

     
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
      public List<Invoice> findByInvoiceCustomerId(Integer id) {
         return (List<Invoice>)sessionProvider.get().createQuery("select distinct i from Invoice i WHERE i.customer.id='"+id+"'").list();
    }
     public List<Invoice> listAllwithDueAmount(List<Invoice> invoicelst,List<Payment> paymentList) {

     for(Iterator<Invoice> ird=invoicelst.iterator();ird.hasNext();){
         Double temp=0.00,a;
         Invoice rd=ird.next();
         rd.setDueQuantity(rd.getNetPayable());
         for(Iterator<Payment> ipay=paymentList.iterator();ipay.hasNext();){
             Payment pay=ipay.next();
             if(rd.getId().equals(pay.getInvoice().getId())){
                 a=pay.getReceivedAmount();
                 temp=temp+a;
                  rd.setDueQuantity(rd.getNetPayable()-temp);
                 System.out.println("zzzzzzzzzzzzzzzzzzzzzz"+temp);
                //rd.setDueQuantity(rd.getNetPayable()-pay.getReceivedAmount());
                // break;
             }


         }
        }
        return invoicelst;
    }
      public Invoice listwithDueAmount(Invoice invoice,List<Payment> paymentList) {

         Double temp=0.00,a;
         invoice.setDueQuantity(invoice.getNetPayable());
         for(Iterator<Payment> ipay=paymentList.iterator();ipay.hasNext();)
         {
             Payment pay=ipay.next();
             if(invoice.getId().equals(pay.getInvoice().getId())){
                a=pay.getReceivedAmount();
                 temp=temp+a;
                  invoice.setDueQuantity(invoice.getNetPayable()-temp);
             }


         }

        return invoice;
    }


    public Integer getMaxInvoiceNumber() {
        System.out.println("innnnnnnnnnnnnnnnnnvoice   :"+(Integer)sessionProvider.get().createQuery("select max(invoiceNumber) from Invoice").uniqueResult());
        return (Integer)sessionProvider.get().createQuery("select max(invoiceNumber) from Invoice").uniqueResult(); 

    }


     public List<Invoice> findByInvoiceTodayDate() {

        return (List<Invoice>)sessionProvider.get().createQuery("from Invoice WHERE createDate LIKE '"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"%'").list();
    }
     public List<Invoice> getInvoiceMonth(int month, int year,String name) {

        if(month<=9)
            return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE (i.customer.name='"+name+"') AND i.createDate LIKE '"+year+"-"+0+month+"%'").list();
        else
            return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE (i.customer.name='"+name+"') AND i.createDate LIKE '"+year+"-"+month+"%'").list();

    }
       public List<Invoice> getInvoiceYear( int year,String name) {


            return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE (i.customer.name='"+name+"') AND i.createDate LIKE '"+year+"%'").list();

    }
     public List<Invoice> getByFromToCust(String fromdate, String todate,String name) {

       List<Invoice> invoicelst=(List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE (i.customer.name='"+name+"') AND (i.createDate BETWEEN '"+fromdate+"%' AND '"+todate+"%')").list();
           System.out.println("pppppprrrrooooodddduuuucttttttllllllssssssssstttttinvoicelst"+invoicelst);
         return invoicelst;
    }
    public List getInvoiceprodbyyear(String name,int year)
    {
   Integer ii=(Integer)sessionProvider.get().createSQLQuery("select id from product where product_name='"+name+"'").uniqueResult();
        System.out.println("iiiiiiiiddddddd"+ii);
    //List in= sessionProvider.get().createSQLQuery("select i.create_date,i.net_payable,i.invoice_number from invoice i left join invoice_has_invoicedetail ih on ih.invoice_id=i.id left join invoice_detail ida on ih.invoice_detail_id=ida.id where ida.product_id='"+ii+"' and i.create_date LIKE '"+year+"%'").list() ;
    //List<Invoice> in= (List<Invoice>)sessionProvider.get().createQuery ("select i from Invoice i  where i.invoiceDetail.product.id='"+i+"' and i.createDate LIKE '"+year+"%'").list() ;
     String sql="select i.create_date,i.net_payable,i.invoice_number,i.excise,i.education_cess,i.secondary_higher_education_cess_tax,i.cst_ovat from invoice i left join invoice_has_invoicedetail ih on ih.invoice_id=i.id left join invoice_detail ida on ih.invoice_detail_id=ida.id where ida.product_id='"+ii+"' and i.create_date LIKE '"+year+"%'";
        Query query = sessionProvider.get().createSQLQuery(sql);
            query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
            List results = query.list();
            return results;
      }
      public List getInvoiceprodbymonth(String name,int month,int year)
    {
   Integer ii=(Integer)sessionProvider.get().createSQLQuery("select id from product where product_name='"+name+"'").uniqueResult();
        System.out.println("iiiiiiiiddddddd"+ii);
        String sql=null;
         if(month<=9)
           sql=  "select i.create_date,i.net_payable,i.invoice_number,i.excise,i.education_cess,i.secondary_higher_education_cess_tax,i.cst_ovat from invoice i left join invoice_has_invoicedetail ih on ih.invoice_id=i.id left join invoice_detail ida on ih.invoice_detail_id=ida.id where ida.product_id='"+ii+"' AND i.create_date LIKE '"+year+"-"+0+month+"%'";
        else
         sql=  "select i.create_date,i.net_payable,i.invoice_number from invoice i left join invoice_has_invoicedetail ih on ih.invoice_id=i.id left join invoice_detail ida on ih.invoice_detail_id=ida.id where ida.product_id='"+ii+"' AND i.create_date LIKE '"+year+"-"+month+"%'";
        Query query = sessionProvider.get().createSQLQuery(sql);
            query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
            List results = query.list();
            return results;
      }
       public List getInvoiceprodbyfromto(String fromdate, String todate,String name)
    {
   Integer ii=(Integer)sessionProvider.get().createSQLQuery("select id from product where product_name='"+name+"'").uniqueResult();
        System.out.println("iiiiiiiiddddddd"+ii);
        String sql="select i.create_date,i.net_payable,i.invoice_number,i.excise,i.education_cess,i.secondary_higher_education_cess_tax,i.cst_ovat from invoice i left join invoice_has_invoicedetail ih on ih.invoice_id=i.id left join invoice_detail ida on ih.invoice_detail_id=ida.id where ida.product_id='"+ii+"'AND (i.create_date BETWEEN '"+fromdate+"%' AND '"+todate+"%')";
        Query query = sessionProvider.get().createSQLQuery(sql);
            query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
            List results = query.list();
            return results;
      }
      public List<Invoice> getInvoiceYearalltax( int year) {


            return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE i.createDate LIKE '"+year+"%'").list();

    }
      public List<Invoice> getInvoiceMonthalltax(int month, int year) {

        if(month<=9)
            return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE i.createDate LIKE '"+year+"-"+0+month+"%'").list();
        else
            return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE  i.createDate LIKE '"+year+"-"+month+"%'").list();

    }
       public List<Invoice> getByFromToalltax(String fromdate, String todate) {

       List<Invoice> invoicelst=(List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE  i.createDate BETWEEN '"+fromdate+"%' AND '"+todate+"%'").list();
          //System.out.println("pppppprrrrooooodddduuuucttttttllllllssssssssstttttinvoicelst"+invoicelst);
         return invoicelst;
    }


   }
