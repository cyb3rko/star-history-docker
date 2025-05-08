# star-history-docker

## Guide

1. Clone repo including submodule:
```bash
git clone --recurse-submodules https://github.com/cyb3rko/star-history-docker
```
2. Copy `template.env` to `.env`:  
```bash
cp template.env .env
```
3. Fill in your GitHub token (https://github.com/settings/personal-access-tokens/new; do not touch any permissions, all OFF by default)
4. Build and run Docker image:
```bash
docker compose up -d --build
```

## Update

To update the upstream repo, run:

```bash
git submodule update --remote
```
