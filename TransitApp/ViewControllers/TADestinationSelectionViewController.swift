//
//  TADestinationSelectionViewController.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 02/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

// MARK: - Enum to populate DestinationSelectionViewController

enum DestinationSelectionOption	: Int {

	case start = 0
	case end
	case time
	case search

	static func allValues(isInformationCompleted: Bool) -> [DestinationSelectionOption] {
		return ((isInformationCompleted == true) ? [.start, .end, .time, .search] : [.start, .end, .time])
	}

	func title() -> String? {
		switch self {
		case .start				: return "Start"
		case .end				: return "End"
		case .time				: return "When"
		case .search			: return nil
		}
	}

	func deafaulText() -> String? {
		switch self {
		case .start				: return "Your location"
		case .end				: return nil
		case .time				: return nil
		case .search			: return nil
		}
	}

	func placeholder() -> String? {
		switch self {
		case .start				: return nil
		case .end				: return "Where to"
		case .time				: return "Depart now"
		case .search			: return nil
		}
	}

	func textToShow(parametersDictionary: [String: Any]) -> Any? {
		switch self {
		case .start				: return parametersDictionary[SearchParametersKeys.Start]
		case .end				: return parametersDictionary[SearchParametersKeys.End]
		case .time				: return parametersDictionary[SearchParametersKeys.ArriveDate] ?? parametersDictionary[SearchParametersKeys.DepartureDate]
		case .search			: return nil
		}
	}
}

class TADestinationSelectionViewController		: UIViewController {

	// MARK: - Outlets

	@IBOutlet private weak var tableView		: UITableView?

	// MARK: - Properties

	var showDateSelectionViewBlock				: ((_ show: Bool) -> Void)?

	// dictionary including search parameters: 
	//	*Start	-> Coordinates/ place to start
	//	*End	-> Coordinates/ place to go
	//	*Date	-> Date departure/arrival
	var searchParametersDictionary				= [String: Any]()

	// MARK: - Accesor methods

	func reloadDataTableView() {
		self.tableView?.reloadData()
	}

	// MARK: - View life cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		self.searchParametersDictionary[SearchParametersKeys.Start] = DestinationSelectionOption.start.deafaulText()
		self.tableView?.isScrollEnabled = false
		self.tableView?.register(UINib(nibName: NibNames.DestinationSelectionCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.startSelection.rawValue)
	}

	// MARK: - Selection Time Picker View Methods

	fileprivate func showDateSelectionView() {
		self.showDateSelectionViewBlock?(true)
	}

	// MARK: - Fill parameter dictionary methods

	fileprivate func userInputBlock(parameter: String, value: String?) {
		guard (value?.isEmpty == false) else {
			self.searchParametersDictionary[parameter] = nil
			return
		}

		self.searchParametersDictionary[parameter] = value
	}

	// MARK: - Search pressed Method

	fileprivate func searchPressed() {
		self.performSegue(withIdentifier: SegueIdentifiers.toSummaryOptionsViewController.rawValue, sender: nil)
	}

	// MARK: - General Helpers

	func isAllSearchInformationCompleted() -> Bool {
		guard (self.searchParametersDictionary[SearchParametersKeys.Start] != nil &&
			   self.searchParametersDictionary[SearchParametersKeys.End] != nil &&
			   (self.searchParametersDictionary[SearchParametersKeys.ArriveDate] != nil || self.searchParametersDictionary[SearchParametersKeys.DepartureDate] != nil)) else {
			return false
		}

		return true
	}

	func resignAllFirstResponders() {
		for destinationSelectionOption in DestinationSelectionOption.allValues(isInformationCompleted: self.isAllSearchInformationCompleted()) {
			let indexPath = IndexPath(row: destinationSelectionOption.rawValue, section: 0)
			let cell = (self.tableView?.cellForRow(at: indexPath) as? TADestinationSelectionCell)
			cell?.resignTextFieldFirstResponder()
		}
	}
}

// MARK: - Table View methods

extension TADestinationSelectionViewController	: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DestinationSelectionOption.allValues(isInformationCompleted: self.isAllSearchInformationCompleted()).count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.startSelection.rawValue) as? TADestinationSelectionCell,
			let destinationSelectionOption = DestinationSelectionOption(rawValue: indexPath.row) else {
				return UITableViewCell()
		}

		cell.setupCell(selectionOptionType: destinationSelectionOption, showDateSelectionBlock: self.showDateSelectionView, userInputBlock: self.userInputBlock, searchPressedBlock: self.searchPressed, parametersDictionary: self.searchParametersDictionary)
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CellHeights.DestinationSelection
	}
}
