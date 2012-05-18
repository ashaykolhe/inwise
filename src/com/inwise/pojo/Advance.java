package com.inwise.pojo;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: May 10, 2012
 * Time: 12:34:45 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "advance")
public class Advance {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    @Column(name = "receipt_no",length = 20,nullable = false)
    private String receiptNo;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "date")
    private Date create_date;
    
    @Column(name = "amount_received",length = 10,precision = 8,nullable = false)
    private Double amountReceived;

    @Column(name = "amount_remained",length = 10,precision = 8,nullable = false)
    private Double amountRemained;

    @Column(name = "payment_mode",length = 10)
    private String paymentMode;
    
    @Column(name = "cheque_or_dd_no",length = 20)
    private String chequeOrDDNo;
    
    @Column(name = "deleted")
    private Integer deleted;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getReceiptNo() {
        return receiptNo;
    }

    public void setReceiptNo(String receiptNo) {
        this.receiptNo = receiptNo;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public Double getAmountReceived() {
        return amountReceived;
    }

    public void setAmountReceived(Double amountReceived) {
        this.amountReceived = amountReceived;
    }

    public Double getAmountRemained() {
        return amountRemained;
    }

    public void setAmountRemained(Double amountRemained) {
        this.amountRemained = amountRemained;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public String getChequeOrDDNo() {
        return chequeOrDDNo;
    }

    public void setChequeOrDDNo(String chequeOrDDNo) {
        this.chequeOrDDNo = chequeOrDDNo;
    }

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    @Override
    public String toString() {
        return "Advance{" +
                "id=" + id +
                ", receiptNo='" + receiptNo + '\'' +
                ", create_date=" + create_date +
                ", amountReceived=" + amountReceived +
                ", amountRemained=" + amountRemained +
                ", paymentMode='" + paymentMode + '\'' +
                ", chequeOrDDNo='" + chequeOrDDNo + '\'' +
                ", deleted=" + deleted +
                ", order=" + order +
                '}';
    }
}
