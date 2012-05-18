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
         if(taxDao.getMaxTax()){
             taxlst=taxDao.listAll();
        return new ForwardResolution(UPDATETAX);
        }

        else
            return new ForwardResolution(ADDTAX);
    }
       
    
      public Resolution addTax()
      {
         
              for(Iterator<Tax> i=taxlst.iterator();i.hasNext();){
             taxDao.save(i.next());
        }
                 
          return new RedirectResolution(TaxActionBean.class,"addTaxLink");

      }

    public Resolution getTaxById(){
        tax  =taxDao.find(id);
         return new JavaScriptResolution(tax);
    }
      public Resolution updateTax(){
                    taxDao.save(getTax());
           return new RedirectResolution(TaxActionBean.class,"addTaxLink");
      }

}
