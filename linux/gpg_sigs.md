# On signer side
1. Generate key
```
gpg --batch --passphrase '' --quick-gen-key $USER default default
```
```
--batch indicates we want to run in batch mode (minimizes the prompts)

--passphrase '' indicates to use no passphrase, but because it is specified there will be no prompt for a passphrase

--quick-gen-key indicates we want to generate a key
USER_ID should be replaced with your own user ID — or email address

default indicates to use the default algorithm

default indicates to use the default usage
```

2. List
```
gpg --list-secret-keys
gpg --list-keys
```

3. Sign the file. It will create a signed file in binary unencrypted format with file name.gpg
```
gpg --sign file.txt
```
- OPTIONAL: Create a signed file as a plaintext
```
gpg --output file.sig --clearsign file.txt
```
- OPTIONAL: Create an encrypted signed file. `This will encrypt the file using public key of the reciever, so first need to import public key of the reciever. Then encrypt and sign, this will guaranty that only recipient can verify and decrypt the file.`
```
gpg --sign --encrypt --recipient $USER file.txt
```

4. Export public key so everyone could verify your signature
```
gpg --export -a $USER > user.pub

Export secret key, only if needed.

gpg --export-secret-key -a $USER > user.key
```

# On reciever side
1. Import public key
```
gpg --import user.pub
```
- OPTIONAL: To validate encrypted signed file need to import private key, or sender should enrypt it using existing key
```
gpg --import user.key
```
2. List Keys
```
gpg --list-keys
gpg --list-secret-key
```
3. Verify `unecnrypted` signed file. This will warn that the signature is good, but it is untrusted.
```
gpg --verify file.txt.gpg
```

4. To trust the key
```
gpg --edit-key key-id from gpg --list-keys

trust
5
y
q
```

5. Extract the file. Work the same with encrypted or unencrypted file
```
gpg --output validated.txt --decrypt file.txt.gpg
```
