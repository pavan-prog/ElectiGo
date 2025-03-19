package voting.application.utility;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class Utils {


	public static String generateTempPassword() {
	    String characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*";
	    StringBuilder password = new StringBuilder(8);
	    SecureRandom random = new SecureRandom();

	    for (int i = 0; i < 8; i++) {
	        int randomIndex = random.nextInt(characters.length());
	        password.append(characters.charAt(randomIndex));
	    }
	    return password.toString();
	}


	public static String generateSalt() {

		String characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

		StringBuilder randomString = new StringBuilder(10); 
		
		SecureRandom random = new SecureRandom();

		for (int i = 0; i < 10; i++) {
			int randomIndex = random.nextInt(characters.length()); 
			randomString.append(characters.charAt(randomIndex));
		}
		return randomString.toString();
	}

	public static String generatePwdHash(String inputString) {
		
		String strHash = "";
		
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");

			byte[] hashBytes = digest.digest(inputString.getBytes(StandardCharsets.UTF_8));

			strHash = bytesToHex(hashBytes);

			System.out.println("Full Hash (64 characters): " + strHash);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return strHash;
	}

	private static String bytesToHex(byte[] bytes) {
		StringBuilder hexString = new StringBuilder(2 * bytes.length);
		for (byte b : bytes) {
			String hex = Integer.toHexString(0xff & b);
			if (hex.length() == 1) {
				hexString.append('0');
			}
			hexString.append(hex);
		}
		return hexString.toString();
	}
	
	public static String generateOtp(int length) {
	    String digits = "0123456789";
	    StringBuilder otp = new StringBuilder(length);
	    SecureRandom random = new SecureRandom();
	    for (int i = 0; i < length; i++) {
	        otp.append(digits.charAt(random.nextInt(digits.length())));
	    }
	    return otp.toString();
	}

}
