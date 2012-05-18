package com.inwise.dao;

import com.inwise.dao.BaseDao;
import com.inwise.pojo.Order;

import java.util.List;

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
}
