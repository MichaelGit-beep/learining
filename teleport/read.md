1. Add PEM key content to
```
vim /Users/michael.vareikis/.tsh/keys/readonly.pem
```
2. export TELEPORT_ADD_KEYS_TO_AGENT=only
3. tsh login --proxy=diag-t.axonius.com
4. tsh ls