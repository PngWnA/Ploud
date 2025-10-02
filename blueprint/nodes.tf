locals {
  nodes = {
    "Sun" = { role = "Controller", ip = "10.24.68.1/24", gw = "10.24.0.1", vm_id = 1000000}
    "Mercury" = { role = "Worker", ip = "10.24.68.2/24", gw = "10.24.0.1", vm_id = 1000001 }
    "Venus" = { role = "Worker", ip = "10.24.68.3/24", gw = "10.24.0.1", vm_id = 1000002 }
    #"Earth" = { role = "Worker", ip = "10.24.68.4/24", gw = "10.24.0.1", vm_id = 1000003 }
    #"Mars" = { role = "Worker", ip = "10.24.68.5/24", gw = "10.24.0.1", vm_id = 1000004 }
    #"Jupiter" = { role = "Worker", ip = "10.24.68.6/24", gw = "10.24.0.1", vm_id = 1000005 }
    #"Saturn" = { role = "Worker", ip = "10.24.68.7/24", gw = "10.24.0.1", vm_id = 1000006 }
    #"Uranus" = { role = "Worker", ip = "10.24.68.8/24", gw = "10.24.0.1", vm_id = 1000007 }
    #"Neptune" = { role = "Worker", ip = "10.24.68.9/24", gw = "10.24.0.1", vm_id = 1000008 }
    #"Pluto" = { role = "Worker", ip = "10.24.68.10/24", gw = "10.24.0.1", vm_id = 1000009 }
  }
  controller_plain = [for name, attrs in local.nodes : name if attrs.role == "Controller"]
  worker_plain     = [for name, attrs in local.nodes : name if attrs.role == "Worker"]
}