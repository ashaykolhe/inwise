package com.inwise.dao.implementation;

import com.inwise.dao.BaseDao;
import com.inwise.dao.ProductMeasurementTypeDao;
import com.inwise.pojo.ProductMeasurementType;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: May 11, 2012
 * Time: 12:33:44 PM
 * To change this template use File | Settings | File Templates.
 */
public class ProductMeasurementTypeDaoImpl extends BaseDao<ProductMeasurementType,Integer> implements ProductMeasurementTypeDao {
     public ProductMeasurementTypeDaoImpl() {
        super(ProductMeasurementType.class);
    }
}
