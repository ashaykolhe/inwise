package com.inwise.action;

import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;
import com.google.inject.Inject;
import com.inwise.dao.*;
import com.inwise.pojo.*;

import java.util.*;
import java.io.FileInputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: May 16, 2012
 * Time: 10:12:38 AM
 * To change this template use File | Settings | File Templates.
 */

@UrlBinding("/invoice")
public class InvoiceActionBean extends BaseActionBean{
    @Inject
    TaxDao taxDao;
    @Inject
    CustomerDao customerDao;
    @Inject
    InvoiceDao  invoiceDao;
    @Inject
    AdvanceDao advanceDao;
    @Inject
    InvoiceNumberDao invoiceNumberDao;



    @Inject
    protected OrderDao orderDao;
    private String today;
    private List<Invoice> invoicelst;
    private List<Customer> customerlst;
    private List<Tax> taxlst;
    private List<Order> orderlst;
    private List<ProductCategory> productcategory;
    private Order order;
    private Invoice invoice;
    private Advance advance;
    private String incname,customerOrderNo;
    private int in,ad,orid,inid;
    private String hiddenvalue;
    Long invoicenum;

    public String getToday() {
        return today;
    }

    public void setToday(String today) {
        this.today = today;
    }

    public Long getInvoicenum() {
        return invoicenum;
    }

    public void setInvoicenum(Long invoicenum) {
        this.invoicenum = invoicenum;
    }

    public List<ProductCategory> getProductcategory() {
        return productcategory;
    }

    public void setProductcategory(List<ProductCategory> productcategory) {
        this.productcategory = productcategory;
    }

    public String getHiddenvalue() {
        return hiddenvalue;
    }

    public void setHiddenvalue(String hiddenvalue) {
        this.hiddenvalue = hiddenvalue;
    }
    public String getCustomerOrderNo() {
        return customerOrderNo;
    }

    public void setCustomerOrderNo(String customerOrderNo) {
        this.customerOrderNo = customerOrderNo;
    }

    public int getInid() {
        return inid;
    }

    public void setInid(int inid) {
        this.inid = inid;
    }

    public int getOrid() {
        return orid;
    }

    public void setOrid(int orid) {
        this.orid = orid;
    }

    public List<Invoice> getInvoicelst() {
        return invoicelst;
    }

    public void setInvoicelst(List<Invoice> invoicelst) {
        this.invoicelst = invoicelst;
    }

    public int getAd() {
        return ad;
    }

    public void setAd(int ad) {
        this.ad = ad;
    }

    public int getIn() {
        return in;
    }

    public void setIn(int in) {
        this.in = in;
    }

    public Advance getAdvance() {
        return advance;
    }

    public void setAdvance(Advance advance) {
        this.advance = advance;
    }

    public String getIncname() {
        return incname;
    }

