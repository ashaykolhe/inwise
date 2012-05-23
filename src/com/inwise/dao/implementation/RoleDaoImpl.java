package com.inwise.dao.implementation;

import com.wideplay.warp.persist.Transactional;
import com.inwise.dao.BaseDao;
import com.inwise.dao.RoleDao;
import com.inwise.pojo.Role;
import com.inwise.pojo.Product;
import org.hibernate.Transaction;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: Feb 24, 2012
 * Time: 3:17:46 PM
 * To change this template use File | Settings | File Templates.
 */
public class RoleDaoImpl extends BaseDao<Role,Integer> implements RoleDao {
    public RoleDaoImpl() {
        super(Role.class);
    }

    @Override @Transactional
    public void remove(Integer id) {
            try{
                Role role=super.find(id);
            role.setDeleted(1);
                System.out.println("prod in delete dao"+role);
                super.save(role);
                System.out.println("prod in delete dao2"+role);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public List<Role> listAll() {
         Criteria criteria = sessionProvider.get().createCriteria(Role.class).add(Restrictions.eq("deleted",0));
    return criteria.list();
    }

     public List<Role> getRole(){
        return sessionProvider.get().createQuery("from Role where deleted='0' and id <> 1").list();
    }
}
