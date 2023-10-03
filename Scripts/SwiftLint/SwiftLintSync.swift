#!/usr/bin/swift
import Foundation

let paths: [String] = [
    "Projects/Features/AppState/.swiftlint.yml",
    "Projects/Features/Version/.swiftlint.yml",
    "Projects/Features/Launch/.swiftlint.yml",
    "Projects/DI/.swiftlint.yml",
    "Projects/Util/.swiftlint.yml",
    "Projects/Core/.swiftlint.yml",
    "Projects/App/.swiftlint.yml"
]

let bash = Bash()

do {
    for path in paths {
        let _ = try bash.run(
            commandName: "cp", 
            arguments: [".swiftlint.yml", path]
        )
        print(path + "의 동기화가 성공했습니다.")
    }
} catch {
    print(".swiftlint.yml 실패했습니다. \(error)")
    exit(1)
}

enum BashError: Error {
    case commandNotFound(name: String)
}

final class Bash {

    func run(commandName: String, arguments: [String] = []) throws -> String {
        return try run(resolve(commandName), with: arguments)
    }

    private func resolve(_ command: String) throws -> String {
        guard var bashCommand = try? run("/bin/bash" , with: ["-l", "-c", "which \(command)"]) else {
            throw BashError.commandNotFound(name: command)
        }
        bashCommand = bashCommand.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return bashCommand
    }

    private func run(_ command: String, with arguments: [String] = []) throws -> String {
        let process = Process()
        process.launchPath = command
        process.arguments = arguments
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        process.launch()
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(decoding: outputData, as: UTF8.self)
        return output
    }
}