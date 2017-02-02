//
//  TADatePickerViewController.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 02/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TADatePickerViewController: UIViewController {

	// MARK: - Properties

	var closeDatePickerViewBlock	: ((_ show: Bool) -> Void)?

	// MARK: - Actions

	@IBAction func closePressed(_ sender: Any) {
		self.closeDatePickerViewBlock?(false)
	}
}
