#### Fluentd-Kubernetes-logentries

#### Objetivo desse projeto
Centralizar logs de containers gerenciados com kuberenets.

#### Pré-requisitos
Adicionar TOKEN logentries no kubernetes secret namespace kube-system

```
kubectl create secret generic clusterinfo --from-literal=CLUSTER_NAME=SEU_TOKEN_AQUI -n kube-system

```

Precisamos criar uma serviceAccount para o Fluentd, além de conceder permissões de leitura no socket docker

```
kubectl create -f ./kubernetes/serviceAccount-fluentd.yaml
```

No DashBoard do kubernetes, no namespace kube-system, precisamos do valor ca.crt da secret fluentd-rd-token-*** gerada. Fluentd precisa desse valor como variável para acesso as APIs.


Criando um secret com o conteudo da ca.crt
```
kubectl create secret generic certificate --from-literal=ca=SUA_CA.CRT_AQUI -n default
```   

#### Criando DaemonSet

```
kubectl create -f ./kubernetes/daemonSet-fluentd.yaml
```
