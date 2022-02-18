Example Voting App
=========

A simple distributed application running across multiple Docker containers.

Getting started
---------------

Application is deployed on the Kubernetes Cluster


## Linux Containers

The Linux stack uses Python, Node.js, .NET Core (or optionally Java), with Redis for messaging and Postgres for storage.

> If you're using [Docker Desktop on Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows), you can run the Linux version by [switching to Linux containers](https://docs.docker.com/docker-for-windows/#switch-between-windows-and-linux-containers), or run the Windows containers version.


Run the app in Kubernetes
-------------------------

The folder aks-specifications contains the yaml specifications of the Voting App's services.

First create the vote namespace

```
$ kubectl create namespace vote
```

Create service connections for Kubernetes (AKS) and private Registry (ACR) and update the name of those connections variables aks_serviceconnection, acr_serviceconnection in 
azure-pipelines.yml file:
```
Create a new pipeline in the azure devops using the azure-pipelines.yml file and run it on desired environment.

```

The vote interface is then available on Loadbalancer vote kubernetes service on port 5000 in the cluster, the result one is available on LoadBalancer kubernetes result service port 5001.

![image](https://user-images.githubusercontent.com/99867275/154625777-5360287f-b321-4eb7-8dd9-1236b9bf72db.png)


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
