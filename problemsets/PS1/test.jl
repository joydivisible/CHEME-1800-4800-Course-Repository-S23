include("Include.jl")

plaintext = "This is a test"

run = encrypt(plaintext)
test = decrypt(run)