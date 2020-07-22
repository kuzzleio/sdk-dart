<p align="center">
  <img src="kuzzle-dart.png"/>
</p>

[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)](https://stackoverflow.com/questions/tagged/flutter?sort=votes)
[![Pub](https://img.shields.io/pub/v/kuzzle.svg?style=flat-square)](https://pub.dartlang.org/packages/kuzzle)
[![codecov](https://img.shields.io/codecov/c/github/prijindal/kuzzle_dart/master.svg?style=flat-square)](https://codecov.io/gh/kuzzleio/sdk-dart)
[![Build Status](https://img.shields.io/travis/prijindal/kuzzle_dart/master.svg?style=flat-square)](https://travis-ci.com/kuzzleio/sdk-dart)

# Kuzzle Dart SDK

## About Kuzzle

A backend software, self-hostable and ready to use to power modern apps.

You can access the Kuzzle repository on [Github](https://github.com/kuzzleio/kuzzle) or view official website [kuzzle.io](https://kuzzle.io).

* [Installation](#installation)
* [Basic usage](#basic-usage)
* [Documentation and Samples](#documentation-and-samples)
* [Contribution](#contribution)

## Installation

Include this in your pubspec.yaml

```yaml
dependencies:
  kuzzle: ^2.0.0

```

> only `WebSocketProtocol` protocol is available for now, feel free to suggest a PR for other protocols submissions

## Documentation and Samples

* [https://docs.kuzzle.io/sdk/dart/2/](https://docs.kuzzle.io/sdk/dart/2/) - 
  _Access the auto generated documentation from source code_
* [https://docs.kuzzle.io/core/1/api](https://docs.kuzzle.io/core/1/api) - 
  _Official Kuzzle API documentation_
* [example/ folder](./example/) - 
  _Various samples about using this library_
  
## Contributions

If you find a bug or want a feature, but don't know how to fix/implement it, feel free to open an issue.
If you fixed a bug or implemented a new feature, we will enjoy to merge your pull request.

## History

The first version of this SDK has been developed by @prijindal which was inspired by the SDK Javascript v5. Later with the help of another contributor, @stafyniaksacha, the SDK was reworked to match the new version 6 of the javascript SDK.
The compatibility of the SDK with Kuzzle v2 was done by @Manuelbaun.

Given the growing interest of the Dart/Flutter community for Kuzzle, we proposed to take over the SDK to integrate it officially and that it be subject to the same quality controls as our other projects.

Many thanks to our amazing contributors!
