#### Fluentd-Kubernetes-logentries

#### Objetivo desse projeto
Centralizar logs de containers gerenciados com kuberenets.

#### Pré-requisitos
Adicionar TOKEN logentries no kubernetes secret namespace kube-system

```
kubectl create secret generic logentries --from-literal=TOKEN=SEU_TOKEN_AQUI -n kube-system

```

Precisamos criar uma serviceAccount para o Fluentd, além de conceder permissões de leitura no socket docker

```
kubectl create -f ./kubernetes/serviceAccount-fluentd.yaml
```

#### Criando DaemonSet

```
kubectl create -f ./kubernetes/daemonSet-fluentd.yaml
```
