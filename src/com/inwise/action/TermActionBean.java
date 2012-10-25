package com.inwise.action;

import net.sourceforge.stripes.action.*;
import com.google.inject.Inject;
import com.inwise.pojo.Term;
import com.inwise.dao.TermDao;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 25, 2012
 * Time: 10:54:06 AM
 * To change this template use File | Settings | File Templates.
 */
public class TermActionBean extends BaseActionBean{
      @Inject
      protected TermDao termdao;
     private Term term;
    private static final String ADDTERM="jsp/addTerms.jsp" ;

    public Term getTerm() {
        return term;
    }

    public void setTerm(Term term) {
        this.term = term;
    }

    @DefaultHandler
     public Resolution termsPageRedirect()
    {
    term=termdao.findByMaxId();
    return new ForwardResolution(ADDTERM);

    }
  public Resolution saveTerm()
    {
    termdao.SaveTerm(term);
  //  getContext().getMessages().add(new LocalizableMessage("/Purchase.action.term.add.success"));
    return new RedirectResolution(TermActionBean.class,"termsPageRedirect");
    }
}
