# Ansible Lab

## Description
This is an architecture composed by three containers (on a real scenary it could be virtual machines) where the main one `centos-ansible` manages the `debian-ansible` and `archlinux-ansible` through Ansible tool.

All containers have ssh enabled in order to use Ansible and all containers can reach each other through ssh.

Container `centos-ansible` is accessible through ssh port from the local network, but the `debian-ansible` and `archlinux-ansible` ones are not because they are on a isolated network. The only way to access `debian` and `archlinux` through ssh is from inside of `centos-ansible` because `debian-ansible` and `archlinux-ansible` are running on root (required to install applications through Ansible) and I do not want to expose port outside of the network, but `centos-ansible` is running on `ansible` user and it is ok to expose port `22002`.

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

Now, if you have copied your public key into `authorized_keys` then you should be able to login into `centos-ansible` through ssh:
```bash
ssh ansible@localhost -oPort=22002

# inside centos-ansible, should be able to ssh into other containers
ssh root@debian-ansible
```