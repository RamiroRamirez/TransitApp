//
//  TAInitialViewController.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 02/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TAInitialViewController									: UIViewController {

	// MARK: - Outlets

	@IBOutlet private weak var destinationSelectionView			: UIView?
	@IBOutlet private weak var datePickerViewBottomConstraint	: NSLayoutConstraint?
	@IBOutlet private weak var datePickerViewHeightConstraint	: NSLayoutConstraint?

	// MARK: - Properties

	var destinationSelectionViewController						: TADestinationSelectionViewController?

	// MARK: - View Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		self.destinationSelectionView?.alpha = AlphaForViews.DestinationSelectionView
		self.addTapRecognizer()
	}

	// MARK: - Date Selection view Methods

	fileprivate func addTapRecognizer() {
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideDatePickerView(_:)))
		self.view.addGestureRecognizer(tapRecognizer)
	}

	func hideDatePickerView(_ sender: UITapGestureRecognizer) {
		self.showOrHideDateSelectionView(show: false)
	}

	fileprivate func showOrHideDateSelectionView(show: Bool) {
		let bottomConstraintToHide = ((self.datePickerViewHeightConstraint?.constant ?? 0)) * CGFloat(-1)
		self.datePickerViewBottomConstraint?.constant = ((show == true) ? 0 : bottomConstraintToHide)
		UIView.animate(withDuration: 0.3) {
			self.view.layoutIfNeeded()
		}
	}

	fileprivate func dateSelected(date: Date, isDeparture: Bool) {
		// Set "date" for parameters dictionary in destination view Controller
		let dateKey = ((isDeparture == true) ? SearchParametersKeys.DepartureDate : SearchParametersKeys.ArriveDate)
		self.destinationSelectionViewController?.searchParametersDictionary[dateKey] = date
		self.destinationSelectionViewController?.reloadDataTableView()
	}

	// MARK: - Navigation

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == SegueIdentifiers.toDestinationSelectionViewController.rawValue),
			let destinationSelectionViewController = segue.destination as? TADestinationSelectionViewController {
				// Configure destination selection View Controller
				destinationSelectionViewController.showDateSelectionViewBlock = self.showOrHideDateSelectionView
				self.destinationSelectionViewController = destinationSelectionViewController

		} else if (segue.identifier == SegueIdentifiers.toDateSelectionViewController.rawValue),
			let dateSelectionViewController = segue.destination as? TADatePickerViewController {
				// Configure Date Selection View controller
				dateSelectionViewController.closeDatePickerViewBlock = self.showOrHideDateSelectionView
				dateSelectionViewController.dateSelectedBlock = self.dateSelected
		}
	}
}
