package com.inwise.action;

import com.google.inject.Inject;

import com.inwise.action.BaseActionBean;
import com.inwise.dao.CustomerDao;
import com.inwise.dao.ProductDao;
import com.inwise.dao.UserDao;
import com.inwise.pojo.Customer;
import com.inwise.pojo.Product;
import com.inwise.pojo.User;
import net.sourceforge.stripes.action.*;

import java.util.Iterator;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: Jul 17, 2012
 * Time: 5:40:31 PM
 * To change this template use File | Settings | File Templates.
 */
@HttpCache(allow = false)
public class RestoreActionBean extends BaseActionBean
{
    @Inject
    CustomerDao customerDao;
    @Inject
    ProductDao productDao;
    @Inject
    UserDao userDao;
    private List<Customer> customerlst;
     private List<Product> productlst;
     private List<User> userlst;
    private boolean restorelistempty;
    private String restoreAll;
     private List<Integer> customerListForRestore,productListForRestore,userListForRestore;

    public List<Customer> getCustomerlst() {
        return customerlst;
    }

    public void setCustomerlst(List<Customer> customerlst) {
        this.customerlst = customerlst;
    }

    public List<Product> getProductlst() {
        return productlst;
    }

    public void setProductlst(List<Product> productlst) {
        this.productlst = productlst;
    }

    public List<User> getUserlst() {
        return userlst;
    }

    public void setUserlst(List<User> userlst) {
        this.userlst = userlst;
    }

    public boolean isRestorelistempty() {
        return restorelistempty;
    }

    public void setRestorelistempty(boolean restorelistempty) {
        this.restorelistempty = restorelistempty;
    }

    public String getRestoreAll() {
        return restoreAll;
    }

    public void setRestoreAll(String restoreAll) {
        this.restoreAll = restoreAll;
    }

    public List<Integer> getCustomerListForRestore() {
        return customerListForRestore;
    }

    public void setCustomerListForRestore(List<Integer> customerListForRestore) {
        this.customerListForRestore = customerListForRestore;
    }

    public List<Integer> getProductListForRestore() {
        return productListForRestore;
    }

    public void setProductListForRestore(List<Integer> productListForRestore) {
        this.productListForRestore = productListForRestore;
    }

    public List<Integer> getUserListForRestore() {
        return userListForRestore;
    }

    public void setUserListForRestore(List<Integer> userListForRestore) {
        this.userListForRestore = userListForRestore;
    }
   @DefaultHandler
    public Resolution restoreCustomerLink()
    {
        customerlst=customerDao.getAllDeletedCustomer();
        System.out.println(customerlst.size());
        if(customerlst.size()>0)
        {
            restorelistempty=false;
        }else{
        restorelistempty=true;}
        return new ForwardResolution("jsp/restoreCustomer.jsp");
    }
    public Resolution restoreCustomer()
    {
        if(restoreAll!=null)
        {
           customerDao.restoreAllCustomer();
        }
        else
        {
            Iterator itr=customerListForRestore.iterator();

            while(itr.hasNext())
            {
                    Integer id=(Integer)itr.next();
                    if(id==null)
                    {
                        itr.remove();
                    }
                else{
                        customerDao.restoreCustomer(id);

                    }
            }
        }
       return new RedirectResolution(RestoreActionBean.class,"restoreCustomerLink");
    }

     public Resolution restoreProductLink()
    {
        productlst=productDao.getAllDeletedProduct();

        if(productlst.size()>0)
        {
            restorelistempty=false;
        }else{
        restorelistempty=true;}
        return new ForwardResolution("jsp/restoreProduct.jsp");
    }
    public Resolution restoreProduct()
    {
        if(restoreAll!=null)
        {
           productDao.restoreAllProduct();
        }
        else
        {
            Iterator itr=productListForRestore.iterator();

            while(itr.hasNext())
            {
                    Integer id=(Integer)itr.next();
                    if(id==null)
                    {
                        itr.remove();
                    }
                else{
                        productDao.restoreProduct(id);

                    }
            }
        }
       return new RedirectResolution(RestoreActionBean.class,"restoreProductLink");
    }
     public Resolution restoreUserLink()
    {
        userlst=userDao.getAllDeletedUser();
      
        if(userlst.size()>0)
        {
            restorelistempty=false;
        }else{
        restorelistempty=true;}
        System.out.println("sssssssshe");
        return new ForwardResolution("jsp/restoreUser.jsp");
    }
    public Resolution restoreUser()
    {
        if(restoreAll!=null)
        {
           userDao.restoreAllUser();
        }
        else
        {
            Iterator itr=userListForRestore.iterator();

            while(itr.hasNext())
            {
                    Integer id=(Integer)itr.next();
                    if(id==null)
                    {
                        itr.remove();
                    }
                else{
                        userDao.restoreUser(id);

                    }
            }
        }
       return new RedirectResolution(RestoreActionBean.class,"restoreUserLink");
    }
}