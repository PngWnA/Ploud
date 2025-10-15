# Ploud

# Blueprint
```mermaid
flowchart LR
  subgraph Proxmox
    subgraph Nodes [VM Nodes]
      subgraph k8s [Kubernetes Cluster]
        direction LR
        subgraph Control [Control plane]
          Sun[VM]
        end
        anchor[ ]:::empty
        subgraph Worker [Worker plane]
          Mercury[VM]
          Venus[VM]
          Earth[VM]
        end
      end
    end
    Hypervisor[Host OS]

  end

  Terraform === Hypervisor
  Hypervisor ==> Nodes
  Sun dp0@=== anchor[ ]:::empty
  anchor dp1@=== Mercury
  anchor dp2@=== Venus
  anchor dp3@=== Earth

  Terraform@{img: "https://www.svgrepo.com/show/354447/terraform-icon.svg", h: 45, constraint: on}
  classDef empty width: 0;
  %%% Can we do better? %%%
  dp0@{ curve: linear, animation: fast }
  dp1@{ curve: linear, animation: fast }
  dp2@{ curve: linear, animation: fast }
  dp3@{ curve: linear, animation: fast }
```

# Prerequisite
* Proxmox should be installed

# Decision
## Kubernetes
* Should kubernetes setup phase be in terraform apply phase?
  - Tie it together for now. 

# Milestone
* Someday we have to implement HA on this blueprint.