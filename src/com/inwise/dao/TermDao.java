package com.inwise.dao;

import com.wideplay.warp.persist.Transactional;
import com.inwise.pojo.Term;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 25, 2012
 * Time: 10:58:40 AM
 * To change this template use File | Settings | File Templates.
 */
public class TermDao extends BaseDao<Term,Integer> {
    public TermDao() {
        super(Term.class);
    }

    public Term findByMaxId() {
         return (Term)sessionProvider.get().createQuery("from Term where id=(select max(id) from Term)").uniqueResult();
    }

     @Transactional
    public boolean SaveTerm(Term terms) {
       try {
            if(terms!=null){

                sessionProvider.get().merge(terms);
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
