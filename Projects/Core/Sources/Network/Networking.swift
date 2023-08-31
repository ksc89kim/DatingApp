import Foundation
import Moya

public final class Networking<Target: NetworkTargetType>: MoyaProvider<Target> {

  // MARK: - Method

  public override func request(
    _ target: Target,
    callbackQueue: DispatchQueue? = .none,
    progress: ProgressBlock? = .none,
    completion: @escaping Completion
  ) -> Cancellable {
    return super.request(
      target,
      callbackQueue: callbackQueue,
      progress: progress
    ) { result in

      var log = """
      📡📡📡📡📡 NETWORK 📡📡📡📡📡
      url: \(target.baseURL)\(target.path)
      method: \(target.method)
      parameters: \(target.task)
      headers: \(target.headers ?? [:])
      """

      switch result {
      case .success(let response):
        if let json = try? JSONSerialization.jsonObject(
          with: response.data,
          options: .allowFragments
        ) {
          log += "\nresponse: \(json)"
        } else if let responseString = String(
          data: response.data,
          encoding: .utf8
        ) {
          log += "\nresponse: \(responseString)"
        } else {
          log += "\nresponse: nil"
        }
      case .failure(let error):
        log += "\nerror: \(error)"
      }
      log += "\n📡📡📡📡📡📡📡📡📡📡📡📡📡📡📡"
      print(log)
      completion(result)
    }
  }

  public func request<T: Codable>(
    _ type: T.Type,
    target: Target,
    callbackQueue: DispatchQueue? = .none,
    progress: ProgressBlock? = .none
  ) async throws -> NetworkResponse<T> {
    return try await withCheckedThrowingContinuation { continuation in
       _ = self.request(
        target,
        callbackQueue: callbackQueue,
        progress: progress
      ) { result in
        switch result {
        case .success(let response):
          do {
            let response = try JSONDecoder().decode(
              NetworkResponse<T>.self,
              from: response.data
            )
            continuation.resume(returning: response)
          } catch {
            continuation.resume(throwing: error)
          }
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
}
