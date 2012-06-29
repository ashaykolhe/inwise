package com.inwise.action;

import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;
import com.google.inject.Inject;
import com.inwise.dao.InvoiceDao;
import com.inwise.dao.ProductDao;
import com.inwise.dao.CustomerDao;
import com.inwise.pojo.Invoice;
import com.inwise.pojo.Product;
import com.inwise.pojo.Customer;

import java.util.List;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: May 31, 2012
 * Time: 4:18:07 PM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/report")
@HttpCache(allow = false)
public class ReportActionBean extends BaseActionBean{

     @Inject
     InvoiceDao invoiceDao;
       @Inject
       ProductDao productDao;
      @Inject
      CustomerDao customerDao;
     private static final String ADDREPORT="jsp/report.jsp";
    private String daily;
    private int monthly;
    private String radio;
    private List<Invoice> invoicelst;
    private String sdate;
    private int year;
     private int y;
    private String stock;
     private String to;
     private String from;
     private List<Product> productnamelst;
     private List<Customer> customernamelst;
    private Product product;
    private Customer customer;
    private String prodorcust;
    private String productget;
    private String customerget;
    private List lst;
    private String test;
    private int i,j;

    public int getI() {
        return i;
    }

    public void setI(int i) {
        this.i = i;
    }

    public int getJ() {
        return j;
    }

    public void setJ(int j) {
        this.j = j;
    }

    public String getTest() {
        return test;
    }

    public void setTest(String test) {
        this.test = test;
    }

    public List getLst() {
        return lst;
    }

    public void setLst(List lst) {
        this.lst = lst;
    }

    public String getCustomerget() {
        return customerget;
    }

    public void setCustomerget(String customerget) {
        this.customerget = customerget;
    }

    public String getProductget() {
        return productget;
    }

    public void setProductget(String productget) {
        this.productget = productget;
    }

    public String getProdorcust() {
        return prodorcust;
    }

