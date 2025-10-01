/*
when you create 
1) EKS cluster , EKS network interfaces and EKS cluster security group will be auto-matically created
2) EKS node group, network interfaces and EKS nodegroup cluster security group will be auto-matically created

```hcl
variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kube cluster"
  type        = string
  default     = null
}
```

### Simple explanation:

- This variable holds the **IPv4 CIDR block** reserved for **Kubernetes Services** inside your EKS cluster.
- A **CIDR block** is a range of IP addresses used for allocating Pod and Service IPs inside the cluster.
- This **service CIDR** defines what IP addresses Kubernetes can assign to Service ClusterIPs (virtual IPs for services).
- It is used during cluster creation or network configuration to avoid conflicts with your VPC or external networks.

### Why it is used for EKS:
- Kubernetes needs a unique IP range to assign IP addresses to Services.
- This range must not overlap with your VPC CIDR or other networks.
- Specifying this allows consistent and conflict-free network setup for your cluster services.

### Where it is used:
- Passed as `serviceIpv4Cidr` in EKS cluster network configuration.
- Configures `--service-cluster-ip-range` flag for Kubernetes API server.
- Used by networking components (kube-proxy, CNI plugin) for managing service networking.

*/
# EKS Cluster Input Variables

variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
  default     = "eksdemo"
}

/*
private IP ranges defined by RFC 1918:

Common private ranges are:
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16
*/
# https://docs.aws.amazon.com/eks/latest/userguide/network-reqs.html
variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kube cluster,This range must be unique and not overlap with your VPC CIDR or other network ranges your cluster communicates with."
  type        = string
  default     = null
}

variable "cluster_version" {
  description = "value"
  type = string
  default = null
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}