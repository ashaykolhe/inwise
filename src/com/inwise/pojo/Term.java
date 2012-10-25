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
     @Column(name = "first_term",length = 5000)
      private String firstTerm;

      @Column(name = "second_term")
      private String secondTerm;

      @Column(name = "third_term")
      private String thirdTerm;
      @Column(name = "forth_term")
      private String forthTerm;


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

    public String getSecondTerm() {
        return secondTerm;
    }

    public void setSecondTerm(String secondTerm) {
        this.secondTerm = secondTerm;
    }

    public String getThirdTerm() {
        return thirdTerm;
    }

    public void setThirdTerm(String thirdTerm) {
        this.thirdTerm = thirdTerm;
    }

    public String getForthTerm() {
        return forthTerm;
    }

    public void setForthTerm(String forthTerm) {
        this.forthTerm = forthTerm;
    }



    @Override
    public String toString() {
        return "Terms{" +
                "id=" + id +
                ", firstTerm='" + firstTerm + '\'' +
                ", secondTerm='" + secondTerm + '\'' +
                ", thirdTerm='" + thirdTerm + '\'' +
                ", forthTerm='" + forthTerm + '\'' +

                '}';
    }
}
