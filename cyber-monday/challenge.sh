for pod in `kubectl get pods -o=name -l app=just-a-pod | sed "s/^.\{4\}//"`
do
    echo "Pod: $pod"
    echo -n "  Copying log.sh to $pod... "
    kubectl cp log.sh $pod:/tmp/ && echo "ok"

    echo -n "  Executing logging script... "
    kubectl exec -it $pod -- /bin/bash -c "chmod 777 /tmp/log.sh && > /tmp/foo.log && /tmp/log.sh" && echo "ok"

    echo -n "  Copying logfile to working directory... "
    kubectl cp $pod:tmp/foo.log $pod.log && echo "ok"

    echo
done