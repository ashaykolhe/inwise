package com.inwise.dao;

import com.inwise.pojo.CompanyInfo;

/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: Jul 3, 2012
 * Time: 3:27:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class CompanyDao extends BaseDao<CompanyInfo,Long>
{
    public CompanyDao()
    {
        super(CompanyInfo.class);
    }

    public boolean saveCompany(CompanyInfo company)
    {
        sessionProvider.get().save(company);
        return true;
    }

    public CompanyInfo findByLastUpdate() {
        return (CompanyInfo)sessionProvider.get().createQuery("from CompanyInfo order by id desc").setMaxResults(1).uniqueResult();
    }
    
}
