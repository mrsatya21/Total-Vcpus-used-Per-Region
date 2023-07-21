#!/bin/bash

# Set your AWS region
regions=$(aws ec2 describe-regions --query 'Regions[].RegionName' --output text)

# Loop through each regions
for region in $regions; do

    # Check if instance is present in the region or not
    instanceCount=$(aws ec2 describe-instances --region "$region" --query "Reservations | length(@)")

    if [ "$instanceCount" != 0 ]
    then

        # Get the Default VPC ID
        vpcId=$(aws ec2 describe-vpcs --filters 'Name=is-default,Values=true' --query 'Vpcs[].VpcId' --region $region --output text)

        # Get the Insatnce IDs in that VPC
        instanceIds=$(aws ec2 describe-instances --region $region --filters "Name=vpc-id,Values=$vpcId" --query "Reservations[].Instances[?State.Name != 'terminated' && State.Name != 'shutting-down'].[InstanceId]" --output text)

        # Defined a variable to take count of VCpus
        TOTAL_VCPU_IN_REGION=0

        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "Region is : $region"
        echo " " 

        for instanceId in $instanceIds; do

            # Check instance type
            instanceType=$(aws ec2 describe-instances --region $region --filters "Name=instance-id, Values=$instanceId" --query "Reservations[].Instances[].[InstanceType]" --output text)

            # Check Instance state
            instanceState=$(aws ec2 describe-instances --region $region --filters "Name=instance-id, Values=$instanceId" --query "Reservations[].Instances[].[State.Name]" --output text)

            # Check number of VCpus for that instance
            VCpu=$(aws ec2 describe-instance-types --instance-types $(aws ec2 describe-instances --region $region --filters "Name=instance-id, Values=$instanceId" --query 'Reservations[].Instances[].[InstanceType]' --output text) --query "InstanceTypes[].[VCpuInfo.DefaultVCpus]" --output text)
            
            # Add the VCpus to total
            TOTAL_VCPU_IN_REGION=$((TOTAL_VCPU_IN_REGION+VCpu))

            # Output 
            echo "InstanceId : $instanceId, InstanceType : $instanceType, InstanceState : $instanceState, VCpu : $VCpu";
        done
        echo "-------------------------------------------------"
        echo "Total VCpu in $region : $TOTAL_VCPU_IN_REGION"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "  ";
    fi
done