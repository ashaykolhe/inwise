package com.inwise.pojo;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;


/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 11, 2012
 * Time: 10:23:01 AM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "invoice")
public class Invoice {
    @Id
    @Column(name = "invoice_number")
    private Integer invoiceNumber;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_date")
    private Date createDate;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    @Column(name = "challan_pass_number",length = 50)
    private String challanPassNumber;

    @Column(name = "loi_number",length = 50)
    private String loiNumber;

    @Column(name = "lr_number",length = 50)
    private String lrNumber;

    @Column(name = "transporter",length = 50)
    private String transporter;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "challan_date")
    private Date challanDate;

    @Column(name = "total_amount",length = 10,precision = 8)
    private Double totalAmount;

    @Column(name = "tax_charges",length = 10,precision = 8)
    private Double taxCharges;

    @Column(name = "grand_total",length = 10,precision = 8)
    private Double grandTotal;

    @Column(name = "net_payable",length = 10,precision = 8)
    private Double netPayable;

    @Column(name = "freight",length = 10,precision = 8)
    private Double freight;

    @Column(name = "vehicle_no",length = 50)
    private String vehicleNo;

    @Column(name = "deleted",length = 2)
    private Integer deleted;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "invoice_has_invoicedetail",
            joinColumns = { @JoinColumn(name = "invoice_id") }, inverseJoinColumns = { @JoinColumn(name = "invoice_detail_id") })
    private List<InvoiceDetail> invoiceDetail=new ArrayList<InvoiceDetail>();

    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "invoice_has_taxes",
            joinColumns = { @JoinColumn(name = "invoice_id") }, inverseJoinColumns = { @JoinColumn(name = "tax_dto_id") })
    private List<TaxDTO> taxes=new ArrayList<TaxDTO>();

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "due_date")
    private Date dueDate;

    @Column(name = "amount_in_words")
    private String amountInWords;

    @Column(name = "remark")
    private String remark;

    @Column(name = "amount_remained",length = 10,precision = 8)
    private Double amountRemained;

    @Column(name = "amount_received",length = 10,precision = 8)
    private Double amountReceived;

    @Column(name = "amount_detect",length = 10,precision = 8)
    private Double amountDetect;

    @Transient
    private Double dueQuantity;

    public Double getDueQuantity() {
        return dueQuantity;
    }

    public void setDueQuantity(Double dueQuantity) {
        this.dueQuantity = dueQuantity;
    }

    public Integer getInvoiceNumber() {
        return invoiceNumber;
    }

    public void setInvoiceNumber(Integer invoiceNumber) {
        this.invoiceNumber = invoiceNumber;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getChallanPassNumber() {
        return challanPassNumber;
    }

    public void setChallanPassNumber(String challanPassNumber) {
        this.challanPassNumber = challanPassNumber;
    }

    public String getLoiNumber() {
        return loiNumber;
    }

    public void setLoiNumber(String loiNumber) {
        this.loiNumber = loiNumber;
    }

    public String getLrNumber() {
        return lrNumber;
    }

    public void setLrNumber(String lrNumber) {
        this.lrNumber = lrNumber;
    }

    public String getTransporter() {
        return transporter;
    }

    public void setTransporter(String transporter) {
        this.transporter = transporter;
    }

    public Date getChallanDate() {
        return challanDate;
    }

    public void setChallanDate(Date challanDate) {
        this.challanDate = challanDate;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Double getTaxCharges() {
        return taxCharges;
    }

    public void setTaxCharges(Double taxCharges) {
        this.taxCharges = taxCharges;
    }

    public Double getGrandTotal() {
        return grandTotal;
    }

    public void setGrandTotal(Double grandTotal) {
        this.grandTotal = grandTotal;
    }

    public Double getNetPayable() {
        return netPayable;
    }

    public void setNetPayable(Double netPayable) {
        this.netPayable = netPayable;
    }

    public Double getFreight() {
        return freight;
    }

    public void setFreight(Double freight) {
        this.freight = freight;
    }

    public String getVehicleNo() {
        return vehicleNo;
    }

    public void setVehicleNo(String vehicleNo) {
        this.vehicleNo = vehicleNo;
    }

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

    public List<InvoiceDetail> getInvoiceDetail() {
        return invoiceDetail;
    }

    public void setInvoiceDetail(List<InvoiceDetail> invoiceDetail) {
        this.invoiceDetail = invoiceDetail;
    }

    public List<TaxDTO> getTaxes() {
        return taxes;
    }

    public void setTaxes(List<TaxDTO> taxes) {
        this.taxes = taxes;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getAmountInWords() {
        return amountInWords;
    }

    public void setAmountInWords(String amountInWords) {
        this.amountInWords = amountInWords;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Double getAmountRemained() {
        return amountRemained;
    }

    public void setAmountRemained(Double amountRemained) {
        this.amountRemained = amountRemained;
    }

    public Double getAmountReceived() {
        return amountReceived;
    }

    public void setAmountReceived(Double amountReceived) {
        this.amountReceived = amountReceived;
    }

    public Double getAmountDetect() {
        return amountDetect;
    }

    public void setAmountDetect(Double amountDetect) {
        this.amountDetect = amountDetect;
    }

    @Override
    public String toString() {
        return "Invoice{" +
                "invoiceNumber=" + invoiceNumber +
                ", createDate=" + createDate +
                ", customer=" + customer +
                ", order=" + order +
                ", challanPassNumber='" + challanPassNumber + '\'' +
                ", loiNumber='" + loiNumber + '\'' +
                ", lrNumber='" + lrNumber + '\'' +
                ", transporter='" + transporter + '\'' +
                ", challanDate=" + challanDate +
                ", totalAmount=" + totalAmount +
                ", taxCharges=" + taxCharges +
                ", grandTotal=" + grandTotal +
                ", netPayable=" + netPayable +
                ", freight=" + freight +
                ", vehicleNo='" + vehicleNo + '\'' +
                ", deleted=" + deleted +
                ", invoiceDetail=" + invoiceDetail +
                ", taxes=" + taxes +
                ", dueDate=" + dueDate +
                ", amountInWords='" + amountInWords + '\'' +
                ", remark='" + remark + '\'' +
                ", amountRemained=" + amountRemained +
                ", amountReceived=" + amountReceived +
                ", amountDetect=" + amountDetect +
                '}';
    }
}