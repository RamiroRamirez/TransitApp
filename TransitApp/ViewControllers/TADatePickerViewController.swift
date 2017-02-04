//
//  TADatePickerViewController.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 02/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TADatePickerViewController								: UIViewController {

	// MARK: - Outlets

	@IBOutlet private weak var arriveDepartureSegmentedControl	: UISegmentedControl?
	@IBOutlet private weak var datePicker						: UIDatePicker?

	// MARK: - Properties

	var closeDatePickerViewBlock								: ((_ show: Bool) -> Void)?
	var dateSelectedBlock										: ((_ date: Date, _ isDeparture: Bool) -> Void)?

	// MARK: - Actions

	@IBAction func donePressed(_ sender: Any) {
		defer {
			self.closeDatePickerViewBlock?(false)
		}

		guard let _selectedDate = datePicker?.date else {
			return
		}

		let isDeparture = (self.arriveDepartureSegmentedControl?.selectedSegmentIndex == 0)
		self.dateSelectedBlock?(_selectedDate, isDeparture)
	}

	@IBAction func nowPressed(_ sender: Any) {
		let nowDate = Date()
		self.dateSelectedBlock?(nowDate, true)
		self.closeDatePickerViewBlock?(false)
	}
}
