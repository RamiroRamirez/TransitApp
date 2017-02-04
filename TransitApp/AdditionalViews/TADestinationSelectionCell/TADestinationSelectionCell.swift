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

	func setupCell(selectionOptionType: DestinationSelectionOption, showDateSelectionBlock: (() -> Void)?, parametersDictionary: [String: Any]) {

		self.selectionStyle = .none
		let textToShow = self.textFromParameterDictionary(selectionOptionType: selectionOptionType, parametersDictionary: parametersDictionary)

		self.titleLabel?.text = selectionOptionType.title()
		self.inputTextField?.placeholder = selectionOptionType.placeholder()
		self.inputTextField?.text = (textToShow ?? selectionOptionType.deafaulText())

		self.showDateSelectionBlock = showDateSelectionBlock
		self.selectionOptionType = selectionOptionType
		self.inputTextField?.delegate = self
	}

	private func textFromParameterDictionary(selectionOptionType: DestinationSelectionOption, parametersDictionary: [String: Any]) -> String? {

		func dateInfosToShow(date: Date?) -> String? {
			guard let _date = date else {
				return nil
			}

			let dateFormatter = DateFormatter()
			dateFormatter.dateStyle = .full
			dateFormatter.timeStyle = .medium

			return dateFormatter.string(from: _date)
		}

		switch selectionOptionType {
		case .start,
		     .end		: return selectionOptionType.textToShow(parametersDictionary: parametersDictionary) as? String
		case .time		: return dateInfosToShow(date: (selectionOptionType.textToShow(parametersDictionary: parametersDictionary) as? Date))
		}
	}
}

extension TADestinationSelectionCell			: UITextFieldDelegate {

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		// If the textfield is the one to pick a date, show the view containing the picker
		guard (self.selectionOptionType != .time) else {
			self.showDateSelectionBlock?()
			return false
		}

		return true
	}
}
