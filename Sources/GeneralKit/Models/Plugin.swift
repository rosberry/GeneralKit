//
//  Copyright © 2021 Rosberry. All rights reserved.
//

public struct Plugin: Codable, Equatable, CustomStringConvertible {
    public let name: String
    public let commands: [String]
    public let repo: String
    public let package: String

    public init(name: String, commands: [String], repo: String, package: String) {
        self.name = name
        self.commands = commands
        self.repo = repo
        self.package = package
    }
}
