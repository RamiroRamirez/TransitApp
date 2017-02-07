//
//  TARouteCell.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 06/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit
import DKHelper

class TARouteCell									: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet private weak var routeLineView		: UIView?
	@IBOutlet private weak var transportNameTitle	: UILabel?
	@IBOutlet private weak var detailsTitle			: UILabel?

	// MARK: - Setup cell

	func setupCell(segment: Segment) {

		// if there is segement name, use it for the transport name title
		// if not, use only the travel mode
		let nameText = ((segment.name != nil) ? "\(segment.travelMode) \(segment.name!)" : nil)
		self.transportNameTitle?.text = (nameText ?? segment.travelMode)

		// show the number of stops, if there is one
		let numberOfStops: String? = ((segment.numberStops != 0) ? "\(segment.numberStops) \(L("stops"))" : nil)
		self.detailsTitle?.text = numberOfStops

		// set the color of the segment/route
		self.routeLineView?.backgroundColor = UIColor(fromHexString: segment.color)
	}
}
