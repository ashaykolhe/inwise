package com.inwise.dao;

import com.inwise.dao.BaseDao;
import com.inwise.pojo.UserPermissions;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: May 15, 2012
 * Time: 4:27:05 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserPermissionDao extends BaseDao<UserPermissions,Integer> {
    public UserPermissionDao() {
        super(UserPermissions.class);
    }
}
