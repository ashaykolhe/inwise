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
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(name = "invoice_number",unique = true,nullable = false)
    private Integer invoiceNumber;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_date")
    private Date createDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "issue_time")
    private Date issueTime;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "removal_time")
    private Date removalTime;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    @Column(name = "sales_rep_code",length = 50)
    private String salesRepCode;

    @Column(name = "total_amount",length = 10,precision = 8)
    private Double totalAmount;

    @Column(name = "excise",length = 10,precision = 8)
    private Double excise;

    @Column(name = "excise_tax",length = 10,precision = 8)
    private Double exciseTax;

    @Column(name = "education_cess",length = 10,precision = 8)
    private Double educationCess;

    @Column(name = "education_cess_tax",length = 10,precision = 8)
    private Double educationCessTax;

    @Column(name = "secondary_higher_education_cess",length = 10,precision = 8)
    private Double secondaryHigherEducationCess;

    @Column(name = "secondary_higher_education_cess_tax",length = 10,precision = 8)
    private Double secondaryHigherEducationCessTax;

    @Column(name = "cst_ovat",length = 10,precision = 8)
    private Double cstOvat;

    @Column(name = "cst_ovat_tax",length = 10,precision = 8)
    private Double cstOvatTax;

    @Column(name = "cst_ovat_type",length = 10,precision = 8)
    private String cstOvatType;

    @Column(name = "tax_charges",length = 10,precision = 8)
    private Double taxCharges;

    @Column(name = "grand_total",length = 10,precision = 8)
    private Double grandTotal;

    @Column(name = "net_payable",length = 10,precision = 8)
    private Double netPayable;

    @Column(name = "freight",length = 10,precision = 8)
    private Double freight;

    @Column(name = "insurance",length = 10,precision = 8)
    private Double insurance;

    @Column(name = "others",length = 10,precision = 8)
    private Double others;

    @Column(name = "entry",length = 10,precision = 8)
    private Double entry;

    @Column(name = "other_charges",length = 10,precision = 8)
    private Double otherCharges;

    @Column(name = "station_to",length = 50)
    private String stationto;

    @Column(name = "reg_br",length = 50)
    private String regBr;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "cont_note_date")
    private Date contNoteDate;

    @Column(name = "des_adv_no",length = 50)
    private String desAdvNo;

    @Column(name = "fgn_no",length = 50)
    private String fgnNo;

    @Column(name = "mode_of_dispatch",length = 50)
    private String modeOfDispatch;

    @Column(name = "vehicle_no",length = 50)
    private String vehicleNo;

    @Column(name = "no_of_packages",length = 10)
    private Integer noOfPackages;

    @Column(name = "rrgcn_no",length = 50)
    private String rrgcnNo;

    @Column(name = "debit_entry_no",length = 50)
    private String debitEntryNo;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "debit_entry_date")
    private Date debitEntryDate;

    @Column(name = "documents_throught")
    private String documentsThrough;

    @Column(name = "remark")
    private String remark;

    @Column(name = "in_entry_tax_given",length = 20)
    private Double inEntryTaxGiven;

    @Column(name = "deleted",length = 2)
    private Integer deleted;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "invoice_has_invoicedetail",
    joinColumns = { @JoinColumn(name = "invoice_id") }, inverseJoinColumns = { @JoinColumn(name = "invoice_detail_id") })
    private List<InvoiceDetail> invoiceDetail=new ArrayList<InvoiceDetail>();

   @Transient
    private Double dueQuantity;

    public Double getDueQuantity() {
        return dueQuantity;
    }

    public void setDueQuantity(Double dueQuantity) {
        this.dueQuantity = dueQuantity;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Date getIssueTime() {
        return issueTime;
    }

    public void setIssueTime(Date issueTime) {
        this.issueTime = issueTime;
    }

    public Date getRemovalTime() {
        return removalTime;
    }

    public void setRemovalTime(Date removalTime) {
        this.removalTime = removalTime;
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

    public String getSalesRepCode() {
        return salesRepCode;
    }

    public void setSalesRepCode(String salesRepCode) {
        this.salesRepCode = salesRepCode;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Double getExcise() {
        return excise;
    }

    public void setExcise(Double excise) {
        this.excise = excise;
    }

    public Double getExciseTax() {
        return exciseTax;
    }

    public void setExciseTax(Double exciseTax) {
        this.exciseTax = exciseTax;
    }

    public Double getEducationCess() {
        return educationCess;
    }

    public void setEducationCess(Double educationCess) {
        this.educationCess = educationCess;
    }

    public Double getEducationCessTax() {
        return educationCessTax;
    }

    public void setEducationCessTax(Double educationCessTax) {
        this.educationCessTax = educationCessTax;
    }

    public Double getSecondaryHigherEducationCess() {
        return secondaryHigherEducationCess;
    }

    public void setSecondaryHigherEducationCess(Double secondaryHigherEducationCess) {
        this.secondaryHigherEducationCess = secondaryHigherEducationCess;
    }

    public Double getSecondaryHigherEducationCessTax() {
        return secondaryHigherEducationCessTax;
    }

    public void setSecondaryHigherEducationCessTax(Double secondaryHigherEducationCessTax) {
        this.secondaryHigherEducationCessTax = secondaryHigherEducationCessTax;
    }

    public Double getCstOvat() {
        return cstOvat;
    }

    public void setCstOvat(Double cstOvat) {
        this.cstOvat = cstOvat;
    }

    public Double getCstOvatTax() {
        return cstOvatTax;
    }

    public void setCstOvatTax(Double cstOvatTax) {
        this.cstOvatTax = cstOvatTax;
    }

    public String getCstOvatType() {
        return cstOvatType;
    }

    public void setCstOvatType(String cstOvatType) {
        this.cstOvatType = cstOvatType;
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

    public Double getInsurance() {
        return insurance;
    }

    public void setInsurance(Double insurance) {
        this.insurance = insurance;
    }

    public Double getOthers() {
        return others;
    }

    public void setOthers(Double others) {
        this.others = others;
    }

    public Double getEntry() {
        return entry;
    }

    public void setEntry(Double entry) {
        this.entry = entry;
    }

    public Double getOtherCharges() {
        return otherCharges;
    }

    public void setOtherCharges(Double otherCharges) {
        this.otherCharges = otherCharges;
    }

    public String getStationto() {
        return stationto;
    }

    public void setStationto(String stationto) {
        this.stationto = stationto;
    }

    public String getRegBr() {
        return regBr;
    }

    public void setRegBr(String regBr) {
        this.regBr = regBr;
    }

    public Date getContNoteDate() {
        return contNoteDate;
    }

    public void setContNoteDate(Date contNoteDate) {
        this.contNoteDate = contNoteDate;
    }

    public String getDesAdvNo() {
        return desAdvNo;
    }

    public void setDesAdvNo(String desAdvNo) {
        this.desAdvNo = desAdvNo;
    }

    public String getFgnNo() {
        return fgnNo;
    }

    public void setFgnNo(String fgnNo) {
        this.fgnNo = fgnNo;
    }

    public String getModeOfDispatch() {
        return modeOfDispatch;
    }

    public void setModeOfDispatch(String modeOfDispatch) {
        this.modeOfDispatch = modeOfDispatch;
    }

    public String getVehicleNo() {
        return vehicleNo;
    }

    public void setVehicleNo(String vehicleNo) {
        this.vehicleNo = vehicleNo;
    }

    public Integer getNoOfPackages() {
        return noOfPackages;
    }

    public void setNoOfPackages(Integer noOfPackages) {
        this.noOfPackages = noOfPackages;
    }

    public String getRrgcnNo() {
        return rrgcnNo;
    }

    public void setRrgcnNo(String rrgcnNo) {
        this.rrgcnNo = rrgcnNo;
    }

    public String getDebitEntryNo() {
        return debitEntryNo;
    }

    public void setDebitEntryNo(String debitEntryNo) {
        this.debitEntryNo = debitEntryNo;
    }

    public Date getDebitEntryDate() {
        return debitEntryDate;
    }

    public void setDebitEntryDate(Date debitEntryDate) {
        this.debitEntryDate = debitEntryDate;
    }

    public String getDocumentsThrough() {
        return documentsThrough;
    }

    public void setDocumentsThrough(String documentsThrough) {
        this.documentsThrough = documentsThrough;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Double getInEntryTaxGiven() {
        return inEntryTaxGiven;
    }

    public void setInEntryTaxGiven(Double inEntryTaxGiven) {
        this.inEntryTaxGiven = inEntryTaxGiven;
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

    @Override
    public String toString() {
        return "Invoice{" +
                "id=" + id +
                ", invoiceNumber=" + invoiceNumber +
                ", createDate=" + createDate +
                ", issueTime=" + issueTime +
                ", removalTime=" + removalTime +
                ", customer=" + customer +
                ", order=" + order +
                ", salesRepCode='" + salesRepCode + '\'' +
                ", totalAmount=" + totalAmount +
                ", excise=" + excise +
                ", exciseTax=" + exciseTax +
                ", educationCess=" + educationCess +
                ", educationCessTax=" + educationCessTax +
                ", secondaryHigherEducationCess=" + secondaryHigherEducationCess +
                ", secondaryHigherEducationCessTax=" + secondaryHigherEducationCessTax +
                ", cstOvat=" + cstOvat +
                ", cstOvatTax=" + cstOvatTax +
                ", cstOvatType='" + cstOvatType + '\'' +
                ", taxCharges=" + taxCharges +
                ", grandTotal=" + grandTotal +
                ", netPayable=" + netPayable +
                ", freight=" + freight +
                ", insurance=" + insurance +
                ", others=" + others +
                ", entry=" + entry +
                ", otherCharges=" + otherCharges +
                ", stationto='" + stationto + '\'' +
                ", regBr='" + regBr + '\'' +
                ", contNoteDate=" + contNoteDate +
                ", desAdvNo='" + desAdvNo + '\'' +
                ", fgnNo='" + fgnNo + '\'' +
                ", modeOfDispatch='" + modeOfDispatch + '\'' +
                ", vehicleNo='" + vehicleNo + '\'' +
                ", noOfPackages=" + noOfPackages +
                ", rrgcnNo='" + rrgcnNo + '\'' +
                ", debitEntryNo='" + debitEntryNo + '\'' +
                ", debitEntryDate=" + debitEntryDate +
                ", documentsThrough='" + documentsThrough + '\'' +
                ", remark='" + remark + '\'' +
                ", inEntryTaxGiven=" + inEntryTaxGiven +
                ", deleted=" + deleted +
                ", invoiceDetail=" + invoiceDetail +
                '}';
    }
}
