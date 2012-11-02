package com.inwise.pojo;

import javax.persistence.*;
import java.util.List;
import java.util.ArrayList;
import java.io.File;

/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: Jul 3, 2012
 * Time: 2:40:11 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "companyinfo")
public class CompanyInfo
{
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int compid;
    @Column(name = "comp_name",length = 50)
    private String compName;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "company_has_address",
    joinColumns = { @JoinColumn(name = "company_id") }, inverseJoinColumns = { @JoinColumn(name = "address_id") })
    private List<Address> address=new ArrayList<Address>();
    @Column(name = "comp_phone",length = 25)
    private String compPhone;
    @Column(name = "comp_email",length = 25)
    private String compEmail;
    @Column(name = "comp_fax",length = 25)
    private String compFax;
    @Column(name = "comp_website",length = 25)
    private String compWebsite;
     @Column(name = "work_phone",length = 25)
    private String workPhone;
    @Column(name = "work_email",length = 25)
    private String workEmail;
    @Column(name = "work_fax",length = 25)
    private String workFax;
    @Column(name = "work_website",length = 25)
    private String workWebsite;
    @Column(name = "comp_tin",length = 25)
    private String compTin;
    @Column(name = "comp_pan",length = 25)
    private String compPan;
    @Column(name = "comp_excise",length = 25)
    private String compExcise;
    @Column(name = "comp_ecc",length = 25)
    private String compEcc;
    @Column(name = "sales_tax",length = 25)
    private String salesTax;
    @Column(name = "cst_no",length = 25)
    private String cstNo;
    @Column(name = "service_tax",length = 25)
    private String serviceTax;
    @Column(name = "range_addr",length = 25)
    private String rangeAddress;
    @Column(name = "division_addr",length = 25)
    private String divisionAddress;
    @Column(name = "commissionerate",length = 25)
    private String commissionerate;
    @Column(name = "deleted")
    private int deleted;

    @Lob  
    @Column(name = "compLogo")
   private byte[] compLogo;
    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }

    public int getCompid() {
        return compid;
    }

    public void setCompid(int compid) {
        this.compid = compid;
    }

    public String getCompName() {
        return compName;
    }

    public void setCompName(String compName) {
        this.compName = compName;
    }

  
    public String getCompPhone() {
        return compPhone;
    }

    public void setCompPhone(String compPhone) {
        this.compPhone = compPhone;
    }

    public String getCompEmail() {
        return compEmail;
    }

    public void setCompEmail(String compEmail) {
        this.compEmail = compEmail;
    }

    public String getCompFax() {
        return compFax;
    }

    public void setCompFax(String compFax) {
        this.compFax = compFax;
    }

    public String getCompTin() {
        return compTin;
    }

    public void setCompTin(String compTin) {
        this.compTin = compTin;
    }

    public String getCompPan() {
        return compPan;
    }

    public void setCompPan(String compPan) {
        this.compPan = compPan;
    }

    public String getCompExcise() {
        return compExcise;
    }

    public void setCompExcise(String compExcise) {
        this.compExcise = compExcise;
    }

    public String getCompEcc() {
        return compEcc;
    }

    public void setCompEcc(String compEcc) {
        this.compEcc = compEcc;
    }

    public String getCompWebsite() {
        return compWebsite;
    }

    public void setCompWebsite(String compWebsite) {
        this.compWebsite = compWebsite;
    }

    public String getWorkPhone() {
        return workPhone;
    }

    public void setWorkPhone(String workPhone) {
        this.workPhone = workPhone;
    }

    public String getWorkEmail() {
        return workEmail;
    }

    public void setWorkEmail(String workEmail) {
        this.workEmail = workEmail;
    }

    public String getWorkFax() {
        return workFax;
    }

    public void setWorkFax(String workFax) {
        this.workFax = workFax;
    }

    public String getWorkWebsite() {
        return workWebsite;
    }

    public void setWorkWebsite(String workWebsite) {
        this.workWebsite = workWebsite;
    }

    public String getSalesTax() {
        return salesTax;
    }

    public void setSalesTax(String salesTax) {
        this.salesTax = salesTax;
    }

    public String getCstNo() {
        return cstNo;
    }

    public void setCstNo(String cstNo) {
        this.cstNo = cstNo;
    }

    public String getServiceTax() {
        return serviceTax;
    }

    public void setServiceTax(String serviceTax) {
        this.serviceTax = serviceTax;
    }

    public String getRangeAddress() {
        return rangeAddress;
    }

    public void setRangeAddress(String rangeAddress) {
        this.rangeAddress = rangeAddress;
    }

    public String getDivisionAddress() {
        return divisionAddress;
    }

    public void setDivisionAddress(String divisionAddress) {
        this.divisionAddress = divisionAddress;
    }

    public String getCommissionerate() {
        return commissionerate;
    }

    public void setCommissionerate(String commissionerate) {
        this.commissionerate = commissionerate;
    }

    public List<Address> getAddress() {
        return address;
    }

    public void setAddress(List<Address> address) {
        this.address = address;
    }

    public byte[] getCompLogo() {
        return compLogo;
    }

    public void setCompLogo(byte[] compLogo) {
        this.compLogo = compLogo;
    }

    @Override
    public String toString() {
        return "CompanyInfo{" +
                "compid=" + compid +
                ", compName='" + compName + '\'' +
                ", compLogo='" + compLogo + '\'' +
                ", address=" + address +
                ", compPhone='" + compPhone + '\'' +
                ", compEmail='" + compEmail + '\'' +
                ", compFax='" + compFax + '\'' +
                ", compWebsite='" + compWebsite + '\'' +
                ", workPhone='" + workPhone + '\'' +
                ", workEmail='" + workEmail + '\'' +
                ", workFax='" + workFax + '\'' +
                ", workWebsite='" + workWebsite + '\'' +
                ", compTin='" + compTin + '\'' +
                ", compPan='" + compPan + '\'' +
                ", compExcise='" + compExcise + '\'' +
                ", compEcc='" + compEcc + '\'' +
                ", salesTax='" + salesTax + '\'' +
                ", cstNo='" + cstNo + '\'' +
                ", serviceTax='" + serviceTax + '\'' +
                ", rangeAddress='" + rangeAddress + '\'' +
                ", divisionAddress='" + divisionAddress + '\'' +
                ", commissionerate='" + commissionerate + '\'' +
                ", deleted=" + deleted +
                '}';
    }
}
