package com.inwise.action;

import com.google.inject.Inject;
import com.inwise.pojo.Unit;
import com.inwise.dao.UnitDao;

import java.util.List;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.UrlBinding;
import net.sourceforge.stripes.ajax.JavaScriptResolution;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 23, 2012
 * Time: 1:48:06 PM
 * To change this template use File | Settings | File Templates.
 */
@UrlBinding("/unit")
public class UnitActionBean  extends BaseActionBean {
    List<Unit> unitlst;
    private Unit unit;
    @Inject
    UnitDao unitdao;
      private boolean flag;
      private String addUnitName;
      private static final String Unit="/jsp/displaytag/unit.jsp";
    public List<Unit> getUnitlst() {
        return unitlst;
    }

    public void setUnitlst(List<Unit> unitlst) {
        this.unitlst = unitlst;
    }

    public Unit getUnit() {
          if(id!=null && id != 0 ) {

               return unitdao.findById(id);
           }
        return unit;
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public String getAddUnitName() {
        return addUnitName;
    }

    public void setAddUnitName(String addUnitName) {
        this.addUnitName = addUnitName;
    }

    @DefaultHandler
    public Resolution paginationUnit(){
    unitlst=unitdao.getUnit() ;
    return new JavaScriptResolution(unitlst);
    }

    //To get section unique list by id
    public Resolution readname(){
        System.out.println("pagal");
    unit= unitdao.findById(id);
    return new JavaScriptResolution(unit);
    }
    //Add section
    public Resolution addunit(){
    unitdao.SaveUnit(getUnit());
    unitlst=unitdao.getUnit();
    return new ForwardResolution(Unit);
    }
    //Delete section
    public Resolution delete(){
    unitdao.delete(getUnit());
    unitlst=unitdao.getUnit();
    return new ForwardResolution(Unit);
    }

    //Update section
    public Resolution update(){
    unitdao.update(getUnit());
    unitlst=unitdao.getUnit();
    return new ForwardResolution(Unit);
    }

    public Resolution checkUnitAlreadyPresent()
    {
        flag=unitdao.checkUnitPresent(addUnitName);
        return new JavaScriptResolution(flag);
    }

    }
