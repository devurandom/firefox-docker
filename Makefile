ifeq ($(VERSION),)
$(error Specify VERSION)
endif

.PHONY: all
all:
	# Adjust version numbers in Dockerfile
	sed -r \
		-e "/^RUN apt-get -y update/s/firefox=[^*]*\*/firefox=$(VERSION)*/" \
		-i Dockerfile
	# Update Ubuntu base image
	docker pull $(shell grep ^FROM Dockerfile | cut -d' ' -f2)
	# Build new version
	docker build -t devurandom/firefox:v$(VERSION) .
	# Tag newly created version as latest
	docker tag -f devurandom/firefox:v$(VERSION) devurandom/firefox:latest
	# Remove container if it is not currently running
	( docker ps | awk '$$NF=="firefox"{found=1} END{if(!found){exit 1}}' && echo "Please restart firefox manually" ) || ( docker ps -a | awk '$$NF=="firefox"{found=1} END{if(!found){exit 1}}' && docker rm firefox ) || true
