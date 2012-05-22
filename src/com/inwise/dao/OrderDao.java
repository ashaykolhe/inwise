package com.inwise.dao;

import com.inwise.dao.BaseDao;
import com.inwise.pojo.Order;
import java.util.List;
import java.util.Date;

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

}
