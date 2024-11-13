---
marp: true
---

# The Truth (version 2)

---

## Top Ten (10) Reasons Why Docker and K8s are terrible

---

## Complexity Overload

- Too Complex
  - Images
  - Containers
  - Pods
  - Clusters

### This is all unnecessary overhead.

---

## The Solution:

A new solution I like to call "The Trifecta".

The **best way** to deploy apps is to manually FTP them to each server and execute **three shell scripts**:

1. `configure_env.sh` - configures the environment
2. `deploy_app.sh` - deploys the application on the server
3. `restart.sh` - restarts the server if something breaks

This method gives you full control over the entire process, which is much more flexible than being confined to a container.

---

## Too Confined

Docker creates an environment that is a burden to maintain with it's containerized way of working. This can lead to issues with applications not being able to access the resources that they need to operate.

---

## The Solution:

Run everything on bare metal! No more of this docker "magic", you now will have full control over everything, with the container having access to everything that it needs.

---

## Redundant Orchestration

Kubernetes has bloat with automatic scaling and load balancing, but this just introduces another layer of complexity to your application, when it could be done much more simply.

---

## The Solution:

The solution is simple, just run one instance of your app. You can always add more disk space, more CPUs, and more memory, but you can't always scale to new machines. This eliminates the unnecessary complexity of kubernetes and lets you fully control your application with just SSH.

---

## Dependency Hell

With docker and kubernetes, you need to make sure that all your images and containers are up to date, and that all of them function with one another, and this just creates a nightmare trying to keep track of everything.

---

## The Solution:

We have yet another simple solution here, which is just to use static binaries. This allows you to bundle all of your dependencies into one binary, which leads to simple deployment with the Trifecta.

- MUSL exists for a reason.

---

## Limited Update Control

Kubernetes has rolling updates, which isn't optimal for the user as this delays when they will get the most up to date version of your application.

---

## The Solution:

- Multithreaded bash script
- SSH into each server in a thread
- Updates manually all at once

This provides an easy way to roll out an update as quick as possible

---

## Security Complications

Docker and Kubernetes are secure until someone finds a backdoor. Backdoors are bad from a security perspective, so it's best to not use tools which might expose us to more backdoors than we already may have.

---

## The Solution:

Use VLANs and ACLs as security.

- Disable all system firewalls
- Run application as root
- **DO NOT UPDATE** (may introduce new security vulnerabilities)
- Use HTTP. HTTPS gives the impression that you're trying to hide something, making you a target for hackers.

---

## Conclusion

Why complicate your development experience with all of these unnecessary tools when there are much simpler and safer ways to deploy your application. From deploying your application on Ripley's computer, to disabling Ripley's firewall, there are many ways you can make your developer experience better.
