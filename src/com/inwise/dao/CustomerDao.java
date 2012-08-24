package com.inwise.dao;

import com.inwise.dao.BaseDao;
import com.inwise.pojo.Customer;
import com.inwise.pojo.Product;
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
public class CustomerDao extends BaseDao<Customer,Integer>
{

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
        return (List<String>)sessionProvider.get().createQuery("SELECT distinct c.name from Customer c").list();
    }

    public List<String> getCustomerCodeLst() {
         return (List<String>)sessionProvider.get().createQuery("SELECT distinct c.customerCode from Customer c").list();
    }

    public Customer findByCustomerName(String name) {
        return (Customer) sessionProvider.get().createQuery("SELECT distinct c from Customer c where c.name='"+name+"' " ).uniqueResult();
    }

    public Customer findByCustomerCode(String name) {
    return (Customer) sessionProvider.get().createQuery("SELECT distinct c from Customer c where c.customerCode='"+name+"' " ).uniqueResult();
    }

/*    public boolean updateCustomer(Customer customer)
    {
          sessionProvider.get().update(customer);
        return false;  //To change body of implemented methods use File | Settings | File Templates.
    }*/
      @Transactional
      @Override
    public Customer save(Customer customer)
    {
        try {
            if(customer!=null && customer.getId()==null){
              //  String subname=((String) sessionProvider.get().createQuery("SELECT name FROM Section WHERE id='"+customer.getSection().getId()+"'").uniqueResult()).substring(0,3);//getSection().getName();
               String s="c";
                String sname= ((String) sessionProvider.get().createQuery("SELECT max(customerCode) FROM Customer").uniqueResult());
                if(sname==null)
                    customer.setCustomerCode(s+1000);
                else{
                     long l=Long.parseLong(sname.substring(1));
                    System.out.println(l);
                    l=l+1;
                    customer.setCustomerCode(s+l);
                    System.out.println("aaaaaaaaaaazzzzzzzzzzzzsssssssss"+customer);
                }


            }else
            {
                 System.out.println(customer.getCustomerCode());
              customer.setCustomerCode(customer.getCustomerCode());  
            }
        }catch (Exception e){
            e.printStackTrace();

        }
        return (Customer) sessionProvider.get().merge(customer);
}
      public List<Customer> listallcustomername()
    {
          return (List<Customer>)sessionProvider.get().createSQLQuery("Select name from customer").list();
    }
}