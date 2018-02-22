#### Fluentd-Kubernetes-logentries

#### Objetivo desse projeto
Centralizar logs de containers gerenciados com kuberenets.

#### Pré-requisitos
Adicionar TOKEN logentries no kubernetes secret namespace kube-system

```
kubectl create secret generic clusterinfo --from-literal=CLUSTER_NAME=SEU_TOKEN_AQUI -n kube-system

```

#### Criando DaemonSet

```
kubectl create -f fluentd-daemonset-logentries.yaml
```
