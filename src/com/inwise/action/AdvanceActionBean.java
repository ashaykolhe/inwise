package com.inwise.action;

import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.ajax.JavaScriptResolution;
import com.inwise.pojo.Advance;
import com.inwise.pojo.PaymentMode;
import com.inwise.dao.AdvanceDao;
import com.inwise.dao.PaymentModeDao;
import com.inwise.dao.OrderDao;
import com.google.inject.Inject;

import java.util.List;
import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: Ashay
 * Date: May 22, 2012
 * Time: 12:09:47 PM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/advance")
public class AdvanceActionBean extends BaseActionBean{
    private static final String ADVANCE="jsp/advance.jsp";
    private static final String ADVANCERECEIPT="jsp/receipt/advanceReceipt.jsp";
    @Inject
    AdvanceDao advanceDao;

    @Inject
    PaymentModeDao paymentModeDao;

    @Inject
    OrderDao orderDao;

    private Advance advance;
    private boolean redirectAdvance;
    private boolean popup;
    private List<PaymentMode> paymentModeList=new ArrayList<PaymentMode>();

    public List<PaymentMode> getPaymentModeList() {
        return paymentModeList;
    }

    public void setPaymentModeList(List<PaymentMode> paymentModeList) {
        this.paymentModeList = paymentModeList;
    }

    public Advance getAdvance() {
        return advance;
    }

    public void setAdvance(Advance advance) {
        this.advance = advance;
    }

    public boolean isRedirectAdvance() {
        return redirectAdvance;
    }

    public void setRedirectAdvance(boolean redirectAdvance) {
        this.redirectAdvance = redirectAdvance;
    }

    public boolean isPopup() {
        return popup;
    }

    public void setPopup(boolean popup) {
        this.popup = popup;
    }

    @DefaultHandler
    public Resolution pre(){
        
        return new ForwardResolution(ADVANCE);
    }

    public Resolution redirectAdvance(){
        paymentModeList=paymentModeDao.listAll();
        id=orderDao.latestOrderId();
        redirectAdvance=true;
        return new ForwardResolution(ADVANCE);
    }

    public Resolution saveAdvance(){
        advanceDao.save(advance);
        popup=true;
        return new RedirectResolution(AdvanceActionBean.class,"redirectAdvance").addParameter("popup",popup);
    }

    public Resolution advancePopup()
   {
       advance = advanceDao.latestAdvanceReceipt();
       return new ForwardResolution(ADVANCERECEIPT);
   }
    
}
