//
//  MathOperationClass.swift
//  MVVMSwiftCalculator
//
//  Created by 17790204 on 09.10.2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

enum MathErrosExeption: String {
	case divideError = "Divide on 0"
}

enum MathOperation {
	case summ
	case subtract
	case multiply
	case divide
}

class MathOperationClass {

	static func execute(firstDigit: Double, secondDigit: Double, operation: MathOperation) -> String {
		switch operation {
		case .summ:
			return String(firstDigit + secondDigit)
		case .subtract:
			return String(firstDigit - secondDigit)
		case .multiply:
			return String(firstDigit * secondDigit)
		case .divide:
			return divideWithError(firstDigit: firstDigit, secondDigit: secondDigit)
		}
	}

	private static func divideWithError(firstDigit: Double, secondDigit: Double) -> String {
		var result = ""
		if secondDigit == 0 {
			result = String(MathErrosExeption.divideError.rawValue)
		} else {
			result = String(firstDigit / secondDigit)
		}
		return result
	}
}
