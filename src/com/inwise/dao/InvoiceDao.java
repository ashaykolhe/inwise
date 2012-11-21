package com.inwise.dao;

import com.inwise.pojo.*;
import com.inwise.dao.BaseDao;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPCell;
import com.wideplay.warp.persist.Transactional;

import java.util.List;
import java.util.Date;
import java.util.Iterator;
import java.util.Calendar;
import java.text.*;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;

import org.hibernate.Criteria;
import org.hibernate.Query;

/**
 * Created by IntelliJ IDEA.
 * User: Milind
 * Date: May 17, 2012
 * Time: 5:12:58 PM
 * To change this template use File | Settings | File Templates.
 */
public class InvoiceDao extends BaseDao<Invoice,Integer>{
    public InvoiceDao() {
        super(Invoice.class);
    }

    public List<Invoice> findByOrderId(Integer orderid)
    {

        return (List<Invoice>) sessionProvider.get().createQuery("from Invoice i where i.order.id="+orderid).list();


    }
    public List<Invoice> findLatestInvoiceByOrderId(Integer orderid)
    {

        return (List<Invoice>) sessionProvider.get().createQuery("from Invoice i where i.order.id="+orderid+" order by i.invoiceNumber DESC").list();
        /*Invoice i= (Invoice) sessionProvider.get().createQuery("select max i from Invoice i where i.order.id='"+orderid+"'").uniqueResult();
        System.out.println("iiiiiiiiiiiiiin"+i);
        return i;
*/
    }
    public List<Invoice> findByOrderNo(Integer orderNo) {
        return (List<Invoice>)sessionProvider.get().createQuery("from Invoice i where i.order.id='"+orderNo+"'").list();
    }
    public List<Integer> getInvoiceNumberLst() {
        return sessionProvider.get().createQuery("select distinct i.invoiceNumber from Invoice i").list();  //To change body of created methods use File | Settings | File Templates.
    }

    public List<String> getInvoiceOrderNumberLst() {
        return sessionProvider.get().createQuery("select distinct i.order.customerOrderNo from Invoice i").list();  //To change body of created methods use File | Settings | File Templates.
    }

    public List<String> getInvoiceCustomerNameLst() {
        return sessionProvider.get().createQuery("select distinct i.customer.name from Invoice i").list();
    }

    public List<String> getInvoiceProductNameLst() {
        return sessionProvider.get().createQuery("select distinct i.product.productName from InvoiceDetail i").list();
    }


    public Invoice findByInvoiceNumber(int id) {
        Invoice ii=null;
        try{
            ii= (Invoice)sessionProvider.get().createQuery("select distinct i from Invoice i WHERE i.invoiceNumber='"+id+"'").uniqueResult();

        }
        catch (Exception e)
        {
            System.out.println(e);
        }
        return ii;
    }

    public List<Invoice> findByInvoiceCustomerOrderNo(String customerOrderno) {
        return (List<Invoice>)sessionProvider.get().createQuery("select distinct i from Invoice i WHERE i.order.customerOrderNo='"+customerOrderno+"'").list();
    }

    public List<Invoice> findByInvoiceCustomerName(String name) {
        return (List<Invoice>)sessionProvider.get().createQuery("select distinct i from Invoice i WHERE i.customer.name='"+name+"'").list();
    }

    public List<Invoice> findByInvoiceDate(String sdate) {
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
         
        return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE i.createDate LIKE '"+sdate+"%'").list();
    }
    public List<Invoice> findByInvoiceCustomerId(Integer id) {
        return (List<Invoice>)sessionProvider.get().createQuery("select distinct i from Invoice i WHERE i.customer.id='"+id+"'").list();
    }
    public List<Invoice> listAllwithDueAmount(List<Invoice> invoicelst,List<Payment> paymentList) {

        for(Iterator<Invoice> ird=invoicelst.iterator();ird.hasNext();){
            Double temp=0.00,a;
            Invoice rd=ird.next();
            rd.setDueQuantity(rd.getNetPayable());
            for(Iterator<Payment> ipay=paymentList.iterator();ipay.hasNext();){
                Payment pay=ipay.next();
                if(rd.getInvoiceNumber().equals(pay.getInvoice().getInvoiceNumber())){
                    a=pay.getReceivedAmount();
                    temp=temp+a;
                    rd.setDueQuantity(rd.getNetPayable()-temp);
                    System.out.println("zzzzzzzzzzzzzzzzzzzzzz"+temp);
//rd.setDueQuantity(rd.getNetPayable()-pay.getReceivedAmount());
// break;
                }


            }
        }
        return invoicelst;
    }
    public Invoice listwithDueAmount(Invoice invoice,List<Payment> paymentList) {

        Double temp=0.00,a;
        invoice.setDueQuantity(invoice.getNetPayable());
        for(Iterator<Payment> ipay=paymentList.iterator();ipay.hasNext();)
        {
            Payment pay=ipay.next();
            if(invoice.getInvoiceNumber().equals(pay.getInvoice().getInvoiceNumber())){
                a=pay.getReceivedAmount();
                temp=temp+a;
                invoice.setDueQuantity(invoice.getNetPayable()-temp);
            }


        }

        return invoice;
    }


    public Long getMaxInvoiceNumber() {
        //return (Integer)sessionProvider.get().createSQLQuery("select invoice_number from invoice order by invoice_number desc").setMaxResults(1).uniqueResult();

        Long i=(Long)sessionProvider.get().createQuery("select max(invoice.invoiceNumber)from Invoice invoice").uniqueResult();
        return i;


    }


