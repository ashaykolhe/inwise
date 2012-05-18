package com.inwise.action;

import com.inwise.pojo.Customer;
import com.inwise.pojo.Address;
import com.inwise.dao.CustomerDao;
import com.google.inject.Inject;
import net.sourceforge.stripes.action.*;

import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: May 11, 2012
 * Time: 11:38:26 AM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/customer")
public class CustomerActionBean extends BaseActionBean
{
    private static final String ADDCUSTOMER="jsp/addCustomer.jsp";
    private static final String UPDATECUSTOMER="jsp/updateCustomer.jsp";
    private static final String DELETECUSTOMER="jsp/deleteCustomer.jsp";
    
    @Inject
    CustomerDao customerDao;

    private Customer customer;
    private List<Customer> customerlst;
    private List<Address> addresslst;


    public List<Address> getAddresslst() {
        return addresslst;
    }

    public void setAddresslst(List<Address> addresslst) {
        this.addresslst = addresslst;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public List<Customer> getCustomerlst() {
        return customerlst;
    }

    public void setCustomerlst(List<Customer> customerlst) {
        this.customerlst = customerlst;
    }

    @DefaultHandler
    public Resolution pageDirect()
    {
      
     return new ForwardResolution(ADDCUSTOMER);
    }

    public Resolution addCustomer()
    {

            customer.setAddressList(addresslst);
        customerDao.save(customer);

        return new RedirectResolution(CustomerActionBean.class,"pageDirect");
    }


     public Resolution deleteLink()
     {   customerlst=customerDao.listAll();

         return new ForwardResolution(DELETECUSTOMER);
     }
    public Resolution delete()
    {
        customerDao.remove(getId());
        return new RedirectResolution(CustomerActionBean.class,"deleteLink");
    }
    public Resolution updateCustomerLink()
    {
        customerlst=customerDao.listAll();

         return new ForwardResolution(UPDATECUSTOMER);
    }
    public Resolution updateCustomer()
    {


        customer = customerDao.find(id);

        return new ForwardResolution(CustomerActionBean.class,"updateCustomerLink");
    }
    public Resolution update()
    {

              customerDao.save(customer);

        return new RedirectResolution(CustomerActionBean.class,"updateCustomerLink");
    }
}
