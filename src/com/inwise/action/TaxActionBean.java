package com.inwise.action;

import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.inwise.pojo.Tax;
import com.inwise.dao.TaxDao;
import com.google.inject.Inject;

import java.util.List;
import java.util.Iterator;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: May 11, 2012
 * Time: 3:34:52 PM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/tax")
@HttpCache(allow = false)
public class TaxActionBean extends BaseActionBean{
    private static final String ADDTAX="jsp/addTax.jsp";
    private static final String UPDATETAX="jsp/updateTax.jsp";
    private static final String VIEWTAX="jsp/viewTax.jsp";

       @Inject
       protected TaxDao taxDao;
      Logger logger= LoggerFactory.getLogger(TaxActionBean.class);

    private Tax tax;
        private List<Tax> taxlst;

    public List<Tax> getTaxlst() {
        return taxlst;
    }

    public void setTaxlst(List<Tax> taxlst) {
        this.taxlst = taxlst;
    }

    public Tax getTax() {
        return tax;
    }

    public void setTax(Tax tax) {
        this.tax = tax;
    }

    @DefaultHandler
    public Resolution addTaxLink()
    {
       
            return new ForwardResolution(ADDTAX);
    }
       
    
      public Resolution addTax()
      {
         
             taxDao.save(getTax());

                 
          return new RedirectResolution(TaxActionBean.class,"viewTaxLink");

      }

    public Resolution getTaxById(){
        tax  =taxDao.find(id);
         return new ForwardResolution(UPDATETAX);
    }
      public Resolution updateTax(){
                    taxDao.save(getTax());
           return new RedirectResolution(TaxActionBean.class,"viewTaxLink");
      }

      public Resolution viewTaxLink(){
                 taxlst=taxDao.listAll();  
           return new ForwardResolution(VIEWTAX);
      }
}
