#!/bin/bash

jDemo="jenkins-demo"

function check_ns {
  kubectl get namespaces | grep "${jDemo}"
}
# Check if namespace exists
check_ns
nsResult=$?

# If not create it
if [ $nsResult -eq 1 ]; then
  echo "Building namespace ${jDemo}..."
  kubectl create namespace "${jDemo}"
  kubectl config set-context --current --namespace="${jDemo}"
fi

files=""

firstFlag=0

for file in ./manifests/*.yaml; do
  if [ $firstFlag -eq 0 ]; then
    files="${files}-f ${file}"
    firstFlag=1
  else
    files="${files} -f ${file}"
  fi
done

# Helm install Jenkins
helm install $files jenkins ./manifests --debug

POD=$(kubectl get pod -l app=jenkins-server -o jsonpath="{.items[0].metadata.name}")

echo "Printing logs with password.."
kubectl logs "${POD}" -n "${jDemo}" | grep "password" -q

result=$?

while [ $result -ne 0 ]; do
  echo "sleeping 5 seconds to let pod in namespace build, then retrying to see if up"
  sleep 5
  POD=$(kubectl get pod -l app=jenkins-server -o jsonpath="{.items[0].metadata.name}")
  echo "pod: $POD"
  kubectl logs "${POD}" -n "${jDemo}" | grep "password" -q
  result=$?
done

kubectl logs "${POD}" -n "${jDemo}"
