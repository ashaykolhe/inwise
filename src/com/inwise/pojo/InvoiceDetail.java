package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 11, 2012
 * Time: 1:31:38 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "invoice_detail")
public class InvoiceDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @Column(name = "material",length = 10)
    private String material;

    @Column(name = "chapter_id",length = 20)
    private String chapterId;

    @Column(name = "dispatched",length = 10,precision = 8)
    private double dispatched;

    @Column(name = "dispatching",length = 10,precision = 8)
    private double dispatching;

    @Column(name = "product_cost",length = 10,precision = 8)
    private double productCost;

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

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getChapterId() {
        return chapterId;
    }

    public void setChapterId(String chapterId) {
        this.chapterId = chapterId;
    }

    public double getDispatched() {
        return dispatched;
    }

    public void setDispatched(double dispatched) {
        this.dispatched = dispatched;
    }

    public double getDispatching() {
        return dispatching;
    }

    public void setDispatching(double dispatching) {
        this.dispatching = dispatching;
    }

    public double getProductCost() {
        return productCost;
    }

    public void setProductCost(double productCost) {
        this.productCost = productCost;
    }

    @Override
    public String toString() {
        return "InvoiceDetail{" +
                "id=" + id +
                ", product=" + product +
                ", material='" + material + '\'' +
                ", chapterId='" + chapterId + '\'' +
                ", dispatched=" + dispatched +
                ", dispatching=" + dispatching +
                ", productCost=" + productCost +
                '}';
    }
}
