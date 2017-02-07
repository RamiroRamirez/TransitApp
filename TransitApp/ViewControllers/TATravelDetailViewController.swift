//
//  TATravelDetailViewController.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 06/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TATravelDetailViewController			: UIViewController {

	// MARK: - Outlets

	@IBOutlet private weak var tableView	: UITableView?

	// MARK: - Properties

	var travel								: Travel?
	var filteredSegmentsToShow				: [Segment]?
	var filteredStopsToShow					: [Stop]?

	// MARK: - Life view cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		self.tableView?.tableFooterView = UIView()
		self.tableView?.register(UINib(nibName: NibNames.TravelOptionCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.travelOption.rawValue)
		self.tableView?.register(UINib(nibName: NibNames.StopCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.stop.rawValue)
		self.tableView?.register(UINib(nibName: NibNames.RouteCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.route.rawValue)
		self.tableView?.register(UINib(nibName: NibNames.ChangeWalkCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.changeWalk.rawValue)
		self.fillDataSources()
		self.tableView?.reloadData()
	}

	// MARK: - Data Source Methods


	/// This method will filter/fill the arrays used to populate the tableview
	/// First, the segments array is filtered to get the ones to show
	/// After that, we go throw each segment and take the stop points to be shown
	fileprivate func fillDataSources() {

		// To filter the segments to be shown
		self.filteredSegmentsToShow = self.travel?.segments.filter({ (segment: Segment) -> Bool in
			return (segment.travelMode != JSONKeys.setup.rawValue && segment.travelMode != JSONKeys.parking.rawValue)
		})

		self.filteredStopsToShow = []
		// Now, find the stops to show (the first and the last stop of the first segment, plus the last stop of the following segments)
		self.filteredSegmentsToShow?.forEach() { (segment: Segment) in
			if
				let firstSegmentPolyline = self.filteredSegmentsToShow?.first?.polyline,
				let firstStop = segment.stops.first,
				let lastStop = segment.stops.last {
					if (firstSegmentPolyline == segment.polyline) {
						self.filteredStopsToShow?.append(firstStop)
						self.filteredStopsToShow?.append(lastStop)

					} else {
						self.filteredStopsToShow?.append(lastStop)
					}
			}
		}
	}

	fileprivate func numberOfRowsForTableView() -> Int {
		// plus one to include first cell where segments and prices are included
		return ((self.filteredStopsToShow?.count ?? 0) + (self.filteredSegmentsToShow?.count ?? 0) + 1)
	}
}

// MARK: - Table view methods

extension TATravelDetailViewController		: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.numberOfRowsForTableView()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if (indexPath.row == 0),
			let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.travelOption.rawValue) as? TATravelOptionCell,
			let _travel = self.travel {
				cell.setupCell(travel: _travel)
				return cell

		// Segments are in even rows
		} else if (indexPath.row % 2 == 0),
			let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.route.rawValue) as? TARouteCell,
			let segment = self.filteredSegmentsToShow?[safe: Int((Double(indexPath.row) * 0.5) - 1)] {
				cell.setupCell(segment: segment)
				return cell

		// Stops are in odd rows
		} else if
			let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.stop.rawValue) as? TAStopCell,
			let stop = self.filteredStopsToShow?[safe: Int((Double(indexPath.row - 1) * 0.5))] {

				// find segment from the stop to show the correct color for the route line
				if let segementArray = self.filteredSegmentsToShow?.filter({ (segment: Segment) -> Bool in
					return (segment.stops.contains(where: { (_stop: Stop) -> Bool in
						return (_stop.longitude == stop.longitude && _stop.latitude == stop.latitude)
					}))
				}).first {
				cell.setupCell(stop: stop, segment: segementArray)
				return cell
			}
		}

		return UITableViewCell()
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if (indexPath.row == 0) {
			return CellHeights.TravelOption

		} else if (indexPath.row % 2 == 0) {
			return CellHeights.Route
		}

		return CellHeights.Stop
	}
}
