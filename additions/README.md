# Additional components
To use these additionola nice to have components you will need to use [HELM](https://helm.sh/docs/intro/install/).

## Rook Ceph
This is a scaleable storage (Ceph) embedded into the cluster (Rook) that can be used to be consumed by PersistentVolumeClaims and consumed by multiple pods at once with volume bindings.

From the [Ceph Operator Install guide](https://rook.io/docs/rook/latest-release/Helm-Charts/operator-chart/#installing):
```
helm repo add rook-release https://charts.rook.io/release
helm install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph -f values.yaml
```

From the [Ceph Cluster Helm Chart](https://rook.io/docs/rook/latest-release/Helm-Charts/ceph-cluster-chart/#release):
```
helm repo add rook-release https://charts.rook.io/release
helm install --create-namespace --namespace rook-ceph rook-ceph-cluster --set operatorNamespace=rook-ceph rook-release/rook-ceph-cluster -f values.yaml
```

> [!NOTE]
> The namespaces should match.
> Note the `-f values.yaml` this requires a values.yaml file from the respective helm charts to customize the installation

> [!NOTE]
> Check out the corresponding [directory](rook-ceph/) for examples.