    public List<Invoice> findByInvoiceTodayDate() {

        return (List<Invoice>)sessionProvider.get().createQuery("from Invoice WHERE createDate LIKE '"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"%'").list();
    }
    public List<Invoice> getInvoiceMonth(int month, int year,String name) {

        if(month<=9)
            return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE (i.customer.name='"+name+"') AND i.createDate LIKE '"+year+"-"+0+month+"%'").list();
        else
            return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE (i.customer.name='"+name+"') AND i.createDate LIKE '"+year+"-"+month+"%'").list();

    }
    public List<Invoice> getInvoiceYear( int year,String name) {


        return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE (i.customer.name='"+name+"') AND i.createDate LIKE '"+year+"%'").list();

    }
    public List<Invoice> getByFromToCust(String fromdate, String todate,String name) {

        List<Invoice> invoicelst=(List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE (i.customer.name='"+name+"') AND (i.createDate BETWEEN '"+fromdate+"%' AND '"+todate+"%')").list();
        System.out.println("pppppprrrrooooodddduuuucttttttllllllssssssssstttttinvoicelst"+invoicelst);
        return invoicelst;
    }
    public List getInvoiceprodbyyear(String name,int year)
    {
        Integer ii=(Integer)sessionProvider.get().createSQLQuery("select id from product where product_name='"+name+"'").uniqueResult();
        System.out.println("iiiiiiiiddddddd"+ii);
//List in= sessionProvider.get().createSQLQuery("select i.create_date,i.net_payable,i.invoice_number from invoice i left join invoice_has_invoicedetail ih on ih.invoice_id=i.id left join invoice_detail ida on ih.invoice_detail_id=ida.id where ida.product_id='"+ii+"' and i.create_date LIKE '"+year+"%'").list() ;
//List<Invoice> in= (List<Invoice>)sessionProvider.get().createQuery ("select i from Invoice i  where i.invoiceDetail.product.id='"+i+"' and i.createDate LIKE '"+year+"%'").list() ;
        String sql="select i.create_date,i.net_payable,i.invoice_number,i.excise,i.education_cess,i.secondary_higher_education_cess_tax,i.cst_ovat from invoice i left join invoice_has_invoicedetail ih on ih.invoice_id=i.id left join invoice_detail ida on ih.invoice_detail_id=ida.id where ida.product_id='"+ii+"' and i.create_date LIKE '"+year+"%'";
        Query query = sessionProvider.get().createSQLQuery(sql);
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List results = query.list();
        return results;
    }
    public List getInvoiceprodbymonth(String name,int month,int year)
    {
        Integer ii=(Integer)sessionProvider.get().createSQLQuery("select id from product where product_name='"+name+"'").uniqueResult();
        System.out.println("iiiiiiiiddddddd"+ii);
        String sql=null;
        if(month<=9)
            sql=  "select i.create_date,i.net_payable,i.invoice_number,i.excise,i.education_cess,i.secondary_higher_education_cess_tax,i.cst_ovat from invoice i left join invoice_has_invoicedetail ih on ih.invoice_id=i.id left join invoice_detail ida on ih.invoice_detail_id=ida.id where ida.product_id='"+ii+"' AND i.create_date LIKE '"+year+"-"+0+month+"%'";
        else
            sql=  "select i.create_date,i.net_payable,i.invoice_number from invoice i left join invoice_has_invoicedetail ih on ih.invoice_id=i.id left join invoice_detail ida on ih.invoice_detail_id=ida.id where ida.product_id='"+ii+"' AND i.create_date LIKE '"+year+"-"+month+"%'";
        Query query = sessionProvider.get().createSQLQuery(sql);
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List results = query.list();
        return results;
    }
    public List getInvoiceprodbyfromto(String fromdate, String todate,String name)
    {
        Integer ii=(Integer)sessionProvider.get().createSQLQuery("select id from product where product_name='"+name+"'").uniqueResult();
        System.out.println("iiiiiiiiddddddd"+ii);
        String sql="select i.create_date,i.net_payable,i.invoice_number,i.excise,i.education_cess,i.secondary_higher_education_cess_tax,i.cst_ovat from invoice i left join invoice_has_invoicedetail ih on ih.invoice_id=i.id left join invoice_detail ida on ih.invoice_detail_id=ida.id where ida.product_id='"+ii+"'AND (i.create_date BETWEEN '"+fromdate+"%' AND '"+todate+"%')";
        Query query = sessionProvider.get().createSQLQuery(sql);
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List results = query.list();
        return results;
    }
    public List<Invoice> getInvoiceYearalltax( int year) {


        return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE i.createDate LIKE '"+year+"%'").list();

    }
    public List<Invoice> getInvoiceMonthalltax(int month, int year) {

        if(month<=9)
            return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE i.createDate LIKE '"+year+"-"+0+month+"%'").list();
        else
            return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE  i.createDate LIKE '"+year+"-"+month+"%'").list();
    }
    public List<Invoice> getByFromToalltax(String fromdate, String todate) {
        List<Invoice> invoicelst=(List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE  i.createDate BETWEEN '"+fromdate+"%' AND '"+todate+"%'").list();
        return invoicelst;
    }
    public String createPdf(Invoice invoice, Advance advance) {
        /*String filepath=null;
        try {
            Document document=new Document(PageSize.A4, -70, -70, 10, 10);
            filepath="c:/Inwise/"+invoice.getCustomer().getName()+"_"+invoice.getOrder().getCustomerOrderNo()+"_"+invoice.getInvoiceNumber()+".pdf";
            FileOutputStream fos=new FileOutputStream(filepath);
            PdfWriter.getInstance(document,fos);
            document.open();
            String strcopy = "";
            float[] widths = {0.05f,0.23f, 0.31f, 0.04f, 0.20f,0.17f};
            PdfPTable firstrowmntable=new PdfPTable(widths);
            Font catfont = new Font(Font.FontFamily.TIMES_ROMAN,9,Font.NORMAL);
            Image cmpyimage = Image.getInstance ("C:/images/WE.JPG");
            firstrowmntable.addCell(cmpyimage);
            PdfPTable tableinfo=new PdfPTable(1);
            PdfPCell infocell1 = new PdfPCell(new Phrase("WELDTECH ENGINEERS", FontFactory.getFont(FontFactory.TIMES_ROMAN,10,Font.BOLD)));
            infocell1.setHorizontalAlignment(Element.ALIGN_LEFT);
            infocell1.setBorder(Rectangle.NO_BORDER);
            infocell1.setFixedHeight(14f);
            infocell1.setPaddingBottom(0);
            tableinfo.addCell(infocell1);
            PdfPCell infocell2 = new PdfPCell( new Paragraph( "   AT:LAING"+ Chunk.NEWLINE +
                    "   PO:KANSBAHAL" + Chunk.NEWLINE + "   DIST:SUNDARGARH"+ Chunk.NEWLINE +
                    "   ORISSA,INDIA",catfont));
            infocell2.setHorizontalAlignment(Element.ALIGN_LEFT);
            infocell2.setBorder(Rectangle.NO_BORDER);
            infocell2.setPadding(0);
            infocell2.setFixedHeight(30f);
            tableinfo.addCell(infocell2);
            firstrowmntable.addCell(tableinfo);
            firstrowmntable.addCell( new Paragraph(Chunk.NEWLINE + "Tel No. : 06624-280433" + Chunk.NEWLINE
                    + "              :092387-23033"
                    + Chunk.NEWLINE +
                    "Fax No. : 06624-280433"  + Chunk.NEWLINE +"E-Mail:weldtech_engineers@rediffmail.com"
                    ,catfont));
            PdfPCell timecell = new PdfPCell(new Paragraph(Chunk.NEWLINE +"TIME", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            timecell.setFixedHeight(20f);
            timecell.setHorizontalAlignment(Element.ALIGN_CENTER);
            timecell.setRotation(90);
            firstrowmntable.addCell(timecell);
            float[] widths1 = {0.10f,0.10f};
            PdfPTable firstrowtable2=new PdfPTable(widths1);
            PdfPCell datecell1 = new PdfPCell(new Phrase("DATE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            datecell1.setHorizontalAlignment(Element.ALIGN_CENTER);
            datecell1.setBorder(Rectangle.RIGHT);
            datecell1.setFixedHeight(16F);
            firstrowtable2.addCell(datecell1);
            Date date = Calendar.getInstance().getTime();
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            String today = formatter.format(date);

            PdfPCell datecellvalue1 = new PdfPCell(new Phrase(today, FontFactory.getFont(FontFactory.TIMES_ROMAN,9)));
            datecellvalue1.setHorizontalAlignment(Element.ALIGN_CENTER);
            datecellvalue1.setBorder(Rectangle.BOTTOM);
            datecellvalue1.setFixedHeight(17F);
            firstrowtable2.addCell(datecellvalue1);

            PdfPCell issuecell = new PdfPCell(new Phrase("ISSUE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            issuecell.setHorizontalAlignment(Element.ALIGN_CENTER);
            issuecell.setBorder(Rectangle.TOP);

            issuecell.setFixedHeight(16f);
            firstrowtable2.addCell(issuecell);

             if(invoice.getIssueTime()!=null && !invoice.getIssueTime().equals("")){
                PdfPCell issuecellvalue = new PdfPCell(new Phrase(invoice.getIssueTime(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            issuecellvalue.setHorizontalAlignment(Element.ALIGN_CENTER);
            issuecellvalue.setBorder(Rectangle.LEFT);
            issuecellvalue.setFixedHeight(16f);
            firstrowtable2.addCell(issuecellvalue);
            }else{
               PdfPCell issuecellvalue = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            issuecellvalue.setHorizontalAlignment(Element.ALIGN_CENTER);
            issuecellvalue.setBorder(Rectangle.LEFT);
            issuecellvalue.setFixedHeight(16f);
            firstrowtable2.addCell(issuecellvalue);
            }


            PdfPCell removalcell = new PdfPCell(new Phrase("REMOVAL", FontFactory.getFont(FontFactory.TIMES_ROMAN,9)));
            removalcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            removalcell.setBorder(Rectangle.NO_BORDER);
            removalcell.setBorderWidthTop (0.35f);
            removalcell.setFixedHeight(16f);
            firstrowtable2.addCell(removalcell);

             if(invoice.getRemovalTime()!=null && !invoice.getRemovalTime().equals("")){
                 PdfPCell removalcellvalue = new PdfPCell(new Phrase(invoice.getRemovalTime(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                          removalcellvalue.setHorizontalAlignment(Element.ALIGN_CENTER);
                          removalcellvalue.setBorder(Rectangle.TOP);
                          removalcellvalue.setBorderWidthLeft(0.35f);
                          removalcellvalue.setFixedHeight(16f);
                          firstrowtable2.addCell(removalcellvalue);
                          firstrowmntable.addCell(firstrowtable2);
            }else{
                 PdfPCell removalcellvalue = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                          removalcellvalue.setHorizontalAlignment(Element.ALIGN_CENTER);
                          removalcellvalue.setBorder(Rectangle.TOP);
                          removalcellvalue.setBorderWidthLeft(0.35f);
                          removalcellvalue.setFixedHeight(16f);
                          firstrowtable2.addCell(removalcellvalue);
                          firstrowmntable.addCell(firstrowtable2);
            }

            int invno  = invoice.getInvoiceNumber();
            String invoiceNo = new Integer(invno).toString();

            PdfPTable firstrowtable3= new PdfPTable(1);
            PdfPCell invoicecell = new PdfPCell(new Phrase("INVOICE NO.", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            invoicecell.setHorizontalAlignment(Element.ALIGN_LEFT);
            invoicecell.setBorder(Rectangle.NO_BORDER);
            invoicecell.setFixedHeight(13f);
            firstrowtable3.addCell(invoicecell);

            PdfPCell invoicecellval = new PdfPCell(new Phrase(invoiceNo, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            invoicecellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            invoicecellval.setBorder(Rectangle.BOTTOM);
            firstrowtable3.addCell(invoicecellval );

            PdfPCell datecell2 = new PdfPCell(new Phrase("DATE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            datecell2.setHorizontalAlignment(Element.ALIGN_LEFT);
            datecell2.setBorder(Rectangle.TOP);
            datecell2.setFixedHeight(13f);
            firstrowtable3.addCell(datecell2);

            String incdate;
            incdate = (invoice.getCreateDate().toString()).substring(0,10);
            incdate = incdate.substring(8,10)+"/"+incdate.substring(5,7)+"/"+incdate.substring(0,4);

            PdfPCell datecellvalue2 = new PdfPCell(new Phrase(incdate, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            datecellvalue2.setHorizontalAlignment(Element.ALIGN_RIGHT);
            datecellvalue2.setBorder(Rectangle.NO_BORDER);
            firstrowtable3.addCell(datecellvalue2 );
            firstrowmntable.addCell(firstrowtable3);

//START OF 2ND ROW

            float[] table3width = {0.43f,0.40f,0.17f};
            PdfPTable secrowmntable=new PdfPTable(table3width);

            float[] widthinv = {0.11f,0.32f};
            PdfPTable invoiceaddtable= new PdfPTable(widthinv);

            PdfPCell cellinv = new PdfPCell(new Phrase("INVOICE TO:", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            cellinv.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellinv.setPaddingBottom(0);
            cellinv.setRowspan(2);
            cellinv.setBorder(Rectangle.NO_BORDER);
            cellinv.setFixedHeight(40f);
            invoiceaddtable.addCell(cellinv );

            if(invoice.getOrder().getOrderAddress().get(0).getAddress()!=null){
                 PdfPCell cellinvval = new PdfPCell(new Phrase(invoice.getCustomer().getName()+
                    Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(0).getAddress().getLine1()+
                    Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(0).getAddress().getLine2()+
                    Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(0).getAddress().getCity()+
                    Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(0).getAddress().getState()+
                    Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(0).getAddress().getCountry()+
                    Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(0).getAddress().getZip(),
                    FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            cellinvval.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellinvval.setRowspan(2);
            cellinvval.setBorder(Rectangle.NO_BORDER);
            invoiceaddtable.addCell(cellinvval );
            }else{
                 PdfPCell cellinvval = new PdfPCell(new Phrase("-",FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            cellinvval.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellinvval.setRowspan(2);
            cellinvval.setBorder(Rectangle.NO_BORDER);
            invoiceaddtable.addCell(cellinvval );
            }
            
//int tinNo  = invoice.getTinno();
//String stinNo = new Integer(tinNo).toString();

            PdfPCell celltinno = new PdfPCell(new Phrase("Tin No:", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            celltinno.setHorizontalAlignment(Element.ALIGN_LEFT);
            celltinno.setFixedHeight(12f);
            celltinno.setBorder(Rectangle.NO_BORDER);
            invoiceaddtable.addCell(celltinno );

            if(invoice.getCustomer().getTinNo()!=null && !invoice.getCustomer().getTinNo().equals("")){
                PdfPCell celltinnovalue = new PdfPCell(new Phrase(invoice.getCustomer().getTinNo(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                celltinnovalue.setHorizontalAlignment(Element.ALIGN_LEFT);
                celltinnovalue.setBorder(Rectangle.NO_BORDER);
                invoiceaddtable.addCell(celltinnovalue );
            }else{
                PdfPCell celltinnovalue = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                celltinnovalue.setHorizontalAlignment(Element.ALIGN_LEFT);
                celltinnovalue.setBorder(Rectangle.NO_BORDER);
                invoiceaddtable.addCell(celltinnovalue );
            }
//int eccNo  = invoice.getEccno();
//String seccNo = new Integer(eccNo).toString();

            PdfPCell celleccno = new PdfPCell(new Phrase("Ecc No:", FontFactory.getFont(FontFactory.TIMES_ROMAN,9,Font.BOLD)));
            celleccno.setHorizontalAlignment(Element.ALIGN_LEFT);
            celleccno.setFixedHeight(12f);
            celleccno.setBorder(Rectangle.NO_BORDER);
            celleccno.disableBorderSide( Rectangle.NO_BORDER);
            invoiceaddtable.addCell(celleccno );

            if(invoice.getCustomer().getEccNo()!=null && !invoice.getCustomer().getEccNo().equals("")){
                PdfPCell celleccvalue = new PdfPCell(new Phrase(invoice.getCustomer().getEccNo(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                celleccvalue.setHorizontalAlignment(Element.ALIGN_LEFT);
                celleccvalue.setBorder(Rectangle.NO_BORDER);
                invoiceaddtable.addCell(celleccvalue );
                secrowmntable.addCell(invoiceaddtable);
            }else
            {
                PdfPCell celleccvalue = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                celleccvalue.setHorizontalAlignment(Element.ALIGN_LEFT);
                celleccvalue.setBorder(Rectangle.NO_BORDER);
                invoiceaddtable.addCell(celleccvalue );
                secrowmntable.addCell(invoiceaddtable);
            }
            float[] widthcon = {0.09f,0.31f};
            PdfPTable tablecon= new PdfPTable(widthcon);
            PdfPCell cellcon = new PdfPCell(new Phrase("Consignee :", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            cellcon.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellcon.setPaddingBottom(0);
            cellcon.setBorder(Rectangle.NO_BORDER);
            cellcon.setFixedHeight(40f);
            tablecon.addCell(cellcon );
            if(invoice.getOrder().getConsigneeName()!=null && !invoice.getOrder().getConsigneeName().equals("")){
            if(invoice.getOrder().getOrderAddress().get(1).getAddress()!=null){
                PdfPCell cellconval = new PdfPCell(new Phrase(invoice.getOrder().getConsigneeName()+
                        Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(1).getAddress().getLine1()+
                        Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(1).getAddress().getLine2()+
                        Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(1).getAddress().getCity()+
                        Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(1).getAddress().getState()+
                        Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(1).getAddress().getCountry()+
                        Chunk.NEWLINE +invoice.getOrder().getOrderAddress().get(1).getAddress().getZip()
                        , FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                cellconval.setHorizontalAlignment(Element.ALIGN_LEFT);
                cellconval.setBorder(Rectangle.NO_BORDER);
                tablecon.addCell(cellconval );
                secrowmntable.addCell(tablecon);
            }
                else
                {
                  PdfPCell cellconval = new PdfPCell(new Phrase(invoice.getOrder().getConsigneeName()+
                        Chunk.NEWLINE +"=", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                cellconval.setHorizontalAlignment(Element.ALIGN_LEFT);
                cellconval.setBorder(Rectangle.NO_BORDER);
                tablecon.addCell(cellconval );
                secrowmntable.addCell(tablecon);
                }
            }
            else{
               PdfPCell cellconval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                cellconval.setHorizontalAlignment(Element.ALIGN_LEFT);
                cellconval.setBorder(Rectangle.NO_BORDER);
                tablecon.addCell(cellconval );
                secrowmntable.addCell(tablecon);
            }

            PdfPTable secrow2table= new PdfPTable(1);
            PdfPCell descell= new PdfPCell(new Phrase("Des.Adv.No", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            descell.setHorizontalAlignment(Element.ALIGN_LEFT);
            descell.setBorder(Rectangle.NO_BORDER);
            descell.setFixedHeight(20f);
            secrow2table.addCell(descell );
             if(invoice.getDesAdvNo()!=null && !invoice.getDesAdvNo().equals("")){
               PdfPCell descellvalue = new PdfPCell(new Phrase(invoice.getDesAdvNo(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            descellvalue.setHorizontalAlignment(Element.ALIGN_RIGHT);
            descellvalue.setBorder(Rectangle.BOTTOM);
            secrow2table.addCell(descellvalue );
            }else
            {
                PdfPCell descellvalue = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                           descellvalue.setHorizontalAlignment(Element.ALIGN_RIGHT);
                           descellvalue.setBorder(Rectangle.BOTTOM);
                           secrow2table.addCell(descellvalue );

            }
           

            PdfPCell datecell3 = new PdfPCell(new Phrase("DATE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            datecell3.setHorizontalAlignment(Element.ALIGN_LEFT);
            datecell3.setBorder(Rectangle.TOP);
            datecell3.setFixedHeight(13f);
            secrow2table.addCell(datecell3);


            String desdate;
            desdate = (invoice.getCreateDate().toString()).substring(0,10);
            desdate = desdate.substring(8,10)+"/"+desdate.substring(5,7)+"/"+desdate.substring(0,4);

            if(desdate!=null && !desdate.equals("")){
               PdfPCell datecell3value = new PdfPCell(new Phrase(desdate, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            datecell3value.setHorizontalAlignment(Element.ALIGN_RIGHT);
            datecell3value.setBorder(Rectangle.NO_BORDER);
            secrow2table.addCell(datecell3value);
            secrowmntable.addCell(secrow2table);
            }else
            {
                PdfPCell datecell3value = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            datecell3value.setHorizontalAlignment(Element.ALIGN_RIGHT);
            datecell3value.setBorder(Rectangle.NO_BORDER);
            secrow2table.addCell(datecell3value);
            secrowmntable.addCell(secrow2table);

            }
           
//START OF 3ND ROW
            float[] table4width = {0.17f,0.26f,0.40f,0.17f};
            PdfPTable thrdrowmntable=new PdfPTable(table4width);

            PdfPTable saletable= new PdfPTable(1);
            PdfPCell salerepcell= new PdfPCell(new Phrase("SALES REP CODE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            salerepcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            salerepcell.setBorder(Rectangle.NO_BORDER);
            salerepcell.setFixedHeight(13f);
            saletable.addCell(salerepcell );
            if(invoice.getSalesRepCode()!=null && !invoice.getSalesRepCode().equals("")){
                PdfPCell salerepcellval = new PdfPCell(new Phrase(invoice.getSalesRepCode(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            salerepcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            salerepcellval.setBorder(Rectangle.NO_BORDER);
            saletable.addCell(salerepcellval );
            thrdrowmntable.addCell(saletable);
            }else
            {
               PdfPCell salerepcellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            salerepcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            salerepcellval.setBorder(Rectangle.NO_BORDER);
            saletable.addCell(salerepcellval );
            thrdrowmntable.addCell(saletable);
            }
            

            PdfPTable station1table= new PdfPTable(1);
            PdfPCell station1cell= new PdfPCell(new Phrase("STATION FROM", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            station1cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            station1cell.setBorder(Rectangle.NO_BORDER);
            station1cell.setFixedHeight(13f);
            station1table.addCell(station1cell );

            PdfPCell station1cellval = new PdfPCell(new Phrase("Kanshahal", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            station1cellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            station1cellval.setBorder(Rectangle.NO_BORDER);
            station1table.addCell(station1cellval );
            thrdrowmntable.addCell(station1table);

            PdfPTable station2table= new PdfPTable(1);
            PdfPCell stationcell= new PdfPCell(new Phrase("STATION TO", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            stationcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            stationcell.setBorder(Rectangle.NO_BORDER);
            stationcell.setFixedHeight(13f);
            station2table.addCell(stationcell );
            if(invoice.getStationto()!=null && !invoice.getStationto().equals("")){

            PdfPCell stationcellval = new PdfPCell(new Phrase(invoice.getStationto(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            stationcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            stationcellval.setBorder(Rectangle.NO_BORDER);
            station2table.addCell(stationcellval );
            thrdrowmntable.addCell(station2table);
           }else
           {

            PdfPCell stationcellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            stationcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            stationcellval.setBorder(Rectangle.NO_BORDER);
            station2table.addCell(stationcellval );
            thrdrowmntable.addCell(station2table);

           }



            PdfPTable fgntable= new PdfPTable(1);
            PdfPCell fgncell= new PdfPCell(new Phrase("FGN NO.", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            fgncell.setHorizontalAlignment(Element.ALIGN_LEFT);
            fgncell.setBorder(Rectangle.NO_BORDER);
            fgncell.setFixedHeight(13f);
            fgntable.addCell(fgncell );
             if(invoice.getFgnNo()!=null && !invoice.getFgnNo().equals("")){

            PdfPCell fgncellval = new PdfPCell(new Phrase(invoice.getFgnNo(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            fgncellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            fgncellval.setBorder(Rectangle.NO_BORDER);
            fgntable.addCell(fgncellval );
            thrdrowmntable.addCell(fgntable);
           }else
           {

           PdfPCell fgncellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            fgncellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            fgncellval.setBorder(Rectangle.NO_BORDER);
            fgntable.addCell(fgncellval );
            thrdrowmntable.addCell(fgntable);

           }
           

//START OF 4ND ROW
            float[] table5width = {0.11f,0.13f,0.27f,0.26f,0.23f};
            PdfPTable frthrwmntable=new PdfPTable(table5width);

            PdfPTable regiontable= new PdfPTable(1);
            PdfPCell regioncell= new PdfPCell(new Phrase(new Paragraph("REGION & BR A/C CODE" , FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD))));
            regioncell.setHorizontalAlignment(Element.ALIGN_LEFT);
            regioncell.setBorder(Rectangle.NO_BORDER);
            regiontable.addCell(regioncell );

            if(invoice.getRegBr()!=null && !invoice.getRegBr().equals("")){
PdfPCell regioncellval = new PdfPCell(new Phrase(invoice.getRegBr()+"1", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            regioncellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            regioncellval.setBorder(Rectangle.NO_BORDER);
            regiontable.addCell(regioncellval );
            frthrwmntable.addCell(regiontable);
           }else
           {

          PdfPCell regioncellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            regioncellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            regioncellval.setBorder(Rectangle.NO_BORDER);
            regiontable.addCell(regioncellval );
            frthrwmntable.addCell(regiontable);
           }
           

            PdfPTable cus1table= new PdfPTable(1);
            PdfPCell cuscell= new PdfPCell(new Phrase(new Paragraph("CUST. CODE"  , FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD))));
            cuscell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cuscell.setBorder(Rectangle.NO_BORDER);
            cuscell.setFixedHeight(15f);
            cus1table.addCell(cuscell );

             if(invoice.getCustomer().getCustomerCode()!=null && !invoice.getCustomer().getCustomerCode().equals("")){
 PdfPCell cuscellval = new PdfPCell(new Phrase(invoice.getCustomer().getCustomerCode(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            cuscellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cuscellval.setBorder(Rectangle.NO_BORDER);
            cus1table.addCell(cuscellval );
            frthrwmntable.addCell(cus1table);
           }else
           {
 PdfPCell cuscellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            cuscellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cuscellval.setBorder(Rectangle.NO_BORDER);
            cus1table.addCell(cuscellval );
            frthrwmntable.addCell(cus1table);
           }
        

            PdfPTable cus2table= new PdfPTable(2);
            PdfPCell cusordcell= new PdfPCell(new Phrase(new Paragraph("CUST. ORDER NO."  , FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD))));
            cusordcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cusordcell.setBorder(Rectangle.NO_BORDER);
            cusordcell.setFixedHeight(15f);
            cus2table.addCell(cusordcell );
            if(invoice.getOrder().getCustomerOrderNo()!=null && !invoice.getOrder().getCustomerOrderNo().equals("")){
             PdfPCell cusordcellval = new PdfPCell(new Phrase(invoice.getOrder().getCustomerOrderNo(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            cusordcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cusordcellval.setBorder(Rectangle.NO_BORDER);
            cus2table.addCell(cusordcellval );
                       }else
                       {
             PdfPCell cusordcellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            cusordcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cusordcellval.setBorder(Rectangle.NO_BORDER);
            cus2table.addCell(cusordcellval );
                       }


            PdfPCell cusdatcell= new PdfPCell(new Phrase(new Paragraph("DATE"  , FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD))));
            cusdatcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cusdatcell.setBorder(Rectangle.NO_BORDER);
            cusdatcell.setFixedHeight(15f);
            cus2table.addCell(cusdatcell );

            String orderdate;
            orderdate = (invoice.getOrder().getCreateDate().toString()).substring(0,10);
            orderdate = orderdate.substring(8,10)+"/"+orderdate.substring(5,7)+"/"+orderdate.substring(0,4);

            if(orderdate!=null && !orderdate.equals("")){
                PdfPCell cusdatcellval = new PdfPCell(new Phrase(orderdate, FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
                cusdatcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cusdatcellval.setBorder(Rectangle.NO_BORDER);
                cusdatcellval.setFixedHeight(15f);
                cus2table.addCell(cusdatcellval );
                frthrwmntable.addCell(cus2table);

            }else
            {
                PdfPCell cusdatcellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
                cusdatcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cusdatcellval.setBorder(Rectangle.NO_BORDER);
                cusdatcellval.setFixedHeight(15f);
                cus2table.addCell(cusdatcellval );
                frthrwmntable.addCell(cus2table);

            }



            PdfPTable cus2table1= new PdfPTable(2);
            PdfPCell cusordcell1= new PdfPCell(new Phrase(new Paragraph("AMENDMENT NO."  , FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD))));
            cusordcell1.setHorizontalAlignment(Element.ALIGN_LEFT);
            cusordcell1.setBorder(Rectangle.NO_BORDER);
            cusordcell1.setFixedHeight(15f);
            cus2table1.addCell(cusordcell1);
            if(invoice.getOrder().getAmendmentNo()!=null && !invoice.getOrder().getAmendmentNo().equals("")){
                PdfPCell cusordcellval1 = new PdfPCell(new Phrase(invoice.getOrder().getAmendmentNo().toString(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
                cusordcellval1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cusordcellval1.setBorder(Rectangle.NO_BORDER);
                cus2table1.addCell(cusordcellval1 );
            }else
            {
                PdfPCell cusordcellval1 = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
                cusordcellval1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cusordcellval1.setBorder(Rectangle.NO_BORDER);
                cus2table1.addCell(cusordcellval1 );
            }
            PdfPCell cusdatcell1= new PdfPCell(new Phrase(new Paragraph("DATE"  , FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD))));
            cusdatcell1.setHorizontalAlignment(Element.ALIGN_LEFT);
            cusdatcell1.setBorder(Rectangle.NO_BORDER);
            cusdatcell1.setFixedHeight(15f);
            cus2table1.addCell(cusdatcell1);
            if(invoice.getOrder().getAmendmentDate()!=null && !invoice.getOrder().getAmendmentDate().equals("")){
                String amendmentdate;
                amendmentdate = (invoice.getOrder().getAmendmentDate().toString()).substring(0,10);
                amendmentdate = amendmentdate.substring(8,10)+"/"+amendmentdate.substring(5,7)+"/"+amendmentdate.substring(0,4);


                PdfPCell cusdatcellval1 = new PdfPCell(new Phrase(amendmentdate, FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
                cusdatcellval1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cusdatcellval1.setBorder(Rectangle.NO_BORDER);
                cusdatcellval1.setFixedHeight(15f);
                cus2table1.addCell(cusdatcellval1 );

            }
            else
            {
                PdfPCell cusdatcellval1 = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
                cusdatcellval1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cusdatcellval1.setBorder(Rectangle.NO_BORDER);
                cusdatcellval1.setFixedHeight(15f);
                cus2table1.addCell(cusdatcellval1 );
            }
            frthrwmntable.addCell(cus2table1);

            PdfPTable contrttable= new PdfPTable(1);
            PdfPCell cntrtcell= new PdfPCell(new Phrase(new Paragraph("CONTRACT NOTE NO. & DATE"  , FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD))));
            cntrtcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cntrtcell.setBorder(Rectangle.NO_BORDER);
            cntrtcell.setFixedHeight(15f);
            contrttable.addCell(cntrtcell );
             String contractdate=null;
                if(invoice.getContNoteDate()!=null)
                {
         contractdate = (invoice.getContNoteDate().toString()).substring(0,10);
            contractdate = contractdate.substring(8,10)+"/"+contractdate.substring(5,7)+"/"+contractdate.substring(0,4);
                }

            if(contractdate!=null && !contractdate.equals("")){
            PdfPCell cntrtcellval = new PdfPCell(new Phrase(contractdate, FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            cntrtcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cntrtcellval.setBorder(Rectangle.NO_BORDER);
            contrttable.addCell(cntrtcellval );
            frthrwmntable.addCell(contrttable);
            }else
            {
               PdfPCell cntrtcellval = new PdfPCell(new Phrase("", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            cntrtcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cntrtcellval.setBorder(Rectangle.NO_BORDER);
            contrttable.addCell(cntrtcellval );
            frthrwmntable.addCell(contrttable);

            }



//START OF 5ND ROW

            float[] table6width = {0.08f,0.08f,0.45f,0.07f,0.15f,0.17f};
            PdfPTable fifthrwmntable=new PdfPTable(table6width);

            PdfPCell itmcell = new PdfPCell(new Phrase("ITEM NO", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            itmcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            itmcell.setFixedHeight(22f);
            fifthrwmntable.addCell(itmcell);

            PdfPCell cshcell = new PdfPCell(new Phrase("CSH NO.", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            cshcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cshcell.setFixedHeight(21f);
            fifthrwmntable.addCell(cshcell);

            PdfPCell desccell = new PdfPCell(new Phrase("Commodity/Description", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            desccell.setHorizontalAlignment(Element.ALIGN_CENTER);
            desccell.setFixedHeight(21f);
            fifthrwmntable.addCell(desccell);

            PdfPCell descell2 = new PdfPCell(new Phrase("Qty", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            descell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            descell2.setFixedHeight(21f);
            fifthrwmntable.addCell(descell2);

            PdfPCell ratecell = new PdfPCell(new Phrase("RATE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            ratecell.setHorizontalAlignment(Element.ALIGN_CENTER);
            ratecell.setFixedHeight(21f);
            fifthrwmntable.addCell(ratecell);

            PdfPCell amountcell = new PdfPCell(new Phrase("AMOUNT", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            amountcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            amountcell.setFixedHeight(21f);
            fifthrwmntable.addCell(amountcell);

//START OF 6ND ROW
            PdfPTable sxthrwmntable=new PdfPTable(table6width);

             Iterator<OrderDetail> iterateorder1 = invoice.getOrder().getOrderDetail().iterator();
            Iterator<InvoiceDetail> iterateinvoice1 = invoice.getInvoiceDetail().iterator();

            while(iterateinvoice1.hasNext())
            {
                OrderDetail orderdetail=iterateorder1.next();
                InvoiceDetail invoicedetail=iterateinvoice1.next();
                String sid=null;
                if(invoicedetail!=null)
                {
                    sid = invoicedetail.getDrawingNo();
                }
                else
                {
                    sid="-";
                }
//Integer iid = (Integer)obj[0];
                String icshno =invoicedetail.getDrawingNo();
                String scshno = invoicedetail.getCshNo();
                String ptype=invoicedetail.getProductCategory().getType();
                String pname =invoicedetail.getProduct().getProductName();
                String productbywght =invoicedetail.getProduct().getUnit().getName();
                Double ioqty=invoicedetail.getDispatching();
                String soqty = ioqty.toString();

                Double idispatched= invoicedetail.getDispatched();
                String sdispatched = idispatched.toString();

                Double idispatching= invoicedetail.getDispatching();
                String sdispatching = idispatching.toString();

                String spcost;
                String samount;
                Double iamendment= orderdetail.getAmendmentQuantity();

                if(iamendment !=null)
                {
                String samendment = iamendment.toString();

                Double ipcost= orderdetail.getAmendmentCost();
                NumberFormat ipcostformatter = new DecimalFormat("#0.00");
                 spcost = ipcostformatter.format(ipcost);

                Double iamount= idispatched * ipcost;
                NumberFormat iamountformatter = new DecimalFormat("#0.00");
                 samount = iamountformatter.format(iamount);
                }
                else
                {
                   Double ipcost= invoicedetail.getProductCost();
                NumberFormat ipcostformatter = new DecimalFormat("#0.00");
                spcost = ipcostformatter.format(ipcost);

                Double iamount= idispatched * ipcost;
                NumberFormat iamountformatter = new DecimalFormat("#0.00");
                 samount = iamountformatter.format(iamount);
                }
                if(invoice.getInvoiceDetail().size()==1)
                {
                    PdfPCell itmcellval = new PdfPCell(new Phrase(sid, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                    itmcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                    itmcellval.setFixedHeight(100f);
                    sxthrwmntable.addCell(itmcellval);


                    PdfPCell cshcellval = new PdfPCell(new Phrase(scshno, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                    cshcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                    sxthrwmntable.addCell(cshcellval);

                    PdfPTable producttable= new PdfPTable(1);

                    PdfPCell prdtypecellval = new PdfPCell(new Phrase(ptype+" Of:-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
                    prdtypecellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                    prdtypecellval.setBorder(Rectangle.NO_BORDER);
                    producttable.addCell(prdtypecellval);

                    PdfPCell prdcellval = new PdfPCell(new Phrase(pname, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                    prdcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                    prdcellval.setBorder(Rectangle.NO_BORDER);
                    producttable.addCell(prdcellval);

                    PdfPCell desccellval = new PdfPCell(producttable);
                    desccellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                    sxthrwmntable.addCell(desccellval);
                    if(productbywght.equals("MT")){
                        PdfPCell descell2val = new PdfPCell(new Phrase(sdispatched+"  MT", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                        descell2val.setHorizontalAlignment(Element.ALIGN_CENTER);
                        sxthrwmntable.addCell(descell2val);
                    }
                    else{
                        PdfPCell descell2val = new PdfPCell(new Phrase(sdispatched, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                        descell2val.setHorizontalAlignment(Element.ALIGN_CENTER);
                        sxthrwmntable.addCell(descell2val);
                    }
                    PdfPCell ratecellval = new PdfPCell(new Phrase(spcost, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                    ratecellval.setHorizontalAlignment(Element.ALIGN_CENTER);
                    sxthrwmntable.addCell(ratecellval);

                    PdfPCell amountcellval = new PdfPCell(new Phrase(samount, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                    amountcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    sxthrwmntable.addCell(amountcellval);
                }
                else
                {

                    PdfPCell itmcellval = new PdfPCell(new Phrase(sid, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                    itmcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                    itmcellval.setFixedHeight(50f);
                    sxthrwmntable.addCell(itmcellval);


                    PdfPCell cshcellval = new PdfPCell(new Phrase(scshno, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                    cshcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                    sxthrwmntable.addCell(cshcellval);

                    PdfPTable producttable= new PdfPTable(1);

                    PdfPCell prdtypecellval = new PdfPCell(new Phrase(ptype+" Of:-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
                    prdtypecellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                    prdtypecellval.setBorder(Rectangle.NO_BORDER);
                    producttable.addCell(prdtypecellval);

                    PdfPCell prdcellval = new PdfPCell(new Phrase(pname, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                    prdcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                    prdcellval.setBorder(Rectangle.NO_BORDER);
                    producttable.addCell(prdcellval);

                    PdfPCell desccellval = new PdfPCell(producttable);
                    desccellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                    sxthrwmntable.addCell(desccellval);
                    if(productbywght.equals("unit")){
                        PdfPCell descell2val = new PdfPCell(new Phrase(sdispatched+"  unit", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                        descell2val.setHorizontalAlignment(Element.ALIGN_CENTER);
                        sxthrwmntable.addCell(descell2val);
                    }
                    else{
                        PdfPCell descell2val = new PdfPCell(new Phrase(sdispatched, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                        descell2val.setHorizontalAlignment(Element.ALIGN_CENTER);
                        sxthrwmntable.addCell(descell2val);
                    }
                    PdfPCell ratecellval = new PdfPCell(new Phrase(spcost, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                    ratecellval.setHorizontalAlignment(Element.ALIGN_CENTER);
                    sxthrwmntable.addCell(ratecellval);

                    PdfPCell amountcellval = new PdfPCell(new Phrase(samount, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                    amountcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    sxthrwmntable.addCell(amountcellval);
                }
            }
            float[] sevenrwwidth = {0.09f,0.91f};
            PdfPTable sevenrwmntable=new PdfPTable(sevenrwwidth);


            PdfPCell remarkcell = new PdfPCell(new Phrase("REMARK:", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            remarkcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            sevenrwmntable.addCell(remarkcell);
            if(invoice.getRemark()!=null)
            {
                PdfPCell remarkcellval = new PdfPCell(new Phrase(invoice.getRemark(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                remarkcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                sevenrwmntable.addCell(remarkcellval);
            }
            else
            {
                PdfPCell remarkcellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
                remarkcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                sevenrwmntable.addCell(remarkcellval);

            }




//float[] excisepayable = {0.09f,0.91f};
            float[] eghtrwwidth = {0.12f,0.61f,0.10f,0.17f};
            PdfPTable eghtrwmntable=new PdfPTable(eghtrwwidth);

            PdfPTable eghtrw1table= new PdfPTable(1);
            PdfPCell assesscell= new PdfPCell(new Phrase(new Paragraph("ASSESSABLE VALUE(as per section 4)"  , FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD))));
            assesscell.setHorizontalAlignment(Element.ALIGN_LEFT);
            assesscell.setFixedHeight(33f);
            assesscell.setBorder(Rectangle.BOTTOM);
            eghtrw1table.addCell(assesscell );

            double dtotal = invoice.getTotalAmount();
            NumberFormat dtotalformatter = new DecimalFormat("#0.00");
            String stotal = dtotalformatter.format(dtotal);

            PdfPCell assesscellval = new PdfPCell(new Phrase(stotal, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            assesscellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            assesscellval.setBorder(Rectangle.BOTTOM);
            eghtrw1table.addCell(assesscellval );

            double ietaxpay = invoice.getExcise();
            String setaxpay = Double.toString(ietaxpay);

            double decesstax= invoice.getEducationCess();
            String secesstax = Double.toString(decesstax);

            double ishtax = invoice.getSecondaryHigherEducationCess();
            String sshtax = Double.toString(ishtax);

            PdfPCell rrateexcellval = new PdfPCell(new Phrase(new Paragraph("RATE OF EXCISE DUTY BED-"+ setaxpay+ "%EDU.CESS-"+ secesstax + "% S&H EDU.CESS-"+sshtax+"%", FontFactory.getFont(FontFactory.TIMES_ROMAN, 7,Font.BOLD))));
            rrateexcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
            rrateexcellval.setFixedHeight(40f);
            rrateexcellval.setBorder(Rectangle.NO_BORDER);
            eghtrw1table.addCell(rrateexcellval );

            PdfPCell debitcell= new PdfPCell(new Phrase(new Paragraph("DEBIT ENTRY" + Chunk.NEWLINE + "NO."  , FontFactory.getFont(FontFactory.TIMES_ROMAN,8,Font.BOLD))));
            debitcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            debitcell.setFixedHeight(20f);
            debitcell.setBorder(Rectangle.TOP);
            eghtrw1table.addCell(debitcell);

            PdfPCell debitcellval = new PdfPCell(new Phrase(invoice.getDebitEntryNo(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            debitcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            debitcellval.setBorder(Rectangle.BOTTOM);
            eghtrw1table.addCell(debitcellval );

            PdfPCell saletaxcell= new PdfPCell(new Phrase(new Paragraph("SALES TAX" + Chunk.NEWLINE + "FORM."  , FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD))));
            saletaxcell.setHorizontalAlignment(Element.ALIGN_LEFT);
//saletaxcell.setFixedHeight(40f);
//saletaxcell.setRowspan(2);
            saletaxcell.setBorder(Rectangle.NO_BORDER);
            eghtrw1table.addCell(saletaxcell );

            if(invoice.getCstOvatType().equals("CST") && invoice.getCstOvatTax()==4)
            {
                PdfPCell saletaxcellval = new PdfPCell(new Phrase("AGAINST FORM 'C'", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
                saletaxcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                saletaxcellval.setBorder(Rectangle.NO_BORDER);
                eghtrw1table.addCell(saletaxcellval );
                eghtrwmntable.addCell(eghtrw1table);
            }
            else
            {
                PdfPCell saletaxcellval = new PdfPCell(new Phrase("", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
                saletaxcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
                saletaxcellval.setBorder(Rectangle.NO_BORDER);
                eghtrw1table.addCell(saletaxcellval );
                eghtrwmntable.addCell(eghtrw1table);
            }

            PdfPTable chargestable= new PdfPTable(1);
            float[] chgwidth= {0.04f,0.10f,0.11f,0.22f,0.14f};
            PdfPTable chargestable1= new PdfPTable(chgwidth);

            PdfPCell chargecell = new PdfPCell(new Paragraph("OTHER CHARGES(Rs.)", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            chargecell.setFixedHeight(82f);
            chargecell.setBorder(Rectangle.RIGHT);
            chargecell.setHorizontalAlignment(Element.ALIGN_CENTER);
            chargecell.setRotation(90);
            chargestable1.addCell(chargecell);

            PdfPTable excisetable= new PdfPTable(1);

            PdfPCell expaycell= new PdfPCell(new Phrase(new Paragraph("EXCISE PAYABLE"  , FontFactory.getFont(FontFactory.TIMES_ROMAN,8,Font.BOLD))));
            expaycell.setHorizontalAlignment(Element.ALIGN_LEFT);
            expaycell.setFixedHeight(23.5f);
            expaycell.setBorder(Rectangle.RIGHT);
            excisetable.addCell(expaycell );

            PdfPCell expaycellval = new PdfPCell(new Phrase(setaxpay +"%", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            expaycellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            expaycellval.setBorder(Rectangle.BOTTOM);
            expaycellval.setBorderWidthRight(0.35f);
            excisetable.addCell(expaycellval );

            double iepay = invoice.getExciseTax();
            NumberFormat iepayformatter = new DecimalFormat("#0.00");
            String sepay = iepayformatter.format(iepay);

            PdfPCell cellval = new PdfPCell(new Phrase(sepay, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            cellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cellval.setBorder(Rectangle.BOTTOM);
            cellval.setBorderWidthRight(0.35f);
            excisetable.addCell(cellval );

            PdfPTable excisetable1= new PdfPTable(1);
            PdfPCell excseduty= new PdfPCell(new Phrase(new Paragraph("* EXCISE DUTY"  , FontFactory.getFont(FontFactory.TIMES_ROMAN,7))));
            excseduty.setHorizontalAlignment(Element.ALIGN_LEFT);
//excseduty.setFixedHeight(20f);
            excseduty.setBorder(Rectangle.BOTTOM);
            excisetable1.addCell(excseduty );

            PdfPCell excseduty1 = new PdfPCell(excisetable1);
            excseduty1.setHorizontalAlignment(Element.ALIGN_LEFT);
            excseduty1.setBorder(Rectangle.NO_BORDER);
            excisetable.addCell(excseduty1 );

            PdfPCell frightcell = new PdfPCell(new Phrase("FRIGHT", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            frightcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            frightcell.setBorderWidthTop(0.35f);
            frightcell.setBorder(Rectangle.RIGHT);
            excisetable.addCell(frightcell );

            double ifrieght = invoice.getFreight();
            NumberFormat ifrieghtformatter = new DecimalFormat("#0.00");
            String sfrieght = ifrieghtformatter.format(ifrieght);

            PdfPCell frightcellval = new PdfPCell(new Phrase(sfrieght, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            frightcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            frightcellval.setBorder(Rectangle.RIGHT);
            excisetable.addCell(frightcellval );

            PdfPCell cell2 = new PdfPCell(excisetable);
            cell2.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell2.setBorder(Rectangle.NO_BORDER);
            chargestable1.addCell(cell2 );

            PdfPTable ecesstable= new PdfPTable(1);

            PdfPCell ecesspaycell= new PdfPCell(new Phrase(new Paragraph("E.CESS PAYABLE"  , FontFactory.getFont(FontFactory.TIMES_ROMAN,8,Font.BOLD))));
            ecesspaycell.setHorizontalAlignment(Element.ALIGN_LEFT);
            ecesspaycell.setFixedHeight(23.5f);
            ecesspaycell.setBorder(Rectangle.RIGHT);
            ecesstable.addCell(ecesspaycell );

            PdfPCell ecesspaycellval = new PdfPCell(new Phrase(secesstax + "%", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            ecesspaycellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            ecesspaycellval.setBorder(Rectangle.BOTTOM);
            ecesspaycellval.setBorderWidthRight(0.20f);
            ecesstable.addCell(ecesspaycellval );

            double iecesspay = invoice.getEducationCessTax();
            NumberFormat iecesspayformatter = new DecimalFormat("#0.00");
            String secesspay = iecesspayformatter.format(iecesspay);

            PdfPCell cellval2 = new PdfPCell(new Phrase(secesspay, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            cellval2.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cellval2.setBorder(Rectangle.BOTTOM);
            cellval2.setBorderWidthRight(0.35f);
            ecesstable.addCell(cellval2 );

            PdfPCell excseduty2= new PdfPCell(new Phrase(new Paragraph("PAYABLE UNDER"  , FontFactory.getFont(FontFactory.TIMES_ROMAN,7))));
            excseduty2.setHorizontalAlignment(Element.ALIGN_LEFT);
//excseduty.setFixedHeight(20f);
            excseduty2.setBorder(Rectangle.NO_BORDER);
            ecesstable.addCell(excseduty2 );

            PdfPCell insurancecell = new PdfPCell(new Phrase("INSURANCE", FontFactory.getFont(FontFactory.TIMES_ROMAN,8,Font.BOLD)));
            insurancecell.setHorizontalAlignment(Element.ALIGN_LEFT);
            insurancecell.setBorder(Rectangle.RIGHT);
            insurancecell.setBorderWidthTop(0.35f);
            ecesstable.addCell(insurancecell );

            double iInsurance = invoice.getInsurance();
            NumberFormat iInsuranceformatter = new DecimalFormat("#0.00");
            String sInsurance = iInsuranceformatter.format(iInsurance);

            PdfPCell insurancecellval = new PdfPCell(new Phrase(sInsurance, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            insurancecellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            insurancecellval.setBorder(Rectangle.RIGHT);
            ecesstable.addCell(insurancecellval );

            PdfPCell cell3 = new PdfPCell(ecesstable);
            cell3.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell3.setBorder(Rectangle.NO_BORDER);
            chargestable1.addCell(cell3 );

            PdfPTable snhcesstable= new PdfPTable(2);

            PdfPTable snhcesstable2= new PdfPTable(2);

            PdfPCell snhcesscell1= new PdfPCell(new Phrase(new Paragraph("S & H. EDU CESS PAYABLE" , FontFactory.getFont(FontFactory.TIMES_ROMAN,7,Font.BOLD))));
            snhcesscell1.setHorizontalAlignment(Element.ALIGN_LEFT);
            snhcesscell1.setBorder(Rectangle.NO_BORDER);
            snhcesscell1.setFixedHeight(23.5f);
            snhcesstable2.addCell(snhcesscell1 );

            PdfPCell snhcesscellval1 = new PdfPCell(new Phrase(new Paragraph("AMOUNT ON WHICH SALES TAX PAYABLE" , FontFactory.getFont(FontFactory.TIMES_ROMAN, 7,Font.BOLD))));
            snhcesscellval1.setHorizontalAlignment(Element.ALIGN_LEFT);
            snhcesscellval1.setBorder(Rectangle.LEFT);
            snhcesscellval1.setBorderWidthRight(0.35f);
            snhcesscellval1.setRowspan(2);
            snhcesstable2.addCell(snhcesscellval1 );

            PdfPCell snhcesscellval2 = new PdfPCell(new Phrase(new Paragraph(sshtax + "%"  , FontFactory.getFont(FontFactory.TIMES_ROMAN,8))));
            snhcesscellval2.setHorizontalAlignment(Element.ALIGN_RIGHT);
            snhcesscellval2.setBorder(Rectangle.NO_BORDER);
//snhcesscellval2.setColspan(2);
            snhcesstable2.addCell(snhcesscellval2 );

            PdfPCell snhcesscell= new PdfPCell(snhcesstable2);
            snhcesscell.setHorizontalAlignment(Element.ALIGN_CENTER);
            snhcesscell.setFixedHeight(36f);
            snhcesscell.setColspan(2);
            snhcesscell.setBorder(Rectangle.BOTTOM);
            snhcesstable.addCell(snhcesscell );

            double ish = invoice.getSecondaryHigherEducationCessTax();
            NumberFormat dishformatter = new DecimalFormat("#0.00");
            String ssh = dishformatter.format(ish);

            PdfPCell snhcesscellval = new PdfPCell(new Phrase(ssh, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            snhcesscellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            snhcesscellval.setBorder(Rectangle.NO_BORDER);
            snhcesstable.addCell(snhcesscellval );

            double dtotalamount = invoice.getTotalAmount()+invoice.getExciseTax()+invoice.getEducationCessTax()+invoice.getSecondaryHigherEducationCessTax();
            NumberFormat dtotalamountformatter = new DecimalFormat("#0.00");
            String stotalamount = dtotalamountformatter.format(dtotalamount);

            PdfPCell cellval3 = new PdfPCell(new Phrase(stotalamount, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            cellval3.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cellval3.setBorderWidthBottom(0.35f);
            cellval3.setBorder(Rectangle.LEFT);
            snhcesstable.addCell(cellval3 );

            PdfPCell excseduty3= new PdfPCell(new Phrase(new Paragraph("RULE-A FOR CENTRAL EXCISE RULES"  , FontFactory.getFont(FontFactory.TIMES_ROMAN,7))));
            excseduty3.setHorizontalAlignment(Element.ALIGN_LEFT);
            excseduty3.setColspan(2);
//excseduty.setFixedHeight(20f);
            excseduty3.setBorder(Rectangle.TOP);
            snhcesstable.addCell(excseduty3 );

            PdfPCell othercell = new PdfPCell(new Phrase("OTHERS", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            othercell.setHorizontalAlignment(Element.ALIGN_LEFT);
            othercell.setBorder(Rectangle.TOP);
            othercell.setBorderWidthRight(0.35f);
            othercell.setColspan(2);
//insurancecell.setFixedHeight(13f);
            snhcesstable.addCell(othercell );

            double dother = invoice.getOthers();
            NumberFormat dotherformatter = new DecimalFormat("#0.00");
            String sother= dotherformatter.format(dother);

            PdfPCell othercellval = new PdfPCell(new Phrase(sother, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            othercellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            othercellval.setBorder(Rectangle.RIGHT);
            othercellval.setColspan(2);
            snhcesstable.addCell(othercellval );

            PdfPCell cell4 = new PdfPCell(snhcesstable);
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell4.setBorder(Rectangle.NO_BORDER);
            chargestable1.addCell(cell4 );


            PdfPTable csttable= new PdfPTable(1);

            if(invoice.getCstOvatType().equals("CST"))
            {
                PdfPCell cstcell= new PdfPCell(new Phrase(new Paragraph("CST PAYABLE"  , FontFactory.getFont(FontFactory.TIMES_ROMAN,8,Font.BOLD))));
                cstcell.setHorizontalAlignment(Element.ALIGN_LEFT);
                cstcell.setFixedHeight(24f);
//cstcell.setColspan(2);
                cstcell.setBorder(Rectangle.NO_BORDER);
                csttable.addCell(cstcell);
            }
            else
            {
                PdfPCell cstcell= new PdfPCell(new Phrase(new Paragraph("OVAT PAYABLE"  , FontFactory.getFont(FontFactory.TIMES_ROMAN,8,Font.BOLD))));
                cstcell.setHorizontalAlignment(Element.ALIGN_LEFT);
                cstcell.setFixedHeight(24f);
//cstcell.setColspan(2);
                cstcell.setBorder(Rectangle.NO_BORDER);
                csttable.addCell(cstcell );
            }

            double dcsttax = invoice.getCstOvat();
//NumberFormat dcsttaxformatter = new DecimalFormat("#0.00");
            String scsttax = Double.toString(dcsttax);

            PdfPCell cstcellval = new PdfPCell(new Phrase( scsttax + "%", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            cstcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cstcellval.setBorder(Rectangle.BOTTOM);
//cstcellval.setFixedHeight(7f);
            csttable.addCell(cstcellval );

            double dcst = invoice.getCstOvatTax();
            NumberFormat dcstformatter = new DecimalFormat("#0.00");
            String scst = dcstformatter.format(dcst);

            PdfPCell cellval7 = new PdfPCell(new Phrase(scst, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            cellval7.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cellval7.setBorder(Rectangle.LEFT);
            csttable.addCell(cellval7 );

            PdfPCell excseduty4= new PdfPCell(new Phrase(new Paragraph("-2002"  , FontFactory.getFont(FontFactory.TIMES_ROMAN,7))));
            excseduty4.setHorizontalAlignment(Element.ALIGN_LEFT);
            excseduty4.setColspan(2);
//excseduty.setFixedHeight(20f);
            excseduty4.setBorder(Rectangle.TOP);
            csttable.addCell(excseduty4 );

            PdfPCell entrytaxcell = new PdfPCell(new Phrase("ENTRY TAX", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            entrytaxcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            entrytaxcell.setBorder(Rectangle.TOP);
            entrytaxcell.setColspan(2);
//insurancecell.setFixedHeight(13f);
            csttable.addCell(entrytaxcell );

            double dentry = invoice.getEntry();
            NumberFormat dentryformatter = new DecimalFormat("#0.00");
            String sentry = dentryformatter.format(dentry);

            PdfPCell entrytaxval = new PdfPCell(new Phrase(sentry, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            entrytaxval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            entrytaxval.setBorder(Rectangle.NO_BORDER);
            entrytaxval.setColspan(2);
            csttable.addCell(entrytaxval );

            PdfPCell cell5 = new PdfPCell(csttable);
            cell5.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell5.setBorder(Rectangle.NO_BORDER);
            chargestable1.addCell(cell5 );

            PdfPCell firstchgcell = new PdfPCell(chargestable1);
            firstchgcell.setFixedHeight(88f);
            firstchgcell.setBorder(Rectangle.NO_BORDER);
            firstchgcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            chargestable.addCell(firstchgcell);

            float[] salecodewidth= {0.20f,0.43f};
            PdfPTable salecodetable1= new PdfPTable(salecodewidth);

            PdfPTable salecodetable2= new PdfPTable(1);

            PdfPCell datecell5 = new PdfPCell(new Phrase("DATE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            datecell5.setHorizontalAlignment(Element.ALIGN_LEFT);
            datecell5.setBorder(Rectangle.NO_BORDER);
            datecell5.setFixedHeight(19f);
            salecodetable2.addCell(datecell5);

            String sts = null,DebitEntryDatein = "";

            if(invoice.getDebitEntryDate()!=null)
            {
                sts = (invoice.getDebitEntryDate().toString()).substring(0,10);
                DebitEntryDatein = sts.substring(8,10)+"/"+sts.substring(5,7)+"/"+sts.substring(0,4);
            }

            PdfPCell datecell5val = new PdfPCell(new Phrase(DebitEntryDatein, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            datecell5val.setHorizontalAlignment(Element.ALIGN_RIGHT);
            datecell5val.setBorder(Rectangle.BOTTOM);
            salecodetable2.addCell(datecell5val);

            PdfPCell salecodecell = new PdfPCell(new Phrase("SALES TAX CODE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            salecodecell.setHorizontalAlignment(Element.ALIGN_LEFT);
            salecodecell.setBorder(Rectangle.BOTTOM);
            salecodecell.setFixedHeight(12f);
            salecodetable2.addCell(salecodecell);

            PdfPTable salecodetable3= new PdfPTable(4);

            PdfPCell saletaxcode1 = new PdfPCell(new Phrase("", FontFactory.getFont(FontFactory.TIMES_ROMAN, 7)));
            saletaxcode1.setHorizontalAlignment(Element.ALIGN_LEFT);
            saletaxcode1.setBorder(Rectangle.RIGHT);
            salecodetable3.addCell(saletaxcode1);

            PdfPCell saletaxcode2 = new PdfPCell(new Phrase("", FontFactory.getFont(FontFactory.TIMES_ROMAN, 7)));
            saletaxcode2.setHorizontalAlignment(Element.ALIGN_LEFT);
            saletaxcode2.setBorder(Rectangle.RIGHT);
            salecodetable3.addCell(saletaxcode2);

            PdfPCell saletaxcode3 = new PdfPCell(new Phrase("", FontFactory.getFont(FontFactory.TIMES_ROMAN, 7)));
            saletaxcode3.setHorizontalAlignment(Element.ALIGN_LEFT);
            saletaxcode3.setBorder(Rectangle.RIGHT);
            salecodetable3.addCell(saletaxcode3);

            PdfPCell saletaxcode4 = new PdfPCell(new Phrase("", FontFactory.getFont(FontFactory.TIMES_ROMAN, 7)));
            saletaxcode4.setHorizontalAlignment(Element.ALIGN_LEFT);
            saletaxcode4.setBorder(Rectangle.NO_BORDER);
            salecodetable3.addCell(saletaxcode4);

            PdfPCell salecodecell4col = new PdfPCell(salecodetable3);
            salecodecell4col.setHorizontalAlignment(Element.ALIGN_LEFT);
            salecodecell4col.setBorder(Rectangle.NO_BORDER);
            salecodetable2.addCell(salecodecell4col);

//salecodetable2.addCell(salecodetable3);

            PdfPCell datesalecell = new PdfPCell(salecodetable2);
            datesalecell.setHorizontalAlignment(Element.ALIGN_LEFT);
            datesalecell.setBorder(Rectangle.NO_BORDER);
            salecodetable1.addCell(datesalecell);


            PdfPTable rupeetable1= new PdfPTable(3);
            float[] rupeewidth= {0.08f,0.35f};
            PdfPTable rupeetable2= new PdfPTable(rupeewidth);
//Image rupeecell = Image.getInstance ("C:/Rupee.JPG");

            PdfPCell rupeecell = new PdfPCell(new Phrase("RUPEES", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
//rupeecell.setHorizontalAlignment(Element.ALIGN_LEFT);
//rupeecell.setFixedHeight(20f);
            rupeecell.setBorder(Rectangle.NO_BORDER);
            rupeetable2.addCell(rupeecell);

            PdfPCell rupeecellval = new PdfPCell(new Phrase(Convert(invoice.getNetPayable()), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            rupeecellval.setHorizontalAlignment(Element.ALIGN_LEFT);
            rupeecellval.setBorder(Rectangle.NO_BORDER);
            rupeetable2.addCell(rupeecellval);

            PdfPCell rupeecellval1 = new PdfPCell(rupeetable2);
            rupeecellval1.setHorizontalAlignment(Element.ALIGN_LEFT);
            rupeecellval1.setBorder(Rectangle.BOTTOM);
            rupeecellval1.setColspan(3);
            rupeecellval1.setFixedHeight(30f);
            rupeetable1.addCell(rupeecellval1);

            PdfPCell payrepcell = new PdfPCell(new Phrase("ADVANCE/PROGRESS PAYMENT RECEIPT NO. & DATE", FontFactory.getFont(FontFactory.TIMES_ROMAN,8,Font.BOLD)));
            payrepcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            payrepcell.setBorder(Rectangle.BOTTOM);
            payrepcell.setColspan(3);
            payrepcell.setFixedHeight(12f);
            rupeetable1.addCell(payrepcell);

            float[] reciptwidth= {0.15f,0.11f,0.17f};
            PdfPTable recipttable= new PdfPTable(reciptwidth);

            PdfPCell repcell = new PdfPCell(new Phrase("RECEIPT NO.", FontFactory.getFont(FontFactory.TIMES_ROMAN,8,Font.BOLD)));
            repcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            repcell.setBorder(Rectangle.RIGHT);
            repcell.setBorderWidthBottom(0.35f);
            recipttable.addCell(repcell);

            PdfPCell datecell6 = new PdfPCell(new Phrase("DATE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            datecell6.setHorizontalAlignment(Element.ALIGN_CENTER);
            datecell6.setBorder(Rectangle.RIGHT);
            recipttable.addCell(datecell6);

            PdfPCell amtcell = new PdfPCell(new Phrase("AMOUNT(Rs.)", FontFactory.getFont(FontFactory.TIMES_ROMAN,8,Font.BOLD)));
            amtcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            amtcell.setBorder(Rectangle.BOTTOM);
            recipttable.addCell(amtcell);

            if(invoice.getAmountRemained()!=0)
            {
                int irno = advance.getId();
                String srno = new Integer(irno).toString();
                PdfPCell repcellval = new PdfPCell(new Phrase(srno, FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
                repcellval.setHorizontalAlignment(Element.ALIGN_CENTER);
                repcellval.setBorder(Rectangle.RIGHT);
                recipttable.addCell(repcellval);
            }
            else
            {
                PdfPCell repcellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
                repcellval.setHorizontalAlignment(Element.ALIGN_CENTER);
                repcellval.setBorder(Rectangle.RIGHT);
                recipttable.addCell(repcellval);
            }

             if(invoice.getAmountRemained()!=0)
            {

                String sst,stt;
                sst = (advance.getCreateDate().toString()).substring(0,10);
                stt = sst.substring(8,10)+"/"+sst.substring(5,7)+"/"+sst.substring(0,4);

                PdfPCell datecell6val = new PdfPCell(new Phrase(stt, FontFactory.getFont(FontFactory.TIMES_ROMAN,8)));
                datecell6val.setHorizontalAlignment(Element.ALIGN_CENTER);
                datecell6val.setBorder(Rectangle.TOP);
                recipttable.addCell(datecell6val);
            }
            else
            {
                PdfPCell datecell6val = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN,8)));
                datecell6val.setHorizontalAlignment(Element.ALIGN_CENTER);
                datecell6val.setBorder(Rectangle.TOP);
                recipttable.addCell(datecell6val);

            }

             if(invoice.getAmountRemained()!=0)
            {
                double iadvanceamount = advance.getAmountReceived();
                NumberFormat iadvanceformatter = new DecimalFormat("#0.00");
                String sadvanceamount = iadvanceformatter.format(iadvanceamount);
                PdfPCell amtcellval = new PdfPCell(new Phrase(sadvanceamount, FontFactory.getFont(FontFactory.TIMES_ROMAN,8)));
                amtcellval.setHorizontalAlignment(Element.ALIGN_CENTER);
                amtcellval.setBorder(Rectangle.LEFT);
                recipttable.addCell(amtcellval);

            }
            else
            {
                PdfPCell amtcellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN,8)));
                amtcellval.setHorizontalAlignment(Element.ALIGN_CENTER);
                amtcellval.setBorder(Rectangle.LEFT);
                recipttable.addCell(amtcellval);
            }
            PdfPCell addcell1 = new PdfPCell(recipttable);
            addcell1.setHorizontalAlignment(Element.ALIGN_LEFT);
            addcell1.setBorder(Rectangle.NO_BORDER);
            addcell1.setColspan(3);
            rupeetable1.addCell(addcell1);

            salecodetable1.addCell(rupeetable1);

            PdfPCell celltest = new PdfPCell(salecodetable1);
            celltest.setHorizontalAlignment(Element.ALIGN_LEFT);
            celltest.setBorder(Rectangle.TOP);
            chargestable.addCell(celltest );

            PdfPCell celltest1 = new PdfPCell(chargestable);
            celltest1.setHorizontalAlignment(Element.ALIGN_LEFT);
            celltest1.setBorder(Rectangle.BOTTOM);
            eghtrwmntable.addCell(celltest1);

            PdfPTable totalamttable= new PdfPTable(1);

            PdfPCell totalamtcell = new PdfPCell(new Phrase("TOTAL AMOUNT", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            totalamtcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            totalamtcell.setBorder(Rectangle.BOTTOM);
            totalamtcell.setFixedHeight(34f);
            totalamttable.addCell(totalamtcell);

            PdfPCell othrchgcell = new PdfPCell(new Phrase("ADD OTHER CHARGES", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            othrchgcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            othrchgcell.setBorder(Rectangle.BOTTOM);
            othrchgcell.setFixedHeight(24f);
            totalamttable.addCell(othrchgcell);

            PdfPCell grdtotalcell = new PdfPCell(new Phrase(new Paragraph("" +Chunk.NEWLINE +"GRAND TOTAL", FontFactory.getFont(FontFactory.TIMES_ROMAN,9,Font.BOLD))));
            grdtotalcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            grdtotalcell.setBorder(Rectangle.BOTTOM);
            grdtotalcell.setFixedHeight(60f);
            totalamttable.addCell(grdtotalcell);

            PdfPCell lessadvcell = new PdfPCell(new Phrase( "" +Chunk.NEWLINE +"LESS ADVANCES", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            lessadvcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            lessadvcell.setBorder(Rectangle.NO_BORDER);
            lessadvcell.setFixedHeight(20f);
            totalamttable.addCell(lessadvcell);
            eghtrwmntable.addCell(totalamttable);

            PdfPTable totalamtvaltable= new PdfPTable(1);

            double itamount = invoice.getTotalAmount();
            NumberFormat itamountformatter = new DecimalFormat("#0.00");
            String stamount = itamountformatter.format(itamount);

            PdfPCell totalamtcellval = new PdfPCell(new Phrase(stamount, FontFactory.getFont(FontFactory.TIMES_ROMAN,9,Font.BOLD)));
            totalamtcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            totalamtcellval.setBorder(Rectangle.BOTTOM);
            totalamtcellval.setFixedHeight(34f);
            totalamtvaltable.addCell(totalamtcellval);

            double iocharges = invoice.getOtherCharges();
            NumberFormat ochargesformatter = new DecimalFormat("#0.00");
            String socharges = ochargesformatter.format(iocharges);

            PdfPCell othrchgcellval = new PdfPCell(new Phrase(socharges, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            othrchgcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            othrchgcellval.setBorder(Rectangle.BOTTOM);
            othrchgcellval.setFixedHeight(24f);
            totalamtvaltable.addCell(othrchgcellval);

            double igTotal = invoice.getGrandTotal();
            NumberFormat gTotalformatter = new DecimalFormat("#0.00");
            String sgTotal = gTotalformatter.format(igTotal);

            PdfPCell grdtotalcellval = new PdfPCell(new Phrase(new Paragraph( "" +Chunk.NEWLINE +"" +Chunk.NEWLINE + sgTotal, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD))));
            grdtotalcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            grdtotalcellval.setBorder(Rectangle.BOTTOM);
            grdtotalcellval.setFixedHeight(60f);
            totalamtvaltable.addCell(grdtotalcellval);

            if(invoice.getAmountDetect()!=0)
            {

                double ilAdvance = invoice.getAmountDetect();
                NumberFormat lAdvanceformatter = new DecimalFormat("#0.00");
                String slAdvance = lAdvanceformatter.format(ilAdvance);

                PdfPCell lessadvcellval = new PdfPCell(new Phrase( "" + Chunk.NEWLINE +slAdvance, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
                lessadvcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
                lessadvcellval.setBorder(Rectangle.NO_BORDER);
                lessadvcellval.setFixedHeight(20f);
                totalamtvaltable.addCell(lessadvcellval);
                eghtrwmntable.addCell(totalamtvaltable);
            }
            else
            {
                double ilAdvance = invoice.getAmountDetect();
                NumberFormat lAdvanceformatter = new DecimalFormat("#0.00");
                String slAdvance = lAdvanceformatter.format(ilAdvance);

                PdfPCell lessadvcellval = new PdfPCell(new Phrase( "" + Chunk.NEWLINE +"-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
                lessadvcellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
                lessadvcellval.setBorder(Rectangle.NO_BORDER);
                lessadvcellval.setFixedHeight(20f);
                totalamtvaltable.addCell(lessadvcellval);
                eghtrwmntable.addCell(totalamtvaltable);
            }

            float[] ninthrwwidth = {0.20f,0.53f,0.10f,0.17f};
            PdfPTable ninthrwmntable=new PdfPTable(ninthrwwidth);

            PdfPCell docuthghcell = new PdfPCell(new Phrase("DOCUMENT THROUGH", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            docuthghcell.setHorizontalAlignment(Element.ALIGN_LEFT);
            docuthghcell.setBorder(Rectangle.NO_BORDER);
//docuthghcell.setBorderWidthBottom(0.20f);
            docuthghcell.setBorderWidthLeft(0.35f);
//docuthghcell.setFixedHeight(20f);
            ninthrwmntable.addCell(docuthghcell);

            PdfPCell docuthghcellval = new PdfPCell(new Phrase(invoice.getDocumentsThrough(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            docuthghcellval.setHorizontalAlignment(Element.ALIGN_LEFT);
            docuthghcellval.setBorder(Rectangle.NO_BORDER);
//docuthghcellval.setBorderWidthBottom(0.10f);
            ninthrwmntable.addCell(docuthghcellval);

            double inetpay = (Double)invoice.getNetPayable();
            NumberFormat formatter1 = new DecimalFormat("#0.00");
            String snetpay1 = formatter1.format(inetpay);

            PdfPCell netpycell = new PdfPCell(new Phrase("NET PAYABLE", FontFactory.getFont(FontFactory.TIMES_ROMAN,9,Font.BOLD)));
            netpycell.setHorizontalAlignment(Element.ALIGN_CENTER);
            ninthrwmntable.addCell(netpycell);

            PdfPCell netpycellval = new PdfPCell(new Phrase(snetpay1, FontFactory.getFont(FontFactory.TIMES_ROMAN,9,Font.BOLD)));
            netpycellval.setHorizontalAlignment(Element.ALIGN_RIGHT);
            ninthrwmntable.addCell(netpycellval);

            float[] tenrwwidth = {0.18f,0.15f,0.14f,0.36f,0.17f};
            PdfPTable tenrwmntable=new PdfPTable(tenrwwidth);

            PdfPCell modefdiscell = new PdfPCell(new Phrase("MODE OF DISPATCH", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            modefdiscell.setHorizontalAlignment(Element.ALIGN_LEFT);
            modefdiscell.setFixedHeight(18f);
            tenrwmntable.addCell(modefdiscell);

            PdfPCell packagecell = new PdfPCell(new Phrase("NO. OF PACKAGE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            packagecell.setHorizontalAlignment(Element.ALIGN_CENTER);
            tenrwmntable.addCell(packagecell);

            PdfPCell vehiclecell = new PdfPCell(new Phrase("VECHICLE NO.", FontFactory.getFont(FontFactory.TIMES_ROMAN,9,Font.BOLD)));
            vehiclecell.setHorizontalAlignment(Element.ALIGN_CENTER);
            tenrwmntable.addCell(vehiclecell);

            PdfPCell rrgcncell = new PdfPCell(new Phrase("RR/GCN NO.", FontFactory.getFont(FontFactory.TIMES_ROMAN,9,Font.BOLD)));
            rrgcncell.setHorizontalAlignment(Element.ALIGN_CENTER);
            tenrwmntable.addCell(rrgcncell);

            PdfPCell datecell7 = new PdfPCell(new Phrase("DATE", FontFactory.getFont(FontFactory.TIMES_ROMAN,9,Font.BOLD)));
            datecell7.setHorizontalAlignment(Element.ALIGN_CENTER);
            tenrwmntable.addCell(datecell7);

            PdfPTable elvenrwmntable=new PdfPTable(tenrwwidth);

            PdfPCell modefdiscellval = new PdfPCell(new Phrase(invoice.getModeOfDispatch(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            modefdiscellval.setHorizontalAlignment(Element.ALIGN_CENTER);
            modefdiscellval.setFixedHeight(25f);
            elvenrwmntable.addCell(modefdiscellval);

            if(invoice.getNoOfPackages()!=null)
            {
                PdfPCell packagecellval = new PdfPCell(new Phrase(invoice.getNoOfPackages().toString(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            packagecellval.setHorizontalAlignment(Element.ALIGN_CENTER);
            elvenrwmntable.addCell(packagecellval);
            }
            else
            {
               PdfPCell packagecellval = new PdfPCell(new Phrase("-", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            packagecellval.setHorizontalAlignment(Element.ALIGN_CENTER);
            elvenrwmntable.addCell(packagecellval);

            }
            *//*PdfPCell packagecellval = new PdfPCell(new Phrase(invoice.getNoOfPackages().toString(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            packagecellval.setHorizontalAlignment(Element.ALIGN_CENTER);
            elvenrwmntable.addCell(packagecellval);
*//*
            PdfPCell vehiclecellval = new PdfPCell(new Phrase(invoice.getVehicleNo(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            vehiclecellval.setHorizontalAlignment(Element.ALIGN_CENTER);
            elvenrwmntable.addCell(vehiclecellval);

            PdfPCell rrgcncellval = new PdfPCell(new Phrase(invoice.getRrgcnNo(), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            rrgcncellval.setHorizontalAlignment(Element.ALIGN_CENTER);
            elvenrwmntable.addCell(rrgcncellval);

            String sst2,stt2;
            sst2 = (invoice.getOrder().getCreateDate().toString()).substring(0,10);
            stt2 = sst2.substring(8,10)+"/"+sst2.substring(5,7)+"/"+sst2.substring(0,4);

            PdfPCell datecell7val = new PdfPCell(new Phrase(stt2, FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            datecell7val.setHorizontalAlignment(Element.ALIGN_CENTER);
            elvenrwmntable.addCell(datecell7val);

            float[] twelvethrwwidth = {0.14f,0.02f,0.84f};
            PdfPTable twelvethrwmntable=new PdfPTable(twelvethrwwidth);

            PdfPCell excise = new PdfPCell(new Phrase("EXCISE:", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            excise.setHorizontalAlignment(Element.ALIGN_LEFT);
            excise.setFixedHeight(20f);
            twelvethrwmntable.addCell(excise);

            Image rupeeimage5 = Image.getInstance ("C:/images/Rupee.JPG");
            rupeeimage5.enableBorderSide(Rectangle.NO_BORDER);
            rupeeimage5.setBorder(Rectangle.NO_BORDER);
            twelvethrwmntable.addCell(rupeeimage5);

            PdfPCell excisecellval = new PdfPCell(new Phrase(Convert(invoice.getExciseTax()), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            excisecellval.setHorizontalAlignment(Element.ALIGN_LEFT);
            excisecellval.setBorder(Rectangle.RIGHT);
            twelvethrwmntable.addCell(excisecellval);

            float[] twelvethrwwidth1 = {0.14f,0.02f,0.84f};
            PdfPTable twelvethrwmntable1=new PdfPTable(twelvethrwwidth1);

            PdfPCell ecess = new PdfPCell(new Phrase("E.CESS :", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            ecess.setHorizontalAlignment(Element.ALIGN_LEFT);
            ecess.setFixedHeight(20f);
            twelvethrwmntable1.addCell(ecess);

            Image rupeeimage1 = Image.getInstance ("C:/images/Rupee.JPG");
            rupeeimage1.enableBorderSide(Rectangle.NO_BORDER);
            rupeeimage1.setBorder(Rectangle.NO_BORDER);
            twelvethrwmntable1.addCell(rupeeimage1);

            PdfPCell ecesscellval = new PdfPCell(new Phrase(Convert(invoice.getEducationCessTax()), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            ecesscellval.setHorizontalAlignment(Element.ALIGN_LEFT);
            twelvethrwmntable1.addCell(ecesscellval);

            float[] twelvethrwwidth2 = {0.14f,0.02f,0.84f};
            PdfPTable twelvethrwmntable2=new PdfPTable(twelvethrwwidth2);

            PdfPCell shedu = new PdfPCell(new Phrase("S & H EDU.CESS :", FontFactory.getFont(FontFactory.TIMES_ROMAN, 9,Font.BOLD)));
            shedu.setHorizontalAlignment(Element.ALIGN_LEFT);
            shedu.setFixedHeight(20f);
            twelvethrwmntable2.addCell(shedu);

            Image rupeeimag= Image.getInstance ("C:/images/Rupee.JPG");
            rupeeimag.enableBorderSide(Rectangle.NO_BORDER);
            rupeeimag.setBorder(Rectangle.NO_BORDER);
            twelvethrwmntable2.addCell(rupeeimag);

            PdfPCell sheducellval = new PdfPCell(new Phrase(Convert(invoice.getSecondaryHigherEducationCessTax()), FontFactory.getFont(FontFactory.TIMES_ROMAN, 9)));
            sheducellval.setHorizontalAlignment(Element.ALIGN_LEFT);
            twelvethrwmntable2.addCell(sheducellval);

            PdfPTable thrdthmntable=new PdfPTable(1);
            PdfPCell infocell3 = new PdfPCell(new Phrase("WE HEREBY CERTIFY THAT OUR REGISTRATION CERTIFICATE UNDER THE ORISSA"
                    + " SALES TAX ACT / IS IN FORCE ON THE" +
                    " DATE ON WHICH THE SALE OF THE GOODS SPECIFIED"+
                    " IN THIS BILL IS MADE BY US AND THAT THE TRANSACTION OF " +
                    " SALE COVERED BY THIS BILL HAS BEEN EFFECTED BY US IN THE REGULAR COURSE OF OUR BUSINESS ",
                    FontFactory.getFont(FontFactory.TIMES_ROMAN,8)));
            infocell3.setHorizontalAlignment(Element.ALIGN_LEFT);
            thrdthmntable.addCell(infocell3);


            PdfPTable fothtable=new PdfPTable(1);
            PdfPCell infocell4 = new PdfPCell(new Phrase("IF ANY EXEMPTION/REDUCTION OF TAX UNDER ORISSA/CENTRAL"
                    +" SALES TAX ACT IS CLAIMED BY" +
                    " YOU VALID DECLARATION (DUPLICATE IN CASE OF CENTRAL SALES TAX) MUST BE"+
                    " RECEIVED BY US WITHIN 15 DAYS FALING WHICH NO ADJUSTMENT WILL BE POSSIBLE"+
                    " IF THE ABOVE SALE IS ASSESSED FOR TAX AT A HIGHER RATE THE EXTRA AMOUNT IS"+
                    " PAYABLE BY YOU. ",
                    FontFactory.getFont(FontFactory.TIMES_ROMAN,8)));
            infocell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            fothtable.addCell(infocell4);

            PdfPTable fifthrwtable=new PdfPTable(1);
            PdfPCell infocell5 = new PdfPCell(new Phrase("CERTIFIED THAT THE PARTICULARS GIVEN ABOVE ARE"+
                    " TRUE AND CORRECT AND THE AMOUNT INDICATED PRESENTS THE PRICE"+
                    " ACTUALLY CHARGED AND THAT THERE IS NO FLOW OF"+
                    " ADDITIONAL CONSIDERATION DIRECTLY OR INDIRECTLY FROM THE BUYER." ,
                    FontFactory.getFont(FontFactory.TIMES_ROMAN,8)));
            infocell5.setHorizontalAlignment(Element.ALIGN_LEFT);
            fifthrwtable.addCell(infocell5);

            float[] lastwidth = {0.12f,0.37f,0.29f,0.22f};
            PdfPTable lastremntable=new PdfPTable(lastwidth);


            PdfPCell authencell = new PdfPCell(new Phrase("AUTHENTICATED", FontFactory.getFont(FontFactory.TIMES_ROMAN,7,Font.BOLD)));
            amtcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            amtcell.setBorder(Rectangle.BOTTOM);
            lastremntable.addCell(authencell);

            float[] widths5 = {0.11f,0.11f,0.11f};
            PdfPTable lastrowtable=new PdfPTable(widths5);
            PdfPCell saletax = new PdfPCell(new Phrase("SALES TAX REGN NO.", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            saletax.setHorizontalAlignment(Element.ALIGN_CENTER);
            saletax.setBorder(Rectangle.BOTTOM);
            saletax.setFixedHeight(16F);
            saletax.setColspan(2);
            lastrowtable.addCell(saletax);

            PdfPCell RANGE = new PdfPCell(new Phrase("RANGE ADDRESS" + Chunk.NEWLINE + "KANSBAHAL" + Chunk.NEWLINE + "PIN : 770034" , FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            RANGE.setHorizontalAlignment(Element.ALIGN_CENTER);
            RANGE.setBorder(Rectangle.LEFT);
//RANGE.setFixedHeight(16F);
            RANGE.setRowspan(3);
            lastrowtable.addCell(RANGE);

            PdfPCell orissa = new PdfPCell(new Phrase("ORISSA", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            orissa.setHorizontalAlignment(Element.ALIGN_CENTER);
            orissa.setBorder(Rectangle.BOTTOM);
            orissa.setFixedHeight(16F);
            lastrowtable.addCell(orissa);

            PdfPCell CENTRAL = new PdfPCell(new Phrase("CENTRAL", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            CENTRAL.setHorizontalAlignment(Element.ALIGN_CENTER);
            CENTRAL.setBorder(Rectangle.LEFT);
            CENTRAL.setFixedHeight(16F);
            lastrowtable.addCell(CENTRAL);

            PdfPCell TINNO = new PdfPCell(new Phrase("TINNO. ::" + Chunk.NEWLINE + "21912001675" + Chunk.NEWLINE, FontFactory.getFont(FontFactory.TIMES_ROMAN, 6)));
            TINNO.setHorizontalAlignment(Element.ALIGN_CENTER);
            TINNO.setBorder(Rectangle.TOP);
            TINNO.setFixedHeight(16F);
            lastrowtable.addCell(TINNO);

            PdfPCell TINNO1 = new PdfPCell(new Phrase("TINNO. ::" + Chunk.NEWLINE + "21912001675(C)" + Chunk.NEWLINE, FontFactory.getFont(FontFactory.TIMES_ROMAN, 6)));
            TINNO1.setHorizontalAlignment(Element.ALIGN_CENTER);
            TINNO1.setBorder(Rectangle.TOP);
            TINNO1.setBorderWidthLeft(0.20f);
            TINNO1.setFixedHeight(16F);
            lastrowtable.addCell(TINNO1);

            PdfPCell cExcise = new PdfPCell(new Phrase("CENTRAL EXCISE REGN. NO. :: AAAFW2808AXM001", FontFactory.getFont(FontFactory.TIMES_ROMAN, 7,Font.BOLD)));
            cExcise.setHorizontalAlignment(Element.ALIGN_CENTER);
            cExcise.setBorder(Rectangle.TOP);
            cExcise.setFixedHeight(16F);
            cExcise.setColspan(3);
            lastrowtable.addCell(cExcise);
            lastremntable.addCell(lastrowtable);

            float[] widths6 = {0.50f,0.50f};
            PdfPTable lastrowtable1=new PdfPTable(widths6);
            PdfPCell divadd = new PdfPCell(new Phrase("DIVISION ADDRESS" + Chunk.NEWLINE + "RAJASWA VIHAR" + Chunk.NEWLINE + "NAYA BAZAR,DIV-II" + Chunk.NEWLINE + "ROURKELA-769010" + Chunk.NEWLINE + Chunk.NEWLINE + Chunk.NEWLINE, FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            divadd.setHorizontalAlignment(Element.ALIGN_CENTER);
            divadd.setBorder(Rectangle.BOTTOM);
            divadd.setFixedHeight(48F);
            lastrowtable1.addCell(divadd);

            PdfPCell COMMRATE = new PdfPCell(new Phrase("COMMISSIONARATE" + Chunk.NEWLINE + "BHUBANESHWAR-II", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
            COMMRATE.setHorizontalAlignment(Element.ALIGN_CENTER);
            COMMRATE.setBorder(Rectangle.LEFT);
//COMMRATE.setFixedHeight(16F);
            lastrowtable1.addCell(COMMRATE);

            PdfPCell ECC = new PdfPCell(new Phrase("ECC NO. :: AAAFW2808AXM001", FontFactory.getFont(FontFactory.TIMES_ROMAN, 7,Font.BOLD)));
            ECC.setHorizontalAlignment(Element.ALIGN_CENTER);
            ECC.setBorder(Rectangle.TOP);
            ECC.setFixedHeight(16F);
            ECC.setColspan(2);
            lastrowtable1.addCell(ECC);
            lastremntable.addCell(lastrowtable1);

            PdfPCell EOE = new PdfPCell(new Phrase("E. & O.E." + Chunk.NEWLINE +" FOR WELDTECH ENGINEERS", FontFactory.getFont(FontFactory.TIMES_ROMAN,8,Font.BOLD)));
            EOE.setHorizontalAlignment(Element.ALIGN_CENTER);
            EOE.setBorder(Rectangle.BOX);
            lastremntable.addCell(EOE);

            PdfPTable doctitle=new PdfPTable(1);
            PdfPCell title = new PdfPCell(new Phrase("INVOICE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 14,Font.BOLD)));
            title.setHorizontalAlignment(Element.ALIGN_CENTER);
            title.setBorder(Rectangle.NO_BORDER);
            doctitle.addCell(title);

            PdfPCell title1 = new PdfPCell(new Phrase("(UNDER RULE 11 OF CENTRAL EXCISE RULES, 2002)", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            title1.setHorizontalAlignment(Element.ALIGN_CENTER);
            title1.setBorder(Rectangle.NO_BORDER);
            doctitle.addCell(title1);

//		PdfPCell title2=null;


            PdfPCell title24 = new PdfPCell(new Phrase(strcopy, FontFactory.getFont(FontFactory.TIMES_ROMAN, 8,Font.BOLD)));
            title24.setHorizontalAlignment(Element.ALIGN_RIGHT);
            title24.setBorder(Rectangle.NO_BORDER);
            doctitle.addCell(title24);

            document.add(doctitle);
            document.add(firstrowmntable);
            document.add(secrowmntable);
            document.add(thrdrowmntable);
            document.add(frthrwmntable);
            document.add(fifthrwmntable);
            document.add(sxthrwmntable);
            document.add(sevenrwmntable);
// document.add(excisepayabletable);
            document.add(eghtrwmntable);
            document.add(ninthrwmntable);
            document.add(tenrwmntable);
            document.add(elvenrwmntable);
            document.add(twelvethrwmntable);
            document.add(twelvethrwmntable1);
            document.add(twelvethrwmntable2);
            document.add(thrdthmntable);
            document.add(fothtable);
            document.add(fifthrwtable);
            document.add(lastremntable);

            PdfPTable docFooter=new PdfPTable(1);
            PdfPCell footer = new PdfPCell(new Phrase("INTEREST @ 22% PER ANNUM WILL BE CHARGED ON ALL BILLS NOT PAID BY DUE DATE", FontFactory.getFont(FontFactory.TIMES_ROMAN, 7,Font.BOLD)));
            footer.setHorizontalAlignment(Element.ALIGN_CENTER);
            footer.setBorder(Rectangle.NO_BORDER);
            docFooter.addCell(footer);
            document.add(docFooter);

            document.close();


        } catch (DocumentException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (Exception e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return filepath;*/
        return null;

    }
    String[] unitdo = { "", " One", " Two", " Three", " Four", " Five", " Six",
            " Seven", " Eight", " Nine", " Ten", " Eleven", " Twelve",
            " Thirteen", " Fourteen", " Fifteen", " Sixteen", " Seventeen",
            " Eighteen", " Nineteen" };
    String[] tens = { "", "Ten", " Twenty", " Thirty", " Forty", " Fifty",
            " Sixty", " Seventy", " Eighty", " Ninety" };
    String[] digit = { "", " Hundred", " Thousand", " Lakh", " Crore", " Arab" };
    int r;
    int numberCount(long num) {
        int cnt = 0;
        while (num > 0) {
            r = (int) (num % 10);
            cnt++;
            num = num / 10;
        }
        return cnt;
    }
    String twonum(long numq) {
        long numr, nq;
        String ltr = "";
        nq = numq / 10;
        numr = numq % 10;
        if (numq > 19) {
            ltr = ltr + tens[(int) nq] + unitdo[(int) numr];
        } else {
            ltr = ltr + unitdo[(int) numq];
        }
        return ltr;
    }
    String threenum(long numq) {
        long numr, nq;
        String ltr = "";
        nq = numq / 100;
        numr = numq % 100;
        if (numr == 0) {
            ltr = ltr + unitdo[(int) nq] + digit[1];
        } else {
            ltr = ltr + unitdo[(int) nq] + digit[1] + " and" + twonum(numr);
        }
        return ltr;
    }
    public String Convert(double number) throws Exception {
        int len;
        long q = 0, r = 0;
        String ltr = " ";
        String Str = "";
        long num = (long) number;
        if (num <= 0)
            System.out.println("Zero or Negative number not for conversion");
        while (num > 0) {
            len = numberCount(num);
            switch (len) {
                case 10:
                    q = num / 1000000000;
                    r = num % 1000000000;
                    ltr = twonum(q);
                    Str = Str + ltr + digit[5];
                    num = r;
                    break;
                case 9:
                case 8:
                    q = num / 10000000;
                    r = num % 10000000;
                    ltr = twonum(q);
                    Str = Str + ltr + digit[4];
                    num = r;
                    break;
                case 7:
                case 6:
                    q = num / 100000;
                    r = num % 100000;
                    ltr = twonum(q);
                    Str = Str + ltr + digit[3];
                    num = r;
                    break;
                case 5:
                case 4:
                    q = num / 1000;
                    r = num % 1000;
                    ltr = twonum(q);
                    Str = Str + ltr + digit[2];
                    num = r;
                    break;
                case 3:
                    if (len == 3)
                        r = num;
                    ltr = threenum(r);
                    Str = Str + ltr;
                    num = 0;
                    break;
                case 2:
                    ltr = twonum(num);
                    Str = Str + ltr;
                    num = 0;
                    break;
                case 1:
                    Str = Str + unitdo[(int) num];
                    num = 0;
                    break;
                default:
                    num = 0;
                    System.exit(1);
            }
        }
        return Str + " Only";
    }

    public List<ProductCategory> getProductCategorylst() {
        return (List<ProductCategory>) sessionProvider.get().createQuery("from ProductCategory").list();
    }

    public List<Invoice> findInvoiceByOrderDate(String sdate) {
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
        return (List<Invoice>)sessionProvider.get().createQuery("select i from Invoice i WHERE i.order.createDate LIKE '"+sdate+"%'").list();
    }
}
