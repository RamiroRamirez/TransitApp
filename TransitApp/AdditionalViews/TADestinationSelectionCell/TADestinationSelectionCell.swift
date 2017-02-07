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
	@IBOutlet private weak var searchButton		: UIButton?

	// MARK: - Properties

	var selectionOptionType						: DestinationSelectionOption = .start
	var showDateSelectionBlock					: (() -> Void)?
	var userInputBlock							: ((_ parameter: String, _ value: String?) -> Void)?
	var searchPressedBlock						: (() -> Void)?

	// MARK: - Setup Methods

	func setupCell(selectionOptionType: DestinationSelectionOption, showDateSelectionBlock: (() -> Void)?, userInputBlock: ((_ parameter: String, _ value: String?) -> Void)?, searchPressedBlock: (() -> Void)?, parametersDictionary: [String: Any]) {

		self.selectionStyle = .none
		self.showUIElementsForOptionType(selectionOptionType: selectionOptionType)
		let textToShow = self.textFromParameterDictionary(selectionOptionType: selectionOptionType, parametersDictionary: parametersDictionary)

		self.searchButton?.layer.cornerRadius = CornerRadius.Standard

		self.titleLabel?.text = selectionOptionType.title()
		self.inputTextField?.placeholder = selectionOptionType.placeholder()
		self.inputTextField?.text = (textToShow ?? selectionOptionType.deafaulText())

		self.showDateSelectionBlock = showDateSelectionBlock
		self.userInputBlock = userInputBlock
		self.searchPressedBlock = searchPressedBlock
		self.selectionOptionType = selectionOptionType
		self.inputTextField?.delegate = self
	}

	private func showUIElementsForOptionType(selectionOptionType: DestinationSelectionOption) {
		self.searchButton?.isHidden = (selectionOptionType != .search)
		self.titleLabel?.isHidden = (selectionOptionType == .search)
		self.inputTextField?.isHidden = (selectionOptionType == .search)
	}

	// MARK: - General Helpers

	private func textFromParameterDictionary(selectionOptionType: DestinationSelectionOption, parametersDictionary: [String: Any]) -> String? {

		func stringForArriveOrDeparture() -> String {
			return ((parametersDictionary[SearchParametersKeys.ArriveDate] != nil) ? "Arrive" : "Depart")
		}

		func dateInfosToShow(date: Date?) -> String? {
			guard let _date = date else {
				return nil
			}

			// Needs to be arrived or departure?
			let firstStringPart = stringForArriveOrDeparture()

			let dateFormatter = DateFormatter()
			dateFormatter.timeStyle = .short

			let calendar = NSCalendar.current
			if (calendar.isDateInToday(_date) == true) {
				return "\(firstStringPart) Today \(dateFormatter.string(from: _date))"

			} else if (calendar.isDateInYesterday(_date) == true) {
				return "\(firstStringPart) Yesterday \(dateFormatter.string(from: _date))"

			} else if (calendar.isDateInTomorrow(_date)){
				return "\(firstStringPart) Tomorrow \(dateFormatter.string(from: _date))"
			}

			dateFormatter.dateFormat = "EEEEEE, dd MMM, H:mm"
			return "\(firstStringPart) \(dateFormatter.string(from: _date))"
		}

		switch selectionOptionType {
		case .start,
		     .end		: return selectionOptionType.textToShow(parametersDictionary: parametersDictionary) as? String
		case .time		: return dateInfosToShow(date: (selectionOptionType.textToShow(parametersDictionary: parametersDictionary) as? Date))
		case .search	: return nil
		}
	}

	func resignTextFieldFirstResponder() {
		self.inputTextField?.resignFirstResponder()
	}
}

// MARK: - Actions

extension TADestinationSelectionCell {

	@IBAction func searchPressed(_ sender: Any) {
		self.searchPressedBlock?()
	}
}

// MARK: - TextField Delegate Methods

extension TADestinationSelectionCell			: UITextFieldDelegate {

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		// If the textfield is the one to pick a date, show the view containing the picker
		guard (self.selectionOptionType != .time) else {
			self.showDateSelectionBlock?()
			return false
		}

		return true
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		if (self.selectionOptionType == .start) {
			self.userInputBlock?(SearchParametersKeys.Start, textField.text)

		} else if (self.selectionOptionType == .end) {
			self.userInputBlock?(SearchParametersKeys.End, textField.text)
		}
	}
}
