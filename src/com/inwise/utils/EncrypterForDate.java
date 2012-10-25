package com.inwise.utils;

import net.sourceforge.stripes.validation.TypeConverter;
import net.sourceforge.stripes.validation.ValidationError;

import java.util.Collection;
import java.util.Locale;

import org.jasypt.util.text.BasicTextEncryptor;

/**
 * Created by IntelliJ IDEA.
 * User: Minal
 * Date: Oct 16, 2012
 * Time: 3:29:43 PM
 * To change this template use File | Settings | File Templates.
 */
public class EncrypterForDate implements TypeConverter<String> {

/**
 * Created by IntelliJ IDEA.
 * User: Admin
 * Date: Mar 22, 2012
 * Time: 2:33:05 PM
 * To change this template use File | Settings | File Templates.
 */




    public String convert(String input, Class<? extends String> cls, Collection<ValidationError> errors)
    {
        //password-superadmin iJo6eRs4dc+uQTV0tT2ku4qQ1T4=
        return hash(input);
    }
    public String hash(String password) {
      
          BasicTextEncryptor encryptor = new BasicTextEncryptor();
             encryptor.setPassword("p1");
             String enc1 = encryptor.encrypt(password);
            return enc1;

    }
    public void setLocale(Locale locale) { }

    public String decrypt(String encrypt){
     
          BasicTextEncryptor encryptor2 = new BasicTextEncryptor();
                   encryptor2.setPassword("p1");
					String dec2 = encryptor2.decrypt(encrypt);
           
                  return dec2;

    }

}

