//
//  Copyright © 2021 Rosberry. All rights reserved.
//

public struct GeneralConfig: Codable {
    public var version: String
    public var installedPlugins: [Plugin]
    public var defaultCommand: String?
    public var commands: [String: String]

    public init(version: String, installedPlugins: [Plugin], defaultCommand: String?, commands: [String: String]) {
        self.version = version
        self.installedPlugins = installedPlugins
        self.defaultCommand = defaultCommand
        self.commands = commands
    }

    public func addingUnique<Value: Hashable>(_ value: Value, by keyPath: KeyPath<GeneralConfig, [Value]>) -> [Value] {
        Array(Set(self[keyPath: keyPath] + [value]))
    }
}
