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

    private CompanyInfo companyInfo;

    private FileBean logo;
    private static final String ADDCOMPANY="jsp/addCompany.jsp";
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
         
        if(companyInfo!=null){
            FileOutputStream fos =null;
            try{
                byte[] imageBytes=companyInfo.getCompLogo();
                InputStream is = new ByteArrayInputStream(imageBytes);
                String filename="companyLogo.jpg";
                String relativePath="/images/" + filename;

                
                fos = new FileOutputStream(getContext().getRequest().getRealPath("/")+"/images/"  + filename);
                int b = 0;
                while ((b = is.read()) != -1)
                {
                    fos.write(b);
                }
                fos.flush();
                    fos.close();
            }catch(Exception e){
                e.printStackTrace();
            }
        }
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
