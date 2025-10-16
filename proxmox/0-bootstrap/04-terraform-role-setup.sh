pveum user add terraform@pve

PRIVS_REALM="Realm.AllocateUser,Realm.Allocate"
PRIVS_SYS="Sys.Console,Sys.Audit,Sys.AccessNetwork,Sys.Incoming,Sys.Modify,Sys.Syslog,Sys.PowerMgmt"
PRIVS_VM="VM.Audit,VM.Monitor,VM.PowerMgmt,VM.Config.Cloudinit,VM.Config.Memory,VM.Allocate,VM.Console,VM.Clone,VM.Backup,VM.Snapshot,VM.Config.Network,VM.Snapshot.Rollback,VM.Config.Disk,VM.Config.CPU,VM.Config.CDROM,VM.Migrate,VM.Config.Options,VM.Config.HWType"
PRIVS_POOL="Pool.Allocate,Pool.Audit"
PRIVS_SDN="SDN.Audit,SDN.Use,SDN.Allocate"
PRIVS_MAPPING="Mapping.Modify,Mapping.Use,Mapping.Audit"
PRIVS_DATASTORE="Datastore.AllocateTemplate,Datastore.Allocate,Datastore.Audit,Datastore.AllocateSpace"
PRIVS_GROUP="Group.Allocate"
PRIVS_USER="User.Modify"
PRIVS_PERMISSIONS="Permissions.Modify"

ALL_PRIVS="${PRIVS_REALM}, ${PRIVS_SYS}, ${PRIVS_VM}, ${PRIVS_POOL}, ${PRIVS_SDN}, ${PRIVS_MAPPING}, ${PRIVS_DATASTORE}, ${PRIVS_GROUP}, ${PRIVS_USER}, ${PRIVS_PERMISSIONS}"

pveum role add Terraform -privs "$ALL_PRIVS"

pveum aclmod / -user terraform@pve -role Terraform
pveum user token add terraform@pve provider --privsep=0