#!/usr/bin/env bash

# This is meant to perform an integration test for mantl, testing against many different providers
# destroying the infrastructure on each one when the test is completed. If any of the providers fail, the whole test
# fails. The test should be based on the sample files, since that is what we are providing for users.
#
# IDEAS:
# the security-setup script should be run automatically, with test:$(/dev/random) being the password.
# the exit code should be init'd to 0, and there should be a 'try/catch/finally' block within the script
# the finally part of the 'try/catch/finally' would be destroying the infrastructure.
# OR
# the tests for each provider could be a separate process/thread, and then aggregate the results into report
# I like this better

## security setup
mkdir /ssh
ssh-keygen -t rsa -N '' -f /ssh/id_rsa
./security-setup

ln -s -f terraform.sample.yml terraform.yml

## for each provider, we link the file we are testing to where the docker launch script expects it to be
ln -s -f testing/aws.tf terraform.tf

terraform get
terraform destroy --force

./docker_launch.sh 
terraform destroy --force
