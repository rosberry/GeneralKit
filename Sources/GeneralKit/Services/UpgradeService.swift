//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import PathKit
import Foundation

public final class UpgradeService {

    public enum Version {
        case current
        case latest
        case concrete(String)
    }

    public enum Error: Swift.Error, CustomStringConvertible {
        case build

        public var description: String {
            switch self {
            case .build:
                return "Could not build app from source code"
            }
        }
    }

    private lazy var githubService: GithubService = .init()
    private lazy var shell: Shell = .init()

    public init() {
        //
    }

    public func upgrade(to version: Version, customizationHandler: (() throws -> Void)? = nil) throws {
        try cloneGeneralIfNeeded(version: version)
        try customizationHandler?()
        try buildGeneral()
    }

    public func fetchConcreteVersion(from version: Version) -> String {
        switch version {
        case let .concrete(version):
            return version
        case .latest:
            return Constants.defaultGithubBranch
        case .current:
            return ConfigFactory.default?.version ?? Constants.defaultGithubBranch
        }
    }

    // MARK: - Private

    private func cloneGeneralIfNeeded(version: Version) throws {
        let version = fetchConcreteVersion(from: version)
        let repo = Constants.githubRepo
        let destination = Constants.downloadedSourcePath
        try githubService.downloadFiles(at: "\(repo) \(version)", to: destination)
    }

    private func buildGeneral() throws {
        func make() throws {
            try shell(throw: "cd \(Constants.downloadedSourcePath); make")
        }

        do {
            try make()
        }
        catch {
            try FileHelper.default.removeFile(at: URL(fileURLWithPath: Constants.downloadedSourcePath) + ".build")
            try make()
        }
    }
}
