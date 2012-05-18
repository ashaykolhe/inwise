package com.inwise.dao;

import com.inwise.dao.BaseDao;
import com.inwise.pojo.Customer;
import com.wideplay.warp.persist.Transactional;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: May 11, 2012
 * Time: 11:44:46 AM
 * To change this template use File | Settings | File Templates.
 */
public class CustomerDao extends BaseDao<Customer,Integer> {
    public CustomerDao()
    {
        super(Customer.class);
    }

    public void addCustomer(Customer customer)
    {
        System.out.println("in save metod");
         save(customer);
    }
    
@Override @Transactional
   public void remove(Integer id) {
           try{
                Customer customer =super.find(id);
               customer.setDeleted(1);
               super.save(customer);

       }catch (Exception e){
           e.printStackTrace();
       }
   }

  @Override
   public List<Customer> listAll() {
        Criteria criteria = sessionProvider.get().createCriteria(Customer.class).add(Restrictions.eq("deleted",0));
   return criteria.list();
   }

	
    public List<String> getCustomerNameLst() {
        return (List<String>)sessionProvider.get().createQuery("SELECT c.name from Customer c").list();
    }

    public List<String> getCustomerCodeLst() {
         return (List<String>)sessionProvider.get().createQuery("SELECT c.customerCode from Customer c").list();
    }

    public Customer findByCustomerName(String name) {
        return (Customer) sessionProvider.get().createQuery("SELECT c from Customer c where c.name='"+name+"' " ).uniqueResult();
    }

    public Customer findByCustomerCode(String name) {
    return (Customer) sessionProvider.get().createQuery("SELECT c from Customer c where c.customerCode='"+name+"' " ).uniqueResult();
    }

/*    public boolean updateCustomer(Customer customer)
    {
          sessionProvider.get().update(customer);
        return false;  //To change body of implemented methods use File | Settings | File Templates.
    }*/
}
