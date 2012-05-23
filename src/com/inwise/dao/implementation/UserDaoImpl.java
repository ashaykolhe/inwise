package com.inwise.dao.implementation;

import com.wideplay.warp.persist.Transactional;
import com.inwise.dao.BaseDao;
import com.inwise.dao.UserDao;
import com.inwise.pojo.User;
import com.inwise.exception.LoginException;

import java.util.List;

import org.hibernate.criterion.Restrictions;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Feb 14, 2012
 * Time: 12:46:02 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserDaoImpl extends BaseDao<User,Integer> implements UserDao {
    public UserDaoImpl() {
        super(User.class);
    }

        public User authenticate(String username, String password) throws LoginException {
            User val=(User)sessionProvider.get()
                    .createQuery("from User where username=:user and password=:pass and deleted=:del")
                    .setString("user",username)
                    .setString("pass",password)
                    .setInteger("del",0)
                    .uniqueResult();
            if(val==null){
                throw new LoginException("invalid credentials");
            }
            return val;
        }


    public List<User> getUser(){
        return sessionProvider.get().createQuery("from User where deleted='0' and id <> 1").list();
    }

        @Override @Transactional
    public void remove(Integer id) {
            try{
                User user=super.find(id);
            user.setDeleted(1);
                System.out.println("prod in delete dao"+user);
                super.save(user);
                System.out.println("prod in delete dao2"+user);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public boolean checkUserPresent(String addUserName) {
        String u;
        boolean f=false;
        try{
            u= (String) sessionProvider.get().createQuery("select username from User where deleted='0' and username='"+addUserName+"'").uniqueResult();
            if(u!=null)
                f=true;
        }catch(Exception e){
            e.printStackTrace();
        }

        return f;  //To change body of implemented methods use File | Settings | File Templates.
    }


}



