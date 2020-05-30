#!/bin/bash

scp -o StrictHostKeyChecking=no root@$1:/etc/rancher/k3s/k3s.yaml ./
sed -i "s/127.0.0.1/$1/" k3s.yaml
