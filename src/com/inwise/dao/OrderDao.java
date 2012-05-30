package com.inwise.dao;

import com.inwise.dao.BaseDao;
import com.inwise.pojo.Order;
import com.inwise.pojo.Customer;

import java.util.List;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

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
        
         return (List<Order>)sessionProvider.get().createQuery(" from Order o where o.customer.id='"+id+"'").list();
    }
    public List<Object> getCustomerForAdvance() {

         List<Object> custNameIdList=sessionProvider.get().createSQLQuery("SELECT DISTINCT c.id ,c.name from customer c inner JOIN order_master o on c.id=o.customer_id ").list();
        return custNameIdList;
    }
/*
    this method is for getting order nos for those advance is not made.....
    public List<Object> getOrderForAdvance(Integer id)
    {
        List<Object> custOrderIdList=sessionProvider.get().createSQLQuery("SELECT DISTINCT o.customer_order_no,o.customer_id from order_master o INNER JOIN advance a on o.id!=a.order_id where customer_id="+id).list();
         Iterator<Object> it=custOrderIdList.iterator();
         return custOrderIdList;
    }
*/


    public List<String> getOrderCustomerOrderNumber() {
         return (List<String>)sessionProvider.get().createQuery("SELECT o.customerOrderNo from Order o").list();
    }

    public List<String> getOrderCustomerNameLst() {
         return (List<String>)sessionProvider.get().createQuery("SELECT o.customer.name from Order o").list();
    }

    public Order findByOrderCustomerOrderNumber(String name) {
     return (Order)sessionProvider.get().createQuery("select o from Order o WHERE o.customerOrderNo='"+name+"'").uniqueResult();
    }

    public Order findByOrderCustomerName(String name) {
        return (Order) sessionProvider.get().createQuery("select o from Order o where o.customer.name='"+name+"'").uniqueResult();

    }

    public Order findByOrderProductName(String name) {
        return (Order)sessionProvider.get().createQuery("select o from Order o WHERE o.orderDetail.produce.productName='"+name+"'").uniqueResult();
    }

    public Order findByOrderDate(Date date) {
        return (Order)sessionProvider.get().createQuery("select o from Order o WHERE o.createDate='"+date+"'").uniqueResult();
    }


    public List<String> getOrderProductNameLst() {
        return sessionProvider.get().createQuery("select o.orderDetail.product.productName from Order o").list();
    }
    public boolean customerOrderNoAlreadyPresent(Integer customerOrderNo){
        return sessionProvider.get().createQuery("from Order o where o.customerOrderNo="+customerOrderNo).uniqueResult()==null ? false : true;
    }
    public Order findOrderByOrderNo(String customerOrderNo)
    {
        return (Order)sessionProvider.get().createQuery("from Order o where o.customerOrderNo="+customerOrderNo);
    }
    public Order findAOrderByOrderNo(String customerOrderNo)
    {
        return (Order)sessionProvider.get().createQuery("from Order o where o.customerOrderNo="+customerOrderNo).uniqueResult();
    }
   
     

}
