ifeq ($(FIREFOX_VERSION),)
$(error Specify FIREFOX_VERSION)
endif

ifeq ($(FLASH_VERSION),)
$(error Specify FLASH_VERSION)
endif

.PHONY: all
all:
	# Adjust version numbers in Dockerfile
	sed -r \
		-e "/^RUN apt-get update/s/firefox=[^*]*\*/firefox=$(FIREFOX_VERSION)*/" \
		-e "/^RUN apt-get update/s/flashplugin-installer=[^*]*\*/flashplugin-installer=$(FLASH_VERSION)*/" \
		-i Dockerfile
	# Update Ubuntu base image
	docker pull $(shell grep ^FROM Dockerfile | cut -d' ' -f2)
	# Build new version
	docker build -t devurandom/firefox:v$(FIREFOX_VERSION)-flash-v$(FLASH_VERSION) .
	# Tag newly created version as latest
	docker tag -f devurandom/firefox:v$(FIREFOX_VERSION)-flash-v$(FLASH_VERSION) devurandom/firefox:latest
	# Remove container if it is not currently running
	( docker ps | awk '$$NF=="firefox"{found=1} END{if(!found){exit 1}}' && echo "Please restart firefox manually" ) || ( docker ps -a | awk '$$NF=="firefox"{found=1} END{if(!found){exit 1}}' && docker rm firefox ) || true
