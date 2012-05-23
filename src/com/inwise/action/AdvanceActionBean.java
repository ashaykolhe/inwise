package com.inwise.action;

import com.google.inject.Inject;
import com.inwise.dao.OrderDao;
import com.inwise.dao.CustomerDao;
import com.inwise.pojo.Order;
import com.inwise.pojo.Customer;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.ajax.JavaScriptResolution;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: May 23, 2012
 * Time: 10:46:02 AM
 * To change this template use File | Settings | File Templates.
 */
public class AdvanceActionBean extends BaseActionBean
{
    @Inject
        protected CustomerDao customerDao;
    @Inject
        protected OrderDao orderDao;
    
    private static final String ADVANCE="jsp/advance.jsp";

    private Integer id1;
    private String id2;
    List<Order> orderList;
    List<Order> orderNoList;
    List<Order> customerOrderList;
    private Customer cust;


    public String getId2() {
        return id2;
    }

    public void setId2(String id2) {
        this.id2 = id2;
    }

    public Integer getId1() {
        return id1;
    }

    public void setId1(Integer id1) {
        this.id1 = id1;
    }

    public Customer getCust() {
        return cust;
    }

    public void setCust(Customer cust) {
        this.cust = cust;
    }

    public List<Order> getCustomerOrderList() {
        return customerOrderList;
    }

    public void setCustomerOrderList(List<Order> customerOrderList) {
        this.customerOrderList = customerOrderList;
    }

    public List<Order> getOrderNoList() {
        return orderNoList;
    }

    public void setOrderNoList(List<Order> orderNoList) {
        this.orderNoList = orderNoList;
    }

    public List<Order> getOrderList() {
        return orderList;
    }

    public void setOrderList(List<Order> orderList) {
        this.orderList = orderList;
    }

    public Resolution advanceLink()
    {
        System.out.println("in advance lin resolution");
        orderList= orderDao.listAll();
      return new ForwardResolution(ADVANCE);
    }
     public Resolution getOrderNumbers()
    {
        orderList= orderDao.listAll();
        orderNoList=orderDao.getCustomerOrderNo(id1);
        cust=customerDao.find(id1);
        return new ForwardResolution(ADVANCE);
    }
    public Resolution getCustomerOrder()
    {
        System.out.println(id2);
        orderList= orderDao.listAll();
     //   Order o=orderDao.
       // cust=customerDao.find(id1);
        customerOrderList=orderDao.findOrderByOrderNo(id2);
      return new ForwardResolution(ADVANCE);
    }
}
