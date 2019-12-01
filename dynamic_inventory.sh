#!/bin/bash

SORACOM_CLI_PROFILE="XXXXX"
TARGET_TAG_KEY="XXXXX"
TARGET_TAG_VALUE="XXXXX"

subscriberList=`soracom subscribers list --fetch-all --profile $SORACOM_CLI_PROFILE | jq '[.[] | select(.tags?.'$TARGET_TAG_KEY'=="'$TARGET_TAG_VALUE'") | .imsi ']`

len=`echo ${subscriberList} | jq length`
for i in `seq 0 $(expr ${len} - 1)`
do
    subscriber=`echo $subscriberList | jq -r .[${i}]`
    existing_port_mapping=`soracom port-mappings get --imsi $subscriber --profile $SORACOM_CLI_PROFILE | jq .`

    len=`echo ${existing_port_mapping} | jq length`;
    if [ $len -eq 0 ]; then
        new_port_mapping=`soracom port-mappings create --body '{"destination": {"imsi": "'$subscriber'", "port": 22}}' --profile $SORACOM_CLI_PROFILE | jq .`
        arr+=`echo $new_port_mapping | jq .`
        continue
    fi

    arr+=`echo $existing_port_mapping | jq .[]`

done

l=`echo $arr | jq -s -c flatten`
echo $l | jq '. | map({ (.imsi) : { "hosts": [.ipAddress], "vars": {"ansible_port": .port, "ansible_user": "pi", "ansible_ssh_pass": "raspberry"}} })' | jq add
