//
//  ViewController.swift
//  MVVMSwiftCalculator
//
//  Created by 17790204 on 21/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// В данном случае ViewController выступает в роли View
class ViewController: UIViewController {

	private var viewModel: ViewModel?

	var firstOperand: Double = 0 // первый операнд
	var secondOperand: Double = 0// второй операнд
	var operationSign: Int = 0   // знак выбранной операции
	var stillTyping = false 	 // флаг проверки вводится ли число или нет
	var dotIsPlaced = false		 // установлена ли точка
	var stillTypingSecondOperand: Bool = false // продолжаем ли мы вводить второй операнд

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

	let mvvmResultLabel: UILabel = {
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

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		setupView()
		viewModel = ViewModel(view: view)
	}

	private func setupView() {

		view.addSubviews(zeroDigitButton,
					oneDigitButton,
					twoDigitButton,
					threeDigitButton,
					fourDigitButton,
					fiveDigitButton,
					sixDigitButton,
					sevenDigitButton,
					eightDigitButton,
					nineDigitButton)

		view.addSubviews(additionButton,
				   subtractionButton,
				   multiplicationButton,
				   divisionButton,
				   clearButton,
				   equalsButton,
				   dotButton)

		view.addSubviews(resultLabel, mvvmResultLabel)

		setupConstraints()
	}

	func setupConstraints() {

		let buttonSize = ( screenWidth - 25 ) / 4
		let zeroButtonWidth = buttonSize * 2 + 5
		let resultHeight = buttonSize 

		NSLayoutConstraint.activate([

			dotButton.heightAnchor.constraint(equalToConstant: buttonSize),
			dotButton.widthAnchor.constraint(equalToConstant: buttonSize),
			dotButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
			dotButton.leftAnchor.constraint(equalTo: zeroDigitButton.rightAnchor, constant: 5),

			zeroDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			zeroDigitButton.widthAnchor.constraint(equalToConstant: zeroButtonWidth),
			zeroDigitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
			zeroDigitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),

			oneDigitButton.heightAnchor.constraint(equalToConstant: buttonSize),
			oneDigitButton.widthAnchor.constraint(equalToConstant: buttonSize),
			oneDigitButton.bottomAnchor.constraint(equalTo: zeroDigitButton.topAnchor, constant: -5),
			oneDigitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),

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
			fourDigitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),

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
			sevenDigitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),

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
			equalsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
			equalsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),

			additionButton.heightAnchor.constraint(equalToConstant: buttonSize),
			additionButton.widthAnchor.constraint(equalToConstant: buttonSize),
			additionButton.bottomAnchor.constraint(equalTo: equalsButton.topAnchor, constant: -5),
			additionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),

			subtractionButton.heightAnchor.constraint(equalToConstant: buttonSize),
			subtractionButton.widthAnchor.constraint(equalToConstant: buttonSize),
			subtractionButton.bottomAnchor.constraint(equalTo: additionButton.topAnchor, constant: -5),
			subtractionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),

			multiplicationButton.heightAnchor.constraint(equalToConstant: buttonSize),
			multiplicationButton.widthAnchor.constraint(equalToConstant: buttonSize),
			multiplicationButton.bottomAnchor.constraint(equalTo: subtractionButton.topAnchor, constant: -5),
			multiplicationButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),


			divisionButton.heightAnchor.constraint(equalToConstant: buttonSize),
			divisionButton.widthAnchor.constraint(equalToConstant: buttonSize),
			divisionButton.bottomAnchor.constraint(equalTo: multiplicationButton.topAnchor, constant: -5),
			divisionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),

			clearButton.heightAnchor.constraint(equalToConstant: buttonSize),
			clearButton.rightAnchor.constraint(equalTo: divisionButton.leftAnchor, constant: -5),
			clearButton.bottomAnchor.constraint(equalTo: sevenDigitButton.topAnchor, constant: -5),
			clearButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),

			resultLabel.heightAnchor.constraint(equalToConstant: resultHeight),
			resultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
			resultLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
			resultLabel.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -5),

			mvvmResultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
			mvvmResultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
			mvvmResultLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
			mvvmResultLabel.bottomAnchor.constraint(equalTo: resultLabel.topAnchor, constant: -5),

		])
	}

	//MARK: - методы для кнопок

	/// метод для нажатия на цифру
	@objc func tapToDigitButton(_ sender: UIButton) {

		if stillTypingSecondOperand {
			if stillTyping {
				resultLabel.text! += String(sender.tag)
				print("Продолжаем вводить цифры для второго операнда")
				secondOperand = (resultLabel.text! as NSString).doubleValue
				print("Второй операнд = \(secondOperand)")
				let res = viewModel?.calculate(firstOperand: firstOperand,
											   secondOperand: secondOperand,
											   operationSign: operationSign)
				mvvmResultLabel.text! = res!

			} else {

				resultLabel.text = String(sender.tag)
				print("Начали вводить второй операнд")
				stillTyping = true
				secondOperand = (resultLabel.text! as NSString).doubleValue
				print("Второй операнд = \(secondOperand)")
				let res = viewModel?.calculate(firstOperand: firstOperand,
											   secondOperand: secondOperand,
											   operationSign: operationSign)
				mvvmResultLabel.text! = res!
			}
		} else {
			if stillTyping {
				resultLabel.text! += String(sender.tag)
				print("Продолжаем вводить цифры для первого операнда:")
				print("Первый операнд = \((resultLabel.text! as NSString).doubleValue)")
			} else {
				resultLabel.text = String(sender.tag)
				print("Начали вводить первый операнд")
				print("Первый операнд = \((resultLabel.text! as NSString).doubleValue)")
				stillTyping = true
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
		stillTyping = false
		dotIsPlaced = false
		// начинаем вводить второй операнд
		stillTypingSecondOperand = true
	}

	/// метод для кнопки: =
	@objc func equlitySignPressed(_ sender: UIButton) {

		dotIsPlaced = false

		switch operationSign {
		case 10 :
			operationWithTwoOperand{$0 + $1}
		case 11 :
			operationWithTwoOperand{$0 - $1}
		case 12 :
			operationWithTwoOperand{$0 * $1}
		case 13 :
			operationWithTwoOperand{$0 / $1}
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
		mvvmResultLabel.text = "0"
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
}
