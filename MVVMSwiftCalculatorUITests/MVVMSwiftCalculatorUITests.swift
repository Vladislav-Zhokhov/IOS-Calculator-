//
//  MVVMSwiftCalculatorUITests.swift
//  MVVMSwiftCalculatorUITests
//
//  Created by 17790204 on 25.09.2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import XCTest
@testable import MVVMSwiftCalculator

//enum MathOperation {
//	case summ
//	case subtract
//	case multiply
//	case divide
//}


class MVVMSwiftCalculatorUITests: XCTestCase {

	var firstDigit: Double = 0
	var secondDigit: Double = 0
	var result: String = "Error"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//		controller = ViewController()
//		viewModel = ViewModel(view: UIView())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//	func testSpecification() {
//		IHaveEnteredFirstDigitIntoCalculator(digit: 5.0)
//		AndIHaveEnteredSecondDigitIntoCalculator(digit: 0.0)
//		WhenIPressed(operation: .divide)
//		result(digit: "Divide")
//	}
//
//	func IHaveEnteredFirstDigitIntoCalculator(digit: Double) {
//		firstDigit = digit
//	}
//
//	func AndIHaveEnteredSecondDigitIntoCalculator(digit: Double) {
//		secondDigit = digit
//	}
//
//	func WhenIPressed(operation: MathOperation) {
//		result = MathOperationClass.execute(firstDigit: firstDigit,
//											secondDigit: secondDigit,
//											operation: operation)
//		print(result)
//	}
//
//	func result(digit: String) {
//		XCTAssertEqual(result, digit)
//	}

	//
   func testSumExample() -> () {
        let app = XCUIApplication()
        app.launch()
		app.buttons["twoDigit"].tap()
		app.buttons["sumButton"].tap()
		app.buttons["twoDigit"].tap()

		let resultLabel = app.staticTexts["4.0"]
        XCTAssertEqual(resultLabel.label, "4.0")
    }

	func testSubtractExample() {
        let app = XCUIApplication()
        app.launch()
		app.buttons["twoDigit"].tap()
		app.buttons["subtractionButton"].tap()
		app.buttons["twoDigit"].tap()

		let resultLabel = app.staticTexts["0.0"]
        XCTAssertEqual(resultLabel.label, "0.0")
    }

	func testMultiplyExample() {
        let app = XCUIApplication()
        app.launch()
		app.buttons["twoDigit"].tap()
		app.buttons["multiplicationButton"].tap()
		app.buttons["twoDigit"].tap()

		let resultLabel = app.staticTexts["4.0"]
        XCTAssertEqual(resultLabel.label, "4.0")
    }

	func testDivideExample() {
        let app = XCUIApplication()
        app.launch()
		app.buttons["twoDigit"].tap()
		app.buttons["divisionButton"].tap()
		app.buttons["twoDigit"].tap()

		let resultLabel = app.staticTexts["1.0"]
        XCTAssertEqual(resultLabel.label, "1.0")
    }

}
