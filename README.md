# Ploud
My Proxmox Cloud Infrastructure

# Blueprint
```mermaid
graph LR
  Internet
  subgraph Proxmox
    subgraph Hypervisor[Host OS]
      hostanchor[ ]:::empty
      Gitea[Git server]
      Wireguard[Wireguard server]
      subgraph Network [Network interfaces]
        ethernet(ethernet)
        vmbr0(vmbr0)
        vmbr1(vmbr1)
      end
    end
    subgraph Nodes [VM Nodes]
        vmbranchor[ ]:::empty
      subgraph k8s [Kubernetes Cluster]
        direction LR
        subgraph Control [Control plane]
          Sun[VM]
        end
        k8sanchor[ ]:::empty
        subgraph Worker [Worker plane]
          Mercury[VM]
          Venus[VM]
          Earth[VM]
        end
      end
      subgraph general [General Purpose VMs]
        alpha[VM]
        beta[VM]
        gamma[VM]
      end
    end
  end

  Internet eth0@=== ethernet eth1@=== vmbr0
  vmbr0 net0@=== vmbr1
  vmbr0 net1@=== hostanchor
  
  vmbr1 net3@=== vmbranchor
  
  vmbranchor net4@=== Sun
  vmbranchor net5@=== Mercury
  vmbranchor net6@=== Venus
  vmbranchor net7@=== Earth 

  vmbranchor net8@=== alpha
  vmbranchor net9@=== beta
  vmbranchor net10@=== gamma 

  hostanchor net11@=== Gitea
  hostanchor net12@=== Wireguard
  
  Sun calico0@=== k8sanchor
  k8sanchor calico1@=== Mercury
  k8sanchor calico2@=== Venus
  k8sanchor calico3@=== Earth


  %%% Style %%%
  Internet@{ shape: cloud }
  classDef empty width: 0
  classDef duplex stroke-dasharray: 50, stroke-dashoffset: 250, animation: dash 3s linear infinite alternate;
  classDef calico stroke-dasharray: 5, stroke-dashoffset: 50, animation: dash 0.5s linear infinite alternate;
  classDef vmbr stroke-dasharray: 40, stroke-dashoffset: 500, animation: dash 5s linear infinite alternate;  
  class eth0,eth1,eth2 duplex
  class calico0,calico1,calico2,calico3 calico
  class net0,net1,net2,net3,net4,net5,net6,net7,net8,net9,net10,net11,net12,net13 vmbr
```

# Prerequisite
* Proxmox

# Decision
## Kubernetes
* Should kubernetes setup phase be in terraform apply phase?
  - Tie it together for now. 

# Milestone
* Someday we have to implement HA on this blueprint.

# Note
* [Proxmox root user should use `bash` as default shell](https://github.com/bpg/terraform-provider-proxmox/issues/1251)