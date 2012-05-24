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

    @OneToMany(cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    @JoinTable(name = "payment_has_paymentdetail",
    joinColumns = { @JoinColumn(name = "payment_id") }, inverseJoinColumns = { @JoinColumn(name = "payment_detail_id") })
    private List<PaymentDetail> paymentDetail=new ArrayList<PaymentDetail>();

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

    public List<PaymentDetail> getPaymentDetail() {
        return paymentDetail;
    }

    public void setPaymentDetail(List<PaymentDetail> paymentDetail) {
        this.paymentDetail = paymentDetail;
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
                ", paymentDetail=" + paymentDetail +
                '}';
    }
}
