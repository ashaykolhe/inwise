package com.inwise.action;

import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;

import java.util.List;

import com.inwise.pojo.Role;
import com.inwise.pojo.RolePermissions;
import com.inwise.constants.PermissionConstants;
import com.inwise.utils.PasswordEncryptor;
import com.inwise.guice.InjectorFactory;
import com.inwise.dao.RoleDao;
import com.inwise.pojo.User;
import com.inwise.pojo.UserPermissions;
import com.google.inject.Inject;

import javax.annotation.security.RolesAllowed;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: Feb 20, 2012
 * Time: 3:33:43 PM
 * To change this template use File | Settings | File Templates.
 */
@HttpCache(allow = false)
public class UserActionBean extends BaseActionBean{
    @Inject
    protected RoleDao roledao;

    private List<User> userlst;
     private String name;
     private String addUserName;
     private String password;
    private  boolean flag;
    private User user;
    private Role role;
    private static String count="0";
       private static Long tempid;
          private List<Role> rolelst;
   private List<RolePermissions> rolePermission;
    private List<UserPermissions> userPermission;
    private List<String> usernamelist;
    private static String test;
     private static final String ADDUSER="jsp/addUser.jsp";
   private static final String UPDATEUSER="jsp/updateUser.jsp";
    private static final String DELETEUSER="jsp/deleteUser.jsp";
      private static final String USERPERMISSION="jsp/userPermission.jsp";
    private static final String ROLEPERMISSION="jsp/rolePermission.jsp";
     private static final String VIEWUSER="jsp/viewUser.jsp";
    public static String getTest() {
        return test;
    }

    public static void setTest(String test) {
        UserActionBean.test = test;
    }

    public static Long getTempid() {
        return tempid;
    }

