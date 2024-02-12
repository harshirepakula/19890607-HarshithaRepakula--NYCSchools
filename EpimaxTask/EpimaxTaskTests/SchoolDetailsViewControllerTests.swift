//
//  SchoolDetailsViewControllerTests.swift
//  EpimaxTaskTests
//
//  Created by Kartheek Repakula on 12/02/24.
//

import XCTest
@testable import EpimaxTask

class SchoolDetailsViewControllerTests: XCTestCase {

    var viewController: SchoolDetailsViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "SchoolDetailsViewController") as? SchoolDetailsViewController
        _ = viewController.view // To trigger viewDidLoad()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testUpdateUIWithHighSchoolAndSATScores() {
        // Mock high school and SAT scores data
        let highSchool = HighSchool(dbn: "123456", school_name: "Test High School")
        
        
        let satScores = SATScores(dbn: "123456", sat_math_avg_score: "500", sat_critical_reading_avg_score: "550", sat_writing_avg_score: "520")
        
        // Set high school and SAT scores to the view controller
        viewController.highSchool = highSchool
        viewController.satScores = satScores
        
        // Call updateUI method
        viewController.updateUI()
        
        // Assert that UI elements are updated correctly
        XCTAssertEqual(viewController.schoolNameLabel.text, "Test High School")
        XCTAssertEqual(viewController.mathScoreLabel.text, "Math: 500")
        XCTAssertEqual(viewController.readingScoreLabel.text, "Reading: 550")
        XCTAssertEqual(viewController.writingScoreLabel.text, "Writing: 520")
    }
    
    func testUpdateUIWithoutSATScores() {
        // Mock high school data without SAT scores
        let highSchool = HighSchool(dbn: "123456", school_name: "Test High School")
        
        // Set high school to the view controller
        viewController.highSchool = highSchool
        viewController.satScores = nil
        
        // Call updateUI method
        viewController.updateUI()
        
        // Assert that UI elements show "SAT scores are not available"
        XCTAssertEqual(viewController.schoolNameLabel.text, "Test High School")
        XCTAssertEqual(viewController.mathScoreLabel.text, "SAT scores are not available")
        XCTAssertEqual(viewController.readingScoreLabel.text, "SAT scores are not available")
        XCTAssertEqual(viewController.writingScoreLabel.text, "SAT scores are not available")
    }

    // Add more test cases as needed
}
