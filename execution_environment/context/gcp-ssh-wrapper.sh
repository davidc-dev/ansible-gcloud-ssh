#!/bin/bash
# SSH wrapper script for Ansible.  Executes gcloud compute ssh for connecting to GCP instances
host="${@: -2: 1}"
cmd="${@: -1: 1}"
# Get attached service account from instance metadata
service_account=$(curl -v -w "\n" -H "Metadata-Flavor: Google" http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/email)
# IF GCP_SERVICE_ACCOUNT var defined, use it, otherwise use discovered service account
username="${GCP_SERVICE_ACCOUNT%@*:-${service_account%@*}}"
# Unfortunately, ansible has hardcoded ssh options, so we need to filter these out
# It's an ugly hack, but for now we'll only accept the options starting with '--'
declare -a opts
for ssh_arg in "${@: 1: $# -3}" ; do
        if [[ "${ssh_arg}" == --* ]] ; then
                opts+="${ssh_arg} "
        fi
done

exec gcloud compute ssh $opts "sa_${username}@${host}" -- -C "${cmd}"
