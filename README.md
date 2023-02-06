# Jenkins Demo Example
## Helm-based deploy of Jenkins on Local K8s
![Jenkins Kubernetes Diagram][jenkins-diagram]

🚨**Note this project was run on WSL and is compatible with Linux machines**🚨

## Key Features
- Locally stand up pipeline with run.sh
- Locally teardown pipeline with cleanup.sh

    ```bash
    # Make scripts executable:
    chmod +x ./run.sh 
    chmod +x ./cleanup.sh
    ```
- Uses Helm to stand up K8s environment
- Configurable with Jenkins based SCM Polling (configure with access token)
- Has PVCs to enable maintenance of state when environment is stopped
- Run all on Docker locally for testing and iteration

<!-- Extraneous Settings -->
[jenkins-diagram]: images/deploy.jpg