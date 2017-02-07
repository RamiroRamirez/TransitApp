//
//  TASegmentView.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 05/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

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
			self.titleLabel?.text = "walk"

		} else if (segment.travelMode == JSONKeys.ciclying.rawValue) {
			self.titleLabel?.text = "cycling"

		} else if (segment.travelMode == JSONKeys.driving.rawValue) {
			self.titleLabel?.text = "driving"

		}

		self.imageView?.isHidden = true
		self.backgroundColor = UIColor(fromHexString: segment.color)
		self.layer.cornerRadius = CornerRadius.Standard
	}
}
