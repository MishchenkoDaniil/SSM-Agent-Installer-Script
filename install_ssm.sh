cat << 'EOF' > install_ssm.sh
#!/bin/bash

# Function to install the Amazon SSM Agent from a .deb package
install_ssm_from_deb() {
    echo "Downloading the Amazon SSM Agent..."
    wget "$SSM_AGENT_URL" -O amazon-ssm-agent.deb
    
    echo "Installing the Amazon SSM Agent..."
    sudo dpkg -i amazon-ssm-agent.deb || echo "Installation encountered an error. If amazon-ssm-agent is already installed via snap, consider using 'sudo snap remove amazon-ssm-agent' before retrying."
    
    # Attempt to start the Amazon SSM Agent service
    if command -v systemctl &> /dev/null; then
        sudo systemctl enable amazon-ssm-agent
        sudo systemctl start amazon-ssm-agent
        sudo systemctl status amazon-ssm-agent
    elif command -v service &> /dev/null; then
        sudo service amazon-ssm-agent start
        sudo service amazon-ssm-agent status
    else
        echo "Cannot manage the Amazon SSM Agent service; service management command not found."
    fi
}

# Determine the system architecture
ARCH=$(uname -m)
SSM_AGENT_URL=""

case "$ARCH" in
    "x86_64")
        SSM_AGENT_URL="https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb"
        ;;
    "aarch64")
        SSM_AGENT_URL="https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_arm64/amazon-ssm-agent.deb"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Check for existing SSM Agent installation via Snap
if snap list amazon-ssm-agent &> /dev/null; then
    echo "Amazon SSM Agent is installed via Snap. Do you wish to remove the Snap version and install the .deb package instead? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        sudo snap remove amazon-ssm-agent
        install_ssm_from_deb
    else
        echo "Proceeding with the Amazon SSM Agent installed via Snap."
    fi
else
    install_ssm_from_deb
fi
EOF

chmod +x install_ssm.sh && ./install_ssm.sh
