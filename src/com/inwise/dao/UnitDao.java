package com.inwise.dao;

import com.wideplay.warp.persist.Transactional;
import com.inwise.pojo.Unit;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 23, 2012
 * Time: 1:41:42 PM
 * To change this template use File | Settings | File Templates.
 */
public class UnitDao extends BaseDao<Unit,Integer>{
    public UnitDao() {
        super(Unit.class);
    }

    @Transactional
    public List getUnit(){
        return sessionProvider.get().createQuery("from Unit where deleted='0'").list();
    }@Transactional
    public List getUnitNameList(){
        return sessionProvider.get().createQuery("select name from Unit where deleted='0'").list();
    }

    @Transactional
    public boolean SaveUnit(Unit unit)

    {
        try {
            if(unit!=null){
                sessionProvider.get().save(unit);
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }

    }
    @Transactional
    public void delete(Unit unit){
        try{
            unit.setDeleted(1);
            sessionProvider.get().update(unit);
        }catch (Exception e){
            e.printStackTrace();

        }
    }

    public Unit findById(Integer id){
        return (Unit)sessionProvider.get().createQuery("from Unit where id='"+id+"'").uniqueResult();
    }
    @Transactional
    public void update(Unit unit){
        try{
            sessionProvider.get().update(unit);
        }catch (Exception e){
            e.printStackTrace();

        }
    }

     public boolean checkUnitPresent(String addUnitName) {
        String u;
        boolean f=false;
        try{
            u= (String) sessionProvider.get().createQuery("select name from Unit where deleted='0' and name='"+addUnitName+"'").uniqueResult();
            if(u!=null)
                f=true;
        }
        finally{
        }

        return f;  //To change body of implemented methods use File | Settings | File Templates.
    }
}


