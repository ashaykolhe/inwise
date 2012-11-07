package com.inwise.pojo;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Nov 6, 2012
 * Time: 10:58:09 AM
 * To change this template use File | Settings | File Templates.
 */
public class ProformaInvoice {

     @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;
     @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_date")
    private Date createDate;
     @Column(name = "amount")
    private Double amount;

    @Column(name = "percentage")
    private Double percentage;

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getPercentage() {
        return percentage;
    }

    public void setPercentage(Double percentage) {
        this.percentage = percentage;
    }

    @Override
    public String toString() {
        return "ProformaInvoice{" +
                "id=" + id +
                ", customer=" + customer +
                ", order=" + order +
                ", createDate=" + createDate +
                ", amount=" + amount +
                ", percentage=" + percentage +
                '}';
    }
}
