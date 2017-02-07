//
//  Travel.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 05/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import Foundation

/*
	======= TRAVEL =======
	
	This struct represents one option route to go from one point to another.
	The parameters for this model are:
		
		* type 		: what kind of route is this option (public transportation or car sharing etc)
		* provider	: Who is providing this service/infos
		* price		: If there is a cost for this travel
		* segments	: The parts of this route (including stops, walking parts, setup from any service)
		* properties: Some Properties to be considered.  

	-------+++IMPORTANT++++-------
		In this example, the properties are not being considered  

*/
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
