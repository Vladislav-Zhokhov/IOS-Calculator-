//
//  ViewModel.swift
//  MVVMSwiftCalculator
//
//  Created by 17790204 on 23/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Класс вью модели
class ViewModel {

	/// слабой ссылкой держим view
	weak var calculatorView: UIView?
	///  модель данных
	var model = Operands(firstOperand: 0, secondOperand: 0)

	private var result: Double = 0

	init(view: UIView) {
		calculatorView = view
	}

	/// Реактивное вычисление значения
	func calculate(firstOperand: Double, secondOperand: Double, operationSign: Int) -> String {
			switch operationSign {
					case 10 :
						model.firstOperand = firstOperand
						model.secondOperand = secondOperand
						result = model.firstOperand + model.secondOperand
						print("Результат сложения =  \(result)")
					case 11 :
						model.firstOperand = firstOperand
						model.secondOperand = secondOperand
						result = model.firstOperand - model.secondOperand
						print("Результат вычитания = \(result)")
					case 12 :
						model.firstOperand = firstOperand
						model.secondOperand = secondOperand
						result = model.firstOperand * model.secondOperand
						print("Результат умножения = \(result)")
					case 13 :
						model.firstOperand = firstOperand
						model.secondOperand = secondOperand
						let result = MathOperationClass.execute(firstDigit: firstOperand,
																secondDigit: secondOperand,
																operation: .divide)
						return result
//						if !(model.secondOperand == 0 || Int(model.secondOperand) < 10 ^ -8) {
//							result = try model.firstOperand / model.secondOperand
//							print("Рузельтат деления = \(result)")
//						} else {
//							print("Деление на ноль запрешено")
//							return ErrorCalculate.divedOnZero.rawValue
//				}
			default: return "error" }
		return String(result)
	}

	func testSumm() {

	}
}


