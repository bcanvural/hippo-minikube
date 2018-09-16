#!/usr/bin/env bash

aws s3api create-bucket --bucket hippocluster-bucket --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1
