# napter-ansible
soracom napter with ansible dynamic inventory example

# prerequire
ansible 
soracom cli  
sshpass

# configure
You can set variables that are appropriate for your environment by editing shellscript.

## key login
Use `dynamic_inventory_key.sh` to log in using SSH with key authentication.  

Set the following variables...

> **SORACOM_CLI_PROFILE** : Set your SORACOM CLI profile name  
> **TARGET_TAG_KEY** : Set the `tag key` set in the SIM you want to set with napter  
> **TARGET_TAG_VALUE** : Set the `tag value` set in the SIM you want to set with napter  
> **TARGET_USERNAME** : Set the `username` for SSH login of the device set by napter

### usage
```bash
$ ansible-playbook -i ./dynamic_inventory_pass.sh playbook.yaml --private-key=<YOUR SECRET KEY> -vvv
```


## Password login (NOT recommended)
Use `dynamic_inventory_pass.sh` to log in using SSH with password authentication.  

Set the following variables...

> **SORACOM_CLI_PROFILE** : Set your SORACOM CLI profile name  
> **TARGET_TAG_KEY** : Set the `tag key` set in the SIM you want to set with napter  
> **TARGET_TAG_VALUE** : Set the `tag value` set in the SIM you want to set with napter  
> **TARGET_USERNAME** : Set the `username` for SSH login of the device set by napter
> **TARGET_SSH_PASS** : Set the `password` for SSH login of the device set by napter

### usage
```bash
$ ansible-playbook -i ./dynamic_inventory_pass.sh playbook.yaml -vvv
```

