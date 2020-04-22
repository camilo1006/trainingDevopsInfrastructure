#!/bin/bash

valuesBack () {
  cd /home/ubuntu/ansible-aws-back/
  echo "$(ansible -i ec2.py -u ubuntu us-east-2 -m ping | grep "SUCCESS =>" | wc -l)"
}

valuesFront () {
  cd /home/ubuntu/ansible-aws-front/
  echo "$(ansible -i ec2.py -u ubuntu us-east-2 -m ping | grep "SUCCESS =>" | wc -l)"
}

instancesBack=$(valuesBack)
instancesFront=$(valuesFront)

echo $instancesBack
echo $instancesFront

while [ True ]; do
  newInstancesBack=$(valuesBack)
  newInstancesFront=$(valuesFront)
  if [ $instancesBack != $newInstancesBack ];
  then
  instancesBack=$newInstancesBack
  echo "Executing play-book Back"
  cd /home/ubuntu/ansible-aws-back/ && ansible-playbook backEndProvision.yml -i ec2.py
  fi
  if [ $instancesFront != $newInstancesFront ];
  then
  instancesFront=$newInstancesFront
  echo "Executing play-book Front"
  cd /home/ubuntu/ansible-aws-back/ && ansible-playbook frontEndProvision.yml -i ec2.py
  fi
  sleep 30
done
