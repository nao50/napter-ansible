# napter-ansible
soracom napter with ansible dynamic inventory example

# prerequire
ansible 
soracom cli

# configure
You can set variables that are appropriate for your environment by editing `dynamic_inventory.sh`.

SORACOM_CLI_PROFILE : set your SORACOM CLI profile name
TARGET_TAG_KEY : Set the `tag key` set in the SIM you want to set with napter.
TARGET_TAG_VALUE : Set the `tag value` set in the SIM you want to set with napter.

# example usage
For test
```bash
$ ansible -i ./dynamic_inventory.sh all -m ping
```

Use playbook
```bash
$ ansible-playbook -i ./dynamic_inventory.sh playbook.yaml -vvv
```