    public static void setTempid(Long tempid) {
        UserActionBean.tempid = tempid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<String> getUsernamelist() {
        return usernamelist;
    }

    public void setUsernamelist(List<String> usernamelist) {
        this.usernamelist = usernamelist;
    }

    public static String getCount() {
        return count;
    }

    public static void setCount(String count) {
        UserActionBean.count = count;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<UserPermissions> getUserPermission() {
        return userPermission;
    }

    public void setUserPermission(List<UserPermissions> userPermission) {
        this.userPermission = userPermission;
    }

    public List<User> getUserlst() {
        return userlst;
    }
    public void setUserlst(List<User> userlst) {
           this.userlst = userlst;

       }

    public String getAddUserName() {
        return addUserName;
    }

    public void setAddUserName(String addUserName) {
        this.addUserName = addUserName;
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }



    public List<Role> getRolelst() {
        return rolelst;
    }

    public void setRolelst(List<Role> rolelst) {
        this.rolelst = rolelst;
    }

    public List<RolePermissions> getRolePermission() {
        return rolePermission;
    }

    public void setRolePermission(List<RolePermissions> rolePermission) {
        this.rolePermission = rolePermission;
    }

    @RolesAllowed({PermissionConstants.ADD_USERS})
    @DefaultHandler
    //Redirect to add user page
    public Resolution addUserLink(){
        userlst=userDao.getUser();
                 rolelst=roledao.getRole();
        count="0";
        return new ForwardResolution(ADDUSER);
   }

    @RolesAllowed({PermissionConstants.ADD_USERS})
   public Resolution addUser(){
        System.out.println("user exist"+getUser());
        if(count.equalsIgnoreCase("0"))
        {
         userDao.SaveUser(user);
        }
        else
        {
            userDao.update(user);
        }
        count="0";

//          rolelst=roledao.getRole();

        role=roledao.find(user.getRole().getId()) ;
          rolePermission=role.getRolePermissions();
//        rolelst=roledao.getRole();
        test="a";

 getContext().getMessages().add(new LocalizableMessage("/User.action.add.success"));
     return new ForwardResolution("jsp/rolePermissionstep.jsp");
           //return new RedirectResolution(UserActionBean.class,"addUserLink");
   }

    @RolesAllowed({PermissionConstants.UPDATE_USERS})
    //Redirect to update user page
 public Resolution updateUserLink(){
     userlst=userDao.getUser();
        return new ForwardResolution(UPDATEUSER);
   }
    //Update user
     @RolesAllowed({PermissionConstants.UPDATE_USERS})
  public Resolution updateUser()
  {
        userDao.update(getUser());
            userlst=userDao.getUser();
      id=userDao.findIdByLatestUpdate();
        role=userDao.findById(userDao.findIdByLatestUpdate()).getRole();
           getContext().getMessages().add(new LocalizableMessage("/User.action.update.success"));

          rolePermission=role.getRolePermissions();
    //  test="b";
        return new RedirectResolution(UserActionBean.class,"viewUserLink");

  }
    //get user list by id
     public Resolution userlist(){

         user= userDao.findByUsername(id);
          rolelst=roledao.getRole();
         userlst=userDao.getUser();
         return new ForwardResolution(UPDATEUSER);
    }

    @RolesAllowed({PermissionConstants.DELETE_USERS})
    //redirect to delete page
     public Resolution deleteUserLink(){
            userlst=userDao.getUser();

      return new ForwardResolution(DELETEUSER);
   }
    @RolesAllowed({PermissionConstants.DELETE_USERS})
    //delete user
    public Resolution delete(){

         userDao.remove(id);
                    getContext().getMessages().add(new LocalizableMessage("/User.action.delete.success"));
        return new RedirectResolution(UserActionBean.class,"viewUserLink");
    }

    @RolesAllowed({PermissionConstants.ROLE_PERMISSIONS})
    //Redirect to user permission page
     public Resolution rolePermissionLink(){
         rolelst=roledao.getRole();
          return new ForwardResolution(ROLEPERMISSION);
     }


    @RolesAllowed({PermissionConstants.USER_PERMISSIONS})
    //Redirect to user permission page
     public Resolution userPermissionLink(){
         userlst=userDao.getUser();
          return new ForwardResolution(USERPERMISSION);
     }
     @RolesAllowed({PermissionConstants.ROLE_PERMISSIONS})
    public Resolution grantRolePermissionstep(){
/*
         for(Iterator<RolePermissions> revoke=rolePermission.iterator();revoke.hasNext();){
             RolePermissions temp=revoke.next();
             if(temp.getAdd()==null && temp.getUpdate()==null && temp.getDelete()==null){
                 revoke.remove();
             }

         }
*/

     // if ( count==1 )

        // if(test.equalsIgnoreCase("a"))
         //{
      role=userDao.latestuser().getRole();
       //else
     // role=roledao.findById(id);

        role.setRolePermissions(rolePermission);
        roledao.SaveRole(role);
//        rolelst=roledao.getRole();
         user=userDao.latestuser();//}

     /*   else
          role=userDao.findById(userDao.findIdByLatestUpdate()).getRole();

        role.setRolePermissions(rolePermission);
        roledao.SaveRole(role);
        user=userDao.findById(userDao.findIdByLatestUpdate());

           userPermission=user.getUserPermissions();

        return new ForwardResolution("invoice/jsp/userPermissionstep.jsp");
    }
     public Resolution grantRolePermission(){
/*
         for(Iterator<RolePermissions> revoke=rolePermission.iterator();revoke.hasNext();){
             RolePermissions temp=revoke.next();
             if(temp.getAdd()==null && temp.getUpdate()==null && temp.getDelete()==null){
                 revoke.remove();
             }

         }
*/

     // if ( count==1 )
     // role=roledao.findByLatestId(id);
       //else
         role=roledao.findById(id);

        role.setRolePermissions(rolePermission);
        roledao.SaveRole(role);
        rolelst=roledao.getRole();
         user=userDao.latestuser();


       return new RedirectResolution(UserActionBean.class,"rolePermissionLink");
    }
    @RolesAllowed({PermissionConstants.USER_PERMISSIONS})
    public Resolution grantUserPermissionstep(){
/*
        for(Iterator<UserPermissions> revoke=userPermission.iterator();revoke.hasNext();){
            UserPermissions temp=revoke.next();
            if(temp.getAdd()==null && temp.getUpdate()==null && temp.getDelete()==null){
                revoke.remove();
            }

        }
*/
       //if(test.equalsIgnoreCase("a"))
       //{
        User temp=userDao.findByLatestId(id);
        temp.setUserPermissions(userPermission);
        userDao.SaveUser(temp);

        userlst=userDao.getUser();
       //}
       /* else
       {
         User temp=userDao.findById(userDao.findIdByLatestUpdate());
        temp.setUserPermissions(userPermission);
        userDao.SaveUser(temp);

        userlst=userDao.getUser();

       } */
         return new RedirectResolution(UserActionBean.class,"addUserLink");
    }
    public Resolution grantUserPermission(){
/*
        for(Iterator<UserPermissions> revoke=userPermission.iterator();revoke.hasNext();){
            UserPermissions temp=revoke.next();
            if(temp.getAdd()==null && temp.getUpdate()==null && temp.getDelete()==null){
                revoke.remove();
            }

        }
*/

            User temp=userDao.findById(id);
            temp.setUserPermissions(userPermission);
            userDao.SaveUser(temp);
            userlst=userDao.getUser();
             return new RedirectResolution(UserActionBean.class,"userPermissionLink");
        }


    public Resolution getRolePermissionsById(){
        rolePermission=roledao.findById(id).getRolePermissions();
        rolelst=roledao.getRole();
        return new ForwardResolution(ROLEPERMISSION);
    }

    public Resolution getUserPermissionsById(){

        userPermission=userDao.findById(id).getUserPermissions();

        userlst=userDao.getUser();
        return new ForwardResolution(USERPERMISSION);
    }

    public Resolution checkUserAlreadyPresent()
       {

             flag=userDao.checkUserPresent(addUserName);
           return new JavaScriptResolution(flag);
       }

   public Resolution  changePasswordLink (){
     return new ForwardResolution("jsp/changePassword.jsp");
   }
public Resolution checkPassword()
    {
       if(getContext().getUser().getPassword().equals(InjectorFactory.getInjector().getInstance(PasswordEncryptor.class).hash(addUserName))){
           flag=false;
       }else flag=true;

        return new JavaScriptResolution(flag);
    }

   public Resolution updatePassword(){
       getContext().getUser().setPassword(InjectorFactory.getInjector().getInstance(PasswordEncryptor.class).hash(password));
       userDao.SaveUser(getUser());
         getContext().getMessages().add(new LocalizableMessage("/User.action.password.success"));
       return new ForwardResolution(UserActionBean.class,"changePasswordLink");
   }
      public Resolution userLink(){
       user=userDao.latestuser();

        rolelst=roledao.getRole();
          role=user.getRole();
                 count="a";
          flag=true;

        return new ForwardResolution(ADDUSER);
   }
     public Resolution roleLink(){
       role=userDao.latestuser().getRole();
         id=userDao.latestuser().getRole().getId();
       //else
     // role=roledao.findById(id);
       //  role=roledao.findById(id);
          rolePermission=roledao.findById(id).getRolePermissions();
        role.setRolePermissions(rolePermission);
        roledao.SaveRole(role);
       // rolelst=roledao.getRole();
         user=userDao.latestuser();
                 //count="a";
          flag=true;

        return new ForwardResolution("jsp/rolePermissionstep.jsp");
   }
    public Resolution userlistforupdate() {
        usernamelist=userDao.getUserNamelist();

         return new JavaScriptResolution(usernamelist);
    }
   /* public Resolution grantRolePermissionupdate(){
/*
         for(Iterator<RolePermissions> revoke=rolePermission.iterator();revoke.hasNext();){
             RolePermissions temp=revoke.next();
             if(temp.getAdd()==null && temp.getUpdate()==null && temp.getDelete()==null){
                 revoke.remove();
             }

         }
*/

     // if ( count==1 )
     // role=roledao.findByLatestId(id);
       //else
        //id=userDao.findIdByLatestUpdate();
         //role=roledao.findById(tempid);
      /*    System.out.println("idididididididiididitemp in update 2"+tempid);

           role=userDao.findById(userDao.findIdByLatestUpdate()).getRole();
       //else
     // role=roledao.findById(id);
         System.out.printf("temptemptemptemptemptemp"+role);
        role.setRolePermissions(rolePermission);
        roledao.SaveRole(role);
//        rolelst=roledao.getRole();

        role.setRolePermissions(rolePermission);
        roledao.SaveRole(role);
        rolelst=roledao.getRole();
         user=userDao.findById(userDao.findIdByLatestUpdate());
       // System.out.println("countcountcountcountcountcount"+count);
          role=userDao.findById(userDao.findIdByLatestUpdate()).getRole();
           rolePermission=role.getRolePermissions();

       return new ForwardResolution("jsp/rolePermissionstep.jsp");
    }*/
     public Resolution viewUserLink(){
            userlst=userDao.getUser();

      return new ForwardResolution(VIEWUSER);
   }
}
