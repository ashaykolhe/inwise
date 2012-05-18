package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 11, 2012
 * Time: 9:59:17 AM
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name = "order_detail")
public class OrderDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @Column(name = "ordered_quantity",nullable = false,precision = 8)
    private Double orderedQuantity;

    @Column(name = "amendment_cost",length = 10)
    private Double amendmentCost;

    @Column(name = "amendment_quantity",length = 10)
    private Double amendmentQuantity;

    @Column(name = "dispatched_quantity",length = 10)
    private Double dispatchedQuantity;

    @Column(name = "remaining_quantity",length = 10)
    private Double remainingQuantity;

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

    public Double getOrderedQuantity() {
        return orderedQuantity;
    }

    public void setOrderedQuantity(Double orderedQuantity) {
        this.orderedQuantity = orderedQuantity;
    }

    public Double getAmendmentCost() {
        return amendmentCost;
    }

    public void setAmendmentCost(Double amendmentCost) {
        this.amendmentCost = amendmentCost;
    }

    public Double getAmendmentQuantity() {
        return amendmentQuantity;
    }

    public void setAmendmentQuantity(Double amendmentQuantity) {
        this.amendmentQuantity = amendmentQuantity;
    }

    public Double getDispatchedQuantity() {
        return dispatchedQuantity;
    }

    public void setDispatchedQuantity(Double dispatchedQuantity) {
        this.dispatchedQuantity = dispatchedQuantity;
    }

    public Double getRemainingQuantity() {
        return remainingQuantity;
    }

    public void setRemainingQuantity(Double remainingQuantity) {
        this.remainingQuantity = remainingQuantity;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "id=" + id +
                ", product=" + product +
                ", orderedQuantity=" + orderedQuantity +
                ", amendmentCost=" + amendmentCost +
                ", amendmentQuantity=" + amendmentQuantity +
                ", dispatchedQuantity=" + dispatchedQuantity +
                ", remainingQuantity=" + remainingQuantity +
                '}';
    }
}
