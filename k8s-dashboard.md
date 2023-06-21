To use [kubernetes dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/), we need to deploy the Dashboard UI:
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
```
Basically, we can download the `recommended.yaml` file and modify it.


* You can enable access to the Dashboard using the kubectl command-line tool, by running the following command:
`kubectl proxy`

Kubectl will make Dashboard available at http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/.

* Follow this tutorial to create [sample user](https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md).
* Access it by generate token or query the available token: 
```
# kubectl describe secret
Name:         default-token
Namespace:    default
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: default
              kubernetes.io/service-account.uid: d6198f11-bfdf-4b23-8f63-90eb0191770d

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1025 bytes
namespace:  7 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6ImxKQ0t0X1RZNlhMUFhvUW03eW5KSWlPUDl3S2FjT2JkMUpsYzJ5RTlOdHcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImQ2MTk4ZjExLWJmZGYtNGIyMy04ZjYzLTkwZWIwMTkxNzcwZCIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.OIepT4QrlnaRrugi0C6vGq-N6lfoR35_xgR_giBKJYxs8aBIvHb6VIfvOtikG3Sj5uPssQ3X9CIQUUYlkMwTLFTisC57GwVNM4nJ2LKcdz-pCPRDrum7-Kual3a36XWePQM9Tbn676gfIM-xWS3QmRQGVZG19CNr6uw4jny7cSZyZP3_Sco_-E4cPfQC7rCVuXN5bFoK-DjcRqkhZrL33evxuuf8ZZAXhKDjBTlrf66NEBG_vZCKst4b6hpO276QVQAwEgvRcfAs7p9jMP-ecpVh_zjFMeEP884m42NlNvIYiF656L5nwCZaK8ZR3FCV97Ro3nGwiSZPSI33pnodcA
```

# Access dashboard from LAN:
Follow this tutorial: https://github.com/kubernetes/dashboard/blob/master/docs/user/accessing-dashboard/README.md
Basically, we can change `type: ClusterIP` to `type: NodePort.

This way of accessing Dashboard is only recommended for development environments in a single node setup.

Edit kubernetes-dashboard service.
```
kubectl -n kubernetes-dashboard edit service kubernetes-dashboard
```
You should see yaml representation of the service. Change `type: ClusterIP` to `type: NodePort` and save file. If it's already changed go to next step.
```
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
...
  name: kubernetes-dashboard
  namespace: kubernetes-dashboard
  resourceVersion: "343478"
  selfLink: /api/v1/namespaces/kubernetes-dashboard/services/kubernetes-dashboard
  uid: 8e48f478-993d-11e7-87e0-901b0e532516
spec:
  clusterIP: 10.100.124.90
  externalTrafficPolicy: Cluster
  ports:
  - port: 443
    protocol: TCP
    targetPort: 8443
  selector:
    k8s-app: kubernetes-dashboard
  sessionAffinity: None
  type: ClusterIP >>> NodePort
status:
  loadBalancer: {}
```
Next we need to check port on which Dashboard was exposed.
```
kubectl -n kubernetes-dashboard get service kubernetes-dashboard
```
The output is similar to this:
```
NAME                   TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
kubernetes-dashboard   NodePort   10.100.124.90   <nodes>       443:31707/TCP   21h
```
Dashboard has been exposed on port 31707 (HTTPS). Now you can access it from your browser at: `https://<control-plane-ip>:31707`. control-plane-ip can be found by executing kubectl cluster-info. Usually it is either `127.0.0.1` or IP of your machine, assuming that your cluster is running directly on the machine, on which these commands are executed.

In case you are trying to expose Dashboard using NodePort on a multi-node cluster, then you have to find out IP of the node on which Dashboard is running to access it. Instead of accessing `https://<control-plane-ip>:<nodePort>` you should access `https://<node-ip>:<nodePort>`.
