#DES encryption/decryption using ECB

class DES
	@@pc1 = [57, 49, 41, 33, 25, 17, 9,
			1, 58, 50, 42, 34, 26, 18,
			10, 2, 59, 51, 43, 35, 27,
			19, 11, 3, 60, 52, 44, 36,
			63, 55, 47, 39, 31, 23, 15,
			7, 62, 54, 46, 38, 30, 22,
			14, 6, 61, 53, 45, 37, 29,
			21, 13, 5, 28, 20, 12, 4]
			
	@@pc2 = [14, 17, 11, 24, 1, 5,
			3, 28, 15, 6, 21, 10,
			23, 19, 12, 4, 26, 8,
			16, 7, 27, 20, 13, 2,
			41, 52, 31, 37, 47, 55,
			30, 40, 51, 45, 33, 48,
			44, 49, 39, 56, 34, 53,
			46, 42, 50, 36, 29, 32]
			
	@@ip = [58, 50, 42, 34, 26, 18, 10, 2,
            60, 52, 44, 36, 28, 20, 12, 4,
            62, 54, 46, 38, 30, 22, 14, 6,
            64, 56, 48, 40, 32, 24, 16, 8,
            57, 49, 41, 33, 25, 17, 9, 1,
            59, 51, 43, 35, 27, 19, 11, 3,
            61, 53, 45, 37, 29, 21, 13, 5,
            63, 55, 47, 39, 31, 23, 15, 7]
			
	@@ebit = [32, 1, 2, 3, 4, 5,
                  4, 5, 6, 7, 8, 9,
                  8, 9, 10, 11, 12, 13,
                 12, 13, 14, 15, 16, 17,
                 16, 17, 18, 19, 20, 21,
                 20, 21, 22, 23, 24, 25,
                 24, 25, 26, 27, 28, 29,
                 28, 29, 30, 31, 32, 1]
	
	@@s = Array.new
	
	@@s[0] = [14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
      0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
      4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
     15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13]
	 
	 @@s[1] = [15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10,
			3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5,
			0 ,14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15,
			13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9]
	 
	@@s[2] = [10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8,
			13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1,
			13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7,
			1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12]
	  
	@@s[3] = [7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15,
			13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9,
			10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4,
			3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14]
	  
	@@s[4] = [2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9,
			14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6,
			4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14,
			11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3]
	 
	@@s[5] = [12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11,
			10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8,
			9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6,
			4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13]
	  
	@@s[6] = [4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1,
			13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
			1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2,
			6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12]
	  
	@@s[7] = [13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
			1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2,
			7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8,
			2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11]
	
	@@ps = [16, 7, 20, 21,
			29, 12, 28, 17,
			1, 15, 23, 26,
			5, 18, 31, 10,
			2, 8, 24, 14,
			32, 27, 3, 9,
			19, 13, 30, 6,
			22, 11, 4, 25]

	@@lastip = [40, 8,  48, 16, 56,  24, 64,  32,
				39, 7,  47, 15, 55,  23, 63,  31,
				38, 6,  46, 14, 54,  22, 62,  30,
				37, 5,  45, 13, 53,  21, 61,  29,
				36, 4,  44, 12, 52,  20, 60,  28,
				35, 3,  43, 11, 51,  19, 59,  27,
				34, 2,  42, 10, 50,  18, 58,  26,
				33, 1,  41, 9, 49,  17, 57,  25]
	
	

	#Converts a hexadecimal string to a binary string
	#Params:
	#	string	-> Hexadecimal string to convert
	#	length	-> Length of returned binary string
	#Returns:
	#	Binary String of size length
	def str_to_bin(string, length)
		bin = "%0#{length}b" % string.hex.to_i
		return bin
	end

	#Converts binary String to Integer
	#Params:
	#	string -> binary String
	#Returns:
	#	Integer
	def bin_to_int(string)
		int = string.to_i(2)
		return int
	end
	
	#XOR two Strings of binary
	#Params:
	#	string1 -> First binary String
	#	string2 -> Second binary String
	#Returns:
	#	String of binary numbers of the same size as the biggest given string
	def str_xor(string1, string2)
		result = Array.new()
		string1.split(",").map(&:to_i)
		string2.split(",").map(&:to_i)
		for i in 0..([string1.length, string2.length].max - 1)
			result.push(string1[i].to_i ^ string2[i].to_i)
		end
		return result.join()
	end
	
	#Permutates a String of binary using lookup table
	#Params:
	#	binString -> Binary string to permutate
	#	table	->	Lookup table used to permutate
	#Returns:
	#	Permutated binary String
	def permutate(binString, table)
		newkey = Array.new(table.length){0}
		for i in 0..table.length-1
			newkey[i] = binString[table[i]-1]
		end
		return newkey.join()
	end

	
	#Shift binary key 16 times using amount of shifts: 1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1
	#Params:
	#	key -> String of binary to shift
	#Returns:
	#	Array of shifted sub keys
	def shift16(key)
		combined = Array.new
		left = Array.new(1){key[0, key.length/2]}
		right = Array.new(1){key[key.length/2, key.length-1]}
		
		for i in 0..15
			newKeyLeft = Array.new
			newKeyRight = Array.new
			
			oldKeyLeft = left[i]
			oldKeyLeft.split(",").map(&:to_i)
			
			oldKeyRight = right[i]
			oldKeyRight.split(",").map(&:to_i)
			
			if(i == 0 || i == 1 || i == 8 || i == 15)
				shifts = 1
			else
				shifts = 2
			end
			
			for j in 0..oldKeyLeft.length-1
				if(shifts == 2 && j == oldKeyLeft.length-2)
					newKeyLeft[j] = oldKeyLeft[0]
					newKeyLeft[j+1] = oldKeyLeft[1]
					
					newKeyRight[j] = oldKeyRight[0]
					newKeyRight[j+1] = oldKeyRight[1]
					break;
				end
				if(j == oldKeyLeft.length-1)
					newKeyLeft[j] = oldKeyLeft[0]
					
					newKeyRight[j] = oldKeyRight[0]
				else
					if(shifts == 2)
						newKeyLeft[j] = oldKeyLeft[j + 2]
						
						newKeyRight[j] = oldKeyRight[j + 2]
					else
						newKeyLeft[j] = oldKeyLeft[j + 1]
						
						newKeyRight[j] = oldKeyRight[j + 1]
					end
				end
			end

			left.push(newKeyLeft.join())
			
			right.push(newKeyRight.join())
			
			combined.push((newKeyLeft << newKeyRight).join())
		end
		
		return combined
	end
	
	#Uses sbox to lookup values for a binary string
	#Params:
	#	string -> String to convert using a sbox
	#	sbox ->	Array of lookup values
	#Returns:
	#	String of binary values
	def sboxValue(string, sbox)
		row = bin_to_int((string[0] << string[5]))
		column = bin_to_int(string[1, 4])
		value = 16 * row + column
		return "%04b" % sbox[value]
	end
	
	
	#Performs the most important parts of DES using sboxs, etc
	#Params: 
	#	right -> String of binary to encrypt
	#	key ->	String sub key used to encrypt
	#Returns:
	#	String of encrypted binary
	def f(right, key)
		
		expansion = permutate(right, @@ebit)
		expansion = str_xor(expansion, key)
		
		sBoxArr = Array.new
		
		for i in 0..7
			sBoxArr.push(sboxValue(expansion[(6*i), 6], @@s[i]))
		end
		
		sBoxArr = sBoxArr.join()
		
		sBoxArr = permutate(sBoxArr, @@ps)
		
		return sBoxArr
	end
	
	#Encrypts or Decrypts blocks of hexed text using a key
	#uses ECB so when encrypting every 64 bit block is taken and encrypted,
	#when a block is not 64 bits it gets padded to the right with 0s, keys 
	#less than 64 bits also get padded with 0s
	#Params:
	#	text -> String of hexadecimal value to encrypt/decrypt
	#	key -> String of hexadecimal key value used to encrypt/decrypt, 64bit maximum
	#	mode -> 0 for encryption, 1 for decryption
	#Returns:
	#	String of encrypted or decrypted text in hexadecimal
	def crypt(text, key, mode)
		results = Array.new

		#Pad key with 0s if not 64 bits
		if(key.length < 16)
			for k in key.length..15
					key[k] = "0"
			end
		end
		
		if(key.length > 16)
			abort("ERROR: Key #{key} too large, needs to be <= 16")
		end
		
		
		text = text.split(",")
		text.each_slice(16) do |x,y|
		
			#Pad right with 0s if any block is too small
			if(x.length < 16)
				for k in x.length..15
					x[k] = "0"
				end
			end
			text = "%s" % text

			binText = str_to_bin(text, 64)
			permutatedText = permutate(binText, @@ip)
			
			textLeft = permutatedText[0, permutatedText.length/2]
			textRight = permutatedText[permutatedText.length/2, permutatedText.length-1]
		
			binKey = str_to_bin(key, 64)
			permutatedKey = permutate(binKey, @@pc1)

			subKeys = shift16(permutatedKey)
				
			oldLeft = textLeft
			
			#important: Go forward when encrypting, go backwards when decrypting
			loop = (mode == 1 ? (subKeys.length-1).downto(0) : (0).upto(subKeys.length-1))
			
			loop.each do |i|
				subKeys[i] = permutate(subKeys[i], @@pc2)

				textLeft = oldLeft
				oldLeft = textRight
				textRight = str_xor(textLeft, f(textRight, subKeys[i]))
			end
			
			textLeft = oldLeft

			result = permutate((textRight << textLeft), @@lastip)
			
			#store results as hex
			results.push((result.to_i(2)).to_s(16))
			
		end
		
		return results
	end
	
	#Encrypt a hexadecimal value using key, friendly call go crypt
	#Params:
	#	plainText	-> Hexadecimal String to encrypt
	#	key			-> Key String used to encrypt
	#Returns:
	#	Encrypted hexadecimal String
	def encrypt(plainText, key)
		return crypt(plainText, key, 0)
	end
	
	#Encrypt a hexadecimal value using key, friendly call go crypt
	#Params:
	#	cipherText	-> Encrypted String in hexadecimal
	#	key			-> Key String used to decrypt
	#Returns:
	#	Decrypted hexadecimal String
	def decrypt(cipherText, key)
		return crypt(cipherText, key, 1)
	end
	
end

if __FILE__==$0
	example = DES.new
	value = example.encrypt("0123456789ABCDEF", "133457799BBCDFF1")
	puts(value)
	value = example.decrypt("85e813540f0ab405", "133457799BBCDFF1")
	puts(value)
	
end