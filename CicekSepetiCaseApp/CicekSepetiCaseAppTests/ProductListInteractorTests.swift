//
//  ProductListInteractorTests.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import CicekSepetiCaseApp
import XCTest

class ProductListInteractorTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: ProductListInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupProductListInteractor()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupProductListInteractor()
    {
        sut = ProductListInteractor()
    }
    
    // MARK: Test doubles
    
    class ProductListPresentationLogicSpy: ProductListPresentationLogic{
        // MARK: Method call expectations
        var presentFetchedProductsCalled = false
        
        // MARK: Spied methods
        func presentFetchedProducts(response: ProductList.GetProducts.Response) {
            presentFetchedProductsCalled = true
        }
    }
    
    class ProductListWorkerSpy: ProductListWorker {
        // MARK: Method call expectations
        var fetchProductListCalled = false
        
        // MARK: Spied methods
        override func fetchProductList(success: @escaping (ProductBaseModel) -> Void, fail: @escaping (ErrorModel) -> Void) {
            fetchProductListCalled = true
            let error = ErrorModel.networkError
            fail(error)
        }
    }
    
    // MARK: Tests
    
    func testShouldAskWorkerToFetchProductsAndPresenterToFormatIt() {
        // Given
        let productListPresentationLogicSpy = ProductListPresentationLogicSpy()
        sut.presenter = productListPresentationLogicSpy
        let productListWorkerSpy = ProductListWorkerSpy()
        sut.worker = productListWorkerSpy
        
        // When
        sut.fetchProducts()
        
        // Then
        XCTAssertTrue(productListWorkerSpy.fetchProductListCalled, "fetchProducts should ask the worker to get products from the given URL.")
        XCTAssertTrue(productListPresentationLogicSpy.presentFetchedProductsCalled, "fetchProducts should ask the presenter to format the result.")
    }
}