    public void setProdorcust(String prodorcust) {
        this.prodorcust = prodorcust;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public List<Customer> getCustomernamelst() {
        return customernamelst;
    }

    public void setCustomernamelst(List<Customer> customernamelst) {
        this.customernamelst = customernamelst;
    }

    public List<Product> getProductnamelst() {
        return productnamelst;
    }

    public void setProductnamelst(List<Product> productnamelst) {
        this.productnamelst = productnamelst;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public int getY() {
        return y;
    }

    public void setY(int y) {
        this.y = y;
    }

    public int getMonthly() {
        return monthly;
    }

    public void setMonthly(int monthly) {
        this.monthly = monthly;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getSdate() {
        return sdate;
    }

    public void setSdate(String sdate) {
        this.sdate = sdate;
    }

    public List<Invoice> getInvoicelst() {
        return invoicelst;
    }

    public void setInvoicelst(List<Invoice> invoicelst) {
        this.invoicelst = invoicelst;
    }

    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }

    public String getRadio() {
        return radio;
    }

    public void setRadio(String radio) {
        this.radio = radio;
    }

    public String getDaily() {
        return daily;
    }

    public void setDaily(String daily) {
        this.daily = daily;
    }


    @DefaultHandler
    public Resolution addreportlink()
    {
       return new ForwardResolution(ADDREPORT);
    }

    public Resolution bytoday()
    {
        System.out.println("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
        if(stock.equalsIgnoreCase("byInvoice"))
        {
            System.out.println("fasgfdghasfd"+stock);
        invoicelst=invoiceDao.findByInvoiceTodayDate();
      //  System.out.println("aaaaaaaaaaaaaaaaaaaaaaffffffffffffffffff"+invoicelst);
        radio="bydaily";
        stock="byInvoice";
       daily="byToday";
        test="a";
        }
        else
        {
        invoicelst=invoiceDao.findByInvoiceTodayDate();
       System.out.println("aaaaaaaaaaaaaaaaaaaaaaffffffffffffffffff"+invoicelst);
        radio="bydaily";
        stock="byTax";
        daily="byToday";
        test="b";
        } 
      return new ForwardResolution(ADDREPORT);
    }
    public Resolution bySelectDate()
    {
        if(stock.equalsIgnoreCase("byInvoice"))
        {
      invoicelst=invoiceDao.findByInvoiceDate(sdate);  
       // System.out.println("aaaaaaaaaaaaaaaaaaaaaaffffffffffffffffffselectdate"+invoicelst);
         radio="bydaily";
        stock="byInvoice";
        daily="bySelectDate";
        test="a";
        }
          if(stock.equalsIgnoreCase("byTax"))
        {
      invoicelst=invoiceDao.findByInvoiceDate(sdate);
       // System.out.println("aaaaaaaaaaaaaaaaaaaaaaffffffffffffffffffselectdate"+invoicelst);
         radio="bydaily";
        stock="byTax";
        daily="bySelectDate";
        test="b";
        }
       return new ForwardResolution(ADDREPORT);
    }
    public Resolution getmonth()
    {

        if(stock.equalsIgnoreCase("byInvoice")){
          if (prodorcust.equalsIgnoreCase("bycust"))
        invoicelst=invoiceDao.getInvoiceMonth(monthly,year,getCustomerget());
       // System.out.println("invoicelst "+invoicelst);
         if (prodorcust.equalsIgnoreCase("byprod"))
         lst=invoiceDao.getInvoiceprodbymonth(getProductget(),monthly,year);
         radio="bymonthly";
        stock="byInvoice";
        test="a";
        }
         if(stock.equalsIgnoreCase("byTax")){
          if (prodorcust.equalsIgnoreCase("bycust"))
        invoicelst=invoiceDao.getInvoiceMonth(monthly,year,getCustomerget());
       // System.out.println("invoicelst "+invoicelst);
          if (prodorcust.equalsIgnoreCase("byprod"))
         lst=invoiceDao.getInvoiceprodbymonth(getProductget(),monthly,year);
         radio="bymonthly";
        stock="byTax";
        test="b";
        }
        if(prodorcust.equalsIgnoreCase("alltax"))
        {
            invoicelst=invoiceDao.getInvoiceMonthalltax(monthly,year);
         test="c";
        radio="bymonthly";
        stock="byTax";
        }
       return new ForwardResolution(ADDREPORT);
    }
    public Resolution byYear()
    {

        if(stock.equalsIgnoreCase("byInvoice")){
        if (prodorcust.equalsIgnoreCase("bycust"))
        invoicelst=invoiceDao.getInvoiceYear(y,getCustomerget());
       if (prodorcust.equalsIgnoreCase("byprod"))
        {
       System.out.println("invoicelsthiiiiiiiiiiiiii"+prodorcust);
        lst=invoiceDao.getInvoiceprodbyyear(getProductget(),y);
            System.out.println("fsyuasfyu"+lst);
        }
          radio="byyearly";
        stock="byInvoice";
        test="a";
        }
         if(stock.equalsIgnoreCase("byTax")){
        if (prodorcust.equalsIgnoreCase("bycust"))
        invoicelst=invoiceDao.getInvoiceYear(y,getCustomerget());
       if (prodorcust.equalsIgnoreCase("byprod"))
        {
       System.out.println("invoicelsthiiiiiiiiiiiiii"+prodorcust);
        lst=invoiceDao.getInvoiceprodbyyear(getProductget(),y);
            System.out.println("fsyuasfyu"+lst);
        }
          radio="byyearly";
        stock="byTax";
        test="b";
        }
        if(prodorcust.equalsIgnoreCase("alltax"))
        {
            invoicelst=invoiceDao.getInvoiceYearalltax(y);
        test="c";
        radio="byyearly";
        stock="byTax";
        }
        return new ForwardResolution(ADDREPORT);
    }
      public Resolution getfromto()
    {

           from=getFrom().replace("/","-");
        to=getTo().replace("/","-");
        try{
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date fdate = (Date)formatter.parse(from);
            Date tdate = (Date)formatter.parse(to);
            from = formatter.format(fdate);
            to = formatter.format(tdate);

            }
        catch (ParseException e)
            {
                System.out.println("Exception :"+e);
            }
        // System.out.println(prodorcust+"pppppprrrrooooodddduuuucttttttllllllssssssssstttttinvoicelst"+getCustomerget());
        System.out.println("frommmmmmtoooooo"+to);
        if(stock.equalsIgnoreCase("byInvoice"))
        {
       if (prodorcust.equalsIgnoreCase("bycust"))
        invoicelst=invoiceDao.getByFromToCust(from,to,getCustomerget());
        // System.out.println("pppppprrrrooooodddduuuucttttttllllllssssssssstttttinvoicelst"+invoicelst);
        if(prodorcust.equalsIgnoreCase("byprod"))
        lst=invoiceDao.getInvoiceprodbyfromto(from,to,getProductget());
        radio="byfromto";
        stock="byInvoice";
        test="a";
        }
        if(stock.equalsIgnoreCase("byTax"))
        {
       if (prodorcust.equalsIgnoreCase("bycust"))
        invoicelst=invoiceDao.getByFromToCust(from,to,getCustomerget());
        // System.out.println("pppppprrrrooooodddduuuucttttttllllllssssssssstttttinvoicelst"+invoicelst);
        if(prodorcust.equalsIgnoreCase("byprod"))
        lst=invoiceDao.getInvoiceprodbyfromto(from,to,getProductget());
        radio="byfromto";
        stock="byTax";
        test="b";
        }
        if(prodorcust.equalsIgnoreCase("alltax"))
        {
            invoicelst=invoiceDao.getByFromToalltax(from,to);
        test="c";
        radio="byfromto";
        stock="byTax";}
        return new ForwardResolution(ADDREPORT);
    }
      public Resolution autoprod()
    {
        //System.out.print("in autoitem");

        productnamelst=productDao.listallprodname();

       // System.out.println("pppppprrrrooooodddduuuucttttttllllllsssssssssttttt"+productnamelst);
        return new JavaScriptResolution(productnamelst);
    }
    public Resolution autocust()
    {
    customernamelst=customerDao.listallcustomername();
     //System.out.println("cccuusssssssttttoooooommmmmmeeeeeerrrrrrr"+customernamelst);
        return new JavaScriptResolution(customernamelst);    
    }
    public Resolution foralltax()

    {
        if(radio.equalsIgnoreCase("byyearly"))
        {
        invoicelst=invoiceDao.listAll();
        test="c";
        radio="byyearly";
        stock="byTax";
        }
          if(radio.equalsIgnoreCase("bymonthly"))
        {
        invoicelst=invoiceDao.listAll();
        test="c";
        radio="bymonthly";
        stock="byTax";
        }
      return new ForwardResolution(ADDREPORT);
    }
}
