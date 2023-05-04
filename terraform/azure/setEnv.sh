#!/bin/bash

dir=$(pwd) 
export TF_CLI_ARGS=" -var-file=${dir}/tfvars/terraform.tfvars -compact-warnings"

