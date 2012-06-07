package com.inwise.dao;

import com.inwise.pojo.Advance;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 22, 2012
 * Time: 12:10:11 PM
 * To change this template use File | Settings | File Templates.
 */
public class AdvanceDao extends BaseDao<Advance,Integer>{
    public AdvanceDao() {
        super(Advance.class);
    }

    public Advance latestAdvanceReceipt(){
        return (Advance)sessionProvider.get().createQuery("from Advance where id=(select max(id) from Advance)").uniqueResult();
    }

    public boolean advanceMadeOrNot(Integer id)
    {
        
        return sessionProvider.get().createQuery("from Advance where order.id="+id).uniqueResult()==null ? false : true;
    }

    public Advance getAdvancedByOrderId(Integer id) {
        return (Advance) sessionProvider.get().createQuery("select a From Advance a where a.order.id='"+id+"'").uniqueResult();  //To change body of created methods use File | Settings | File Templates.
    }
}
