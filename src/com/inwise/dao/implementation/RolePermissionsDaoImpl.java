package com.inwise.dao.implementation;

import com.wideplay.warp.persist.Transactional;
import com.inwise.dao.BaseDao;
import com.inwise.dao.RolePermissionsDao;
import com.inwise.pojo.RolePermissions;

import java.util.List;
import java.util.Iterator;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Mar 2, 2012
 * Time: 11:54:42 AM
 * To change this template use File | Settings | File Templates.
 */
public class RolePermissionsDaoImpl extends BaseDao<RolePermissions,Integer> implements RolePermissionsDao {

    public RolePermissionsDaoImpl() {
        super(RolePermissions.class);
    }

     //get all list
    @Transactional
    public List getRolePermissions(){
        String hql="from RolePermissions where deleted='1' and name <> 'superadmin'";
// List list=null;
        try {
            
        }catch (Exception e){
            e.printStackTrace();

        }finally{
//  s.close();
        }
        return sessionProvider.get().createQuery(hql).list();
    }
}
