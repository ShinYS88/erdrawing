package kr.or.ddit.util.encrypt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class SecurityUtil {
	private Logger logger = LoggerFactory.getLogger(SecurityUtil.class);

	public static String encryptSHA256(String str) {

		String sha = "";

		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}

			sha = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			sha = null;
		}
		return sha;
	}

	public static String encryptMD5(String str) {

		String md5 = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}

			md5 = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			md5 = null;
		}
		return md5;
	}

	public static String Decrypt(String text, String key){
		String result = null;
		
		try{
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	
			byte[] keyBytes = new byte[16];
	
			byte[] b = key.getBytes("UTF-8");
	
			int len = b.length;
	
			if (len > keyBytes.length)
				len = keyBytes.length;
	
			System.arraycopy(b, 0, keyBytes, 0, len);
	
			SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
	
			IvParameterSpec ivSpec = new IvParameterSpec(keyBytes);
	
			cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);
	
			BASE64Decoder decoder = new BASE64Decoder();
	
			byte[] results = cipher.doFinal(decoder.decodeBuffer(text));
			result = new String(results, "UTF-8");
		}catch(Exception e){
		}
		return result;
	}

	public static String Encrypt(String text, String key){
		byte[] results = null;
		try{
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");

			byte[] keyBytes = new byte[16];

			byte[] b = key.getBytes("UTF-8");

			int len = b.length;

			if (len > keyBytes.length)
				len = keyBytes.length;

			System.arraycopy(b, 0, keyBytes, 0, len);

			SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");

			IvParameterSpec ivSpec = new IvParameterSpec(keyBytes);

			cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);

			results = cipher.doFinal(text.getBytes("UTF-8"));

			
		}catch(Exception e){
			
		}
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(results);

	}
}
