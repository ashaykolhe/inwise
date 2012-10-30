package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 26, 2012
 * Time: 10:30:51 AM
 * To change this template use File | Settings | File Templates.
 */@Entity
@Table(name = "proposal_detail")
public class ProposalDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @Column(name = "quantity",length = 10)
    private Double quantity;

    @Column(name = "cost",length = 10)
    private Double cost;
    @Column(name = "requote_no",length = 5)
    private Integer requoteno;


    @Transient
    private Double amount;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public Integer getRequoteno() {
        return requoteno;
    }

    public void setRequoteno(Integer requoteno) {
        this.requoteno = requoteno;
    }

    public Double getAmount() {

        return (cost!=null && quantity!=null)? cost*quantity:0.0;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    @Override
    public String toString() {
        return "ProposalDetail{" +
                "id=" + id +
                ", product=" + product +
                ", quantity=" + quantity +
                ", cost=" + cost +
                ", requoteno=" + requoteno +
                '}';
    }
}
