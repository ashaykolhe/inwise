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

    @Column(name = "drawing_no",length = 20)
    private String drawingNo;

    @ManyToOne
    @JoinColumn(name = "product_category_id")
    private ProductCategory productCategory;

    @Column(name = "csh_no",length = 20)
    private String cshNo;

    @Column(name = "dispatched",length = 10,precision = 8)
    private double dispatched;

    @Column(name = "dispatching",length = 10,precision = 8)
    private double dispatching;

    @Column(name = "product_cost",length = 10,precision = 8)
    private double productCost;

    @Transient
    private double dueQuantity;

    public double getDueQuantity() {
        return dueQuantity;
    }

    public void setDueQuantity(double dueQuantity) {
        this.dueQuantity = dueQuantity;
    }

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

    public String getDrawingNo() {
        return drawingNo;
    }

    public void setDrawingNo(String drawingNo) {
        this.drawingNo = drawingNo;
    }

    public ProductCategory getProductCategory() {
        return productCategory;
    }

    public void setProductCategory(ProductCategory productCategory) {
        this.productCategory = productCategory;
    }

    public String getCshNo() {
        return cshNo;
    }

    public void setCshNo(String cshNo) {
        this.cshNo = cshNo;
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
                ", drawingNo='" + drawingNo + '\'' +
                ", productCategory=" + productCategory +
                ", cshNo='" + cshNo + '\'' +
                ", dispatched=" + dispatched +
                ", dispatching=" + dispatching +
                ", productCost=" + productCost +
                '}';
    }
}
