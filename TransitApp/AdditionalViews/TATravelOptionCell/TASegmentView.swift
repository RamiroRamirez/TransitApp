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

		if (segment.travelMode == JSONKeys.walking.rawValue) {
			self.titleLabel?.text = "walk"

		} else {
			self.titleLabel?.text = segment.name
		}

		self.titleLabel?.sizeToFit()
		self.imageView?.isHidden = true
		self.backgroundColor = UIColor(fromHexString: segment.color)
		self.layer.cornerRadius = CornerRadius.Standard
	}
}
