package com.inwise.action;
import com.inwise.dao.OrderDao;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.InvoiceDao;
import com.inwise.dao.AdvanceDao;
import com.inwise.pojo.Invoice;
import com.inwise.pojo.Order;
import com.inwise.pojo.Customer;
import com.inwise.pojo.Advance;
import com.inwise.utils.Converter;

import javax.inject.Inject;

import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.UrlBinding;
import net.sourceforge.stripes.action.StreamingResolution;
import net.sourceforge.stripes.ajax.JavaScriptResolution;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Date;
import java.io.FileInputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;

/**
 * Created by IntelliJ IDEA.
 * User: Milind
 * Date: May 17, 2012
 * Time: 3:51:47 PM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/search")
public class SearchActionBean extends BaseActionBean{
    @Inject
    CustomerDao customerDao;
    @Inject
    OrderDao orderDao;
    @Inject
    AdvanceDao advanceDao;
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
    private String searchMenu,searchSubmenu,name,content,ajaxSubmenu,hdnvalue,invoicenumber;
    private String date;
    private Advance advance;

    public Advance getAdvance() {
        return advance;
    }

    public void setAdvance(Advance advance) {
        this.advance = advance;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getInvoicenumber() {
        return invoicenumber;
    }

    public void setInvoicenumber(String invoicenumber) {
        this.invoicenumber = invoicenumber;
    }

    public String getHdnvalue() {
        return hdnvalue;
    }

    public void setHdnvalue(String hdnvalue) {
        this.hdnvalue = hdnvalue;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

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

//Customer
//"none","custName","custCode"
        if(searchSubmenu.equalsIgnoreCase("custName"))
            customer=customerDao.findByCustomerName(getName());
        if(searchSubmenu.equalsIgnoreCase("custCode"))
            customer=customerDao.findByCustomerCode(getName());
//Invoice
//"none","invoiceNumber","invoiceCustomerOrderNo","invoiceCustomerName","invoiceProductName","invoiceDate"
        if(searchSubmenu.equalsIgnoreCase("invoiceNumber"))
            invoice=invoiceDao.findByInvoiceNumber(Integer.parseInt(getName()));
        if(searchSubmenu.equalsIgnoreCase("invoiceCustomerOrderNo"))
            invoicelst=invoiceDao.findByInvoiceCustomerOrderNo(getName());
        if(searchSubmenu.equalsIgnoreCase("invoiceCustomerName"))
            invoicelst=invoiceDao.findByInvoiceCustomerName(getName());
        if(searchSubmenu.equalsIgnoreCase("invoiceDate"))
        {
            invoicelst=invoiceDao.findByInvoiceDate(getDate());
         //Order
        //"none","orderCustomerOrderNumber","orderCustomerName","orderProductName","orderDate"
        }
        if(searchSubmenu.equalsIgnoreCase("orderCustomerOrderNumber"))

        {
            order=orderDao.findByOrderCustomerOrderNumber(getName());
            invoicelst=orderDao.findInvoiceByCustomerOrderNumber(getName());
            System.out.println("oooooooooooooooooooooooooooooooooooooooooo"+order);
        }
        if(searchSubmenu.equalsIgnoreCase("orderCustomerName"))
        {
            System.out.println("name  :"+getName());
            orderlst=orderDao.findByOrderCustomerName(getName());
            invoicelst=orderDao.findInvoiceByCustomerName(getName());
            System.out.println("oooooooooooo"+getOrder());
        }
        if(searchSubmenu.equalsIgnoreCase("orderDate"))
              invoicelst=invoiceDao.findInvoiceByOrderDate(getDate());
            //orderlst=orderDao.findByOrderDate(getDate());
        return new ForwardResolution("jsp/search.jsp");
    }
    public Resolution autoinvoice()
    {
        if(ajaxSubmenu.equals("invoiceNumber"))
        {
            Integerlst=invoiceDao.getInvoiceNumberLst();
            Stringlst=new ArrayList<String>();
            for(Iterator<Integer> i=Integerlst.iterator();i.hasNext();){
                Stringlst.add(i.next().toString());
            }
        }
        if(ajaxSubmenu.equals("invoiceCustomerOrderNo"))
            Stringlst=invoiceDao.getInvoiceOrderNumberLst();
        if(ajaxSubmenu.equals("invoiceCustomerName"))
            Stringlst=invoiceDao.getInvoiceCustomerNameLst();

        System.out.println("invoice stringlst :"+Stringlst);
        return new JavaScriptResolution(Stringlst);
    }
    //"none","orderCustomerOrderNumber","orderCustomerName","orderProductName","orderDate"
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

        System.out.println("order prod name lst :"+Stringlst);
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
    public Resolution print()
    {
        //"none","orderCustomerOrderNumber","orderCustomerName","orderProductName","orderDate"
        System.out.println("search sub menu "+searchSubmenu);
        System.out.println("in print"+getName());
        if(searchSubmenu.equalsIgnoreCase("orderCustomerOrderNumber"))
        {
            hdnvalue="receiptOrderSlip";

            invoicelst=invoiceDao.findByInvoiceCustomerOrderNo(getName());
            order=orderDao.findByOrderCustomerOrderNumber(getName());
        }
        if(searchSubmenu.equalsIgnoreCase("orderCustomerName"))
        {
            hdnvalue="receiptOrderSlip";

            invoicelst=invoiceDao.findByInvoiceCustomerName(getName());//InvoiceCustomerOrderNo(getName());
            order=orderDao.findByOrderCustomerOrderNumber(getName());
        }
        if(searchSubmenu.equalsIgnoreCase("orderDate"))
        {
            hdnvalue="receiptOrderSlip";
            date=invoiceDao.findByInvoiceNumber(id).getCreateDate().toString();
            invoicelst=invoiceDao.findInvoiceByOrderDate(date);
            date=date.replace("-","/");
            date=date.substring(0,10);
            order=orderDao.findByOrderCustomerOrderNumber(getName());
        }
        if(searchSubmenu.equalsIgnoreCase("invoiceCustomerName"))
        {
            System.out.println("ddd"+getName());
            hdnvalue="receiptOrderSlip";
            
            invoicelst=invoiceDao.findByInvoiceCustomerName(getName());
            
        }
        if(searchSubmenu.equalsIgnoreCase("invoiceCustomerOrderNo"))
        {
            
            hdnvalue="receiptOrderSlip";
            System.out.println("dfgf");
            invoicelst=invoiceDao.findByInvoiceCustomerOrderNo(getName());
            System.out.println("iii"+invoicelst);

        }
         if(searchSubmenu.equalsIgnoreCase("invoiceDate"))
        {
            System.out.println("in date");
            hdnvalue="receiptOrderSlip";

             date=invoiceDao.findByInvoiceNumber(id).getCreateDate().toString();

            System.out.println(date);
            invoicelst=invoiceDao.findByInvoiceDate(date);
           

           date=date.replace("-","/");
            date=date.substring(0,10);
            System.out.println(date+"ddddddddddddddaaaaaaaaaaaaaateeeeeeeeeee");
        }
        if(searchSubmenu.equalsIgnoreCase("invoiceNumber"))
        {
          
            hdnvalue="receiptOrderSlip";

            invoice=invoiceDao.findByInvoiceNumber(id);
            
        }
        return new ForwardResolution("jsp/search.jsp");
    }
    public Resolution printpdf()
    {
         invoice=invoiceDao.findByInvoiceNumber(Integer.parseInt(invoicenumber));
         advance=advanceDao.getAdvancedByOrderId(invoice.getOrder().getId());
       String path=invoiceDao.createPdf(invoice,advance);
        System.out.println("ppppppaaaaaaaattttttttthhhhhhhh"+path);

        
        FileInputStream sis=null;
        try{
           
            sis=new FileInputStream(path);
        }catch(Exception e){
            System.out.println("achtung "+e.getMessage());
        }


        return new StreamingResolution("application/pdf",sis);

    }
    public Resolution redirectorderpopup()
    {
        invoice=invoiceDao.findByInvoiceNumber(getId());
        advance=advanceDao.getAdvancedByOrderId(invoice.getOrder().getId());
        return new ForwardResolution("/jsp/receipt/viewOrderSlip.jsp");
    }

}
