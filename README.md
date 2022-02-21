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

-------------------------
Build and Deploy Automation code
-------------------------
1. The folder Infra_provision contains the Infra provisioning code (terraform configuration files).
2. The folder azure_kubernetes contains the yaml specifications of the Voting App's services.
3. The azure-pipelines.yml file to create a CI-CD process for build and deployment of App on kubernetes cluster.

Steps to provision Infra, build and deploy the app
-------------------------
1. create a new project in azure devops
2. import the github repo in the newly created project in azure devops
3. create azure pipeline with the help of azure-pipeline.yml file.
4. provide the value of the parameters at runtime and run the pipeline selecting infra provisoning stage to provison the Infrastructure.

![image](https://user-images.githubusercontent.com/99867275/154904418-23197be4-f406-4af8-8004-3c401f3091c5.png)


5. create and update the variables aks_serviceconnection, acr_serviceconnection value in azure-pipeline.yml file

![image](https://user-images.githubusercontent.com/99867275/154904228-38c30592-4247-4d08-b0a3-68da09846c12.png)

For database password encryption a secret is created during the execution of azure devops pipeline.

![image](https://user-images.githubusercontent.com/99867275/154626216-b3def3e3-8386-4168-a923-7c811d638775.png)

6. Run the azure devops pipeline to build and deploy app on kubernetes cluster

After the successfull execution on the azure devops pipelinet the vote interface is available on Loadbalancer vote kubernetes service on port 5000 in the cluster, the result one is available on LoadBalancer kubernetes result service on port 5001.

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
