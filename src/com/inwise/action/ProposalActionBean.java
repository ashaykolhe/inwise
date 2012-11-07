package com.inwise.action;

import net.sourceforge.stripes.action.*;
import com.inwise.pojo.*;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.ProductDao;
import com.inwise.dao.ProposalDao;
import com.inwise.dao.OrderDao;
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
        OrderDao orderDao;
     private Order order;
    @Inject
    ProductDao productDao;
    @Inject
    ProposalDao proposalDao;
    private Proposal proposal;
    private Proposal proposalDuplicate;
    private String alert;
    private List<Customer> customerList=new ArrayList<Customer>();
    private List<Product> productList=new ArrayList<Product>();
    private List<Proposal> proposallst;
    private static final String ADDPROPOSAL="jsp/addProposal.jsp";
     private static final String PREVIEWPROPOSAL="jsp/previewProposal.jsp";
      private static final String EDITPROPOSAL="jsp/editProposal.jsp";
    private static final String VIEWPROPOSAL="jsp/viewProposal.jsp";
    private static final String REQUOTEPROPOSAL="jsp/requoteProposal.jsp";
     private static final String CONVERTTOORDER="jsp/covertToOrder.jsp";
     private List<Address> addressList=new ArrayList<Address>();
      private boolean emailbox;

    public boolean isEmailbox() {
        return emailbox;
    }

    public void setEmailbox(boolean emailbox) {
        this.emailbox = emailbox;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getAlert() {
        return alert;
    }

    public void setAlert(String alert) {
        this.alert = alert;
    }

    public List<Address> getAddressList() {
        return addressList;
    }

    public void setAddressList(List<Address> addressList) {
        this.addressList = addressList;
    }

    public Proposal getProposalDuplicate() {
        return proposalDuplicate;
    }

    public void setProposalDuplicate(Proposal proposalDuplicate) {
        this.proposalDuplicate = proposalDuplicate;
    }


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
     public Resolution redirectProposalLink(){
          getContext().getMessages().add(new LocalizableMessage("/Proposal.action.add.success"));

        return new RedirectResolution(ProposalActionBean.class,"addProposalLink");
    }
    public Resolution addProposal(){
        System.out.println("email"+emailbox);
       /* ProposalDetail g=null;
        for(Iterator<ProposalDetail> i=proposal.getProposalDetail().iterator();i.hasNext();){
            g=(ProposalDetail)i.next();
            if(g==null){
                i.remove();
                continue;
            }else {
                g.setRequoteno(1);
                 g.setRequoteStatus("requote");
                continue;
            }
        }

        proposalDao.save(proposal);
*/
       // proposalDao.sendGeneralMail(saved.getId());
        return new RedirectResolution(ProposalActionBean.class,"previewLink");
    }
     public Resolution editProposalLink(){
          proposal=proposalDao.findByLastUpdate();
           productList=productDao.listAll();
         customerList=customerDao.listAll();
        return new ForwardResolution(EDITPROPOSAL);
    }
    public Resolution editProposal(){
         ProposalDetail g=null;
        for(Iterator<ProposalDetail> i=proposal.getProposalDetail().iterator();i.hasNext();){
            g=(ProposalDetail)i.next();
            if(g==null){
                i.remove();
                continue;
            }else {
                g.setRequoteno(1);
                 g.setRequoteStatus("requote");
                continue;
            }
        }
         Proposal saved=  proposalDao.save(proposal);

       // proposalDao.sendGeneralMail(saved.getId());
             getContext().getMessages().add(new LocalizableMessage("/Proposal.action.add.success"));
         return new RedirectResolution(ProposalActionBean.class,"previewLink");
    }
   public Resolution previewLink(){
       proposal=proposalDao.findByLastUpdate();
       return new ForwardResolution(PREVIEWPROPOSAL);  
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
                g.setRequoteStatus("requote");
                --value;
                continue;
            }
        }
        proposalDuplicate.getProposalDetail().addAll(proposal.getProposalDetail());
        proposal.setProposalDetail(proposalDuplicate.getProposalDetail());
        proposal.setRequoteStatus("requote");
        proposalDao.save(proposal);
        return new RedirectResolution(ProposalActionBean.class,"viewProposalLink");
    }

 public Resolution convertToOrder(){
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
                g.setRequoteStatus("final");
                --value;
                continue;
            }
        }
        proposalDuplicate.getProposalDetail().addAll(proposal.getProposalDetail());
        proposal.setProposalDetail(proposalDuplicate.getProposalDetail());
     proposal.setRequoteStatus("final");
        proposalDao.save(proposal);

     return  new RedirectResolution(ProposalActionBean.class,"redirectToConvertPage").addParameter("id",proposal.getId());
 }
    public Resolution redirectToConvertPage(){
           proposal=proposalDao.find(id);
          addressList=proposal.getCustomer().getAddressList();
           return  new ForwardResolution(CONVERTTOORDER);
    }
    public Resolution addOrder(){
                 System.out.println("hello"+order);
           orderDao.save(order);
            getContext().getMessages().add(new LocalizableMessage("/Order.action.add.success"));
           return new RedirectResolution(OrderActionBean.class,"viewOrderLink");
       }

}
