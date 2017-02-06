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

	override func viewDidLoad() {
		self.tableView?.register(UINib(nibName: NibNames.TravelOptionCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.travelOption.rawValue)

		APIManager.fetchTransportOptions { [weak self] (travels: [Travel]?, error: NSError?) in

			guard let _travels = travels else {
				return
			}

			self?.travels = _travels
		}
	}
}

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
}
