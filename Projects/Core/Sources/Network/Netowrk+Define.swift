//
//  Netowrk+Define.swift
//  Core
//
//  Created by kim sunchul on 2023/08/27.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Moya

public typealias Task = Moya.Task
public typealias Method = Moya.Method
public typealias Response = Moya.Response
public typealias NetworkError = Moya.MoyaError
public typealias ProgressBlock = Moya.ProgressBlock
public typealias Completion = (_ result: Result<Response, NetworkError>) -> Void
public typealias ParameterEncoding = Moya.ParameterEncoding
public typealias JSONEncoding = Moya.JSONEncoding
public typealias URLEncoding = Moya.URLEncoding
