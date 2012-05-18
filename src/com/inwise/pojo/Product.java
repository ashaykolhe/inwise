package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: May 10, 2012
 * Time: 12:27:05 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "product")
public class Product {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    @Column(name = "product_name",length = 50,nullable = false)
    private String productName;
    
    @Column(name = "product_cost",length = 10,precision = 8,nullable = false)
    private Double productCost;

    @ManyToOne
    @JoinColumn(name = "product_measurement_type_id")
    private ProductMeasurementType productMeasurementType;

    @Column(name = "deleted")
    private Integer deleted;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Double getProductCost() {
        return productCost;
    }

    public void setProductCost(Double productCost) {
        this.productCost = productCost;
    }

    public ProductMeasurementType getProductMeasurementType() {
        return productMeasurementType;
    }

    public void setProductMeasurementType(ProductMeasurementType productMeasurementType) {
        this.productMeasurementType = productMeasurementType;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", productName='" + productName + '\'' +
                ", productCost=" + productCost +
                ", productMeasurementType=" + productMeasurementType +
                ", deleted=" + deleted +
                '}';
    }
}
