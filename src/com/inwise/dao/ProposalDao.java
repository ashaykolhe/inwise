package com.inwise.dao;

import com.inwise.pojo.Proposal;
import com.wideplay.warp.persist.Transactional;

import java.util.Properties;
import java.util.List;
import java.io.File;
import java.io.FileInputStream;
import java.io.ByteArrayOutputStream;

import org.codemonkey.simplejavamail.Email;
import org.codemonkey.simplejavamail.Mailer;
import org.codemonkey.simplejavamail.TransportStrategy;

import javax.mail.util.ByteArrayDataSource;
import javax.mail.Message;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 26, 2012
 * Time: 11:46:21 AM
 * To change this template use File | Settings | File Templates.
 */
public class ProposalDao extends BaseDao<Proposal,Integer>{

    public ProposalDao() {
        super(Proposal.class);
    }

@Override @Transactional
public List<Proposal> listAll() {
      
      return    sessionProvider.get().createQuery("from Proposal ORDER BY id DESC ").list();


}
    public void sendGeneralMail(Integer id) {
        try {
                Properties prop = new Properties();
                prop.load(this.getClass().getResourceAsStream("/email.properties"));
                Email email=new Email();
                String drivePath=prop.getProperty("drivePath");
                String emailFrom=prop.getProperty("emailFrom");
                String mimetype=prop.getProperty("mimetype");
                String fileExtension=prop.getProperty("fileExtension");
                String pass=prop.getProperty("pass");
                int port=Integer.parseInt(prop.getProperty("port"));
                String hostName=prop.getProperty("hostName");
                Proposal po=find(id);
                String emailTo=po.getCustomer().getEmail();
                final String name=""+po.getCustomer().getName()+""+"_"+po.getId()+fileExtension;
                byte []data=null;
             /*   File file = new File(drivePath+name);
                FileInputStream fis = null;
                fis = new FileInputStream(file);
                ByteArrayOutputStream bos = new ByteArrayOutputStream();
                data = new byte[(int) file.length()] ;

                for (int readNum; (readNum = fis.read(data)) != -1;) {
                bos.write(data, 0, readNum); //no doubt here is 0
                //Writes len bytes from the specified byte array starting at offset off to this byte array output stream.
                System.out.println("read " + readNum + " bytes,");
                }
                final ByteArrayDataSource dataSource = new ByteArrayDataSource(data,mimetype);
*/
                email.addRecipient("",emailTo, Message.RecipientType.TO);
                email.setFromAddress("",emailFrom);
              //  email.addAttachment(name,dataSource);
                email.setSubject("Hi this is mail from bajaj.minal@gmail.com to check inwise");
                email.setText("for approval of proposal order");

                new Mailer(hostName,port,emailFrom,pass, TransportStrategy.SMTP_SSL).sendMail(email);

        } catch (Exception e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }

       }

     public Proposal findByLastUpdate() {
        return (Proposal)sessionProvider.get().createQuery("from Proposal order by id desc").setMaxResults(1).uniqueResult();
    }
    
}
