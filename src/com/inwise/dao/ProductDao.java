package com.inwise.dao;

import com.inwise.dao.BaseDao;
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
public class ProductDao extends BaseDao<Product,Integer> {
     public ProductDao() {
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

    public List<Product> listallprodname()
    {
          return (List<Product>)sessionProvider.get().createSQLQuery("Select product_name from product").list();
    }
     public List<Product> getAllDeletedProduct() {
        return (List<Product>)sessionProvider.get().createQuery("FROM Product where deleted='1'").list();
    }
    @Transactional
      public void restoreAllProduct()
    {
        sessionProvider.get().createQuery("UPDATE Product SET deleted=0 WHERE deleted=1").executeUpdate();

    }
    @Transactional
    public void restoreProduct(int id)
    {
        sessionProvider.get().createQuery("UPDATE Product SET deleted=0 WHERE id="+id).executeUpdate();

    }
}
