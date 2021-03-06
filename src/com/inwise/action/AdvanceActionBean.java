package com.inwise.action;

import com.inwise.pojo.Order;

import net.sourceforge.stripes.action.*;
import com.inwise.pojo.*;
import com.inwise.dao.*;
import com.google.inject.Inject;
import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.ByteArrayInputStream;


/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 22, 2012
 * Time: 12:09:47 PM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/advance")
public class AdvanceActionBean extends BaseActionBean
{
    private static final String ADVANCE="jsp/advance.jsp";
    private static final String ADDADVANCE="jsp/addAdvance.jsp";
     private static final String PROFORMAINVOICE="jsp/proformaInvoice.jsp";
    private static final String ADVANCERECEIPT="jsp/receipt/advanceReceipt.jsp";
    @Inject
    AdvanceDao advanceDao;
     @Inject
    ProformaInvoiceDao proformaDao;
    @Inject
    PaymentModeDao paymentModeDao;

    @Inject
    CustomerDao customerDao ;

    @Inject
    OrderDao orderDao;
     private ProformaInvoice proforma;
    private Advance advance;
    private boolean popup;
    private List<PaymentMode> paymentModeList=new ArrayList<PaymentMode>();
     String alert;
    private String checkAdvanceMade;
    private Double total;
    private Integer id1;
    private String id2;
    private Customer cust;
    private Order o;
    @Inject
    CompanyDao companyDao;

    private CompanyInfo companyInfo;

    List<Object> custNameIdList;
    List<Order> orderNoList;
    List<OrderDetail> customerOrderList;

    public ProformaInvoice getProforma() {
        return proforma;
    }

    public void setProforma(ProformaInvoice proforma) {
        this.proforma = proforma;
    }

    public AdvanceDao getAdvanceDao() {
        return advanceDao;
    }

    public void setAdvanceDao(AdvanceDao advanceDao) {
        this.advanceDao = advanceDao;
    }

    public PaymentModeDao getPaymentModeDao() {
        return paymentModeDao;
    }

    public void setPaymentModeDao(PaymentModeDao paymentModeDao) {
        this.paymentModeDao = paymentModeDao;
    }

    public CustomerDao getCustomerDao() {
        return customerDao;
    }

    public void setCustomerDao(CustomerDao customerDao) {
        this.customerDao = customerDao;
    }

