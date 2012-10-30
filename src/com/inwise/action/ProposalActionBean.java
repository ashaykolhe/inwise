package com.inwise.action;

import net.sourceforge.stripes.action.*;
import com.inwise.pojo.Customer;
import com.inwise.pojo.Product;
import com.inwise.pojo.Proposal;
import com.inwise.pojo.ProposalDetail;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.ProductDao;
import com.inwise.dao.ProposalDao;
import com.google.inject.Inject;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 25, 2012
 * Time: 4:57:57 PM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/proposal")
public class ProposalActionBean extends BaseActionBean{
    @Inject
    CustomerDao customerDao;

    @Inject
    ProductDao productDao;
    @Inject
    ProposalDao proposalDao;
    private Proposal proposal;
    private Proposal proposalDuplicate;

    public Proposal getProposalDuplicate() {
        return proposalDuplicate;
    }

    public void setProposalDuplicate(Proposal proposalDuplicate) {
        this.proposalDuplicate = proposalDuplicate;
    }

    private List<Customer> customerList=new ArrayList<Customer>();
    private List<Product> productList=new ArrayList<Product>();
    private List<Proposal> proposallst;
    private static final String ADDPROPOSAL="jsp/addProposal.jsp";
    private static final String VIEWPROPOSAL="jsp/viewProposal.jsp";
    private static final String REQUOTEPROPOSAL="jsp/requoteProposal.jsp";
    public Proposal getProposal() {
        return proposal;
    }

    public void setProposal(Proposal proposal) {
        this.proposal = proposal;
    }

    public List<Customer> getCustomerList() {
        return customerList;
    }

    public void setCustomerList(List<Customer> customerList) {
        this.customerList = customerList;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    public List<Proposal> getProposallst() {
        return proposallst;
    }

    public void setProposallst(List<Proposal> proposallst) {
        this.proposallst = proposallst;
    }

    @DefaultHandler
    public Resolution addProposalLink(){
        customerList=customerDao.listAll();
        productList=productDao.listAll();
        return new ForwardResolution(ADDPROPOSAL);
    }

    public Resolution addProposal(){
        System.out.println("proposal"+proposal);
        ProposalDetail g=null;
        for(Iterator<ProposalDetail> i=proposal.getProposalDetail().iterator();i.hasNext();){
            g=(ProposalDetail)i.next();
            if(g==null){
                i.remove();
                continue;
            }else {
                g.setRequoteno(1);

                continue;
            }
        }
        System.out.println("proposal"+proposal);

        Proposal saved= proposalDao.save(proposal);
        System.out.println("saved id "+saved.getId());
        proposalDao.sendGeneralMail(saved.getId());
        return new RedirectResolution(ProposalActionBean.class,"addProposalLink");
    }
    public Resolution viewProposalLink(){
        proposallst=proposalDao.listAll();

        return new ForwardResolution(VIEWPROPOSAL);
    }
    public Resolution getProposalList(){
       // proposallst=proposalDao.listAll();
               proposal=proposalDao.find(id);
          
           
        return new ForwardResolution(REQUOTEPROPOSAL);
    }

    public Resolution reQuote(){
        Integer value=0;
        proposalDuplicate=proposalDao.find(proposal.getId());
        ProposalDetail po=null;
        for(Iterator<ProposalDetail> i=proposalDuplicate.getProposalDetail().iterator();i.hasNext();){
            po=(ProposalDetail)i.next();
            value= po.getRequoteno();

        }
        ProposalDetail g=null;
        for(Iterator<ProposalDetail> i=proposal.getProposalDetail().iterator();i.hasNext();){
            g=(ProposalDetail)i.next();
            if(g==null){
                i.remove();
                continue;
            }else {
                value++;
                g.setRequoteno(value);
                --value;
                continue;
            }
        }
        proposalDuplicate.getProposalDetail().addAll(proposal.getProposalDetail());
        proposal.setProposalDetail(proposalDuplicate.getProposalDetail());
        proposalDao.save(proposal);
        return new ForwardResolution(ProposalActionBean.class,"viewProposalLink");
    }
}
