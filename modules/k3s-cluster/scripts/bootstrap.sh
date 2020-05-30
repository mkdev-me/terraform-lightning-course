#!/bin/bash

set -e

yum install -y container-selinux selinux-policy-base
rpm -i https://rpm.rancher.io/k3s-selinux-0.1.1-rc1.el7.noarch.rpm

curl -sfL https://get.k3s.io | sh -
