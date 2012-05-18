package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 11, 2012
 * Time: 10:06:26 AM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "product_measurement_type")
public class ProductMeasurementType {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(name = "measurement_type",length = 10, nullable = false)
    private String measurementType;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMeasurementType() {
        return measurementType;
    }

    public void setMeasurementType(String measurementType) {
        this.measurementType = measurementType;
    }

    @Override
    public String toString() {
        return "ProductMeasurementType{" +
                "id=" + id +
                ", measurementType='" + measurementType + '\'' +
                '}';
    }
}
