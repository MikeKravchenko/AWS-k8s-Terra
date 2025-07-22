# AWS-k8s-Terra project description

A simple Python application (`app.py`) that serves a basic HTML page with Docker, Kubernetes and Terraform.

## Objectives

### 1. Dockerize the Application

- Write a `Dockerfile` to containerize the provided Python application.

### 2. Kubernetes Deployment

- Write Helm charts to deploy the application.

### 3. Infrastructure Provisioning with Terraform

- Write Terraform code to provision the necessary infrastructure to deploy the Kubernetes cluster.
  - Ensure the web service is publicly accessible.
  - Include any required networking resources (e.g., VPC, subnets, load balancers).

## Usage:

### Docker, build and deploy

1. Build the image:
   `docker build -t flask-app .`
2. Run the container:
   `docker run -p 5000:5000 flask-app`
3. Access the app:
   `curl http://127.0.0.1:5000`

### Provision infrastructure

1. **cd to Terraform folder. Initiate terraform and check if nothing is sketchy***:

   ```bash

   terraform init && terraform plan
   ```
2. **Provision infrastructure**:

   ```bash
   terraform apply
   ```

### Kubernetes, build and deploy

1. **Helm deploy with already pushed image to DockerHub**:

   ```bash

   helm install flask-app ./flask-app --namespace flask-app --create-namespace -set service.type=LoadBalancer
   ```
2. **(Optional-alternative)Build and Push the Docker Image from scratch**:

   - Build the Docker image:

     ```bash
     docker build -t <your-dockerhub-username>/flask-app:latest .
     ```
   - Push the image to a container registry (e.g., Docker Hub):

     ```bash
     docker push <your-dockerhub-username>/flask-app:latest
     ```
   - Update the `flask-app/values.yaml` file to use your Docker image:

     ```yaml
     image:
       repository: <your-dockerhub-username>/flask-app
       tag: latest
       pullPolicy: IfNotPresent
     ```
   - Install the Helm chart:

     ```bash
     helm install flask-app ./flask-app --namespace flask-app --create-namespace -set service.type=LoadBalancer
     ```
3. **Verify the Deployment**:

   - Check the status of the pods:
     ```bash
     kubectl get pods
     ```
   - Check the service to get the external IP:
     ```bash
     kubectl get svc
     ```
4. **Access the Application**:

   - Use the external IP from the `kubectl get svc` command to access the app in browser:
     ```
     kubectl get svc flask-app-flask-app -n flask-app -o jsonpath="http://{.status.loadBalancer.ingress[0].hostname}:{.spec.ports[0].port}{'\n'}"
     ```
5. **Cleanup infra**:

   ```bash
   terraform destroy
   ```
