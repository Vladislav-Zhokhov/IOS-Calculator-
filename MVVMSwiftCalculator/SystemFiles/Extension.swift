//
//  Extension.swift
//  MVVMSwiftCalculator
//
//  Created by 17790204 on 21/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//
import UIKit

public extension UIView {

	/// Добавить несколько сабвью
	///
	/// - Parameter views:  несколько вью
	func addSubviews(_ views: UIView...) {
		addSubviews(views)
	}

	/// Добавить массив сабвью
	///
	/// - Parameter views:  массив вью
	func addSubviews(_ views: [UIView]) {
		for view in views {
			addSubview(view)
		}
	}

	///  Прицепить вью констрейнтами к супервью с одинаковым отступом от всех сторон
	///
	/// - Parameters:
	///   - inset:  отступ
	func pinToSuperView(inset: CGFloat = 0.0) {
		pinToSuperView(insets: UIEdgeInsets(top: inset,
									   left: inset,
									   bottom: inset,
									   right: inset))
	}

	///  Прицепить вью констрейнтами к супервью с разным отступом от всех сторон
	///
	/// - Parameters:
	///   - insets:  отступы
	func pinToSuperView(insets: UIEdgeInsets) {

		guard let superview = superview else { return }

		let top = superview.topAnchor
		let leading = superview.leadingAnchor
		let trailing = superview.trailingAnchor
		let bottom = superview.bottomAnchor

		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: top, constant: insets.top),
			leadingAnchor.constraint(equalTo: leading, constant: insets.left),
			trailingAnchor.constraint(equalTo: trailing, constant: -insets.right),
			bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom)
		])
	}
}
