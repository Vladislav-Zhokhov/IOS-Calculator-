//
//  CalculatorView.swift
//  MVVMSwiftCalculator
//
//  Created by 17790204 on 21/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Вью калькулятор
class CalculatorView: UIView {

	var firstOperand: Double = 0 // первый операнд
	var secondOperand: Double = 0// второй операнд
	var operationSign: Int = 0   // знак выбранной операции
	var stillTyping = false 	 // флаг проверки вводится ли число или нет
	var dotIsPlaced = false		 // установлена ли точка

	var currentInput: Double {
		get {
			return (resultLabel.text! as NSString).doubleValue
		}

		set {
			let value = "\(newValue)"
			let valueArray = value.components(separatedBy: ".")
			if valueArray[1] == "0" {
				resultLabel.text = "\(valueArray[0])"
			} else {
				resultLabel.text = "\(value)"
			}

			stillTyping = false
		}
	}

	let screenWidth = UIScreen.main.bounds.width

	let mvvmResult: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "0"
		label.textColor = .white
		label.textAlignment = .right
		label.font = UIFont.systemFont(ofSize: 65)
		return label
	}()

	/// Вью с резульатом вычисления
	let resultLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "0"
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 65)
		return label
	}()

	//MARK: - Кнопки с цифрами

	private lazy var zeroDigitButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(tapToDigitButton), for: .touchUpInside)
		button.setTitle("0", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 0
		return button
	}()

	private lazy var oneDigitButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(tapToDigitButton), for: .touchUpInside)
		button.setTitle("1", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 1
		return button
	}()

	private lazy var twoDigitButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(tapToDigitButton), for: .touchUpInside)
		button.setTitle("2", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 2
		return button
	}()

	private lazy var threeDigitButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(tapToDigitButton), for: .touchUpInside)
		button.setTitle("3", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 3
		return button
	}()

	private lazy var fourDigitButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(tapToDigitButton), for: .touchUpInside)
		button.setTitle("4", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 4
		return button
	}()

	private lazy var fiveDigitButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(tapToDigitButton), for: .touchUpInside)
		button.setTitle("5", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 5
		return button
	}()

	private lazy var sixDigitButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(tapToDigitButton), for: .touchUpInside)
		button.setTitle("6", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 6
		return button
	}()

	private lazy var sevenDigitButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(tapToDigitButton), for: .touchUpInside)
		button.setTitle("7", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 7
		return button
	}()

	private lazy var eightDigitButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(tapToDigitButton), for: .touchUpInside)
		button.setTitle("8", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 8
		return button
	}()

	private lazy var nineDigitButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(tapToDigitButton), for: .touchUpInside)
		button.setTitle("9", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 9
		return button
	}()

	//MARK: - Кнопки с арифметическими операциями

	private lazy var additionButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(arithmeticOperation), for: .touchUpInside)
		button.setTitle("+", for: .normal)
		button.backgroundColor = .systemOrange
		button.layer.cornerRadius = 20
		button.tag = 10
		return button
	}()

	private lazy var subtractionButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(arithmeticOperation), for: .touchUpInside)
		button.setTitle("-", for: .normal)
		button.backgroundColor = .systemOrange
		button.layer.cornerRadius = 20
		button.tag = 11
		return button
	}()

	private lazy var multiplicationButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(arithmeticOperation), for: .touchUpInside)
		button.setTitle("*", for: .normal)
		button.backgroundColor = .systemOrange
		button.layer.cornerRadius = 20
		button.tag = 12
		return button
	}()

	private lazy var divisionButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(arithmeticOperation), for: .touchUpInside)
		button.setTitle("/", for: .normal)
		button.backgroundColor = .systemOrange
		button.layer.cornerRadius = 20
		button.tag = 13
		return button
	}()

	private lazy var clearButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
		button.setTitle("C", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 14
		return button
	}()

	private lazy var equalsButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
	//	button.addTarget(self, action: #selector(equlitySignPressed), for: .touchUpInside)
		button.addTarget(self, action: #selector(equlitySignPressed), for: .touchUpInside)
		button.setTitle("=", for: .normal)
		button.backgroundColor = .systemOrange
		button.layer.cornerRadius = 20
		button.tag = 15
		return button
	}()

	private lazy var dotButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(dotButtonPressed), for: .touchUpInside)
		button.setTitle(".", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 16
		return button
	}()

	private lazy var percentButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(percentageButtonPressed), for: .touchUpInside)
		button.setTitle("%", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 17
		return button
	}()

	private lazy var plusMinusButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(plusMinusButtonPressed), for: .touchUpInside)
		button.setTitle("+/-", for: .normal)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .normal)
		button.layer.cornerRadius = 20
		button.tag = 18
		return button
	}()

	//MARK: - init

	init() {
		super.init(frame: .zero)
		backgroundColor = .black
		setupView()
	}

	private func setupView() {

		addSubviews(zeroDigitButton,
					oneDigitButton,
					twoDigitButton,
					threeDigitButton,
					fourDigitButton,
					fiveDigitButton,
					sixDigitButton,
					sevenDigitButton,
					eightDigitButton,
					nineDigitButton)

		addSubviews(additionButton,
				   subtractionButton,
				   multiplicationButton,
				   divisionButton,
				   clearButton,
				   equalsButton,
				   dotButton,
				   percentButton,
				   plusMinusButton)

		addSubviews(resultLabel, mvvmResult)

		setupConstraints()
	}

	func setupConstraints() {

		let buttonSize = ( screenWidth - 25 ) / 4
		let zeroButtonWidth = buttonSize * 2 + 5
		let resultHeight = buttonSize * 2

		NSLayoutConstraint.activate([

			dotButton.heightAnchor.constraint(equalToConstant: buttonSize),
			dotButton.widthAnchor.constraint(equalToConstant: buttonSize),
			dotButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
			dotButton.leftAnchor.constraint(equalTo: zeroDigitButton.rightAnchor, constant: 5),

			zeroDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			zeroDigitButton.widthAnchor.constraint(equalToConstant: zeroButtonWidth),
			zeroDigitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
			zeroDigitButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),

			oneDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			oneDigitButton.widthAnchor.constraint(equalToConstant: buttonSize),
			oneDigitButton.bottomAnchor.constraint(equalTo: zeroDigitButton.topAnchor, constant: -5),
			oneDigitButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),

			twoDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			twoDigitButton.widthAnchor.constraint(equalToConstant: buttonSize),
			twoDigitButton.bottomAnchor.constraint(equalTo: zeroDigitButton.topAnchor, constant: -5),
			twoDigitButton.leftAnchor.constraint(equalTo: oneDigitButton.rightAnchor, constant: 5),

			threeDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			threeDigitButton.widthAnchor.constraint(equalToConstant: buttonSize),
			threeDigitButton.bottomAnchor.constraint(equalTo: zeroDigitButton.topAnchor, constant: -5),
			threeDigitButton.leftAnchor.constraint(equalTo: twoDigitButton.rightAnchor, constant: 5),

			fourDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			fourDigitButton.widthAnchor.constraint(equalToConstant: buttonSize),
			fourDigitButton.bottomAnchor.constraint(equalTo: oneDigitButton.topAnchor, constant: -5),
			fourDigitButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),

			fiveDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			fiveDigitButton.widthAnchor.constraint(equalToConstant: buttonSize),
			fiveDigitButton.bottomAnchor.constraint(equalTo: twoDigitButton.topAnchor, constant: -5),
			fiveDigitButton.leftAnchor.constraint(equalTo: fourDigitButton.rightAnchor, constant: 5),

			sixDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			sixDigitButton.widthAnchor.constraint(equalToConstant: buttonSize),
			sixDigitButton.bottomAnchor.constraint(equalTo: threeDigitButton.topAnchor, constant: -5),
			sixDigitButton.leftAnchor.constraint(equalTo: fiveDigitButton.rightAnchor, constant: 5),

			sevenDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			sevenDigitButton.widthAnchor.constraint(equalToConstant: buttonSize),
			sevenDigitButton.bottomAnchor.constraint(equalTo: fourDigitButton.topAnchor, constant: -5),
			sevenDigitButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),

			eightDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			eightDigitButton.widthAnchor.constraint(equalToConstant: buttonSize),
			eightDigitButton.bottomAnchor.constraint(equalTo: fiveDigitButton.topAnchor, constant: -5),
			eightDigitButton.leftAnchor.constraint(equalTo: sevenDigitButton.rightAnchor, constant: 5),

			nineDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			nineDigitButton.widthAnchor.constraint(equalToConstant: buttonSize),
			nineDigitButton.bottomAnchor.constraint(equalTo: sixDigitButton.topAnchor, constant: -5),
			nineDigitButton.leftAnchor.constraint(equalTo: eightDigitButton.rightAnchor, constant: 5),

			equalsButton.heightAnchor.constraint(equalToConstant: buttonSize),
			equalsButton.widthAnchor.constraint(equalToConstant: buttonSize),
			equalsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
			equalsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),

			additionButton.heightAnchor.constraint(equalToConstant: buttonSize),
			additionButton.widthAnchor.constraint(equalToConstant: buttonSize),
			additionButton.bottomAnchor.constraint(equalTo: equalsButton.topAnchor, constant: -5),
			additionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),

			subtractionButton.heightAnchor.constraint(equalToConstant: buttonSize),
			subtractionButton.widthAnchor.constraint(equalToConstant: buttonSize),
			subtractionButton.bottomAnchor.constraint(equalTo: additionButton.topAnchor, constant: -5),
			subtractionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),

			multiplicationButton.heightAnchor.constraint(equalToConstant: buttonSize),
			multiplicationButton.widthAnchor.constraint(equalToConstant: buttonSize),
			multiplicationButton.bottomAnchor.constraint(equalTo: subtractionButton.topAnchor, constant: -5),
			multiplicationButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),


			divisionButton.heightAnchor.constraint(equalToConstant: buttonSize),
			divisionButton.widthAnchor.constraint(equalToConstant: buttonSize),
			divisionButton.bottomAnchor.constraint(equalTo: multiplicationButton.topAnchor, constant: -5),
			divisionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),

			clearButton.heightAnchor.constraint(equalToConstant: buttonSize),
			clearButton.widthAnchor.constraint(equalToConstant: buttonSize),
			clearButton.bottomAnchor.constraint(equalTo: sevenDigitButton.topAnchor, constant: -5),
			clearButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),

			plusMinusButton.heightAnchor.constraint(equalToConstant: buttonSize),
			plusMinusButton.widthAnchor.constraint(equalToConstant: buttonSize),
			plusMinusButton.bottomAnchor.constraint(equalTo: eightDigitButton.topAnchor, constant: -5),
			plusMinusButton.leftAnchor.constraint(equalTo: clearButton.rightAnchor, constant: 5),

			percentButton.heightAnchor.constraint(equalToConstant: buttonSize),
			percentButton.widthAnchor.constraint(equalToConstant: buttonSize),
			percentButton.bottomAnchor.constraint(equalTo: nineDigitButton.topAnchor, constant: -5),
			percentButton.leftAnchor.constraint(equalTo: plusMinusButton.rightAnchor, constant: 5),

			resultLabel.heightAnchor.constraint(equalToConstant: resultHeight),
			resultLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
			resultLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
			resultLabel.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -5),

			mvvmResult.heightAnchor.constraint(equalToConstant: resultHeight),
			mvvmResult.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
			mvvmResult.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
			mvvmResult.bottomAnchor.constraint(equalTo: resultLabel.topAnchor, constant: -5),

		])
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	var stillTypingSecondOperand: Bool = false // начинае вводить второй операнд
	var firstModel: Double = 0
	var secondModel: Double = 0
	var tupaResult: Double = 0

	//MARK: - методы для кнопок

	/// метод для нажатия на цифру
	@objc func tapToDigitButton(_ sender: UIButton) {

		if stillTypingSecondOperand {
			if stillTyping {

				// через delegateVM.calculate() {}

				resultLabel.text! += String(sender.tag)
				print("Продолжаем вводить цифры для второго операнда")

				secondModel = (resultLabel.text! as NSString).doubleValue

				
				switch operationSign {
				case 10 :
					tupaResult = firstModel + secondModel
					print("сложение \(tupaResult)")
					mvvmResult.text! = String(tupaResult)
				case 11 :
					tupaResult = firstModel - secondModel
					print("вычитание \(tupaResult)")
					mvvmResult.text! = String(tupaResult)
				case 12 :
					tupaResult = firstModel * secondModel
					print("умножение \(tupaResult)")
					mvvmResult.text! = String(tupaResult)
				case 13 :
					tupaResult = firstModel / secondModel
					print("деление \(tupaResult)")
					mvvmResult.text! = String(tupaResult)
				default: break }

			} else {

				resultLabel.text = String(sender.tag)
				print("Вводим второй операнд")
				stillTyping = true

				// через delegateVM.calculate() {}
				secondModel = (resultLabel.text! as NSString).doubleValue

				switch operationSign {
				case 10 :
					tupaResult = firstModel + secondModel
					print("сложение \(tupaResult)")
					mvvmResult.text! = String(tupaResult)
				case 11 :
					tupaResult = firstModel - secondModel
					print("вычитание \(tupaResult)")
					mvvmResult.text! = String(tupaResult)
				case 12 :
					tupaResult = firstModel * secondModel
					print("умножение \(tupaResult)")
					mvvmResult.text! = String(tupaResult)
				case 13 :
					tupaResult = firstModel / secondModel
					print("деление \(tupaResult)")
					mvvmResult.text! = String(tupaResult)
				default: break }
			}
		} else {
			if stillTyping {
				resultLabel.text! += String(sender.tag)
				print("Продолжаем вводить цифры для первого операнда")
				firstModel = (resultLabel.text! as NSString).doubleValue
				print(firstModel)
			} else {
				resultLabel.text = String(sender.tag)
				print("Вводим первый операнд")
				stillTyping = true
				firstModel = (resultLabel.text! as NSString).doubleValue
				print(firstModel)
			}
		}

	}

	/// вычисление выражения c двумя операндами
	private func operationWithTwoOperand(operation: (Double, Double) -> Double) {
		currentInput = operation(firstOperand, secondOperand)
		stillTyping = false
	}

	/// метод для кнопок:  + - * /
	@objc func arithmeticOperation(_ sender: UIButton) {
		operationSign = sender.tag
		firstOperand = currentInput
		print("Получившийся первый операнд: \(firstOperand)")
		stillTyping = false
		dotIsPlaced = false
		// начинаем вводить второй операнд
		stillTypingSecondOperand = true
	}

	/// метод для кнопки: =
	@objc func equlitySignPressed(_ sender: UIButton) {

		if stillTyping {
			secondOperand = currentInput
		}

		dotIsPlaced = false

		switch operationSign {
		case 10 :
			print("сложение")
			operationWithTwoOperand{$0 + $1}

			tupaResult = firstModel + secondOperand
			print("сложение \(tupaResult)")
		case 11 :
			print("вычитание")
			operationWithTwoOperand{$0 - $1}

			tupaResult = firstModel - secondOperand
			print("вычитание \(tupaResult)")
		case 12 :
			print("умножение")
			operationWithTwoOperand{$0 * $1}

			tupaResult = firstModel * secondOperand
			print("умножение \(tupaResult)")
		case 13 :
			print("деление")
			operationWithTwoOperand{$0 / $1}

			tupaResult = firstModel / secondOperand
			print("деление \(tupaResult)")
		default: break
		}
	}

	// метод для кнопки стереть
	@objc func clearButtonPressed(_ sender: UIButton) {
		firstOperand = 0
		secondOperand = 0
		currentInput = 0
		resultLabel.text = "0"
		stillTyping = false
		operationSign = 0
		dotIsPlaced = false

		stillTypingSecondOperand = false
		mvvmResult.text = "0"
	}

	///  метод для кнопки +/-
	@objc func plusMinusButtonPressed(_ sender: UIButton) {
		currentInput = -currentInput
	}

	/// метод для подстановки точки
	@objc func dotButtonPressed(_ sender: UIButton) {
		if stillTyping && !dotIsPlaced {
			resultLabel.text = resultLabel.text! + "."
			dotIsPlaced = true
		} else if stillTyping && !dotIsPlaced {
			resultLabel.text = "0."
		}
	}

	/// вычисление процента
	@objc func percentageButtonPressed(_ sender: UIButton) {
		if firstOperand == 0 {
			currentInput = currentInput / 100
		} else {
			secondOperand = firstOperand * currentInput / 100
		}
		stillTyping = false
	}


}