    public void setIncname(String incname) {
        this.incname = incname;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public List<Order> getOrderlst() {
        return orderlst;
    }

    public void setOrderlst(List<Order> orderlst) {
        this.orderlst = orderlst;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public List<Tax> getTaxlst() {
        return taxlst;
    }

    public void setTaxlst(List<Tax> taxlst) {
        this.taxlst = taxlst;
    }

    public List<Customer> getCustomerlst() {
        return customerlst;
    }

    public void setCustomerlst(List<Customer> customerlst) {
        this.customerlst = customerlst;
    }

    @DefaultHandler
    public Resolution pre(){
        customerlst=customerDao.listAll();
        orderlst=orderDao.listAll();
        taxlst=taxDao.listAll();
//        System.out.println("iiiiiiiiiiiiiiiddddddddddddd "+id);
//        productcategory=invoiceDao.getProductCategorylst();
        return new ForwardResolution("jsp/addInvoice.jsp");
    }
    public Resolution getOrderDetail(){

        order=orderDao.find(id);

        advance=advanceDao.getAdvancedByOrderId(id);

        return new ForwardResolution(InvoiceActionBean.class,"pre");
    }
    public Resolution getTax(){

        taxlst=taxDao.listAll();
        return new JavaScriptResolution(taxlst);
    }


    public Resolution addpreview()
    {


        if(invoice!=null){
            if (invoice.getCreateDate() == null)
            {
                invoice.setCreateDate(new Date());
            }
            Integer invoicenum=invoiceNumberDao.find(1).getValue();
            ++invoicenum;
            invoice.setInvoiceNumber(invoicenum);

        }
        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail idetail=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            idetail=(InvoiceDetail)i.next();
            if(idetail==null){
                i.remove();
                continue;
            }
        }
        if(invoice.getAmountRemained()==null)
        {
            invoice.setAmountRemained(invoice.getAmountReceived());
        }

        invoice.setDeleted(0);
        invoice.setInvoiceDetail(invoicedetail);



        invoice=invoiceDao.save(invoice);
        //advanceDao.setAmountRemained(invoice.getAmountRemained(),advance.getOrder().getId());
        return new RedirectResolution(InvoiceActionBean.class,"redirectpreview").addParameter("in",invoice.getInvoiceNumber());

    }

    public Resolution addgenerate()
    {
        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail id=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            id=(InvoiceDetail)i.next();
            if(id==null){
                i.remove();
                continue;
            }
        }
        if(invoice.getAmountRemained()==null)
        {
            invoice.setAmountRemained(invoice.getAmountReceived());
        }

        invoice.setDeleted(0);
        invoice.setInvoiceDetail(invoicedetail);
        //   in=invoice.getInvoiceNumber();

        orderDao.setRemainingNDispatchedQtyForUpdateOrder(invoice.getOrder().getId(),invoice.getInvoiceDetail());
        if(invoice.getAmountRemained()!=0)
        {

            advanceDao.setAmountRemained(invoice.getAmountRemained(),advance.getOrder().getId());
        }



        if(invoice!=null){
            if (invoice.getCreateDate() == null)
            {
                invoice.setCreateDate(new Date());
            }
            InvoiceNumber inNum=invoiceNumberDao.find(1);
            Integer invoicenum=inNum.getValue();
            invoicenum=invoicenum+1;
            invoice.setInvoiceNumber(invoicenum);

            inNum.setValue(invoicenum);

            invoiceNumberDao.save(inNum);
        }
        invoice=invoiceDao.save(invoice);
        return new RedirectResolution(InvoiceActionBean.class,"pre").addParameter("id",invoice.getInvoiceNumber()).addParameter("hiddenvalue","invoicereceipt");
    }
    public Resolution previewgenerate()
    {
        invoice=invoiceDao.findByInvoiceNumber(invoice.getInvoiceNumber());

        if(invoice!=null){
            if (invoice.getCreateDate() == null)
            {
                invoice.setCreateDate(new Date());

            }
            InvoiceNumber inNum=invoiceNumberDao.find(1);
            Integer invoicenum=inNum.getValue();
            invoicenum=invoicenum+1;
            inNum.setValue(invoicenum);

            invoiceNumberDao.save(inNum);

        }
        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail id=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            id=(InvoiceDetail)i.next();
            if(id==null){
                i.remove();
                continue;
            }
        }
        invoice.setDeleted(0);
        invoice.setInvoiceDetail(invoicedetail);
        orderDao.setRemainingNDispatchedQtyForUpdateOrder(invoice.getOrder().getId(),invoice.getInvoiceDetail());

        invoice=invoiceDao.save(invoice);

