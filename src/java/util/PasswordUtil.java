package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class PasswordUtil {
    public static String hashPassword(String password) {
        if (password == null) {
            return null;
        }
        try {            
            MessageDigest md = MessageDigest.getInstance("SHA-256");
                       
            byte[] hashedBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));
                        
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {            
            throw new RuntimeException("Error: SHA-256 algorithm not found.", e);
        }
    }
    
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
                
        String hashedPlainPassword = hashPassword(plainPassword);
                
        return hashedPlainPassword.equals(hashedPassword);
    }
}
