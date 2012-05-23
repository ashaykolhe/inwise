package com.inwise.dao.implementation;

import com.inwise.dao.BaseDao;
import com.inwise.dao.RolePermissionsDao;
import com.inwise.dao.UserPermissionsDao;
import com.inwise.pojo.UserPermissions;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: May 15, 2012
 * Time: 4:27:05 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserPermissionDaoImpl extends BaseDao<UserPermissions,Integer> implements UserPermissionsDao {
    public UserPermissionDaoImpl() {
        super(UserPermissions.class);
    }
}
