package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: May 10, 2012
 * Time: 1:02:39 PM
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name = "address_type")
public class AddressType
{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(name ="type",length = 10)
    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "AddressType{" +
                "id=" + id +
                ", type='" + type + '\'' +
                '}';
    }
}
