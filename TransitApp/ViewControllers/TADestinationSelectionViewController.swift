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

	case start
	case end
	case time

	static func allValues() -> [DestinationSelectionOption] {
		return [.start, .end, .time]
	}

	func title() -> String? {
		switch self {
		case .start				: return "Start"
		case .end				: return "End"
		case .time				: return "When"
		}
	}

	func placeholder() -> String? {
		switch self {
		case .start				: return nil
		case .end				: return "Where to"
		case .time				: return "Depart now"
		}
	}
}

class TADestinationSelectionViewController		: UIViewController {

	// MARK: - Outlets

	@IBOutlet private weak var tableView		: UITableView?

	// MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView?.isScrollEnabled = false

    }
}

// MARK: - Table View methods

extension TADestinationSelectionViewController	: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DestinationSelectionOption.allValues().count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CellHeights.DestinationSelectionCellHeight
	}
}