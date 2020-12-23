//
//  MVVMSwiftCalculatorTests.swift
//  MVVMSwiftCalculatorTests
//
//  Created by 17790204 on 25.09.2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import XCTest
@testable import MVVMSwiftCalculator

class MVVMSwiftCalculatorTests: XCTestCase {

	var firstDigit: Double = 0
	var secondDigit: Double = 0
	var result: String = "Error"

	var viewModel: ViewModel?

    override func setUp() {
        viewModel = ViewModel(view: UIView())
    }

    override func tearDown() {
        viewModel = nil
    }

	func testSpecification() {
		IHaveEnteredFirstDigitIntoCalculator(digit: 5.0)
		AndIHaveEnteredSecondDigitIntoCalculator(digit: 0.0)
		WhenIPressed(operation: .divide)
		result(digit: MathErrosExeption.divideError.rawValue)
//		result(digit: "2.5")
	}

	func IHaveEnteredFirstDigitIntoCalculator(digit: Double) {
		firstDigit = digit
	}

	func AndIHaveEnteredSecondDigitIntoCalculator(digit: Double) {
		secondDigit = digit
	}

	func WhenIPressed(operation: MathOperation) {
		result = MathOperationClass.execute(firstDigit: firstDigit,
											secondDigit: secondDigit,
											operation: operation)
		print(result)
	}

	func result(digit: String) {
		XCTAssertEqual(result, digit)
	}

	/// тест на сумму двух чисел
    func testSum() throws {
		// Given
		let firstOperand = 5.0
		let secondOperand = 5.0
		let expectedResult: String = "10.0"
		var result: String
		//When
		result = (viewModel?.calculate(firstOperand: firstOperand,
									   secondOperand: secondOperand,
									   operationSign: 10))!
		// Them
		//XCTAssert(result == expectedResult, "error")
		XCTAssertEqual(expectedResult, result)
    }

	/// тест на разность двух чисел
    func testSubtract() throws {
		// Given
		let firstOperand = 5.0
		let secondOperand = 5.0
		let expectedResult: String = "0.0"
		var result: String
		//When
		result = (viewModel?.calculate(firstOperand: firstOperand,
									   secondOperand: secondOperand,
									   operationSign: 11))!
		// Them
		XCTAssertEqual(expectedResult, result)
    }

	/// тест на произведение двух чисел
    func testMultiply() throws {
		// Given
		let firstOperand = 5.0
		let secondOperand = 5.0
		let expectedResult: String = "25.0"
		var result: String
		//When
		result = (viewModel?.calculate(firstOperand: firstOperand,
									   secondOperand: secondOperand,
									   operationSign: 12))!
		// Them
		XCTAssertEqual(expectedResult, result)
    }

	/// тест на деление двух чисел
    func testDivide() throws {
		// Given
		let firstOperand = 5.0
		let secondOperand = 5.0
		let expectedResult: String = "1.0"
		var result: String
		//When
		result = (viewModel?.calculate(firstOperand: firstOperand,
									   secondOperand: secondOperand,
									   operationSign: 13))!
		//
		XCTAssertEqual(expectedResult, result)
    }

	func testDivideOnZero() throws {
		// Given
		let firstOperand = 5.0
		let secondOperand = 0
		let expectedResult = ErrorCalculate.divedOnZero.rawValue
		var result: String
		//When
		result = (viewModel?.calculate(firstOperand: firstOperand,
									   secondOperand: Double(secondOperand),
									   operationSign: 13))!
		//
		XCTAssertEqual(expectedResult, result)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
