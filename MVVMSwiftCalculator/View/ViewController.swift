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

	private var viewModel = ViewModel()

	/// Свойство содержащее вью калькулятора
	private let calculatorView: CalculatorView = {
		let view = CalculatorView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .black
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}

	private func setupView() {
		view.addSubview(calculatorView)
		setupConstaints()
	}

	private func setupConstaints() {
		calculatorView.pinToSuperView()
	}
}
