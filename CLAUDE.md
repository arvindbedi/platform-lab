# AGENTS.md: rules for AI assistants in platform-lab

This repo is a hands-on DevOps learning lab. The human owner reviews and understands every change. Optimise for small, explainable diffs, not speed.

## Repo layout
- apps/            application code (orders-api, later a Java/Maven service)
- infra/           Terraform (modules/, envs/)
- gitops/          Kubernetes manifests, Helm charts, Argo CD apps
- observability/   Prometheus, Grafana, Loki, OpenTelemetry config
- aiops/           anomaly detection, RCA service, evals
- ops-toolkit/     Bash and Python ops scripts
- docs/            ADRs, runbooks, comparison docs

## Safety rules (non-negotiable)
1. NO PRODUCTION ACCESS. Never read, request, create or use credentials, tokens, kubeconfigs or AWS profiles for any environment except the personal sandbox account and the local kind cluster.
2. Never run `terraform apply`, `terraform destroy`, `kubectl apply/delete`, `helm install/upgrade` or any cloud-mutating command. Propose the command and wait for the human to run it. `terraform plan`, `validate`, `fmt`, `kubectl get/describe` and `--dry-run` are fine.
3. Never commit secrets, `.env` files, state files (`*.tfstate`), `*.tfvars` with real values or private keys. Use placeholders such as `<REPLACE_ME>`.
4. No static AWS keys anywhere. Use SSO profiles locally and OIDC in CI.
5. Do not push, merge or force-push. Work on a feature branch; the human opens the PR.
6. Do not edit `.github/workflows/`, CODEOWNERS, branch-protection settings or this file unless the task explicitly says so.
7. Do not add new dependencies, providers, actions or base images without naming them and the reason. Pin versions; pin actions to a tag or SHA.
8. Anything destructive or irreversible: stop and ask first.

## Working agreement
- Plan first: for anything beyond a trivial change, state the plan in 3 to 6 bullets and wait for a go-ahead.
- One logical change per diff. Keep diffs small (target under 200 lines). Do not reformat unrelated files.
- Explain each change in plain words: what, why, what could break, how to verify.
- If unsure, ask. Do not guess resource names, account IDs, regions or CIDRs.
- Say so when a result is unverified. Never claim tests passed without running them.

## Conventions
General
- Commits: Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`, `ci:`). Imperative subject, 72 characters or less.
- Branches: `feat/<topic>`, `fix/<topic>`, `docs/<topic>`.
- Every directory with real content gets a README that says what it is and how to run it.

Bash
- `#!/usr/bin/env bash`, `set -euo pipefail`, quote all variables, `local` in functions.
- Must pass `shellcheck` with no warnings. Support `--help`. Exit non-zero on failure.

Python
- 3.12 or later, type hints, `argparse` for CLIs, no bare `except`.
- `ruff check` and `ruff format` clean. Tests in `pytest`; every new function gets at least one test.

Terraform
- Pin `required_version` and provider versions. Remote state with locking.
- Run `terraform fmt` and `terraform validate`. Use variables with descriptions and types, plus outputs.
- Tag every resource (`project=platform-lab`, `owner`, `ttl`). Least-privilege IAM; no `*` actions or resources without a comment explaining why.
- Prefer small modules in `infra/modules/`.

Kubernetes and Helm
- Set resource requests and limits, liveness and readiness probes, `runAsNonRoot`, and no `latest` image tags.
- One namespace per environment. Secrets are never in Git in plain form.

Docker
- Multi-stage, non-root user, pinned base image tag, `HEALTHCHECK`, `.dockerignore` present.

CI (GitHub Actions / Jenkins)
- Least-privilege `permissions:` block; cache dependencies; fail fast.
- Jenkinsfile: declarative pipeline only.

## Definition of done for a change
- [ ] Linters and tests pass locally (`make lint test` once the Makefile exists)
- [ ] No secrets or real account IDs in the diff
- [ ] README or docs updated if behaviour changed
- [ ] The human has read the whole diff and can explain it

## Review log
Record what the assistant got wrong in `docs/ai-review-log.md` (date, task, mistake, how caught). This feeds the weekly review.
