package com.inwise.dao;

import com.inwise.dao.BaseDao;
import com.inwise.pojo.ProductMeasurementType;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: May 11, 2012
 * Time: 12:33:44 PM
 * To change this template use File | Settings | File Templates.
 */
public class ProductMeasurementTypeDao extends BaseDao<ProductMeasurementType,Integer> {
     public ProductMeasurementTypeDao() {
        super(ProductMeasurementType.class);
    }
}
