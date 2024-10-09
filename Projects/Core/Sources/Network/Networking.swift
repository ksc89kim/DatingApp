import Foundation
import Moya

public final class Networking<Target: NetworkTargetType> {

  // MARK: - Property

  private let provider: MoyaProvider<MoyaTarget>
  
  // MARK: - Init
  
  public init(stub: StubClosure) {
    self.provider = .init(stubClosure: stub.asMoya)
  }

  // MARK: - Method
  
  public func request<T: Codable>(
    _ type: T.Type,
    target: Target,
    callbackQueue: DispatchQueue? = .none,
    progress: ProgressBlock? = .none
  ) async throws -> NetworkResponse<T> {
    return try await withCheckedThrowingContinuation { continuation in
      
      var log = """
      📡📡📡📡📡 NETWORK 📡📡📡📡📡
      url: \(target.baseURL)\(target.path)
      method: \(target.method)
      parameters: \(target.task)
      headers: \(target.headers ?? [:])
      """
      _ = self.provider.request(
        target.asMoya,
        callbackQueue: callbackQueue,
        progress: { response in
          progress?(response.progress)
        },
        completion: { result in
          switch result {
          case .success(let response):
            do {
              let response = try JSONDecoder().decode(
                NetworkResponse<T>.self,
                from: response.data
              )
              log += "\nresponse: \(response)"
              continuation.resume(returning: response)
            } catch {
              log += "\nerror: \(error)"
              continuation.resume(throwing: error)
            }
          case .failure(let error):
            log += "\nerror: \(error)"
            continuation.resume(throwing: error)
          }
          log += "\n📡📡📡📡📡📡📡📡📡📡📡📡📡📡📡"
          print(log)
        }
      )
    }
  }
}
