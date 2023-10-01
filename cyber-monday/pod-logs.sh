for pod in $(kubectl get pods -o jsonpath='{.items[*].metadata.name}')
do
  echo "Pod: $pod"
  kubectl cp ./log.sh $pod:/tmp/

  kubectl exec -it $pod -- /bin/bash /tmp/log.sh

  kubectl cp $pod:/tmp/foo.log ./logs/$pod.log
done