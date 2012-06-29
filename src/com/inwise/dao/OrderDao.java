package com.inwise.dao;
import com.inwise.dao.BaseDao;

import java.util.List;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import com.inwise.pojo.*;
import com.wideplay.warp.persist.Transactional;

import java.util.List;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;

import org.hibernate.criterion.Restrictions;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 17, 2012
 * Time: 10:25:03 AM
 * To change this template use File | Settings | File Templates.
 */
public class OrderDao extends BaseDao<Order,Integer> {
    public OrderDao() {
        super(Order.class);
    }
	public List<Order> getCustomerOrderNo(Integer id) {
        
         return (List<Order>)sessionProvider.get().createQuery(" from Order o where o.customer.id='"+id+"' and deleted='0'").list();
    }
    /*public Integer getInvoiceNumber()
    {
        return (Integer)sessionProvider.get().createSQLQuery("select invoice_number from invoice order by invoice_number desc").setMaxResults(1).uniqueResult();
    }*/
    public List<Object> getCustomerForAdvance() {

         List<Object> custNameIdList=sessionProvider.get().createSQLQuery("SELECT DISTINCT c.id ,c.name from customer c inner JOIN order_master o on c.id=o.customer_id ").list();
        return custNameIdList;
    }

  /*-----------------  this method is for getting order nos for those advance is made-------------*/
    public List<Object> getOrderForPrint(Integer id)
    {
        List<Object> custOrderIdList=sessionProvider.get().createSQLQuery("SELECT DISTINCT o.customer_order_no,a.receipt_no,a.amount_received,o.customer_id from order_master o INNER JOIN advance a on o.id=a.order_id where customer_id="+id).list();
         Iterator<Object> it=custOrderIdList.iterator();
         return custOrderIdList;
    }
   /*------------------this method is for getting the order no..for those advance is not made*/
    public List<Object> getOrderForAdvance(Integer id)
       {
           List<Object> custOrderIdList=sessionProvider.get().createSQLQuery("SELECT DISTINCT o.customer_order_no,o.customer_id from order_master o INNER JOIN advance a on o.id!=a.order_id where customer_id="+id).list();
            Iterator<Object> it=custOrderIdList.iterator();
            return custOrderIdList;
       }
    public List<String> getOrderCustomerOrderNumber() {
         return (List<String>)sessionProvider.get().createQuery("SELECT distinct o.customerOrderNo from Order o").list();
    }

    public List<String> getOrderCustomerNameLst() {
         return (List<String>)sessionProvider.get().createQuery("SELECT distinct o.customer.name from Order o").list();
    }

    public Order findByOrderCustomerOrderNumber(String name) {
     return (Order)sessionProvider.get().createQuery("select distinct o from Order o WHERE o.customerOrderNo='"+name+"'").uniqueResult();
    }

    public List<Order> findByOrderCustomerName(String name) {
        return (List<Order>) sessionProvider.get().createQuery("select distinct o from Order o where o.customer.name='"+name+"'").list();

    }


    public List<Order> findByOrderDate(String sdate) {
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
        return (List<Order>)sessionProvider.get().createQuery("select distinct o from Order o WHERE o.createDate LIKE '"+sdate+"%'").list();
    }
    public boolean customerOrderNoAlreadyPresent(String customerOrderNo){
        return sessionProvider.get().createQuery("from Order o where o.customerOrderNo='"+customerOrderNo+"'").uniqueResult()==null ? false : true;
    }

    public Integer latestOrderId(){
        return (Integer)sessionProvider.get().createQuery("select max(id) from Order").uniqueResult();
    }

    public List<Order> getOrderList(){
        return sessionProvider.get().createQuery("from Order where deleted='0'").list();
    }

    @Override @Transactional
public void remove(Integer id) {
        try{
            Order order=super.find(id);
        order.setDeleted(1);
            System.out.println("prod in delete dao"+order);
            super.save(order);
            System.out.println("prod in delete dao2"+order);
    }catch (Exception e){
        e.printStackTrace();
    }
}
    


    public List<Invoice> findInvoiceByCustomerOrderNumber(String name) {
        return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE i.order.customerOrderNo='"+name+"'").list();
    }
    
    public Order findAOrderByOrderNo(String customerOrderNo)
    {
        return (Order)sessionProvider.get().createQuery("from Order o where o.customerOrderNo='"+customerOrderNo+"'").uniqueResult();
    }
   
     

    public List<Invoice> findInvoiceByCustomerName(String name) {
         return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE i.customer.name='"+name+"'").list();
    }

    public Boolean checkInvoiceForThisOrderDispatched(Integer orderId){

        Double remainingQuantity=(Double)sessionProvider.get().createSQLQuery("select sum(od.remaining_quantity) from order_master o left join order_has_orderdetail ohod on o.id=ohod.order_id left join order_detail od on od.id=ohod.order_detail_id where o.id="+orderId).uniqueResult();

        return remainingQuantity==0.0;
    }
    @Transactional
    public void setRemainingNDispatchedQtyForUpdateOrder(int id, List<InvoiceDetail> invoiceDetail) {
        Order order= (Order) sessionProvider.get().createQuery("select o from Order o where o.id="+id+"").uniqueResult();
              Iterator<OrderDetail> it=order.getOrderDetail().iterator();

        for (Iterator<InvoiceDetail> invoiceDetailIterator = invoiceDetail.iterator(); invoiceDetailIterator.hasNext();) {
            InvoiceDetail detail =  invoiceDetailIterator.next();
                  if(it.hasNext())
                  {
                      OrderDetail orderdetail=it.next();
                      if(orderdetail.getRemainingQuantity()==0.0)
                      {
                        
                        continue;
                      }
                      else
                      {
                      orderdetail.setRemainingQuantity(orderdetail.getRemainingQuantity()-detail.getDispatched());
                      orderdetail.setDispatchedQuantity(detail.getDispatched());
                      }
                  }

      }
        super.save(order);


    }
}
