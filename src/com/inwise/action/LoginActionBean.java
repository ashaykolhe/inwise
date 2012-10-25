package com.inwise.action;

    import net.sourceforge.stripes.action.*;

    import com.inwise.exception.LoginException;
    import com.inwise.dao.TrailDate;

    import com.inwise.pojo.Traildate;

    import com.google.inject.Inject;

    import java.util.List;

    /**
    * Created by IntelliJ IDEA.
    * User: Milind
    * Date: Feb 9, 2012
    * Time: 10:42:59 AM
    * To change this template use File | Settings | File Templates.
    */
    @HttpCache(allow = false)
    public class LoginActionBean extends BaseActionBean{
    @Inject
    protected TrailDate traildate;

        private static final String Login="jsp/login.jsp";
         private static final String DASHBOARD="jsp/dashBoard.jsp";
       

        @DefaultHandler
    public Resolution login()
    {
    if(traildate.checkPeriod(new Traildate())==1) {
        try
        {

            getContext().setUser(userDao.authenticate(getUser()));


        }
        catch(LoginException le)
        {
            getContext().getMessages().add(new SimpleMessage("Invalid User"));

            return new RedirectResolution(LoginActionBean.class,"redirectlogin");
        }

        return new ForwardResolution(LoginActionBean.class,"redirectToHome");
    }
    else
    {
        getContext().getMessages().add(new SimpleMessage("Trial period is over"));
        return new RedirectResolution(LoginActionBean.class,"redirectlogin");
    }

    }
    public Resolution redirectToHome()
    {
       // vendorList=vendorDao.listAll();
        return new ForwardResolution(DASHBOARD);
    }
    public Resolution redirectlogin()
    {

        return new ForwardResolution(Login);
    }

    public Resolution logout(){
    getContext().logout();
    return new RedirectResolution(LoginActionBean.class,"redirectlogin");
    }
    }
