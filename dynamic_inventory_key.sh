#!/bin/bash

SORACOM_CLI_PROFILE="XXXXX"
TARGET_TAG_KEY="XXXXX"
TARGET_TAG_VALUE="XXXXX"

subscriberList=`soracom subscribers list --fetch-all --profile "$SORACOM_CLI_PROFILE" | jq '[.[] | select(.tags?."'$TARGET_TAG_KEY'"=="'$TARGET_TAG_VALUE'") | { imsi: .imsi, tags: .tags? } ']`

len=`echo ${subscriberList} | jq length`
for i in `seq 0 $(expr ${len} - 1)`
do
    imsi=`echo $subscriberList | jq -r .[${i}].imsi`
    ansible_user=`echo $subscriberList | jq .[${i}].tags.ansible_user`

    existing_port_mapping=`soracom port-mappings get --imsi $imsi --profile $SORACOM_CLI_PROFILE | jq '.[0] | { port_mapping: ., ansible_user: '$ansible_user' }'`

    if [ -n `echo $existing_port_mapping | jq .port_mapping` ]; then
        new_port_mapping=`soracom port-mappings create --body '{"destination": {"imsi": "'$imsi'", "port": 22}}' --profile "$SORACOM_CLI_PROFILE" | jq '. | { port_mapping: ., ansible_user: '$ansible_user' }'`
        arr+=`echo $new_port_mapping | jq .`
        continue
    fi

    arr+=`echo $existing_port_mapping | jq .`
done

l=`echo $arr | jq -s -c flatten`

echo $l | jq '. | map({ (.port_mapping.imsi) : { "hosts": [.port_mapping.ipAddress], "vars": {"ansible_port": .port_mapping.port, "ansible_user": .ansible_user}} })' | jq add


