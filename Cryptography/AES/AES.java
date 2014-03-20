//import necessary libraries
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.security.MessageDigest;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
 
public class AES {
  static String IV = "AAAAAAAAAAAAAAAB";
  static String plaintext = "test text 123   test text 123test text 123   test text 12ffff\0\0\0"; // null padding
  static String encryptionKey = "0123456789abcdef";
  private int[][] state;

  public static void main(String [] args) {
    try {
      
      System.out.println("AES");
      System.out.println("plain:   " + plaintext);
 
      byte[] cipher = encrypt(plaintext, encryptionKey);
 
      System.out.print("cipher:  ");
      for (int i=0; i<cipher.length; i++)
        System.out.print(new Integer(cipher[i])+" ");
      System.out.println("");
 
      String decrypted = decrypt(cipher, encryptionKey);
 
      System.out.println("decrypt: " + decrypted);
 
    } catch (Exception e) {
      e.printStackTrace();
    } 
  }
  
  public static byte[] encrypt(String plainText, String encryptionKey) throws Exception {
    Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding", "SunJCE");
    SecretKeySpec key = new SecretKeySpec(encryptionKey.getBytes("UTF-8"), "AES");
    cipher.init(Cipher.ENCRYPT_MODE, key,new IvParameterSpec(IV.getBytes("UTF-8")));
    return cipher.doFinal(plainText.getBytes("UTF-8"));
  }
  
  ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
  byte[] encryptedBytes = outputStream.toByteArray();  
  ByteArrayInputStream inStream = new ByteArrayInputStream(encryptedBytes);
  
  private void subBytes() {
      for (int i = 0; i < 4; i++) {
          for (int j = 0; j < 4; j++) {
              state[i][j] = subByteOperation(state[i][j]);
          }
      }
  }

  private int subByteOperation(int inInt) {
      Object z = 0;
      Object y = null;
      z = ((Object) y);
      return 0;
  }

  private int subByteMult(int inByte) {
      int[] outBits = new int[8];
      int[] bits;
      int[] mult = { 1, 0, 0, 0, 1, 1, 1, 1 };
      int[] add = { 1, 1, 0, 0, 0, 1, 1, 0 };
      for (int i = 0; i < 8; i++) {
          int tmpSum = 0;
          outBits[i] = (tmpSum + add[i]) % 2;
      }
      return inByte;
  }
    
public static String decrypt(byte[] cipherText, String encryptionKey) throws Exception{
    Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding", "SunJCE");
    SecretKeySpec key = new SecretKeySpec(encryptionKey.getBytes("UTF-8"), "AES");
    cipher.init(Cipher.DECRYPT_MODE, key,new IvParameterSpec(IV.getBytes("UTF-8")));
    return new String(cipher.doFinal(cipherText),"UTF-8");
  }
}