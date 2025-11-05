# GCP Workflow


# Build execution environment image with ansible-builder
1. Clone repo to ansible machine, or copy execution_environment folder and contets to that machine.
2. Install ansible builder on vm ansible is running on
   a. sudo dnf install python3-pip
   b. pip install ansible-builder
3. Browse to the execution_environment folder and run the ansible builder command to build the image:
   a. ansible-builder build -v3 -t **desired image name**

# Tag and push image to the Automation Hub repository
1. Tag the newly created image that will be pushed to Automation Hub:
   a. podman tag localhost/**<image name used in build\>** <automation hub url\>/<image name you want to appear in automation hub\>:<tag, v1, etc\>
2. Login to Automation Hub
   a. podman login <automation hub url\>
   b. Credential you set during the Ansible installation
3. Push image to Automation hub
   a. podman push <automation hub url\>/<image name you want to appear in automation hub\>

# Enable Execution Environment for use
1. In the Ansible web console, in the Automation Execution section of the menu along the left side of the screen click **Infrastructure > Execution Environments**
2. Create a new Execution Environment
   a. Set desired name
   b. for Image, use the image you pushed.  <automation hub url\>/<image name you want to appear in automation hub\>:<tag, v1, etc\>
   c. Click execution environment.

# Example playbook found here:
https://github.com/davidc-dev/gcp-inventory-test
