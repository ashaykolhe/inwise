package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: Nov 1, 2012
 * Time: 11:11:37 AM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "invoiced_tax")
public class TaxDTO {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(name = "tax_name",length = 20)
    private String taxName;

    @Column(name = "previous_tax_percent",length = 10,precision = 8)
    private Double previousTaxPercent;

    @Column(name = "applicable_on",length = 20)
    private String applicableOn;

    @Column(name = "tax_amount",length = 10,precision = 8)
    private Double taxAmount;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTaxName() {
        return taxName;
    }

    public void setTaxName(String taxName) {
        this.taxName = taxName;
    }

    public Double getPreviousTaxPercent() {
        return previousTaxPercent;
    }

    public void setPreviousTaxPercent(Double previousTaxPercent) {
        this.previousTaxPercent = previousTaxPercent;
    }

    public Double getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(Double taxAmount) {
        this.taxAmount = taxAmount;
    }

    public String getApplicableOn() {
        return applicableOn;
    }

    public void setApplicableOn(String applicableOn) {
        this.applicableOn = applicableOn;
    }

    @Override
    public String toString() {
        return "TaxDTO{" +
                "id=" + id +
                ", taxName='" + taxName + '\'' +
                ", previousTaxPercent=" + previousTaxPercent +
                ", applicableOn='" + applicableOn + '\'' +
                ", taxAmount=" + taxAmount +
                '}';
    }
}
