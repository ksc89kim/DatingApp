//
//  PaginationTests.swift
//  CoreTests
//
//  Created by kim sunchul on 11/28/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import XCTest
@testable import Core

final class PaginationTests: XCTestCase {

  // MARK: - Define

  enum DefaultError: Error {
    case error
  }

  // MARK: - Method

  /// 첫번째 페이지 로드
  func testLoad() async throws {
    let pagination = Pagination()
    let dataSource = MockPagiationDataSource()
    pagination.dataSource = dataSource

    let result =  try await pagination.load()

    XCTAssertEqual(result?.itemCount, pagination.state.limit)
  }

  /// 첫번째 페이지 로드시 에러
  func testErrorWhenLoad() async {
    let pagination = Pagination()
    let dataSource = MockPagiationDataSource()
    dataSource.error = DefaultError.error
    pagination.dataSource = dataSource

    do {
      _ = try await pagination.load()
      XCTFail()
    } catch {
      XCTAssertEqual(error as? PaginationTests.DefaultError, DefaultError.error)
    }
  }

  /// 더보기 페이지 로드
  func testLoadMore() async throws {
    let pagination = Pagination()
    let threshold = pagination.state.itemsFromEndThreshold
    let dataSource = MockPagiationDataSource()
    pagination.state.itemsLoadedCount += pagination.state.limit
    pagination.dataSource = dataSource

    let result =  try await pagination.loadMoreIfNeeded(index: threshold)

    XCTAssertEqual(result?.itemCount, pagination.state.limit)
    XCTAssertEqual(pagination.state.itemsLoadedCount, pagination.state.limit * 2)
  }

  /// 더보기 페이지 로드시 에러
  func testErrorWhenLoadMore() async {
    let pagination = Pagination()
    let threshold = pagination.state.itemsFromEndThreshold
    let dataSource = MockPagiationDataSource()
    dataSource.error = DefaultError.error
    pagination.state.itemsLoadedCount += pagination.state.limit
    pagination.dataSource = dataSource

    do {
      _ =  try await pagination.loadMoreIfNeeded(index: threshold)
      XCTFail()
    } catch {
      XCTAssertEqual(error as? PaginationTests.DefaultError, DefaultError.error)
    }
  }

  /// 더보기 연속으로 페이지 로드 한 경우
  func testLoadMoreContinuously() async throws {
    let pagination = Pagination()
    let threshold = pagination.state.itemsFromEndThreshold
    let dataSource = MockPagiationDataSource()
    pagination.dataSource = dataSource
    pagination.state.itemsLoadedCount += pagination.state.limit

    let resultFirst =  try await pagination.loadMoreIfNeeded(
      index: threshold
    )

    let resultSecond =  try await pagination.loadMoreIfNeeded(
      index: threshold + 1
    )

    XCTAssertNotNil(resultFirst)
    XCTAssertNil(resultSecond)
  }

  /// 인덱스가 페이지 임계치에 가지 못한 경우
  func testIfIndexIsLessThanTheThreshold() async throws {
    let pagination = Pagination()
    let dataSource = MockPagiationDataSource()
    pagination.state.itemsLoadedCount += pagination.state.limit
    pagination.dataSource = dataSource

    let result =  try await pagination.loadMoreIfNeeded(index: 10)

    XCTAssertNil(result)
    XCTAssertEqual(pagination.state.itemsLoadedCount, pagination.state.limit)
  }

  /// 마지막 페이지 이후 테스트
  func testPageOver() async throws {
    let pagination = Pagination()
    let threshold = pagination.state.itemsFromEndThreshold
    let dataSource = MockPagiationDataSource()
    pagination.dataSource = dataSource
    dataSource.isFinal = true

    let fianlResult =  try await pagination.loadMoreIfNeeded(
      index: threshold
    )

    let resultAfterFinal =  try await pagination.loadMoreIfNeeded(
      index: threshold
    )

    XCTAssertNotNil(fianlResult)
    XCTAssertNil(resultAfterFinal)
  }
}
