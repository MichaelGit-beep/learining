## Encrypt string 
> For example, to encrypt the string ‘foobar’ using the only password stored in ‘a_password_file’ and name the variable ‘the_secret’:
```
ansible-vault encrypt_string --vault-password-file a_password_file 'foobar' --name 'the_secret'
```

## Encrypt file
```
ansible-vault encrypt --vault-password-file  secret file
```
## Decrypt file
```
ansible-vault decrypt --vault-password-file  secret file
```