package com.inwise.dao;


import com.inwise.pojo.Payment;

import java.util.List;
import java.util.Iterator;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: May 25, 2012
 * Time: 11:08:51 AM
 * To change this template use File | Settings | File Templates.
 */
public class PaymentDao extends BaseDao<Payment,Integer>{
       public PaymentDao() {
        super(Payment.class);
    }

    public Payment findByCustomerId(Integer id) {
        return (Payment)sessionProvider.get().createQuery("select p from Payment p where p.invoice.customer.id='"+id+"'").uniqueResult();  //To change body of created methods use File | Settings | File Templates.
    }
    

    }

