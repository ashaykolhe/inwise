package com.inwise.dao.implementation;

import com.inwise.dao.BaseDao;
import com.inwise.dao.ProductDao;
import com.inwise.pojo.Product;
import com.wideplay.warp.persist.Transactional;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: May 11, 2012
 * Time: 12:23:44 PM
 * To change this template use File | Settings | File Templates.
 */
public class ProductDaoImpl extends BaseDao<Product,Integer> implements ProductDao {
     public ProductDaoImpl() {
        super(Product.class);
    }

    public boolean checkProductPresent(String addProductName) {
         String u;
        Session s = sessionProvider.get();
        boolean f=false;
        try{
            u= (String) s.createQuery("select productName from Product where deleted='0' and productName='"+addProductName+"'").uniqueResult();
            if(u!=null)
                f=true;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }



    @Override @Transactional
    public void remove(Integer id) {
            try{
                Product product=super.find(id);
            product.setDeleted(1);
                System.out.println("prod in delete dao"+product);
                super.save(product);
                System.out.println("prod in delete dao2"+product);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public List<Product> listAll() {
         Criteria criteria = sessionProvider.get().createCriteria(Product.class).add(Restrictions.eq("deleted",0));
    return criteria.list();
    }
    @Transactional
    public List<String> listname(){
      List u;
        Session s = sessionProvider.get();
         u= (List) s.createQuery("select productName from Product where deleted='0' ").list();
        return u;
    }
    @Transactional
    public List<Product> searchByName(String name){
           Session s = sessionProvider.get();
         return (List<Product>)s.createQuery("FROM Product WHERE productName='"+name+"'").list();
    }
}
