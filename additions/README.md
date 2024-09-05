# Additional components
To use these additionola nice to have components you will need to use [HELM](https://helm.sh/docs/intro/install/).

## Veeam Kasten
Backup and recovery tool.
Official [docs](https://docs.kasten.io/7.0.7/index.html).

Quick install (with Helm) as a sidecar:
```
helm repo add kasten https://charts.kasten.io/;
kubectl create namespace kasten-io;
helm install k10 kasten/k10 --namespace=kasten-io --set injectKanisterSidecar.enabled=true --set-string injectKanisterSidecar.namespaceSelector.matchLabels.k10/injectKanisterSidecar=true;
```
This will take a little while.

To access the Dashboard without an Ingress:
```
kubectl --namespace kasten-io port-forward service/gateway 8080:80;
```

The dashboard will be reachable at [localhost:8080/k10/#/](http://localhost:8080/k10/#/)

---

To track already running deployments:
```
kubectl namespace ___THE_NAMESPACE___ k10/injectKanisterSidecar=true;
kubectl annotate deployment __THE_DEPLOYMENT___ k10.kasten.io/forcegenericbackup="true" -n ___THE_NAMESPACE___;
```

After this it is advised to scale to 0 and back to original replicas of the deployment so the sidecar gets created in the deployment.

Other use cases (running production apps for example) refer the docs.


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

Check the [examples](examples/) for a shared filesystem or go to the [documentation](https://rook.io/docs/rook/latest-release/Storage-Configuration/Shared-Filesystem-CephFS/filesystem-storage/) for detailed informations.
