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
import java.util.Date;

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
    private static final String DELETEORDER="jsp/deleteOrder.jsp";
     private static final String VIEWORDER="jsp/viewOrder.jsp";
    @Inject
    OrderDao orderDao;

    @Inject
    CustomerDao customerDao;

    @Inject
    ProductDao productDao;
     private Proposal proposal;
    private Order order;
    private String customerOrderNumber;
    private List<Customer> customerList=new ArrayList<Customer>();
    private List<Product> productList=new ArrayList<Product>();
    private List<Address> addressList=new ArrayList<Address>();
    private List<Order> orderlst;
    private int invoiceToAddressId;
    private int shipmentToAddressId;
    private Integer invoicenum;
       private String hiddenvalue;

    public Proposal getProposal() {
        return proposal;
    }

    public void setProposal(Proposal proposal) {
        this.proposal = proposal;
    }

    public String getHiddenvalue() {
        return hiddenvalue;
    }

    public void setHiddenvalue(String hiddenvalue) {
        this.hiddenvalue = hiddenvalue;
    }

    public Integer getInvoicenum() {
        return invoicenum;
    }

    public void setInvoicenum(Integer invoicenum) {
        this.invoicenum = invoicenum;
    }

    public int getInvoiceToAddressId() {
        return invoiceToAddressId;
    }

    public void setInvoiceToAddressId(int invoiceToAddressId) {
        this.invoiceToAddressId = invoiceToAddressId;
    }

    public int getShipmentToAddressId() {
        return shipmentToAddressId;
    }

    public void setShipmentToAddressId(int shipmentToAddressId) {
        this.shipmentToAddressId = shipmentToAddressId;
    }

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

    public String getCustomerOrderNumber() {
        return customerOrderNumber;
    }

    public void setCustomerOrderNumber(String customerOrderNumber) {
        this.customerOrderNumber = customerOrderNumber;
    }

    @DefaultHandler
    public Resolution pre(){
        customerList=customerDao.listAll();
        productList=productDao.listAll();
        return new ForwardResolution(ADDORDER);
    }

    public Resolution updateOrderLink(){
        
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
        orderlst=orderDao.getCustomerOrderNo(order.getCustomer().getId());
        System.out.println("oooooooooooo"+order);
      
        return updateOrderLink();
    }

    public Resolution updateOrder() {
        order.setAmendmentDate(new Date());

        System.out.println(order);
        Order temp = order;
        OrderDetail od = null;
        for (Iterator<OrderDetail> ite = temp.getOrderDetail().iterator(); ite.hasNext();) {
            od=ite.next();
            if(od.getAmendmentQuantity()==null){
                              od.setRemainingQuantity(0.0);
            }
             else      od.setRemainingQuantity(od.getAmendmentQuantity());
            if (od.getAmendmentCost() == null)
                od.setAmendmentCost(od.getProduct().getProductCost());
            else
                od.setAmendmentCost((od.getProduct().getProductCost()) + od.getAmendmentCost());


        }

          order.setOrderDetail(temp.getOrderDetail());
       //order.getOrderDetail().add((OrderDetail) temp.getOrderDetail());
        orderDao.save(order);
        //  order =orderDao.find(order.getId());
        /* order.setAmendmentDate(new Date());
         System.out.println("------------------------------------------"+order.getId());
         System.out.println(order);
         Order temp=order;
         System.out.println("tempppppppppp"+temp);
         for(Iterator<OrderDetail> ite=temp.getOrderDetail().iterator();ite.hasNext();){
             OrderDetail od=ite.next();
             System.out.println("proct"+od.getProduct());
             if( od.getAmendmentCost()==null)
                 od.setAmendmentCost(od.getProduct().getProductCost());
             else
                 od.setAmendmentCost((od.getProduct().getProductCost())+od.getAmendmentCost());
             System.out.println(order.getOrderDetail());
             order.getOrderDetail().clear();
             System.out.println(od);
             order.getOrderDetail().add(od);
         }
         orderDao.save(order);
        */
        return new RedirectResolution(OrderActionBean.class, "viewOrderLink");
    }

    public Resolution addressAjax(){
        return new JavaScriptResolution(customerDao.find(id).getAddressList());
    }
    
    public Resolution InvoiceToAddressAjax(){
        return new JavaScriptResolution(orderDao.find(invoiceToAddressId).getOrderAddress().get(0).getAddress());
    }

    public Resolution ShipmentToAddressAjax(){
        return new JavaScriptResolution(orderDao.find(shipmentToAddressId).getOrderAddress().get(1).getAddress());
    }


    public Resolution productDetailsAjax(){
        return new JavaScriptResolution(productDao.find(id));
    }

    public Resolution getCustomerOrderNo(){
        orderlst=orderDao.getCustomerOrderNo(id);

        return new JavaScriptResolution(orderlst);
    }
/*public Resolution getInvoiceNumber(){

        invoicenum=orderDao.getInvoiceNumber();
        return new JavaScriptResolution(invoicenum);
    }*/

    public Resolution customerOrderNoAlreadyPresent()
    {
        return new JavaScriptResolution(orderDao.customerOrderNoAlreadyPresent(customerOrderNumber));
    }

    public Resolution deleteOrderLink(){
        orderlst=orderDao.getOrderList();
        return new ForwardResolution(DELETEORDER);
    }

        //delete user
    public Resolution delete(){
        orderDao.remove(id);
        return new RedirectResolution(OrderActionBean.class,"deleteOrderLink");
    }

    public Resolution checkOrderDispatched(){

                if(orderDao.checkInvoiceForThisOrderDispatched(id)){
       return new RedirectResolution(OrderActionBean.class,"getOrders").addParameter("id",id);     
        } else{

                       hiddenvalue="alert";
                      orderlst=orderDao.getOrderList();
                     return new ForwardResolution(VIEWORDER);
                }



    }
    public Resolution checkInvoiceForThisOrderDispatched(){
        return new JavaScriptResolution(orderDao.checkInvoiceForThisOrderDispatched(id));
    }
     public Resolution viewOrderLink(){
        orderlst=orderDao.getOrderList();
        return new ForwardResolution(VIEWORDER);
    }

}
