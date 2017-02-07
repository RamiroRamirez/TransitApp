//
//  TAInitialViewController.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 02/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit
import DKHelper

class TAInitialViewController											: UIViewController {

	// MARK: - Outlets

	@IBOutlet private weak var destinationSelectionView					: UIView?
	@IBOutlet private weak var datePickerViewBottomConstraint			: NSLayoutConstraint?
	@IBOutlet private weak var datePickerViewHeightConstraint			: NSLayoutConstraint?
	@IBOutlet private weak var destinationSelectionViewHeightConstraint	: NSLayoutConstraint?

	// MARK: - Properties

	var destinationSelectionViewController								: TADestinationSelectionViewController?
	var datePickerViewController										: TADatePickerViewController?

	// MARK: - View Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = L("TransportApp")
		self.destinationSelectionView?.alpha = AlphaForViews.DestinationSelectionView
		self.addTapRecognizer()
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	// MARK: - General Helpers

	fileprivate func addTapRecognizer() {
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideDatePickerView(_:)))
		self.view.addGestureRecognizer(tapRecognizer)
	}

	/// Change destination height to show the extra row with search button
	fileprivate func changeDestinationSelectionViewHeightIfNeeded() {
		let isAllInformationCompleted = (self.destinationSelectionViewController?.isAllSearchInformationCompleted() == true)
		self.destinationSelectionViewHeightConstraint?.constant = ((isAllInformationCompleted == true) ? ConstraintsConstants.TableViewWithSearchHeight : ConstraintsConstants.TableViewWithoutSearchHeight)
		UIView.animate(withDuration: AnimationDurations.Standard) { [weak self] in
			self?.view.layoutIfNeeded()
		}
	}

	// MARK: - Date Selection view Methods

	func hideDatePickerView(_ sender: UITapGestureRecognizer) {
		self.showOrHideDateSelectionView(show: false)

		// Resign the responders from all textfields and reload data to show search button if needed
		self.destinationSelectionViewController?.resignAllFirstResponders()
		self.destinationSelectionViewController?.reloadDataTableView()

		self.changeDestinationSelectionViewHeightIfNeeded()
	}

	fileprivate func showOrHideDateSelectionView(show: Bool) {
		let bottomConstraintToHide = ((self.datePickerViewHeightConstraint?.constant ?? 0)) * CGFloat(-1)
		self.destinationSelectionViewController?.resignAllFirstResponders()
		self.datePickerViewBottomConstraint?.constant = ((show == true) ? 0 : bottomConstraintToHide)
		UIView.animate(withDuration: AnimationDurations.Standard) { [weak self] in
			self?.view.layoutIfNeeded()
		}
	}

	fileprivate func dateSelected(date: Date, isDeparture: Bool) {
		// Clean date already saved in parameter dictionary
		self.destinationSelectionViewController?.searchParametersDictionary[SearchParametersKeys.ArriveDate] = nil
		self.destinationSelectionViewController?.searchParametersDictionary[SearchParametersKeys.DepartureDate] = nil

		// Set "date" for parameters dictionary in destination view Controller
		let dateKey = ((isDeparture == true) ? SearchParametersKeys.DepartureDate : SearchParametersKeys.ArriveDate)
		self.destinationSelectionViewController?.searchParametersDictionary[dateKey] = date

		self.changeDestinationSelectionViewHeightIfNeeded()
		self.destinationSelectionViewController?.reloadDataTableView()

		// Set last option selected in date picker for a better UI Experience
		let timeConfigurationOption: TimeConfigurationOption = ((isDeparture == true) ? .departure : .arrive)
		self.datePickerViewController?.setInitialValuesForPickerAndSegmentedControl(date: date, timeConfigurationOption: timeConfigurationOption)
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
				self.datePickerViewController = dateSelectionViewController
		}
	}
}
