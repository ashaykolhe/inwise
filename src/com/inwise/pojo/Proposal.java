package com.inwise.pojo;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 26, 2012
 * Time: 10:29:36 AM
 * To change this template use File | Settings | File Templates.
 */


@Entity
@Table(name = "proposal")
public class Proposal {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;


    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_date")
    private Date createDate;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "proposal_has_proposal_detail",
    joinColumns = { @JoinColumn(name = "proposal_id") }, inverseJoinColumns = { @JoinColumn(name = "proposal_detail_id") })
    private List<ProposalDetail> proposalDetail=new ArrayList<ProposalDetail>();
    @Column(name = "total_amount",length = 10)
    private Double totalAmount;

    @Column(name = "deleted",length = 2)
    private Integer deleted;
    @Column(name = "requote_status",length = 20)
    private String requoteStatus;

    public String getRequoteStatus() {
        return requoteStatus;
    }

    public void setRequoteStatus(String requoteStatus) {
        this.requoteStatus = requoteStatus;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
         public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

    public List<ProposalDetail> getProposalDetail() {
        return proposalDetail;
    }

    public void setProposalDetail(List<ProposalDetail> proposalDetail) {
        this.proposalDetail = proposalDetail;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    @Override
    public String toString() {
        return "Proposal{" +
                "id=" + id +
                ", customer=" + customer +
                ", createDate=" + createDate +
                ", proposalDetail=" + proposalDetail +
                ", totalAmount=" + totalAmount +
                ", deleted=" + deleted +
                ", requoteStatus='" + requoteStatus + '\'' +
                '}';
    }
}
