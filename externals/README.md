# Externals

## External DB
To connect to one we should create a new Secret with informations about the connection, and use that Secret to add environemnt variables to a pod.
[Check YAML](connect-to-db.yaml)

> [!NOTE]
> values needs to be replaced with the actual credential endoced into base64. You can encode using 
> ```echo - n 'the_value' | base64```
> Be careful, since this can expose your credentials into the bash history!


## Private Container Registry
Depending on the Registry a password generation for the registry may vary, but once you have it add it to the clust to the default namespace.

```
kubectl create secret docker-registry theprivateregistry --docker-server=<https://your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```

After it is added use it on configurartions where you want to pull a container from this repository

```
# ...
      containers:
        - name: strapi
          image: ghcr.io/corestad/poc-strapi-dockerized:main
      imagePullSecrets:
        - name: theprivateregistry
# rest of the yaml

```
