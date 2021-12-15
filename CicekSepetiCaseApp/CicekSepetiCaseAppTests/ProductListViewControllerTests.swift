//
//  ProductListViewControllerTests.swift
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

class ProductListViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: ProductListViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupProductListViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupProductListViewController()
  {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class ProductListBusinessLogicSpy: ProductListBusinessLogic {
    // MARK: Method call expectations
    var fetchProductsCalled = false
    
    // MARK: Spied methods
    func fetchProducts() {
        fetchProductsCalled = true
    }
  }
  
  // MARK: Tests
  
  func testShouldFetchProductsWhenViewIsLoaded()
  {
    // Given
    let productListBusinessLogicSpy = ProductListBusinessLogicSpy()
    sut.interactor = productListBusinessLogicSpy
    
    // When
    loadView()
    sut.fetchProductList()
    
    // Then
    XCTAssertTrue(productListBusinessLogicSpy.fetchProductsCalled, "viewDidLoad() should ask the interactor to fetch product list")
  }

}
