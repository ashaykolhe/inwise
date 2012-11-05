package com.inwise.pojo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 25, 2012
 * Time: 10:59:12 AM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "term_order")
public class TermOrder {
     @Id
  @Column(name = "id")
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Integer id;
     @Column(name = "first_term",length = 5000)
      private String firstTerm;



    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFirstTerm() {
        return firstTerm;
    }

    public void setFirstTerm(String firstTerm) {
        this.firstTerm = firstTerm;
    }

    @Override
    public String toString() {
        return "TermOrder{" +
                "id=" + id +
                ", firstTerm='" + firstTerm + '\'' +
                '}';
    }
}
