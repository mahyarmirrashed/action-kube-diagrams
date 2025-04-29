# GitHub Action for Kube Diagrams ⎈

> [!WARNING]
> This repository is now archived. The changes have been merged into the official [Kube Diagrams](https://github.com/philippemerle/KubeDiagrams) repository. Please use the action there.

This is a GitHub action for https://github.com/philippemerle/KubeDiagrams. It
can be used in your GitHub Actions workflow to generate diagrams from Kubernetes
manifests.

## Example Usage

```yaml
name: "Your GitHub Action Name"
on:
  workflow_dispatch: # add your specific triggers (https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: "Checkout repository"
        uses: actions/checkout@v4

      - name: "Generate diagram from Helm chart"
        uses: mahyarmirrashed/action-kube-diagrams@main
        with:
          type: "helm"
          args: 'https://charts.jetstack.io/cert-manager'
```
