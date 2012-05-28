package com.inwise.pojo;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 24, 2012
 * Time: 3:35:59 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "payment")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "invoice_id")
    private Invoice invoice;

    @Column(name = "transaction_status",length = 10)
    private String transactionStatus;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_date",length = 20)
    private Date createDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "update_date",length = 20)
    private Date updateDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "received_date",length = 20)
    private Date receivedDate;

    @Column(name = "received_amount",length = 10,precision = 8)
    private Double receivedAmount;

    @ManyToOne
    @JoinColumn(name = "payment_mode")
    private PaymentMode paymentMode;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public String getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(String transactionStatus) {
        this.transactionStatus = transactionStatus;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Date getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(Date receivedDate) {
        this.receivedDate = receivedDate;
    }

    public Double getReceivedAmount() {
        return receivedAmount;
    }

    public void setReceivedAmount(Double receivedAmount) {
        this.receivedAmount = receivedAmount;
    }

    public PaymentMode getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(PaymentMode paymentMode) {
        this.paymentMode = paymentMode;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "id=" + id +
                ", invoice=" + invoice +
                ", transactionStatus='" + transactionStatus + '\'' +
                ", user=" + user +
                ", createDate=" + createDate +
                ", updateDate=" + updateDate +
                ", receivedDate=" + receivedDate +
                ", receivedAmount=" + receivedAmount +
                ", paymentMode=" + paymentMode +
                '}';
    }
}
