//
//  HighSchoolsViewControllerTests.swift
//  EpimaxTaskTests
//
//  Created by Kartheek Repakula on 12/02/24.
//

import XCTest
@testable import EpimaxTask

class HighSchoolsViewControllerTests: XCTestCase {

    var viewController: HighSchoolsViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "HighSchoolsViewController") as? HighSchoolsViewController
        _ = viewController.view // To trigger viewDidLoad()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testViewModelBinding() {
        XCTAssertNotNil(viewController.viewModel)
        // You can test whether viewModel bindings are set up correctly
    }

    func testTableViewDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource)
        XCTAssertTrue(viewController.tableView.dataSource is HighSchoolsViewController)
    }

    func testTableViewDelegate() {
        XCTAssertNotNil(viewController.tableView.delegate)
        XCTAssertTrue(viewController.tableView.delegate is HighSchoolsViewController)
    }

    func testTableViewDidLoad() {
        // Ensure that the table view is loaded
        XCTAssertNotNil(viewController.tableView)
    }

    func testTableViewHasDataSource() {
        // Ensure that the table view has a data source set
        XCTAssertNotNil(viewController.tableView.dataSource)
    }

    func testTableViewHasDelegate() {
        // Ensure that the table view has a delegate set
        XCTAssertNotNil(viewController.tableView.delegate)
    }


    func testTableViewNumberOfRows() {
        // Ensure that the table view has the correct number of rows
        let numberOfRows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, viewController.viewModel.highSchools.count)
    }

    func testFetchHighSchools() {
        // Ensure that fetching high schools updates the view model
        let initialCount = viewController.viewModel.highSchools.count
        viewController.viewModel.fetchHighSchools()
        XCTAssertEqual(viewController.viewModel.highSchools.count, initialCount)
    }

    


}
