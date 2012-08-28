package com.inwise.pojo;

import javax.persistence.Entity;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by IntelliJ IDEA.
 * User: Milind
 * Date: Jun 29, 2012
 * Time: 3:47:04 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "invoice_number")
public class InvoiceNumber {
    @Id
    @Column(name = "id")
    private Integer id;
    @Column(name = "invoice_number")
   private Integer value;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "InvoiceNumber{" +
                "id=" + id +
                ", value=" + value +
                '}';
    }
}
