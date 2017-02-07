//
//  TARouteCell.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 06/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TARouteCell									: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet private weak var routeLineView		: UIView?
	@IBOutlet private weak var transportNameTitle	: UILabel?
	@IBOutlet private weak var detailsTitle			: UILabel?

	// MARK: - Setup cell

	func setupCell(segment: Segment) {
		let nameText = ((segment.name != nil) ? "\(segment.travelMode) \(segment.name!)" : nil)
		self.transportNameTitle?.text = (nameText ?? segment.travelMode)
		let numberOfStops: String? = ((segment.numberStops != 0) ? "\(segment.numberStops) stops" : nil)
		self.detailsTitle?.text = numberOfStops
		self.routeLineView?.backgroundColor = UIColor(fromHexString: segment.color)
	}
}
