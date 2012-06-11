package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 22, 2012
 * Time: 12:27:35 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "payment_mode")
public class PaymentMode {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(name = "payment_mode",length = 10)
    private String mode;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    @Override
    public String toString() {
        return "PaymentMode{" +
                "id=" + id +
                ", mode='" + mode + '\'' +
                '}';
    }
}
