package com.inwise.dao;

import com.inwise.pojo.User;
import com.inwise.exception.LoginException;
import com.inwise.dao.BaseDao;
import com.wideplay.warp.persist.Transactional;

import java.util.List;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Feb 14, 2012
 * Time: 12:46:02 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserDao extends BaseDao<User,Integer>{
    public UserDao() {
        super(User.class);
    }

    public boolean checkUserPresent(String addUserName) {
        String u;
        boolean f=false;
        try{
            u= (String) sessionProvider.get().createQuery("select username from User where deleted='0' and username='"+addUserName+"'").uniqueResult();
            if(u!=null)
                f=true;
        }
        finally{
        }
        return f;  //To change body of implemented methods use File | Settings | File Templates.
    }
    @Transactional
    public User authenticate(User u) throws LoginException {
        System.out.println("heloo"+u.getUsername()+"pass"+u.getPassword());
        User val=(User)sessionProvider.get().createQuery("from User where username=:user and password=:pass and deleted=:del").setString("user",u.getUsername()).setString("pass",u.getPassword()).setInteger("del",0).uniqueResult();

              
        if(val==null){
            throw new LoginException("invalid credentials");
        }
        return val;
    }

    @Transactional
    public boolean SaveUser(User u)
    {

        try {
            if(u!=null){
                sessionProvider.get().save(u);
                 if (u.getCreateDate() == null) u.setCreateDate(new Date());
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }


    public User findById(Integer id){
        return (User)sessionProvider.get().createQuery("from User where id='"+id+"'").uniqueResult();
    }


    public List getUser(){
        return sessionProvider.get().createQuery("from User where deleted='0' and user_id <> 1").list();
    }

    @Transactional
    public void update(User user)  {
        try{
            sessionProvider.get().update(user);
            user.setCreateDate(new Date());
        }catch (Exception e){
            e.printStackTrace();
        }
    }
     @Override @Transactional
    public void remove(Integer id) {
            try{
                User user=super.find(id);
            user.setDeleted(1);

                super.save(user);

        }catch (Exception e){
            e.printStackTrace();
        }
    }
          public User latestuser() {
        return (User)sessionProvider.get().createQuery("from User where id=(select max(id) from User)").uniqueResult();

    }
    public User findByLatestId(Integer id){
           return (User)sessionProvider.get().createQuery("from User  where id=(select max(id) from User)").uniqueResult();
       }

       public List getUserNamelist(){
        return sessionProvider.get().createQuery("select username from User where deleted='0'").list();
    }
    public User findByUsername(String name){
          return (User)sessionProvider.get().createQuery("from User where username='"+name+"'").uniqueResult();
      }
    public Integer findIdByLatestUpdate(){
              return (Integer)sessionProvider.get().createQuery("select id from User  where createDate=(select max(createDate) from User)").uniqueResult();
          }
   public List<User> getAllDeletedUser() {
        return (List<User>)sessionProvider.get().createQuery("FROM User where deleted='1'").list();
    }
    @Transactional
      public void restoreAllUser()
    {
        sessionProvider.get().createQuery("UPDATE User SET deleted=0 WHERE deleted=1").executeUpdate();

    }
    @Transactional
    public void restoreUser(int id)
    {
        sessionProvider.get().createQuery("UPDATE User SET deleted=0 WHERE id="+id).executeUpdate();

    }
}



