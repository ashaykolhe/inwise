package com.inwise.action;

import com.google.inject.Inject;
import com.inwise.dao.OrderDao;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.AdvanceDao;
import com.inwise.pojo.Order;
import com.inwise.pojo.Customer;
import com.inwise.pojo.OrderDetail;
import com.inwise.pojo.Advance;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.ajax.JavaScriptResolution;

import java.util.List;
import java.util.Iterator;
import java.util.HashMap;

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
    @Inject
        protected AdvanceDao advanceDao;

    private static final String ADVANCE="jsp/addAdvance.jsp";

    private String checkAdvanceMade;
    private Double total;
    private Advance advance;
    private Integer id1;
    private String id2;
    private Customer cust;
    private Order o;


    List<Object> custNameIdList;
    List<Order> orderNoList;
    List<OrderDetail> customerOrderList;


    public String getCheckAdvanceMade() {
        return checkAdvanceMade;
    }

    public void setCheckAdvanceMade(String checkAdvanceMade) {
        this.checkAdvanceMade = checkAdvanceMade;
    }

    public List<Object> getCustNameIdList() {
        return custNameIdList;
    }

    public void setCustNameIdList(List<Object> custNameIdList) {
        this.custNameIdList = custNameIdList;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Advance getAdvance() {
        return advance;
    }

    public void setAdvance(Advance advance) {
        this.advance = advance;
    }

    public Order getO() {
        return o;
    }

    public void setO(Order o) {
        this.o = o;
    }

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

    public List<OrderDetail> getCustomerOrderList() {
        return customerOrderList;
    }

    public void setCustomerOrderList(List<OrderDetail> customerOrderList) {
        this.customerOrderList = customerOrderList;
    }

    public List<Order> getOrderNoList() {
        return orderNoList;
    }

    public void setOrderNoList(List<Order> orderNoList) {
        this.orderNoList = orderNoList;
    }

      public Resolution advanceLink()
    {
        System.out.println("in advance lin resolution");
        custNameIdList=orderDao.getCustomerForAdvance();
       // orderDao.getOrderForAdvance(2);
/*
        Iterator<Object> it=custNameIdList.iterator();
        while(it.hasNext())
        {
            Object[] t=(Object[])it.next();
            System.out.println(t[0]+" "+t[1]);
        }
*/

        //orderList= orderDao.listAll();
      return new ForwardResolution(ADVANCE);
    }
     public Resolution getOrderNumbers()
    {
        custNameIdList=orderDao.getCustomerForAdvance();
       // System.out.println("iiiiiiiiiddddddddddd"+id1);
       orderNoList=orderDao.getCustomerOrderNo(id1);
        cust=customerDao.find(id1);
        return new ForwardResolution(ADVANCE);
    }
    public Resolution getCustomerOrder()
    {
        total=0.0;
        custNameIdList=orderDao.getCustomerForAdvance();
        o=orderDao.findAOrderByOrderNo(id2);
        setCust(o.getCustomer());
       // System.out.println("advance made or naot...."+advanceDao.advanceMadeOrNot(o.getId()));
        if(advanceDao.advanceMadeOrNot(o.getId()))
        {
           checkAdvanceMade="yes"; 
        }
        else
        {
                customerOrderList=o.getOrderDetail();
                Iterator<OrderDetail> itr=customerOrderList.iterator();
                while (itr.hasNext())
               {
                   OrderDetail temp=itr.next();
                   total=total+temp.getOrderedQuantity()*temp.getProduct().getProductCost();

               }
        }
         orderNoList=orderDao.getCustomerOrderNo(cust.getId());

        return new ForwardResolution(ADVANCE);
    }
    public Resolution addAdvance()
    {
        System.out.println(advance);
        advance.setAmountRemained(total-advance.getAmountReceived());
        advanceDao.save(advance);
        return new RedirectResolution(AdvanceActionBean.class,"advanceLink");
    }
}
