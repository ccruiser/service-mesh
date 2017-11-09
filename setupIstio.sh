!/bin/sh

## login as admin
oc login -u system:admin

## Setup Default Project
#oc project default
oc adm policy add-scc-to-user anyuid -z default
oc adm policy add-scc-to-user privileged -z default
oc adm policy add-cluster-role-to-user cluster-admin -z default

## Add Cluster admin roles
oc adm policy add-cluster-role-to-user cluster-admin admin

## Setup ISTIO System Project and Access
oc new-project istio-system
oc project istio-system
oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account
oc adm policy add-scc-to-user privileged -z istio-ingress-service-account
oc adm policy add-scc-to-user anyuid -z istio-egress-service-account
oc adm policy add-scc-to-user privileged -z istio-egress-service-account
oc adm policy add-scc-to-user anyuid -z istio-pilot-service-account
oc adm policy add-scc-to-user privileged -z istio-pilot-service-account

## Download ISTIO
#curl -L https://git.io/getLatestIstio | sh -
#ISTIO=`ls | grep istio`
#export PATH="$PATH:~/$ISTIO/bin"
#cd $ISTIO

### Deploy istio
oc apply -f install/kubernetes/istio.yaml
#oc apply -f istio/install/kubernetes/istio-auth.yaml
#oc apply -f istio/install/kubernetes/istio-auth-with-cluster-ca.yaml
#oc apply -f istio/install/kubernetes/istio-rbac-beta2.yaml

### Deploy addons
oc apply -f istio/install/kubernetes/addons/prometheus.yaml
oc apply -f istio/install/kubernetes/addons/grafana.yaml
oc apply -f istio/install/kubernetes/addons/servicegraph.yaml
oc apply -f istio/install/kubernetes/addons/zipkin.yaml
#oc apply -f istio/install/kubernetes/addons/istio.yaml


### Expose Services
oc expose svc servicegraph
oc expose svc prometheus
oc expose svc grafana
oc expose svc zipkin
#oc expose svc istio-egress
#oc expose svc istio-ingress

