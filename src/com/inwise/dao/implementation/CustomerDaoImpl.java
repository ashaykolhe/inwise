package com.inwise.dao.implementation;

import com.inwise.dao.CustomerDao;
import com.inwise.dao.BaseDao;
import com.inwise.pojo.Customer;
import com.inwise.pojo.Product;
import com.wideplay.warp.persist.Transactional;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: May 11, 2012
 * Time: 11:44:46 AM
 * To change this template use File | Settings | File Templates.
 */
public class CustomerDaoImpl extends BaseDao<Customer,Integer> implements CustomerDao
{
    public CustomerDaoImpl()
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

  public List<String> listname()
  {
       List u;
        Session s = sessionProvider.get();
         u= (List) s.createQuery("select name from Customer where deleted='0' ").list();
        return u;
  }
    @Transactional
    public List<Customer> searchByName(String name){
           Session s = sessionProvider.get();
         return (List<Customer>)s.createQuery("FROM Customer WHERE name='"+name+"'").list();
    }

}
