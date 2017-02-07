//
//  TASummaryOptionsViewController.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 04/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit
import MBProgressHUD

class TASummaryOptionsViewController		: UIViewController {

	// MARK: - Outlets

	@IBOutlet private weak var tableView	: UITableView?

	// MARK: - Properties

	var travels								= [Travel]()

	// MARK: - View life cycle

	override func viewDidLoad() {
		self.tableView?.register(UINib(nibName: NibNames.TravelOptionCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.travelOption.rawValue)

		APIManager.fetchTransportOptions { [weak self] (travels: [Travel]?, error: NSError?) in

			guard let _travels = travels else {
				return
			}

			self?.travels = _travels
		}
	}

	// Navigation

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == SegueIdentifiers.toTravelDetailViewController.rawValue),
			let travel = sender as? Travel,
			let travelDetailViewController = segue.destination as? TATravelDetailViewController {
				travelDetailViewController.travel = travel
		}
	}
}

// MARK: - Table View Methods

extension TASummaryOptionsViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.travels.count
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CellHeights.TravelOption
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.travelOption.rawValue) as? TATravelOptionCell,
			let travel = self.travels[safe: indexPath.row] else {
				return UITableViewCell()
		}

		cell.setupCell(travel: travel)
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		self.performSegue(withIdentifier: SegueIdentifiers.toTravelDetailViewController.rawValue, sender: travels[safe: indexPath.row])
	}
}
