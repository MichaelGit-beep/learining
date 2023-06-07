```
───────┤ Configuring libpam-modules ├───────┐
 │                                            │
 │ you are using pam_tally or pam_tally2 in   │
 │ your configuration                         │
 │                                            │
 │ The pam_tally and pam_tally2 modules have  │
 │ been removed from PAM. You are using one   │
 │ of these modules in your PAM               │
 │ configuration in /etc/pam.d. You must      │
 │ remove the uses of these modules before    │
 │ PAM can be upgraded; including these       │
 │ modules in your PAM configuration after    │
 │ the upgrade will stop users from being     │
 │ able to log into the system.               │
 │                                            │
 │ Consider the pam_faillock module as a      │
 │ replacement for pam_tally.                 │
 │                                            │
 │                   <Ok>                     │
 │
```
 The message you received indicates that you are using either the pam_tally or pam_tally2 modules in your PAM (Pluggable Authentication Modules) configuration located in /etc/pam.d. However, these modules have been removed from PAM, and you need to remove their usage before upgrading PAM.

If you proceed with the upgrade while still including these modules in your PAM configuration, users will be unable to log into the system. To replace the functionality provided by pam_tally, you should consider using the pam_faillock module.

To address this issue, you need to make the following changes:


- Find all the mentions of pam_tally 
```
sudo find /etc/ -type f -exec grep -l -i "pam_tally" {} \;
```
- Open the PAM configuration file located at /etc/pam.d using a text editor.
- Look for any lines that include pam_tally or pam_tally2.
- Comment out or remove those lines from the configuration file.
- Save the changes to the file.


After making these changes, you should be able to proceed with the PAM upgrade without affecting user login functionality.


- sudo apt update
- sudo apt --fix-broken install
- sudo apt upgrade -y