In Terraform, the priority for variable values from files is as follows (higher overrides lower):

1. **Explicit `-var` command-line arguments** (highest priority)
2. **Explicit `-var-file` command-line argument** (e.g., `-var-file=prod.tfvars`)
3. **`.auto.tfvars` files** (automatically loaded)
4. **`terraform.tfvars` file** (automatically loaded)
5. **Default values in variable declarations**

So between `terraform.tfvars` and `.auto.tfvars`, **`.auto.tfvars` has higher priority** if both define the same variable.

This means `.auto.tfvars` values override `terraform.tfvars` values automatically.


Terraform’s default parallelism for resource operations is 10
```bash
time -p terraform plan
real 19.25
user 0.00
sys 0.06

time -p terraform plan -parallelism=20
real 18.78
user 0.00
sys 0.09
```
**real**: Total elapsed wall-clock time from start to finish (how much time passed on the clock).
**user**: CPU time spent running your program's own code (in user mode).
**sys**: CPU time spent by the system (kernel) on behalf of your program (like I/O or system calls).

Q1) if admin access role is assigned to bastion host will it be able to run kubectl get po?
Ans: no necessarily the user/role used to create the eks cluster will onlybe able to run this command during initial setup/creation. for other mapping is required

#### Kubernetes commands
```bash
kubectl run -it --rm --restart=Never busybox --image=busybox -- sh
wget -qO- http://checkip.amazonaws.com

kubectl run -it --rm --restart=Never busybox --image=busybox --overrides='
{
  "spec": {
    "nodeName": "ip-10-0-1-248.ec2.internal"
  }
}
' -- sh

```
vcluster create team-a -n team-a --connect=false --values vcluster_values.yaml
vcluster connect team-a -n team-a --print > team-a-kubconfig.yaml
