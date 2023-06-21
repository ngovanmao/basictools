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
