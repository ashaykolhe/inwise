package com.inwise.action;



import java.util.List;

import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;
import com.inwise.action.BaseActionBean;
import com.inwise.pojo.Role;
import com.inwise.dao.RoleDao;
import com.google.inject.Inject;

import javax.annotation.security.RolesAllowed;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: Feb 27, 2012
 * Time: 11:04:10 AM
 * To change this template use File | Settings | File Templates.
 */

@HttpCache(allow = false)
public class RoleActionBean extends BaseActionBean {

    List<Role> rolelst;
       protected Role role;
         @Inject
       protected RoleDao roledao;
        private boolean flag;
          private String addRoleName;
         private static final String ROLE="jsp/displaytag/role.jsp";

       public String getAddRoleName() {
           return addRoleName;
       }

       public void setAddRoleName(String addRoleName) {
           this.addRoleName = addRoleName;
       }

       public List<Role> getRolelst() {
           return rolelst;
       }

       public void setRolelst(List<Role> rolelst) {
           this.rolelst = rolelst;
       }

       public Role getRole() {
           if(id!=null && id != 0) {

               return roledao.findById(id);
           }
           return role;
       }

       public void setRole(Role role) {
           this.role = role;
       }

       public boolean isFlag() {
           return flag;
       }

       public void setFlag(boolean flag) {
           this.flag = flag;
       }

       @DefaultHandler
       public Resolution paginationRole(){
           rolelst=roledao.getRole();
           return new JavaScriptResolution(rolelst);
       }

       //To get role unique list by id
       public Resolution readname(){

           role= roledao.findById(id);
           return new JavaScriptResolution(role);
       }

//Add role
   public Resolution addroledb(){
            System.out.println("as");
     System.out.println("as233"+getRole());
           roledao.SaveRole(getRole());
           rolelst=roledao.getRole();
           return new ForwardResolution(ROLE);
       }


//Delete role
   public Resolution delete1(){
           roledao.delete(getRole());
           rolelst=roledao.getRole();
           return new ForwardResolution(ROLE);
       }


//Update role
   public Resolution update(){
           roledao.update(getRole());
           rolelst=roledao.getRole();
           return new ForwardResolution(ROLE);
       }

         public Resolution checkRoleAlreadyPresent()
       {

       flag=roledao.checkRolePresent(addRoleName);
       return new JavaScriptResolution(flag);
       }
   }
    