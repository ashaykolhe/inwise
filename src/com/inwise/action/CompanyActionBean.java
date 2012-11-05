package com.inwise.action;

import com.google.inject.Inject;
import com.inwise.dao.CompanyDao;
import com.inwise.pojo.CompanyInfo;

import net.sourceforge.stripes.action.*;

import javax.imageio.ImageIO;
import java.io.*;
import java.awt.image.WritableRaster;

/**
 * Created by IntelliJ IDEA.
 * User: Atul
 * Date: Jul 3, 2012
 * Time: 3:22:58 PM
 * To change this template use File | Settings | File Templates.
 */
public class CompanyActionBean extends BaseActionBean
{
    @Inject
    CompanyDao companyDao;
    private static final String ADDCOMPANY="jsp/addCompany.jsp";
    private CompanyInfo companyInfo;

    private FileBean logo;

    public FileBean getLogo() {
        return logo;
    }

    public void setLogo(FileBean logo) {
        this.logo = logo;
    }

    public CompanyInfo getCompanyInfo() {
        return companyInfo;
    }

    public void setCompanyInfo(CompanyInfo companyInfo) {
        this.companyInfo = companyInfo;
    }

    @DefaultHandler
    public Resolution pre()
    {
          companyInfo=companyDao.findByLastUpdate();
  /*      System.out.println("companyInfoimage"+companyInfo.getCompLogo());
        if(companyInfo!=null){
            try{
                 byte[] imageBytes=null;
                InputStream in = new ByteArrayInputStream(imageBytes);
         ImageIO.read(in);
       *//*          ByteArrayOutputStream out = new ByteArrayOutputStream();
       ImageIO.write("".toString(), "PNG" *//**//* for instance *//**//*, out);*//*
       // imageBytes = out.toByteArray();
}catch(Exception e){
e.printStackTrace();
}
       //     BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(c);
        }*/
        System.out.println(companyInfo);
        return new ForwardResolution(ADDCOMPANY);
    }
    public Resolution addCompany()
    {

            byte[] bFile=null;
        try {

            bFile = new byte[Integer.valueOf(String.valueOf(logo.getSize()))];

            BufferedInputStream buffered=new BufferedInputStream(logo.getInputStream());
            buffered.read(bFile);
	     //convert file into array of bytes
	     buffered.close();
        } catch (Exception e) {
	     e.printStackTrace();
        }
           System.out.println("company"+getCompanyInfo());
        companyInfo.setCompLogo(bFile);
        companyDao.save(companyInfo);
        getContext().getMessages().add(new LocalizableMessage("/Company.action.add.success"));
        return new RedirectResolution(CompanyActionBean.class,"pre");
    }

}
