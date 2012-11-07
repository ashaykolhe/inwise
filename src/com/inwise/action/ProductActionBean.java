package com.inwise.action;

import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;
import com.inwise.pojo.Product;
import com.inwise.pojo.Unit;
import com.inwise.dao.ProductDao;
import com.inwise.dao.UnitDao;
import com.google.inject.Inject;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: May 11, 2012
 * Time: 11:40:38 AM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/product")
@HttpCache(allow = false)
public class ProductActionBean extends BaseActionBean{

    private static final String ADDPRODUCT="jsp/addProduct.jsp";
    private static final String UPDATEPRODUCT="jsp/updateProduct.jsp";
    private static final String DELETEPRODUCT="jsp/deleteProduct.jsp";
     private static final String VIEWPRODUCT="jsp/viewProduct.jsp";
    Logger logger= LoggerFactory.getLogger(ProductActionBean.class);
     @Inject
     protected ProductDao productDao;
   @Inject
   UnitDao unitdao;
    private Product product;
  List<Unit> unitlst;
    private List<Product> prodlst;
     private String addProductName;
      private boolean flag;

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public List<Product> getProdlst() {
        return prodlst;
    }

    public void setProdlst(List<Product> prodlst) {
        this.prodlst = prodlst;
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public String getAddProductName() {
        return addProductName;
    }

    public void setAddProductName(String addProductName) {
        this.addProductName = addProductName;
    }

    public List<Unit> getUnitlst() {
        return unitlst;
    }

    public void setUnitlst(List<Unit> unitlst) {
        this.unitlst = unitlst;
    }

    @DefaultHandler
    public Resolution addProductLink()
    {
        unitlst=unitdao.getUnit();
        return new ForwardResolution(ADDPRODUCT);
    }
      public Resolution addProduct()
      {
            logger.info("created product: "+product);

              productDao.save(getProduct());
             getContext().getMessages().add(new LocalizableMessage("/Product.action.add.success"));
          return new RedirectResolution(ProductActionBean.class,"viewProductLink");
      }
    public Resolution productAlreadyPresent()
    {
       flag=productDao.checkProductPresent(addProductName);
        return new JavaScriptResolution(flag);
    }

    
   public Resolution updateProductLink()
   {
       prodlst=productDao.listAll();
    unitlst=unitdao.getUnit();
    
       return new ForwardResolution(UPDATEPRODUCT);
   }
    public Resolution getProductButton()
    {      unitlst=unitdao.getUnit();
        product=productDao.find(id);
        return updateProductLink();
    }
   public Resolution updateProduct()
   {
       productDao.save(product);
             getContext().getMessages().add(new LocalizableMessage("/Product.action.update.success"));
     return new RedirectResolution(ProductActionBean.class,"viewProductLink");
   }
    public Resolution deleteProductLink()
    {
          prodlst=productDao.listAll();
      return new ForwardResolution(DELETEPRODUCT);
    }
     public Resolution deleteProduct()
     {
         productDao.remove(id);
               getContext().getMessages().add(new LocalizableMessage("/Product.action.delete.success"));
         return new RedirectResolution(ProductActionBean.class,"viewProductLink");
     }
      public Resolution viewProductLink()
    {
          prodlst=productDao.listAll();
      return new ForwardResolution(VIEWPRODUCT);
    }

}
