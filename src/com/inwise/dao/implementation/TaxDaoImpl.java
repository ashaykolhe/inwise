package com.inwise.dao.implementation;

import com.inwise.dao.BaseDao;
import com.inwise.dao.TaxDao;
import com.inwise.pojo.Tax;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: May 11, 2012
 * Time: 4:42:54 PM
 * To change this template use File | Settings | File Templates.
 */
public class TaxDaoImpl extends BaseDao<Tax,Integer> implements TaxDao {
     public TaxDaoImpl() {
        super(Tax.class);
    }

     public boolean getMaxTax(){
        if(sessionProvider.get().createQuery("from Tax")!=null && sessionProvider.get().createQuery("from Tax").list().size()>0)    {
            return true;
        }
         return false;

     }
}
