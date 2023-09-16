BASE_PATH=$(pwd)
SSH_CREDENTIALS_PATH=${BASE_PATH}/ssh-credentials

for container_name in $(echo archlinux centos debian); do
    for file_name in $(echo id_rsa id_rsa.pub authorized_keys); do
        cp -f ${SSH_CREDENTIALS_PATH}/$file_name ${BASE_PATH}/$container_name/$file_name;
    done
done