        if(invoice.getAmountRemained()!=0)
            advanceDao.setAmountRemained(invoice.getAmountRemained(),advance.getOrder().getId());
        return new RedirectResolution(InvoiceActionBean.class,"pre").addParameter("id",invoice.getInvoiceNumber()).addParameter("hiddenvalue","invoicereceipt");
    }
    public Resolution updatepreview()
    {

        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail id=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            id=(InvoiceDetail)i.next();
            if(id==null){
                i.remove();
                continue;
            }
        }
        invoice.setDeleted(0);
        invoice.setInvoiceDetail(invoicedetail);
        //orderDao.setRemainingNDispatchedQtyForUpdateOrder(invoice.getOrder().getId(),invoice.getInvoiceDetail());
        //  advanceDao.setAmountRemained(invoice.getAmountRemained(),advance.getOrder().getId());
        invoice=invoiceDao.save(invoice);


        return new RedirectResolution(InvoiceActionBean.class,"redirectpreview").addParameter("in",invoice.getInvoiceNumber());
    }
    public Resolution redirectpreview()
    {

        int no=Integer.parseInt(getContext().getRequest().getParameter("in"));
        //Integer.parseInt(getContext().getRequest().getParameter("ad"));

        invoice=invoiceDao.findByInvoiceNumber(no);
        advance=advanceDao.getAdvancedByOrderId(invoice.getOrder().getId());

        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail id=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            id=(InvoiceDetail)i.next();
            if(id==null){
                i.remove();
                continue;
            }
            else if(id.getDispatched()==0)
            {
                i.remove();
                continue;
            }
        }

        return new ForwardResolution("jsp/receipt/InvoicePreviewPage.jsp");
    }
    public Resolution editinvoice()
    {

        invoice=invoiceDao.findByInvoiceNumber(invoice.getInvoiceNumber());

        advance=advanceDao.getAdvancedByOrderId(ad);
        productcategory=invoiceDao.getProductCategorylst();


        return new ForwardResolution("jsp/editInvoice.jsp");
    }
    public Resolution editgenerate()
    {
        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail id=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            id=(InvoiceDetail)i.next();
            if(id==null){
                i.remove();
                continue;
            }
        }
        if(invoice!=null)
        {
            InvoiceNumber inNum=invoiceNumberDao.find(1);
            Integer invoicenum=inNum.getValue();
            invoicenum=invoicenum+1;
            inNum.setValue(invoicenum);

            invoiceNumberDao.save(inNum);
        }
        invoice.setDeleted(0);
        invoice.setInvoiceDetail(invoicedetail);
        invoice=invoiceDao.save(invoice);
        orderDao.setRemainingNDispatchedQtyForUpdateOrder(invoice.getOrder().getId(),invoice.getInvoiceDetail());
        if(invoice.getAmountRemained() != 0)
            advanceDao.setAmountRemained(invoice.getAmountRemained(),advance.getOrder().getId());
        return new RedirectResolution(InvoiceActionBean.class,"pre").addParameter("id",invoice.getInvoiceNumber()).addParameter("hiddenvalue","invoicereceipt");
    }
    public Resolution preupdate()
    {
        customerlst=customerDao.listAll();
        orderlst=orderDao.listAll();
        return new ForwardResolution("jsp/updateInvoice.jsp");
    }
    public Resolution getinvoicenumber()
    {

        invoicelst=invoiceDao.findLatestInvoiceByOrderId(id);


        return new JavaScriptResolution(invoicelst);
    }
    public Resolution getinvoicedetail()
    {


        invoice=invoiceDao.find(inid);
        customerlst=customerDao.listAll();
        advance=advanceDao.getAdvancedByOrderId(getInvoice().getOrder().getId());
        productcategory=invoiceDao.getProductCategorylst();


        return new ForwardResolution("jsp/updateInvoice.jsp");
    }
    public Resolution update()
    {

        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail id=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            id=(InvoiceDetail)i.next();
            if(id==null){
                i.remove();
                continue;
            }
        }
        invoice.setDeleted(0);
        invoice.setInvoiceDetail(invoicedetail);
        in=invoice.getInvoiceNumber();
        orderDao.setRemainingNDispatchedQtyForUpdateOrder(invoice.getOrder().getId(),invoice.getInvoiceDetail());
        if(invoice.getAmountRemained() != 0)
            advanceDao.setAmountRemained(invoice.getAmountRemained(),advance.getOrder().getId());
        invoiceDao.save(invoice);

        return new RedirectResolution(InvoiceActionBean.class,"preupdate");
    }
    public Resolution redirectinvoicepopup()
    {
        hiddenvalue="invoicepdf";

        invoice=invoiceDao.find(invoice.getInvoiceNumber());
        advance=advanceDao.getAdvancedByOrderId(invoice.getOrder().getId());
        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail id=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            id=(InvoiceDetail)i.next();
            if(id==null){
                i.remove();
                continue;
            }
            else if(id.getDispatched()==0)
            {
                i.remove();
                continue;
            }
        }

        return new ForwardResolution("jsp/receipt/InvoicePreviewPage.jsp");
    }
    public Resolution printpdf()
    {

        invoice=invoiceDao.findByInvoiceNumber(getId());
        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail id=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            id=(InvoiceDetail)i.next();
            if(id==null){
                i.remove();
                continue;
            }
            else if(id.getDispatched()==0)
            {
                i.remove();
                continue;
            }
        }
        advance=advanceDao.getAdvancedByOrderId(invoice.getOrder().getId());
        String path=invoiceDao.createPdf(invoice,advance);
        FileInputStream sis=null;
        try{

            sis=new FileInputStream(path);
        }catch(Exception e){
            System.out.println("Eception msg "+e.getMessage());
        }


        return new StreamingResolution("application/pdf",sis);

    }
    public Resolution cancel()
    {
        return new RedirectResolution(InvoiceActionBean.class,"pre");
    }
    public Resolution redirectorderpopup()
    {

        hiddenvalue="invoicepdf";
        invoice=invoiceDao.findByInvoiceNumber(getId());

        advance=advanceDao.getAdvancedByOrderId(invoice.getOrder().getId());



        List<InvoiceDetail> invoicedetail=invoice.getInvoiceDetail();
        InvoiceDetail id=null;
        for(Iterator<InvoiceDetail> i=invoicedetail.iterator();i.hasNext();){
            id=(InvoiceDetail)i.next();
            if(id==null){
                i.remove();
                continue;
            }
            else if(id.getDispatched()==0)
            {
                i.remove();
                continue;
            }
        }
        Date tdate = new Date();
        DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        today = formatter.format(tdate);
        return new ForwardResolution("jsp/receipt/InvoicePreview.jsp");
    }

}
