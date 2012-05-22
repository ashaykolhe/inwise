package com.inwise.action;

import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;
import net.sourceforge.stripes.validation.Validate;

import java.util.List;
import java.util.Iterator;

import com.inwise.action.BaseActionBean;
import com.inwise.pojo.User;
import com.inwise.pojo.UserPermissions;
import com.inwise.pojo.RolePermissions;
import com.inwise.pojo.Role;
import com.inwise.dao.RolePermissionsDao;
import com.inwise.dao.*;
import com.inwise.dao.UserPermissionDao;
import com.inwise.exception.LoginException;
import com.google.inject.Inject;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: Feb 20, 2012
 * Time: 3:33:43 PM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/user")
@HttpCache(allow = false)
public class UserActionBean extends BaseActionBean {


    @Validate(on="login", required =true, label = "Username")

    private String username;
    @Validate(on="login", required = true, label = "Password"/*,converter = PasswordEncryptor.class*/)
    private String password;

    @Inject
    protected UserDao userDao;
    @Inject
    RoleDao roleDao;
    @Inject protected RolePermissionsDao rolePermissionsDao;
    @Inject protected UserPermissionDao userPermissionsDao;
    private final String LOGIN="jsp/login.jsp";
    private final String SUCCESS="jsp/main_page.jsp";
    private final String ADDUSER="jsp/addUser.jsp";
    private final String UPDATEUSER="jsp/updateUser.jsp";
    private final String DELETEUSER="jsp/deleteUser.jsp";
    private final String ROLEPERMISSION="jsp/rolePermission.jsp";
    private final String USERPERMISSION="jsp/userPermission.jsp";

    public User user;
    private List<User> userlst;
    private String addUserName;
    private  boolean flag;
    private Role role;

    private List<Role> rolelst;
    private List<RolePermissions> rolePermission;
    private List<UserPermissions> userPermission;

    public Role getRole() {

        return role;
    }

    public void setRole(Role role) {
        this.role = role;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public User getUser() {
        if(id!=null && id!=0){
            return userDao.find(id);
        }
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @DefaultHandler
    public Resolution pre(){

        return new ForwardResolution(LOGIN);
    }

    public Resolution login()
    {

        try{
            System.out.println(username+" "+password);
            getContext().setUser(userDao.authenticate(username,password));
        }catch(LoginException le){
            getContext().getMessages().add(new SimpleMessage("Invalid User"));

            return new RedirectResolution(UserActionBean.class,"pre");
        }

        return new ForwardResolution(SUCCESS);
    }


    //Redirect to add user page
    public Resolution addUserLink(){
        userlst=userDao.getUser();
        rolelst=roleDao.getRole();

        return new ForwardResolution(ADDUSER);
    }
    //Save user
    public Resolution addUser(){
        userDao.save(getUser());
        return new RedirectResolution(UserActionBean.class,"addUserLink");
    }

    //Redirect to update user page
    public Resolution updateUserLink(){
        userlst=userDao.getUser();
        rolelst=roleDao.getRole();
        return new ForwardResolution(UPDATEUSER);
    }
    //Update user
    public Resolution updateUser()
    {
        System.out.println("getUser() "+getUser());
        System.out.println("user "+user);
        userDao.save(getUser());
        return new RedirectResolution(UserActionBean.class,"updateUserLink");

    }
    //get user list by id
    public Resolution userlist(){

        user= userDao.find(id);
        return updateUserLink();
    }

    //redirect to delete page
    public Resolution deleteUserLink(){
        userlst=userDao.getUser();

        return new ForwardResolution(DELETEUSER);
    }
    //delete user
    public Resolution delete(){

        userDao.remove(id);
        return new RedirectResolution(UserActionBean.class,"deleteUserLink");
    }

    //Redirect to user permission page
    public Resolution rolePermissionLink(){
        rolelst=roleDao.getRole();
        return new ForwardResolution(ROLEPERMISSION);
    }

    //Redirect to user permission page
    public Resolution userPermissionLink(){
        userlst=userDao.getUser();
        return new ForwardResolution(USERPERMISSION);
    }
    public Resolution grantRolePermission(){
        for(Iterator<RolePermissions> i= rolePermission.iterator();i.hasNext();){
            RolePermissions roleper=i.next();
            roleper.setRole(roleDao.find(id));
            rolePermissionsDao.save(roleper);
        }

        return new RedirectResolution(UserActionBean.class,"rolePermissionLink");
    }
    public Resolution grantUserPermission(){
        for(Iterator<UserPermissions> i= userPermission.iterator();i.hasNext();){
            UserPermissions userper=i.next();
            userper.setUser(userDao.find(id));
            userPermissionsDao.save(userper);
        }

        return new RedirectResolution(UserActionBean.class,"userPermissionLink");
    }


    public Resolution getRolePermissionsById(){
        rolePermission=roleDao.find(id).getRolePermissions();

        return rolePermissionLink();
    }

    public Resolution getUserPermissionsById(){
        userPermission=userDao.find(id).getUserPermissions();
        return userPermissionLink();
    }

    public Resolution checkUserAlreadyPresent()
    {
        flag=userDao.checkUserPresent(addUserName);
        return new JavaScriptResolution(flag);
    }
}
