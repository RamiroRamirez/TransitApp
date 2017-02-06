//
//  TATravelOptionCell.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 04/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TATravelOptionCell									: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet private weak var titleLabel					: UILabel?
	@IBOutlet private weak var timeLabel					: UILabel?
	@IBOutlet private weak var priceLabel					: UILabel?
	@IBOutlet private weak var startEndTime					: UILabel?
	@IBOutlet private weak var optionImagesContainerView	: UIView?
	@IBOutlet private weak var mainContainerView			: UIView?

	@IBOutlet var segmentViews								: [TASegmentView]?

	// MARK: - Properties

	var travel												: Travel?

	func setupCell(travel: Travel) {
		self.travel = travel

		self.mainContainerView?.layer.cornerRadius = CornerRadius.Standard
		self.titleLabel?.text = travel.type
		self.priceLabel?.text = "\(travel.price.amount / GeneralHelpers.AmountFactor) \(travel.price.currency)"
		self.timeLabel?.text = self.calculateTotalTimeString()
		self.startEndTime?.text = self.rangeOfTimeToShow()
		self.showNeededSegmentViews()
	}

	fileprivate func calculateTotalTimeString() -> String? {
		guard
			let firstSegment = self.travel?.segments.first,
			let lastSegment = self.travel?.segments.last,
			let firstStop = firstSegment.stops.first,
			let totalTimeInMinutes = lastSegment.stops.last?.dateTime.minutes(from: firstStop.dateTime) else {
				return nil
		}

		return "\(totalTimeInMinutes) min"
	}

	fileprivate func rangeOfTimeToShow() -> String? {
		guard
			let firstSegment = self.travel?.segments.first,
			let lastSegment = self.travel?.segments.last,
			let firstStop = firstSegment.stops.first,
			let lastStop = lastSegment.stops.last else {
				return nil
		}

		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .none
		dateFormatter.timeStyle = .short

		let startTime = dateFormatter.string(from: firstStop.dateTime)
		let endTime = dateFormatter.string(from: lastStop.dateTime)

		return "\(startTime) -> \(endTime)"
	}

	fileprivate func showNeededSegmentViews() {

		let numberOfSegments = (self.travel?.segments.count ?? 0)

		var numberOfShownSegmentViews = 0
		for segmentView in (self.segmentViews ?? []) {
			if (numberOfShownSegmentViews < numberOfSegments),
				let _segment = self.travel?.segments[safe: numberOfShownSegmentViews] {
					segmentView.isHidden = false
					segmentView.setupView(segment: _segment)
					numberOfShownSegmentViews += 1

			} else {
				segmentView.isHidden = true
			}

		}
	}
}

extension Date {
	/// Returns the amount of minutes from another date
	func minutes(from date: Date) -> Int {
		return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
	}
}
