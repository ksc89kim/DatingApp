//
//  Netowrk+Moya.swift
//  Core
//
//  Created by kim sunchul on 2023/08/27.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Moya
import Foundation

public typealias ProgressBlock = (Double) -> Void


public enum StubClosure {
  case immediatelyStub
  case neverStub
  
  var asMoya: MoyaProvider<MoyaTarget>.StubClosure {
    switch self {
    case .immediatelyStub: return MoyaProvider<MoyaTarget>.immediatelyStub
    case .neverStub: return MoyaProvider<MoyaTarget>.neverStub
    }
  }
}


public enum ParameterEncoding {
  case json
  case url
  
  // MARK: - Moya
  
  var asMoya: Moya.ParameterEncoding {
    switch self {
    case .json: return Moya.JSONEncoding.default
    case .url: return Moya.URLEncoding.default
    }
  }
}


public enum NetworkTask {
  case requestPlain
  case requestData(Data)
  case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
  case uploadMultipart([MultipartFormData])
  case uploadCompositeMultipart([MultipartFormData], urlParameters: [String: Any])
  
  // MARK: - Moya
  
  var asMoya: Moya.Task {
    switch self {
    case .requestPlain: return .requestPlain
    case .requestData(let data): return .requestData(data)
    case .requestParameters(parameters: let parameters, encoding: let encoding):
      return .requestParameters(parameters: parameters, encoding: encoding.asMoya)
    case .uploadMultipart(let multipart):
      return .uploadMultipart(multipart.map(\.asMoya))
    case .uploadCompositeMultipart(let multipart, urlParameters: let urlParameters):
      return .uploadCompositeMultipart(multipart.map(\.asMoya), urlParameters: urlParameters)
    }
  }
}


public enum NetworkMethod: String {
  case connect = "CONNECT"
  case delete = "DELETE"
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  
  // MARK: - Moya
  
  var asMoya: Moya.Method {
    return .init(rawValue: self.rawValue)
  }
}


public struct MultipartFormData: Hashable {
  
  // MARK: - Define
  
  public enum FormDataProvider: Hashable {
    case data(Data)
    case file(URL)
    case stream(InputStream, UInt64)
    
    var asMoya: Moya.MultipartFormData.FormDataProvider {
      switch self {
      case .data(let data): return .data(data)
      case .file(let file): return .file(file)
      case .stream(let stream, let data): return .stream(stream, data)
      }
    }
  }
  
  // MARK: - Property
  
  public let provider: FormDataProvider
  
  public let name: String
  
  public let fileName: String?
  
  public let mimeType: String?
  
  // MARK: - Moya
  
  var asMoya: Moya.MultipartFormData {
    return .init(
      provider: self.provider.asMoya,
      name: self.name,
      fileName: self.fileName,
      mimeType: self.mimeType
    )
  }
  
  // MARK: - Init
  
  public init(
    provider: FormDataProvider,
    name: String,
    fileName: String? = nil,
    mimeType: String? = nil
  ) {
    self.provider = provider
    self.name = name
    self.fileName = fileName
    self.mimeType = mimeType
  }
}


public enum ValidationType {
  case none
  case successCodes
  case successAndRedirectCodes
  case customCodes([Int])
  
  var asMoya: Moya.ValidationType {
    switch self {
    case .successCodes:
      return .successCodes
    case .successAndRedirectCodes:
      return .successAndRedirectCodes
    case .customCodes(let codes):
      return .customCodes(codes)
    case .none:
      return .none
    }
  }
}


struct MoyaTarget: TargetType {
  
  // MARK: - Property
  
  let baseURL: URL
  
  let path: String
  
  let method: Moya.Method
  
  let task: Moya.Task
  
  let headers: [String: String]?
  
  let sampleData: Data

  let validationType: ValidationType
  
  // MARK: - Init
  
  init(
    baseURL: URL,
    path: String,
    method: Moya.Method,
    task: Moya.Task,
    sampleData: Data,
    validationType: ValidationType = .none,
    headers: [String: String]? = nil
  ) {
    self.baseURL = baseURL
    self.path = path
    self.method = method
    self.task = task
    self.sampleData = sampleData
    self.headers = headers
    self.validationType = validationType
  }
}
