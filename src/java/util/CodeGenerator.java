package util;

import java.security.SecureRandom;
import java.util.Base64;
import java.util.UUID;

public class CodeGenerator {

    private static final SecureRandom random = new SecureRandom();
    
    public static String randomToken() {
        byte[] b = new byte[32]; // 256-bit
        random.nextBytes(b);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(b);
    }

    public static String generateVerificationCode() {
        return String.format("%06d", random.nextInt(999999));
    }

    public static String generateResetToken() {
        return UUID.randomUUID().toString();
    }
}
