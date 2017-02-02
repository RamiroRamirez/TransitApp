//
//  TADestinationSelectionCell.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 02/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TADestinationSelectionCell				: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet private weak var titleLabel		: UILabel?
	@IBOutlet private weak var inputTextField	: UITextField?

	// MARK: - Properties

	var selectionOptionType						: DestinationSelectionOption = .start
	var showDateSelectionBlock					: (() -> Void)?

	func setupCell(selectionOptionType: DestinationSelectionOption, showDateSelectionBlock: (() -> Void)?) {

		self.selectionStyle = .none
		self.titleLabel?.text = selectionOptionType.title()
		self.inputTextField?.placeholder = selectionOptionType.placeholder()
		self.inputTextField?.text = selectionOptionType.text()

		self.showDateSelectionBlock = showDateSelectionBlock
		self.selectionOptionType = selectionOptionType
		self.inputTextField?.delegate = self
	}
}

extension TADestinationSelectionCell			: UITextFieldDelegate {

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		guard (self.selectionOptionType != .time) else {
			self.showDateSelectionBlock?()
			return false
		}

		return true
	}
}
