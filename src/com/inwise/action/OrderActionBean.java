package com.inwise.action;

import com.inwise.pojo.*;
import com.inwise.dao.OrderDao;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.ProductDao;
import com.google.inject.Inject;
import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 17, 2012
 * Time: 10:24:12 AM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/order")
public class OrderActionBean extends BaseActionBean{

    private static final String ADDORDER="jsp/addOrder.jsp";
    private static final String UPDATEORDER="jsp/updateOrder.jsp";
    @Inject
    OrderDao orderDao;

    @Inject
    CustomerDao customerDao;

    @Inject
    ProductDao productDao;

    private Order order;
    private List<Customer> customerList=new ArrayList<Customer>();
    private List<Product> productList=new ArrayList<Product>();
    private List<Address> addressList=new ArrayList<Address>();
    private List<Order> orderlst;

    public List<Order> getOrderlst() {
        return orderlst;
    }

    public void setOrderlst(List<Order> orderlst) {
        this.orderlst = orderlst;
    }

    public List<Customer> getCustomerList() {
        return customerList;
    }

    public void setCustomerList(List<Customer> customerList) {
        this.customerList = customerList;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    public List<Address> getAddressList() {
        return addressList;
    }

    public void setAddressList(List<Address> addressList) {
        this.addressList = addressList;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    @DefaultHandler
    public Resolution pre(){
        customerList=customerDao.listAll();
        productList=productDao.listAll();
        return new ForwardResolution(ADDORDER);
    }

    public Resolution updateOrderLink(){
        orderlst=orderDao.listAll();
        customerList=customerDao.listAll();
        productList=productDao.listAll();
        return new ForwardResolution(UPDATEORDER);
    }

    public Resolution addOrder(){
        orderDao.save(order);
        
        return new RedirectResolution(AdvanceActionBean.class,"redirectAdvance");
    }

    public Resolution getOrders(){
        order=orderDao.find(id);
        addressList=order.getCustomer().getAddressList();
        return updateOrderLink();
    }

    public Resolution updateOrder(){
        System.out.println("----------------------------------order------------------------------------");
        System.out.println(order);
        System.out.println("----------------------------------order------------------------------------");
        orderDao.save(order);
        return new RedirectResolution(OrderActionBean.class,"updateOrderLink");
    }

    public Resolution addressAjax(){
        return new JavaScriptResolution(customerDao.find(id).getAddressList());
    }

    public Resolution productDetailsAjax(){
        return new JavaScriptResolution(productDao.find(id));
    }

    public Resolution getCustomerOrderNo(){
        orderlst=orderDao.getCustomerOrderNo(id);
        return new JavaScriptResolution(orderlst);
    }

    public Resolution customerOrderNoAlreadyPresent()
    {
        return new JavaScriptResolution(orderDao.customerOrderNoAlreadyPresent(id));
    }


}
