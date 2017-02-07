//
//  Travel.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 05/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import Foundation

struct Travel {

	let type		: String
	let provider	: String
	let price		: Price
	let segments	: [Segment]
	let properties	: [String: AnyObject]?

	static func createTravel(withDicionary dictionary: [String: AnyObject]) -> Travel? {

		guard
			let type = dictionary[JSONKeys.transportType.rawValue] as? String,
			let provider = dictionary[JSONKeys.provider.rawValue] as? String,
			let segmentsDict = dictionary[JSONKeys.segments.rawValue] as? [[String: AnyObject]],
			let segments = Segment.createSegments(fromDictionary: segmentsDict),
			let priceDict = dictionary[JSONKeys.price.rawValue] as? [String: AnyObject],
			let price = Price.createPrice(fromDictionary: priceDict) else {
				return nil
		}

		var properties: [String: AnyObject]?

		if let _properties = dictionary[JSONKeys.properties.rawValue] as? [String: AnyObject] {
			properties = _properties
		}

		return Travel(type: type, provider: provider, price: price, segments: segments, properties: properties)
	}
}
