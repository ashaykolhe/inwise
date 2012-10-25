package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 11, 2012
 * Time: 11:51:13 AM
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name = "tax")
public class Tax {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(name = "name",length = 100)
    private String name;

    @Column(name = "tax_percentage",length = 10,precision = 8)    
    private Double taxPercentage;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public Double getTaxPercentage() {
        return taxPercentage;
    }

    public void setTaxPercentage(Double taxPercentage) {
        this.taxPercentage = taxPercentage;
    }

    @Override
    public String toString() {
        return "Tax{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", taxPercentage=" + taxPercentage +
                '}';
    }
}
