//
//  ViewModel.swift
//  MVVMSwiftCalculator
//
//  Created by 17790204 on 23/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

class ViewModel {

	var operands: Operands!

	var result:Double = 0
	var firstOperand: Double { return operands.firstOperand } // первый операнд
	var secondOperand: Double { return operands.secondOperand } // второй

	typealias calculateCallBack = (_ status: Bool) -> Void
	var calcCallback:calculateCallBack?

	/// вычисление выражения c двумя операндами
	private func operationWithTwoOperand(operation: (Double, Double) -> Double) {
		result = operation(firstOperand, secondOperand)
	}

	func calculate(firstOperand: Double, secondOperand: Double, operationSign: Int) {

		switch operationSign {
		case 10 :
			print("сложение")
			operationWithTwoOperand{$0 + $1}
		case 11 :
			print("вычитание")
			operationWithTwoOperand{$0 - $1}
		case 12 :
			print("умножение")
			operationWithTwoOperand{$0 * $1}
		case 13 :
			print("деление")
			operationWithTwoOperand{$0 / $1}
		default: break
		}
	}

	//MARK:- verifyUserWith
	fileprivate func verifyUserWith(firstOperand: Double, secondOperand: Double) {
			operands = Operands(firstOperand: firstOperand, secondOperand: secondOperand)
			self.calcCallback?(true)
	}

	//MARK:- loginCompletionHandler
	func loginCompletionHandler(callBack: @escaping calculateCallBack) {
		self.calcCallback = callBack
	}
}


