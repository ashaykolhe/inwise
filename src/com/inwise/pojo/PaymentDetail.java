package com.inwise.pojo;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 24, 2012
 * Time: 3:43:50 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "payment_detail")
public class PaymentDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "received_date",length = 20)
    private Date receivedDate;

    @Column(name = "received_amount",length = 10,precision = 8)
    private Double receivedAmount;

    @ManyToOne
    @JoinColumn(name = "payment_mode")
    private PaymentMode paymentMode;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "update_date",length = 20)
    private Date updateDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    @Override
    public String toString() {
        return "PaymentDetail{" +
                "id=" + id +
                ", receivedDate=" + receivedDate +
                ", receivedAmount=" + receivedAmount +
                ", paymentMode=" + paymentMode +
                ", user=" + user +
                ", updateDate=" + updateDate +
                '}';
    }
}
