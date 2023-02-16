"""
    encrypt(plaintext::String) -> Dict{Int64,String}

Fill me in

Function "encrypt" translates the input text into codon notation as specified by the key.
"""
function encrypt(plaintext::String)::Dict{Int32,String}

      # initialize -
      message = Dict{Int64,String}()
      counter = 0;
  
      # build encryptionkey -
      encryption_model = _build(DNAEncryptionKey);
      encryptionkey = encryption_model.encryptionkey;
  
      for c ∈ uppercase(plaintext)
  
          # encrypt -
          message[counter] = encryptionkey[c]
  
          # update the counter -
          counter = counter + 1
      end
  
      # return -
      return message

  


end


"""
    decrypt(encrypteddata::Dict{Int64,String}) -> String

Fill me in

Function "decrypt" takes the input in codon notation and converts it back to the equivalent characters.
"""
function decrypt(encrypteddata::Dict{Int32,String})::String
   # initialize -
   number_of_chars = length(encrypteddata)
   inverse_encryptionkey_dict = Dict{String, Char}()
   plaintext = Vector{Char}()

   # build encryptionkey -
   encryption_model = _build(DNAEncryptionKey);
   encryptionkey = encryption_model.encryptionkey;

   # build the inverse_key -
   for (key, value) ∈ encryptionkey
       inverse_encryptionkey_dict[value] = key
   end

   for i ∈ 0:(number_of_chars - 1)
       
       codon = encrypteddata[i]
       value = inverse_encryptionkey_dict[codon]
       push!(plaintext, value)
   end

   # return -
   return String(plaintext)
    

end