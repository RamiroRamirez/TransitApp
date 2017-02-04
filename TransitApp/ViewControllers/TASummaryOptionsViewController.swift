//
//  TASummaryOptionsViewController.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 04/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TASummaryOptionsViewController		: UIViewController {

	@IBOutlet private weak var tableView	: UITableView?

	override func viewDidLoad() {
		self.tableView?.register(UINib(nibName: NibNames.TravelOptionCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.travelOption.rawValue)
	}
}

extension TASummaryOptionsViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CellHeights.TravelOption
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.travelOption.rawValue) as? TATravelOptionCell else {
			return UITableViewCell()
		}

		return cell
	}
}
