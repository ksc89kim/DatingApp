#!/usr/bin/swift
import Foundation

Logger.instance.inputLog("Feature 이름을 선정해주세요")
guard let featureName = readLine(), !featureName.isEmpty else {
    Logger.instance.errorLog("Feature 이름이 비어있습니다.")
    exit(1)
}

Logger.instance.inputLog("ProjectType Features Key 이름을 선정해주세요")
guard let projectPathFeatureKey = readLine(), !projectPathFeatureKey.isEmpty else {
    Logger.instance.errorLog("ProjectType Features Key 이름이 비어있습니다.")
    exit(1)
}

Logger.instance.ingLog("Feture 생성을 시작합니다.")
Logger.instance.ingLog("##########################")

let manager = FRBFileManager(
    path: "Tuist/ProjectDescriptionHelpers/Project/ProjectType.swift"
)

do {
    try manager.updateFile(
        finding: "enum Features: String {",
        inserting: "\n    case " + projectPathFeatureKey +  " = \"" + featureName + "\"",
        duplicate: "case " + projectPathFeatureKey
    )
} catch {
    Logger.instance.errorLog(error.localizedDescription)
    exit(1)
}

Logger.instance.ingLog("ProjectType.Feature에 Key 추가 완료 됐습니다.")

let bash = Bash()
do {
    let _ = try bash.run(
            commandName: "tuist", 
            arguments: ["scaffold", "MicroFeatures", "--name", featureName, "--key", projectPathFeatureKey]
        )
} catch {
    Logger.instance.errorLog(error.localizedDescription)
    exit(1)
}

do {
    let _ = try bash.run(
            commandName: "tuist", 
            arguments: ["edit"]
        )
} catch {
    Logger.instance.errorLog(error.localizedDescription)
    exit(1)
}

Logger.instance.successLog()

enum FRBError: LocalizedError {
    case notFound(path: String)
    case duplicate(content: String)
    
    var errorDescription: String? {
        switch self {
            case .notFound(let path): return "파일을 찾을 수 없습니다. " + path
            case .duplicate(let content): return "중복된 내용이 존재합니다 : " + content
        }
    }
}

final class Logger {

    static let instance: Logger = .init()

    func inputLog(_ content: String) {
        print("⌨️  " + content, terminator: " : ")
    }

    func ingLog(_ content: String) {
        print("🛠️  " + content)
    }

    func successLog() {
        print("✅ 모든 구성이 완료되었습니다.")
    }

    func errorLog(_ content: String) {
        print("❌ " + content)
    }
}

final class FRBFileManager {
    var path: URL

    init(path: String) {
        self.path = URL(fileURLWithPath: path)
    }

    func updateFile(
        finding findingString: String,
        inserting insertString: String,
        duplicate: String = ""
    ) throws {
        let readData = try self.readFile()
        guard var fileString = String(data: readData, encoding: .utf8) else { 
            throw FRBError.notFound(path: self.path.absoluteString)
         }

        if !duplicate.isEmpty, fileString.contains(duplicate) {
            throw FRBError.duplicate(content: duplicate)
        }
        fileString.insert(
            contentsOf: insertString, 
            at: fileString.range(of: findingString)?.upperBound ?? fileString.endIndex
        )
        try self.writeFile(content: Data(fileString.utf8))
    }

    private func readFile() throws -> Data {
        let handle  = try FileHandle(forReadingFrom: self.path)
        guard let data = try handle.readToEnd() else {
            throw FRBError.notFound(path: self.path.absoluteString)
        }
        try handle.close()
        return data
    }

    private func writeFile(content: Data) throws {
        let handle  = try FileHandle(forWritingTo: self.path)
        handle.seek(toFileOffset: 0)
        try handle.write(contentsOf: content)
        try handle.close()
    }
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