    public OrderDao getOrderDao() {
        return orderDao;
    }

    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }

    public Advance getAdvance() {
        return advance;
    }

    public void setAdvance(Advance advance) {
        this.advance = advance;
    }

    public List<PaymentMode> getPaymentModeList() {
        return paymentModeList;
    }

    public void setPaymentModeList(List<PaymentMode> paymentModeList) {
        this.paymentModeList = paymentModeList;
    }

    public String getCheckAdvanceMade() {
        return checkAdvanceMade;
    }

    public void setCheckAdvanceMade(String checkAdvanceMade) {
        this.checkAdvanceMade = checkAdvanceMade;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Integer getId1() {
        return id1;
    }

    public void setId1(Integer id1) {
        this.id1 = id1;
    }

    public String getId2() {
        return id2;
    }

    public void setId2(String id2) {
        this.id2 = id2;
    }

    public Customer getCust() {
        return cust;
    }

    public void setCust(Customer cust) {
        this.cust = cust;
    }

    public Order getO() {
        return o;
    }

    public void setO(Order o) {
        this.o = o;
    }

    public List<Object> getCustNameIdList() {
        return custNameIdList;
    }

    public void setCustNameIdList(List<Object> custNameIdList) {
        this.custNameIdList = custNameIdList;
    }

    public List<Order> getOrderNoList() {
        return orderNoList;
    }

    public void setOrderNoList(List<Order> orderNoList) {
        this.orderNoList = orderNoList;
    }

    public List<OrderDetail> getCustomerOrderList() {
        return customerOrderList;
    }

    public void setCustomerOrderList(List<OrderDetail> customerOrderList) {
        this.customerOrderList = customerOrderList;
    }

    public CompanyInfo getCompanyInfo() {
        return companyInfo;
    }

    public void setCompanyInfo(CompanyInfo companyInfo) {
        this.companyInfo = companyInfo;
    }

    public String getAlert() {
        return alert;
    }

    public void setAlert(String alert) {
        this.alert = alert;
    }

    public Resolution advanceLink()
    {
        System.out.println("in advance link resolution");
         paymentModeList=paymentModeDao.listAll();
        System.out.println(paymentModeList);
        custNameIdList=orderDao.getCustomerForAdvance();
        System.out.println(custNameIdList);
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
      return new ForwardResolution(ADDADVANCE);
    }
    public Resolution getOrderNumbers()
    {


        custNameIdList=orderDao.getCustomerForAdvance();
        paymentModeList=paymentModeDao.listAll();
       System.out.println("iiiiiiiiiddddddddddd"+id1);
       orderNoList=orderDao.getCustomerOrderNo(id1);
        cust=customerDao.find(id1);

        return new ForwardResolution(ADDADVANCE);
    }
    public Resolution getCustomerOrder()
    {
        System.out.println("in get cust order order no resolution");
        total=0.0;
        custNameIdList=orderDao.getCustomerForAdvance();
        paymentModeList=paymentModeDao.listAll();
        o=orderDao.findAOrderByOrderNo(id2,id1);
        System.out.println(o);
        System.out.println(id2);
        setCust(o.getCustomer());
       // System.out.println("advance made or naot...."+advanceDao.advanceMadeOrNot(o.getId()));

        if(advanceDao.advanceMadeOrNot(o.getId()))
        {
           checkAdvanceMade="yes";
            getContext().getMessages().add(new SimpleMessage("Advance is already made"));
        }
        else
        {
                customerOrderList=o.getOrderDetail();
                Iterator<OrderDetail> itr=customerOrderList.iterator();
                while (itr.hasNext())
               {
                   OrderDetail temp=itr.next();
                   total=total+temp.getOrderedQuantity()*temp.getCost();

               }
        }
         orderNoList=orderDao.getCustomerOrderNo(cust.getId());

        return new ForwardResolution(ADDADVANCE);
    }
    public Resolution addAdvance()
    {
       /* System.out.println("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"+advance.getId()+advance.getAmountReceived()+advance.getPaymentMode());*/
        advance.setAmountRemained(advance.getAmountReceived());
        
        advanceDao.save(advance);
        System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
        popup=true;
        return new RedirectResolution(AdvanceActionBean.class,"advanceLink").addParameter("popup",popup);
    }

    public boolean isPopup() {
        return popup;
    }

    public void setPopup(boolean popup) {
        this.popup = popup;
    }

    @DefaultHandler
    public Resolution pre(){
        
        return new ForwardResolution(ADDADVANCE);
    }

    public Resolution redirectAdvance(){
        paymentModeList=paymentModeDao.listAll();
        id=orderDao.latestOrderId();
        return new ForwardResolution(ADVANCE);
    }

    public Resolution saveAdvance(){
        advance.setAmountRemained(advance.getAmountReceived());
        advanceDao.save(advance);
        popup=true;
        return new RedirectResolution(AdvanceActionBean.class,"redirectAdvance").addParameter("popup",popup);
    }

    public Resolution advancePopup()
   {
       System.out.println("advance popup resoltuin");
       advance = advanceDao.latestAdvanceReceipt();
       System.out.println(advance);
        companyInfo=companyDao.findByLastUpdate();

        if(companyInfo!=null){
            FileOutputStream fos =null;
            try{
                byte[] imageBytes=companyInfo.getCompLogo();
                InputStream is = new ByteArrayInputStream(imageBytes);
                String filename="companyLogo.jpg";
                fos = new FileOutputStream("C:\\" + filename);
                int b = 0;
                while ((b = is.read()) != -1)
                {
                    fos.write(b);
                }
                fos.flush();
                    fos.close();
            }catch(Exception e){
                e.printStackTrace();
            }
        }
       return new ForwardResolution(ADVANCERECEIPT);
   }

    public Resolution advancePopupViaReceiptNo()
   {
       System.out.println("advance popup resoltuin");
       advance = advanceDao.find(id);
       System.out.println(advance);
        companyInfo=companyDao.findByLastUpdate();

        if(companyInfo!=null){
            FileOutputStream fos =null;
            try{
                byte[] imageBytes=companyInfo.getCompLogo();
                InputStream is = new ByteArrayInputStream(imageBytes);
                String filename="companyLogo.jpg";
                fos = new FileOutputStream("C:\\" + filename);
                int b = 0;
                while ((b = is.read()) != -1)
                {
                    fos.write(b);
                }
                fos.flush();
                    fos.close();
            }catch(Exception e){
                e.printStackTrace();
            }
        }
       return new ForwardResolution(ADVANCERECEIPT);
   }

    public Resolution cancel(){
        return new RedirectResolution(OrderActionBean.class);
    }
    /* public Resolution proformaLink(){
          paymentModeList=paymentModeDao.listAll();
        System.out.println(paymentModeList);
        custNameIdList=orderDao.getCustomerForAdvance();
          customerList=customerDao.listAll();
        productList=productDao.listAll();
        return new ForwardResolution(PROFORMAINVOICE);
    }
     public Resolution getOrderNumbersForProforma()
    {
        custNameIdList=orderDao.getCustomerForAdvance();
        paymentModeList=paymentModeDao.listAll();
       System.out.println("iiiiiiiiiddddddddddd"+id1);
       orderNoList=orderDao.getCustomerOrderNo(id1);
        cust=customerDao.find(id1);

        return new ForwardResolution(PROFORMAINVOICE);
    }
    public Resolution getCustomerOrderForProforma()
    {

        total=0.0;
        custNameIdList=orderDao.getCustomerForAdvance();
        paymentModeList=paymentModeDao.listAll();
        o=orderDao.findAOrderByOrderNo(id2,id1);

        setCust(o.getCustomer());


        if(advanceDao.advanceMadeOrNot(o.getId()))
        {
           checkAdvanceMade="yes";
            getContext().getMessages().add(new SimpleMessage("Advance is already made"));
        }
        else
        {
                customerOrderList=o.getOrderDetail();
                Iterator<OrderDetail> itr=customerOrderList.iterator();
                while (itr.hasNext())
               {
                   OrderDetail temp=itr.next();
                   total=total+temp.getOrderedQuantity()*temp.getCost();

               }
        }
         orderNoList=orderDao.getCustomerOrderNo(cust.getId());

        return new ForwardResolution(PROFORMAINVOICE);
    }

 public Resolution addProforma(){

     System.out.println("proforma");
      cust=customerDao.find(id1);
     custNameIdList=orderDao.getCustomerForAdvance();
      o=orderDao.findAOrderByOrderNo(id2,id1);
     proforma.setCustomer(o.getCustomer());
   proforma.setOrder(o);
  alert="Yes";
      System.out.println("proforma"+getProforma());
        return new RedirectResolution(AdvanceActionBean.class,"proformaLink").addParameter("Yes",alert);
 }*/
}
