# Kubernetes on Ploud
* Overall configuration is done in cloud-init phase.
* Follow `setup` section to finish kubernetes setup.

# Setup
## Control node
* Record command output of `kubeadm token create --print-join-command`. This will be used in worker node
  - example output is as follows.
```bash
kubeadm join 1.2.3.4:6443 --token 7j55h.fl4q0vhomulunyq --discovery-token-ca-cert-hash sha256:65422961d1ffafc544e00f222abd1953f3c62eeb885bc260de418cc1737dd80a
```
* Install Calico CNI
```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.30.3/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.30.3/manifests/custom-resources.yaml
```

## Worker node
* Run `kubeadm join` commnad provided [above](#control-node).

