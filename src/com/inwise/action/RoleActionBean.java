package com.inwise.action;



import java.util.List;

import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;
import com.inwise.action.BaseActionBean;
import com.inwise.pojo.Role;
import com.inwise.dao.RoleDao;
import com.google.inject.Inject;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: Feb 27, 2012
 * Time: 11:04:10 AM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/role")
@HttpCache(allow = false)
public class RoleActionBean extends BaseActionBean {

    private static final String ROLE="jsp/displaytag/role.jsp";
    
    @Inject
    RoleDao roleDao;

     List<Role> rolelst;

    protected Role role;

    public List<Role> getRolelst() {
        return rolelst;
    }

    public void setRolelst(List<Role> rolelst) {
        this.rolelst = rolelst;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    @DefaultHandler
    public Resolution pre(){
        rolelst=roleDao.getRole();
        return new ForwardResolution(ROLE);
    }

    public Resolution paginationRole(){
        rolelst=roleDao.getRole();
       return new JavaScriptResolution(rolelst);
   }

    //To get role unique list by id
      public Resolution readname(){
        role= roleDao.find(id);
        return new JavaScriptResolution(role);
   }
   //Add role
     public Resolution addroledb(){
               roleDao.save(getRole());
       return pre();
   }

    //Delete role
     public Resolution delete1(){
         roleDao.remove(id);
        return pre();
    }

    //Update role
      public Resolution update(){
        return addroledb();
    }}
