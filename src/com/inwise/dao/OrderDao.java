package com.inwise.dao;

import com.inwise.dao.BaseDao;
import com.inwise.pojo.Order;
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
        return (List<Order>)sessionProvider.get().createQuery("select o from Order o WHERE o.createDate LIKE '"+sdate+"%'").list();
    }
    public boolean customerOrderNoAlreadyPresent(String customerOrderNo){
        return sessionProvider.get().createQuery("from Order o where o.customerOrderNo='"+customerOrderNo+"'").uniqueResult()==null ? false : true;
    }

    public Integer latestOrderId(){
        return (Integer)sessionProvider.get().createQuery("select max(id) from Order").uniqueResult();
    }

}
