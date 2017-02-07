//
//  TAStopCell.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 06/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TAStopCell												: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet private weak var timeLabel						: UILabel?
	@IBOutlet private weak var pointView						: UIView?
	@IBOutlet private weak var whitePointView					: UIView?
	@IBOutlet private weak var backgroundPointView				: UIView?
	@IBOutlet private weak var placeLabel						: UILabel?
	@IBOutlet private weak var heightPointView					: NSLayoutConstraint?
	@IBOutlet private weak var backgroundPointTopConstraint		: NSLayoutConstraint?
	@IBOutlet private weak var backgroundPointBottomConstraint	: NSLayoutConstraint?

	// MARK: - View life cycle

    override func awakeFromNib() {
        super.awakeFromNib()

		self.pointView?.layer.cornerRadius = ((self.heightPointView?.constant ?? 0) * GeneralHelpers.CornerRadiusPointFactor)
		self.whitePointView?.layer.cornerRadius = ((self.heightPointView?.constant ?? 0) * GeneralHelpers.CornerRadiusBackgroundPointFactor)
    }

	// MARK: - Setup cell

	func setupCell(stop: Stop, segment: Segment, hideBackgroundPoint: (hideUp: Bool, hideDown: Bool)) {

		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .short
		self.timeLabel?.text = dateFormatter.string(from: stop.dateTime)
		self.placeLabel?.text = stop.name

		let color = UIColor(fromHexString: segment.color)
		self.pointView?.backgroundColor = color
		self.backgroundPointView?.backgroundColor = color

		// if it is the first/last row of the route draw, hide the backgroung point to make them look like start/end points 
		guard
			let _backgroundPointTopConstantConstraint = self.backgroundPointTopConstraint?.constant,
			let _backgroundPointBottomConstantConstraint = self.backgroundPointBottomConstraint?.constant else {
				return
		}

		self.backgroundPointTopConstraint?.constant = ((hideBackgroundPoint.hideUp == true) ? 10 : _backgroundPointTopConstantConstraint)
		self.backgroundPointBottomConstraint?.constant = ((hideBackgroundPoint.hideDown == true) ? 10 : _backgroundPointBottomConstantConstraint)
	}
}
