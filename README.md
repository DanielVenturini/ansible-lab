# Ansible Lab

## Description
This is an architecture composed by three containers (on a real scenary it could be virtual machines) where the main on `centos-ansible` manages the `debian-ansible` and `archlinux-ansible` through Ansible tool.

All containers have ssh enables in order to use Ansible and all containers can reach each other through ssh.

## Configuration
First, let's create the ssh keys used on containers and save under `ssh-credentials/` path and create the authorized key file as well:

```bash
ssh-keygen -t rsa -b 2048 -f ssh-credentials/id_rsa -N ''
cp ssh-credentials/id_rsa.pub ssh-credentials/authorized_keys
```

In addition, I can copy my own public key into authorized keys file to be able to ssh into containers using my own public key:
```bash
cat $HOME/.ssh/id_rsa.pub >> ssh-credentials/authorized_keys
```

Now let's copy all the keys generated into each container path:
```bash
bash ssh-credentials/deploy-authentication-files.sh
```

## Running
It can be easily deployed using docker compose:
```bash
docker compose up -d --build
```

Now, whether you copied your public key into `authorized_keys`, you should be able to ssh into any container:
```bash
ssh root@localhost -oPort=22002

# inside centos-ansible
## should be able to ssh into other containers
ssh root@debian-ansible
```