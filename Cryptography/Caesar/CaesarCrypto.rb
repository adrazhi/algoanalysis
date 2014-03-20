#!/usr/bin/env ruby
#####################################################
# COS 350 Algorithms | Team 01
# Caesar-Cipher Encryption/Decryption
#####################################################
# DESCRIPTION:
#    Ciphers involve mapping each character of the
#    alphabet to a different letter. The weakest such 
#    ciphers rotate the alphabet by some fixed number 
#    of characters (often 13), and thus have only 26 
#    possible keys.	 
#
# => Good example of breaking "unsecure" cryptography
# => Constant-Time breaking case
#####################################################
#
# Usage:
#   cc.encrypt('A', 'TEST')   #=> "TEST"
#   cc.encrypt('R', "CAESAR") #=> "KVJK"
#	
#   cc.decrypt('A', 'CAESAR') #=> "CAESAR"
#   cc.decrypt('R', 'KVJK') #=> "TEST"
#####################################################


class CaesarCrypto
  FIRST_OFFSET = 65 	#'A'.unpack('C').first
  LAST_OFFSET  = 90 	#'Z'.unpack('C').first
  @@primCount = 0       #count primitive ops

  # INPUT: Plain Text and the given encryption key
  # OUTPUT: Encrypted Cipher Text
  def encrypt(key, plain_text)
    offset = key.upcase.unpack('C').first

    cipher_text = plain_text.upcase.split('').collect do |l| 
      cipher_letter = (l.unpack('C').first + offset - FIRST_OFFSET)
      if cipher_letter > LAST_OFFSET 
        cipher_letter -= ( LAST_OFFSET  - FIRST_OFFSET + 1 )
      end
      cipher_letter.chr
    end

    encryption_result = cipher_text.join
    
    #puts encryption_result
  end

  # INPUT: Previously Encrypted Cipher Text and the decryption key
  # OUTPUT: Decrypted Plain Text
  def decrypt(key, cipher_text)
    offset = key.upcase.unpack('C').first

    plain_text = cipher_text.split('').collect do |cipher_letter|
 	  @@primCount = @@primCount + 1
      if !('A'..'Z').include?(cipher_letter)
        cipher_letter
      else
        if cipher_letter.unpack('C').first >= offset
          @@primCount = @@primCount + 1
          letter = cipher_letter.unpack('C').first - offset
        else
          letter = (cipher_letter.unpack('C').first + (LAST_OFFSET  - FIRST_OFFSET + 1)) - offset
        end
        letter += FIRST_OFFSET
        letter.chr
      end
    end

    decryption_result = plain_text.join
    @@primCount = @@primCount + 2
    #puts decryption_result
  end

  def getPrimCount() 
  	return @@primCount
  end

end


if __FILE__==$0
  for i in (16..1008).step(16)
    o = [('a'..'f'), ('A'..'F')].map { |i| i.to_a }.flatten
    string = (0...i).map{ o[rand(o.length)] }.join
    example = CaesarCrypto.new

    value = example.encrypt("TEST", string)

    example.decrypt("TEST", value.to_s)
    print example.getPrimCount()
    print ","
  end
end