# Ansible User Setup on EC2

This README provides steps to create and configure a new user `ansible-test` on an AWS EC2 instance and set up SSH access using an existing SSH key. Additionally, it sets up the user to have passwordless `sudo` access.

## Prerequisites

- An AWS EC2 instance running Ubuntu.
- SSH access to the instance using a key pair.
- Basic knowledge of SSH and Linux command-line.
- Ansible installed on your local machine.

## Steps

### 1. SSH into the EC2 Instance as the `ubuntu` User

Use your existing key pair to SSH into your EC2 instance as the `ubuntu` user.

```bash
ssh -i /path/to/your/private/key.pem ubuntu@<EC2_PUBLIC_IP>
```

### 2. Create a New User (`ansible-test`)

Create a new user `ansible-test` on the EC2 instance.

```bash
sudo adduser ansible-test
```

You'll be prompted to set a password and optional user information.

### 3. Configure SSH Access for `ansible-test`

#### 3.1 Create the `.ssh` Directory

Switch to the `ansible-test` user and create a `.ssh` directory with the correct permissions.

```bash
sudo su - ansible-test
mkdir ~/.ssh
chmod 700 ~/.ssh
```

#### 3.2 Copy the SSH Public Key

While still logged in as the `ubuntu` user, copy the SSH `authorized_keys` from the `ubuntu` user's `.ssh` directory to the `ansible-test` user.

```bash
exit  # Exit from ansible-test user to ubuntu user
sudo cp /home/ubuntu/.ssh/authorized_keys /home/ansible-test/.ssh/authorized_keys
sudo chown ansible-test:ansible-test /home/ansible-test/.ssh/authorized_keys
sudo chmod 600 /home/ansible-test/.ssh/authorized_keys
```

### 4. Allow `ansible-test` User to Run `sudo` Without a Password

Create a sudoers file to allow the `ansible-test` user to run `sudo` commands without a password.

```bash
echo "ansible-test ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible-test
sudo chmod 0440 /etc/sudoers.d/ansible-test
```

### 5. Verify the Setup

To verify that the setup is successful, try to SSH into the EC2 instance as the `ansible-test` user from your local machine.

```bash
ssh -i /path/to/your/private/key.pem ansible-test@<EC2_PUBLIC_IP>
```

If the connection is successful and the `ansible-test` user can run `sudo` commands without being prompted for a password, then the setup is configured correctly. You can ansible playbook to speed up this process

```bash
make user
```

and then you can

```bash
make start
```