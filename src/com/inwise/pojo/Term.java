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
@Table(name = "term")
public class Term {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    @Column(name = "terms",length = 5000)
    private String terms;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTerms() {
        return terms;
    }

    public void setTerms(String terms) {
        this.terms = terms;
    }

    @Override
    public String toString() {
        return "Term{" +
                "id=" + id +
                ", terms='" + terms + '\'' +
                '}';
    }
}
