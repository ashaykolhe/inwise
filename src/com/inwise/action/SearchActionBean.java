package com.inwise.action;

import com.inwise.dao.OrderDao;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.InvoiceDao;
import com.inwise.pojo.Invoice;
import com.inwise.pojo.Order;
import com.inwise.pojo.Customer;

import javax.inject.Inject;

import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.ajax.JavaScriptResolution;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Created by IntelliJ IDEA.
 * User: Milind
 * Date: May 17, 2012
 * Time: 3:51:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class SearchActionBean extends BaseActionBean{
    @Inject
    CustomerDao customerDao;
    @Inject
    OrderDao orderDao;
    @Inject
    InvoiceDao invoiceDao;
    private List<Invoice> invoicelst;
    private List<Integer> Integerlst;
    private List<String> Stringlst;
    private List<Order> orderlst;
    private List<Customer> customerlst;
    private Customer customer;
    private Invoice invoice;
    private Order order;
    private String searchMenu,searchSubmenu,name,hdnvalue,ajaxSubmenu;

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAjaxSubmenu() {
        return ajaxSubmenu;
    }

    public void setAjaxSubmenu(String ajaxSubmenu) {
        this.ajaxSubmenu = ajaxSubmenu;
    }

    public List<Invoice> getInvoicelst() {
        return invoicelst;
    }

    public void setInvoicelst(List<Invoice> invoicelst) {
        this.invoicelst = invoicelst;
    }

    public List<Integer> getIntegerlst() {
        return Integerlst;
    }

    public void setIntegerlst(List<Integer> integerlst) {
        Integerlst = integerlst;
    }

    public List<String> getStringlst() {
        return Stringlst;
    }

    public void setStringlst(List<String> stringlst) {
        Stringlst = stringlst;
    }

    public List<Order> getOrderlst() {
        return orderlst;
    }

    public void setOrderlst(List<Order> orderlst) {
        this.orderlst = orderlst;
    }

    public List<Customer> getCustomerlst() {
        return customerlst;
    }

    public void setCustomerlst(List<Customer> customerlst) {
        this.customerlst = customerlst;
    }

    public String getHdnvalue() {
        return hdnvalue;
    }

    public void setHdnvalue(String hdnvalue) {
        this.hdnvalue = hdnvalue;
    }

    public String getSearchMenu() {
        return searchMenu;
    }

    public void setSearchMenu(String searchMenu) {
        this.searchMenu = searchMenu;
    }

    public String getSearchSubmenu() {
        return searchSubmenu;
    }

    public void setSearchSubmenu(String searchSubmenu) {
        this.searchSubmenu = searchSubmenu;
    }

    public Resolution searchLink()
    {
        return new ForwardResolution("jsp/search.jsp");
    }
    public Resolution search()
    {
        if(searchSubmenu.equalsIgnoreCase("custName"))
            customer=customerDao.findByCustomerName(getName());
        if(searchSubmenu.equalsIgnoreCase("custCode"))
            customer=customerDao.findByCustomerCode(getName());
        if(searchSubmenu.equalsIgnoreCase("inwiseNumber"))
            invoice=invoiceDao.findByInvoiceNumber(Integer.parseInt(getName()));
        if(searchSubmenu.equalsIgnoreCase("inwiseCustomerOrderNo"))
                invoice=invoiceDao.findByInvoiceNumber(Integer.parseInt(getName()));
        if(searchSubmenu.equalsIgnoreCase("inwiseProductName"))
                invoice=invoiceDao.findByInvoiceNumber(Integer.parseInt(getName()));

        System.out.println("cccccccc"+getCustomer());
        return new ForwardResolution("jsp/search.jsp");
    }

    public Resolution autoinwise()
    {
        if(ajaxSubmenu.equals("inwiseNumber"))
        {
            Integerlst=invoiceDao.getInvoiceNumberLst();
             Stringlst=new ArrayList<String>();
            for(Iterator<Integer> i=Integerlst.iterator();i.hasNext();){
                Stringlst.add(i.next().toString());
                }
        }
        if(ajaxSubmenu.equals("inwiseCustomerOrderNo"))
            Stringlst=invoiceDao.getInvoiceOrderNumberLst();
        if(ajaxSubmenu.equals("inwiseCustomerOrderNo"))
         Stringlst=invoiceDao.getInvoiceCustomerNameLst();
        if(ajaxSubmenu.equals("inwiseProductName"))
         Stringlst=invoiceDao.getInvoiceProductNameLst();

         return new JavaScriptResolution(Stringlst);
    }
    public Resolution autoorder()
    {
        if(ajaxSubmenu.equals("orderCustomerOrderNumber"))
        {
                 Stringlst=orderDao.getOrderCustomerOrderNumber();
        }
         if(ajaxSubmenu.equals("orderCustomerName"))
        {
                 Stringlst=orderDao.getOrderCustomerNameLst();
        }

        return new JavaScriptResolution(Stringlst);
    }
    public Resolution autocust()
    {
         if(ajaxSubmenu.equals("custName"))
        {
                 Stringlst=customerDao.getCustomerNameLst();
        }
         if(ajaxSubmenu.equals("custCode"))
        {
                 
                 Stringlst=customerDao.getCustomerCodeLst();
        }
        return new JavaScriptResolution(Stringlst);
    }

}
