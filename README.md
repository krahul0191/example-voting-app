Example Voting App
=========

A simple distributed application running across Azure Kubernetes cluster.

Getting started
---------------

Application is deployed on the Azure Kubernetes Cluster


## Linux Containers

The Linux stack uses Python, Node.js, .NET Core (or optionally Java), with Redis for messaging and Postgres for storage.

> If you're using [Docker Desktop on Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows), you can run the Linux version by [switching to Linux containers](https://docs.docker.com/docker-for-windows/#switch-between-windows-and-linux-containers), or run the Windows containers version.



Prerequisites
-------------------------
1. Azure Kubernetes cluster
2. Azure Container Registry
3. Azure DevOps
4. Terraform Utility 
-------------------------
Build and Deploy Automation code
-------------------------
1. The folder Infra_provision contains the Infra provisioning code (terraform configuration files).
2. The folder azure_kubernetes contains the yaml specifications of the Voting App's services.
3. The azure-pipelines.yml file to create a CI-CD process for build and deployment of App on kubernetes cluster.

Steps to provision the Infrastructure (AKS, ACR)
-------------------------
1. Clone the github repo.
2. provide azure service principal account client_id, client_secret, tenant_id and subscription_id in variables.tf file in Infra_provision folder to authenticate the terraform with azure portal.
3. change the directory to the Infra_provision folder and run mentioned commands to provision the Infrastructure.
 ```
 Terraform init
 Terraform apply --auto-approve
```
Create namespace on azure kubernetes cluster
-------------------------
```
kubectl create namespace vote
```
Create service connections and update varaibles in azure-pipelines.yml
-------------------------
Create service connections for Kubernetes (AKS) and private Registry (ACR) in Azure DevOps and update the name of those connections variables aks_serviceconnection, acr_serviceconnection in azure-pipelines.yml file:

![image](https://user-images.githubusercontent.com/99867275/154627672-38b5ff30-73b6-4086-8dc3-a783e4951f1d.png)


For database password encryption a secret is created during the execution of azure devops pipeline.

![image](https://user-images.githubusercontent.com/99867275/154626216-b3def3e3-8386-4168-a923-7c811d638775.png)

For Autoscaling of the deployed pods HorizontalPodAutoscaler kubernetes object also deployed along with deployment.

![image](https://user-images.githubusercontent.com/99867275/154626451-660ae336-10e3-4390-8f07-9c1888f997a4.png)


Create Azure DevOps pipeline
-------------------------
Use azure-pipelines.yml file to create a azure devops CI-CD pipeline and run it on desired environment.

After the successfull execution on the azure devops pipelinet he vote interface is available on Loadbalancer vote kubernetes service on port 5000 in the cluster, the result one is available on LoadBalancer kubernetes result service on port 5001.

![image](https://user-images.githubusercontent.com/99867275/154890689-ccd804c5-9017-4674-b6bd-15bd4f25e3e2.png)

Architecture
-----

![Architecture diagram](architecture.png)

* A front-end web app in [Python](/vote) or [ASP.NET Core](/vote/dotnet) which lets you vote between two options
* A [Redis](https://hub.docker.com/_/redis/) or [NATS](https://hub.docker.com/_/nats/) queue which collects new votes
* A [.NET Core](/worker/src/Worker), [Java](/worker/src/main) or [.NET Core 2.1](/worker/dotnet) worker which consumes votes and stores them in…
* A [Postgres](https://hub.docker.com/_/postgres/) or [TiDB](https://hub.docker.com/r/dockersamples/tidb/tags/) database backed by a Docker volume
* A [Node.js](/result) or [ASP.NET Core SignalR](/result/dotnet) webapp which shows the results of the voting in real time


Notes
-----

The voting application only accepts one vote per client. It does not register votes if a vote has already been submitted from a client.

This isn't an example of a properly architected perfectly designed distributed app... it's just a simple 
example of the various types of pieces and languages you might see (queues, persistent data, etc), and how to 
deal with them in Docker at a basic level. 
