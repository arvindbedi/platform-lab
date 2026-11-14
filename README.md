# platform-lab

# platform-lab

A hands-on DevOps / Cloud / Platform engineering lab, built in public over six months (Oct 2026 – Apr 2027). Everything here is built, broken and rebuilt from scratch: no copy-paste labs.

One app (`orders-api`) is carried through the whole delivery chain: CI/CD, infrastructure as code, containers, Kubernetes, GitOps, observability, and finally an AI-assisted incident-response copilot.

## Repo layout

| Folder | What lives here |
|---|---|
| `apps/` | Application code: `orders-api` (FastAPI, Postgres, Redis) and small supporting services |
| `infra/` | Terraform: remote state, VPC, ALB/ASG, EKS, IAM (applied through CI with OIDC, no static keys) |
| `gitops/` | Kubernetes manifests, Helm charts and Argo CD app-of-apps; Git is the source of truth |
| `observability/` | Prometheus, OpenTelemetry, Loki, Tempo and Grafana config, dashboards and alerts as code, SLOs |
| `aiops/` | Anomaly detector, LLM root-cause-analysis service, guarded remediation agent, `evals/` |
| `docs/` | Architecture diagrams, ADRs, comparison write-ups, troubleshooting guides, postmortems |

## Roadmap

Status key: ⬜ planned · 🟨 in progress · ✅ shipped

| # | Project | Target | Shows | Status |
|---|---|---|---|---|
| 1 | **ops-toolkit**: Bash and Python ops scripts with tests and CI | Wk 1–2 | Linux, scripting, Git workflow | 🟨 |
| 2 | **orders-api + dual pipelines**: Jenkinsfile and GitHub Actions parity, comparison doc | Wk 3–4 | CI/CD fundamentals | ⬜ |
| 3 | **Ansible hardening role**: idempotent, vault, lint in CI | Wk 5 | Configuration management | ⬜ |
| 4 | **Terraform AWS foundation**: remote state, VPC module, ALB/ASG, S3 + CloudFront, plan/apply via OIDC | Wk 6–10 | Infrastructure as code | ⬜ |
| 5 | **Container build and supply chain**: multi-stage image, Compose, Trivy, ECR push | Wk 8–9 | Containers, secure builds | ⬜ |
| 6 | **Kubernetes on kind**: manifests, Helm, RBAC, NetworkPolicy, 5-failure troubleshooting guide | Wk 9–11 | Kubernetes operations | ⬜ |
| 7 | **EKS with GitOps**: Terraform EKS, ALB controller, Argo CD | Wk 12–13 | Managed Kubernetes, GitOps | ⬜ |
| 8 | **Observability stack**: OpenTelemetry, Prometheus, Loki, Tempo, dashboards as code, SLOs | Wk 14–16 | Observability, SRE practice | ⬜ |
| 9 | **AIOps copilot (flagship)**: anomaly detection, LLM RCA with evidence and confidence, guarded remediation, eval table | Wk 16–19 | AIOps, agents, evals, safety | ⬜ |
| 10 | **DevSecOps pipeline**: scan gates, SBOM, image signing, admission policy | Wk 21 | Supply-chain security | ⬜ |
| 11 | **Platform golden path**: template repo, self-service environments with TTL, Infracost, DORA dashboard, game day | Wk 22–23 | Platform engineering | ⬜ |
| 12 | **AI-for-DevOps toolbox**: Terraform plan reviewer, read-only cluster MCP server, runbook RAG | Wk 7–22 | Practical AI in the delivery workflow | ⬜ |

## How this repo is run

- **Everything goes through a pull request.** `main` is protected; CI must pass before merge.
- **Infra is ephemeral.** Anything that costs money (EKS, NAT gateways) is created per session and destroyed after. Every project has a teardown script.
- **AI is a tool, not an author of record.** AI-generated code and IaC is linted, scanned and reviewed by me before merge. Where an AI got something wrong, I note it.
- **Automation is guarded.** Remediation agents only run allow-listed actions, dry-run first, with human approval and an audit log.

## Getting started

```bash
./bootstrap.sh        # checks the local toolchain: docker, kubectl, kind, helm, terraform, aws, k9s
make up               # (once orders-api lands) start the local stack
```

## Progress log

Weekly notes and decisions live in [`docs/`](docs/). Each shipped project gets its own README with an architecture diagram, cost notes and teardown steps.