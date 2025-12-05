git_abbr_branch = $(shell git rev-parse --short --abbrev-ref HEAD 2>/dev/null | sed -E 's/[^A-Za-z0-9-]+/-/g' | sed -E 's/-+/-/g' | tr '[:upper:]' '[:lower:]')
git_commit_hash = $(shell git rev-parse --short HEAD 2>/dev/null)

aws_region = $(shell aws configure get region)
aws_account = $(shell aws sts get-caller-identity --output text --query Account)

docker_image_name := ${aws_account}.dkr.ecr.${aws_region}.amazonaws.com/argocd
docker_image_tag := ${git_abbr_branch}-${git_commit_hash}

docker-build:
	docker build -f Dockerfile -t ${docker_image_name}:${docker_image_tag} .

docker-push:
	docker push ${docker_image_name}:${docker_image_tag}

docker-print:
	@echo ${docker_image_name}:${docker_image_tag}
