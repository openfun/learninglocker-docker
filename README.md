# Learning locker docker images

This repository contains the `Dockerfile` to build images for:

- [learning locker](https://github.com/LearningLocker/learninglocker), a LRS to store and analyze xAPI statements.
- [xapi-service](https://github.com/LearningLocker/xapi-service), a service dedicated to xAPI requests.

We follow learning locker's versions, so images built from this repository will have the same tags you can found in learning locker and xapi-service repositories.

## Building learning locker image

To build a learning locker image, you have to pick the right [tag](https://github.com/LearningLocker/learninglocker/tags) to use and then build it using the following docker command (here with the `v2.6.2` tag):

```bash
$ docker build -t fundocker/learninglocker:v2.6.2 --build-arg LL_VERSION="v2.6.2" learninglocker/
```

## Building xapi-service image

To build the xapi-service image, you have to pick the right [tag](https://github.com/LearningLocker/xapi-service/tags) to use and then build it using the following docker command (here with the `v2.2.15` tag):

```bash
$ docker build -t fundocker/xapi-service:v2.2.15 --build-arg VERSION="v2.2.15" xapi/
```

## How to use the CI

The CI configured in this repository will test if the image can be built successfully for a particular release, but it also pushes images to docker hub when this repository is tagged

Here are the steps to follow to publish a new image:

- Edit the `.circleci/releases.sh` file and update the tag version corresponding to the image you want to publish.
- Commit your changes, submit a pull request and once merged into master you will be able to tag a new version.

Tags must stick to the following patterns for the image release you want to publish:

- `learninglocker-[RELEASE_TAG]` if you want to publish a new learning locker image (_e.g._ `learninglocker-v2.6.2`),
- `xapi-service-[RELEASE_TAG]` if you want to publish a new xapi-service image (_e.g._ `xapi-service-v2.2.15`).

## Using the learning locker image

You have to configure your learning locker image using environment variables. You will find all available variables in the [project documentation](http://docs.learninglocker.net/guides-configuring/#learning-locker-application).

There is no entrypoint nor command configured in this image. You will have to declare them explicitly when you run your container. A list of commands to use _per_ service follows:

Running the UI application:

```
$ docker run --rm fundocker/learninglocker:v2.6.2 node ui/dist/server
```

Running the API application:

```
$ docker run --rm fundocker/learninglocker:v2.6.2 node api/dist/server
```

Running the worker application:

```
$ docker run --rm fundocker/learninglocker:v2.6.2 node worker/dist/server
```

You can also use the CLI by executing the following command from your container:

```
$ docker run --rm fundocker/learninglocker:v2.6.2 node cli/dist/server
```

### Using the xapi-service image

You have to configure your xapi-service image using environment variables. You will find all available variables in the [project documentation](http://docs.learninglocker.net/guides-configuring/#xapi-service).

By default, the entrypoint from this image will run the `xapi-service`, so you don't have to declare a command.

### docker-compose example

In the `example` directory you will find a docker-compose configuration. This configuration is here as an example to help you to integrate
Learning Locker in your stack.

You can run it without modification in this directory, you can test it by connecting to the interface with the url [http://localhost:8080](http://localhost:8080).
You will also have to create a `site admin` by executing this command once your docker-compose is up and running:

```
$ docker-compose exec api node cli/dist/server createSiteAdmin [email] [organisation] [password]
```

You will probably want to integrate the Learning Locker API in your project, to do that you must copy the `docker-compose.yml` content in your `docker-compose.yml` project file and adapt it to match with your stack.

## License

This work is released under the MIT License (see [LICENSE](./LICENSE)).
