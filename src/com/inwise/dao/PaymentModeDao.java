package com.inwise.dao;

import com.inwise.pojo.PaymentMode;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 22, 2012
 * Time: 5:05:43 PM
 * To change this template use File | Settings | File Templates.
 */
public class PaymentModeDao extends BaseDao<PaymentMode,Integer>{
    public PaymentModeDao() {
        super(PaymentMode.class);
    }
}
