#!/bin/bash
#Simple change password to use as a custom script extension in Azure Linux VMs where waagent is not reseting the password.
#Waagent needs to be running healthy.

#Change "User12345" by your username and "Pass12345" by the new password (without spaces).

username=User12345
password=Pass12345

echo "$username:$password" | chpasswd

exit 0;
