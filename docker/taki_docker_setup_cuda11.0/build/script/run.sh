export SHELL=/bin/bash

service ssh start
/etc/init.d/libnss-ldap start

# ln -s /mnt/home/* /home/
# ln -s /mnt/home_1/* /home/
# ln -s /mnt/home_2/* /home/
ln -s /mnt/qnap2/* /home/

while true
do
  sleep 1
done
