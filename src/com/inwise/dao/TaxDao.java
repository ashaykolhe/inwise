package com.inwise.dao;

import com.inwise.dao.BaseDao;
import com.inwise.pojo.Tax;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: May 11, 2012
 * Time: 4:42:54 PM
 * To change this template use File | Settings | File Templates.
 */
public class TaxDao extends BaseDao<Tax,Integer>{
     public TaxDao() {
        super(Tax.class);
    }

    public boolean getMaxTax(){
        if(sessionProvider.get().createQuery("from Tax")!=null && sessionProvider.get().createQuery("from Tax").list().size()>0)    {
            return true;
        }
         return false;

     }
}
