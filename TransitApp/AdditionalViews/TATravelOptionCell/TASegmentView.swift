//
//  TASegmentView.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 05/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit
import DKHelper

class TASegmentView: UIView {

	// MARK: - Outlets

	@IBOutlet private weak var titleLabel					: UILabel?
	@IBOutlet private weak var imageView					: UIImageView?

	// MARK: - Properties

	var segment												: Segment?

	func setupView(segment: Segment) {

		self.titleLabel?.text = nil

		if segment.name != nil {
			self.titleLabel?.text = segment.name

		} else if(segment.travelMode == JSONKeys.walking.rawValue) {
			self.titleLabel?.text = L("Travel.Mode.Walk")

		} else if (segment.travelMode == JSONKeys.ciclying.rawValue) {
			self.titleLabel?.text = L("Travel.Mode.Cycling")

		} else if (segment.travelMode == JSONKeys.driving.rawValue) {
			self.titleLabel?.text = L("Travel.Mode.Driving")
		}

		self.imageView?.isHidden = true
		self.backgroundColor = UIColor(fromHexString: segment.color)
		self.layer.cornerRadius = CornerRadius.Standard
	}
}
