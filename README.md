# Learning locker docker images

This repository contains the `Dockerfile` to build images for [learning locker](https://github.com/LearningLocker/learninglocker), a LRS to store and analyze xAPI statements.

We follow the learning locker's tag, so an image will have the same tag you can found in learning locker repository.

## Building a learning locker image

To build a learning locker image, you have to pick the right tag to use, set it in the `VERSION` environment variable and then use the `build` task in our Makefile:

```bash
$ VERSION="v2.6.2" make build
```

## Use learning locker image

You have to configure your learning locker image using environment variables. You will found all available variables in the [project documentation](http://docs.learninglocker.net/guides-configuring/#learning-locker-application).

You also have to use the [xapi-service](https://github.com/LearningLocker/xapi-service) provided by learning locker. They also provide a docker image you can use.

There is no entrypoint nor command configured in this image. You will have to declare them when you run your container. Here are the commands to use:

Running the UI application:

```
$ docker-run --rm fundocker/learninglocker:v2.6.2 node ui/dist/server
```

Running the API application:

```
$ docker-run --rm fundocker/learninglocker:v2.6.2 node api/dist/server
```

Running the worker application:

```
$ docker-run --rm fundocker/learninglocker:v2.6.2 node worker/dist/server
```

You can also use the CLI by executing the following command from your container:

```
$ docker-run --rm fundocker/learninglocker:v2.6.2 node cli/dist/server
```
