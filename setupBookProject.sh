!/bin/sh

## login as admin
oc login -u system:admin



## Setup Default Project
#oc project default
oc apply -f <(istioctl kube-inject -f samples/bookinfo/kube/bookinfo.yaml)
oc expose svc productpage

#PRODUCTPAGE=$(oc get route productpage -o jsonpath='{.spec.host}{"\n"}')
#watch -n 1 curl -o /dev/null -s -w %{http_code}\n $PRODUCTPAGE/productpage
