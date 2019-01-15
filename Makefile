.PHONY: build
build:
	docker build -t fundocker/learninglocker:${VERSION} --build-arg LL_VERSION="${VERSION}" .
