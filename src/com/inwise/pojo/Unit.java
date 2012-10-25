package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 23, 2012
 * Time: 1:39:17 PM
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name = "unit")

public class Unit {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Column(name = "name")
    private String name;

     @Column(name = "deleted",nullable = true)
    private  int deleted;
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }

    @Override
    public String toString() {
        return "Unit{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", deleted=" + deleted +
                '}';
    }
}
