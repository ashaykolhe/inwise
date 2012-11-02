package com.inwise.dao;

import com.inwise.dao.BaseDao;
import com.inwise.pojo.Traildate;
import com.inwise.utils.PasswordEncryptor;
import com.inwise.utils.EncrypterForDate;
import com.wideplay.warp.persist.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Iterator;

import org.hibernate.Query;

/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: Apr 18, 2012
 * Time: 3:52:07 PM
 * To change this template use File | Settings | File Templates.
 */
public class TrailDate extends BaseDao<Traildate,Long>
{
    public TrailDate() {
        super(Traildate.class);
    }

    @Transactional
    public int checkPeriod(Traildate traildate)
    {           EncrypterForDate encrypt=new EncrypterForDate();
        Traildate td=new Traildate();
        try
        {
            Query qry=sessionProvider.get().createQuery("from Traildate");
            List l=qry.list();
            Iterator it=l.iterator();
            if(!it.hasNext())
            {
                Date d=new Date();
                Date d1=new Date();
                d1.setDate(d.getDate()+365);
                String date1=encrypt.convert(String.valueOf(d.getTime()),null,null);
                String date2=encrypt.convert(String.valueOf(d1.getTime()),null,null);
                traildate.setDate1(date1);
                traildate.setDate2(date2);
                sessionProvider.get().save(traildate);
                return 1;
            }
            else
            {
                td=(Traildate)sessionProvider.get().load(Traildate.class,1);
                Date d=new Date();

                String s= encrypt.decrypt(td.getDate1());
                String s1=(encrypt.decrypt(td.getDate2()));

                Date firstDate=new Date(Long.valueOf(s));
                  Date secondDate=new Date(Long.valueOf(s1));
                if(d.compareTo(firstDate)==-1)
                {
                    return 0;
                }
                else
                if(d.compareTo(secondDate)==1)
                {
                    return 0;
                }
                else{
                    return 1;
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return 0;
    }


}
