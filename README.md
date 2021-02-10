# GeneralKit
New vision of source code generation. Provides a few simple functionality to  generate files by the most easiest way. All you need is to get templates where already declared and specify spec file.

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.2-orange.svg" />
    <a href="https://github.com/yonaskolb/Mint">
          <img src="https://img.shields.io/badge/mint-compatible-brightgreen.svg?style=flat" alt="Mint" />
    </a>
</p>

## Using

Override `ParsableCommand` and use any available service

	```swift
	//
    //  Copyright © 2020 Rosberry. All rights reserved.
    //

    import Foundation
    import ArgumentParser
    import GeneralKit

    public final class Generate: ParsableCommand {
        
        public static let configuration: CommandConfiguration = .init(commandName: "gen", abstract: "Generates modules from templates.")

        // MARK: - Parameters

        @Option(name: .shortAndLong, completion: .directory, help: "The path for the project.")
        var path: String = FileManager.default.currentDirectoryPath

        @Option(name: .shortAndLong, help: "The name of the module.")
        var name: String

        @Option(name: .shortAndLong, help: "The name of the template.", completion: .templates)
        var template: String

        @Option(name: .shortAndLong, help: "The output for the template.", completion: .directory)
        var output: String?

        @Argument(help: "The additional variables for templates.")
        var variables: [GeneralKit.Variable] = []

        // MARK: - Lifecycle

        public init() {
        }

        public func run() throws {
            let renderer = Renderer(name: name, template: template, path: path, variables: variables, output: output)
            try renderer.render()
        }
    }

	```

## Installing
- [SPM](https://swift.org/package-manager/): `.package("GeneralKit", .upToMajor("0.0.0"))`


## Authors

* Artem Novichkov, artem.novichkov@rosberry.com
* Nikolay Tyunin, nikolay.tyunin@rosberry.com
* Vlad Zhavoronkov, vlad.zhavoronkov@rosberry.com
* Stanislav Klyukhin, stanislav.klyukhin@rosberry.com

## About

<img src="https://github.com/rosberry/Foundation/blob/master/Assets/full_logo.png?raw=true" height="100" />

This project is owned and maintained by [Rosberry](http://rosberry.com). We build mobile apps for users worldwide 🌏.

Check out our [open source projects](https://github.com/rosberry), read [our blog](https://medium.com/@Rosberry) or give us a high-five on 🐦 [@rosberryapps](http://twitter.com/RosberryApps).

## License

The project is available under the MIT license. See the LICENSE file for more info.
