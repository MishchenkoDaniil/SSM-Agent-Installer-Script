# Install Amazon SSM Agent Script

This script installs the Amazon SSM (Systems Manager) Agent on a Debian-based system. It supports both `x86_64` and `aarch64` architectures and provides an option to remove the existing Snap installation of the SSM Agent if present.

## Usage

1. Clone the repository or download the `install_ssm.sh` script.

2. Make the script executable:
   ```sh
   chmod +x install_ssm.sh
   ```

3. Run the script:
   ```sh
   ./install_ssm.sh
   ```

## Script Details

### Functionality

The script performs the following actions:

1. **Determine System Architecture**:
   - Identifies the system architecture (`x86_64` or `aarch64`) and sets the appropriate URL for downloading the Amazon SSM Agent `.deb` package.

2. **Check for Existing SSM Agent Installation via Snap**:
   - If the Amazon SSM Agent is installed via Snap, the script prompts the user to remove the Snap version and install the `.deb` package instead.
   - If the user agrees, the Snap version is removed, and the `.deb` package is installed.
   - If the user declines, the script exits.

3. **Download and Install the Amazon SSM Agent**:
   - Downloads the Amazon SSM Agent `.deb` package from the appropriate URL.
   - Installs the downloaded package using `dpkg`.
   - Enables and starts the Amazon SSM Agent service using `systemctl` or `service` commands.

### Example Output

When running the script, you will see output similar to the following:

```plaintext
Downloading the Amazon SSM Agent...
--2024-05-24 12:00:00--  https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
Resolving s3.amazonaws.com (s3.amazonaws.com)... 52.216.237.109
Connecting to s3.amazonaws.com (s3.amazonaws.com)|52.216.237.109|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 12345678 (12M) [application/x-debian-package]
Saving to: ‘amazon-ssm-agent.deb’

amazon-ssm-agent.deb                 100%[===============================================================>]  12.34M  1.23MB/s    in 10s

2024-05-24 12:00:10 (1.23 MB/s) - ‘amazon-ssm-agent.deb’ saved [12345678/12345678]

Installing the Amazon SSM Agent...
Selecting previously unselected package amazon-ssm-agent.
(Reading database ... 123456 files and directories currently installed.)
Preparing to unpack amazon-ssm-agent.deb ...
Unpacking amazon-ssm-agent (2.3.1234.0) ...
Setting up amazon-ssm-agent (2.3.1234.0) ...
Processing triggers for systemd (245.4-4ubuntu3.15) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.9) ...

Starting the Amazon SSM Agent service...
● amazon-ssm-agent.service - Amazon SSM Agent
     Loaded: loaded (/lib/systemd/system/amazon-ssm-agent.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2024-05-24 12:00:20 UTC; 2s ago
   Main PID: 1234 (amazon-ssm-agen)
      Tasks: 6 (limit: 9457)
     Memory: 8.3M
     CGroup: /system.slice/amazon-ssm-agent.service
             └─1234 /usr/bin/amazon-ssm-agent

May 24 12:00:20 yourhostname systemd[1]: Started Amazon SSM Agent.
```

## License

This project is licensed under the MIT License.
