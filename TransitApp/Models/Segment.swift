//
//  Segment.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 05/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import Foundation

/*
	======= SEGMENT =======

	This struct represents one option route to go from one point to another.
	The parameters for this model are:

		* name 			: name og segment, if there is some
		* numberStops	: stops during this segment
		* travelMode	: what kind of transportation is considered to have this segment
		* description	: some description about the travel mode
		* color			: Color to use in UI
		* iconURL		: ---
		* polyline		: route to be printed in map
		* stops			: stops during this segment

-------+++IMPORTANT++++-------
In this example, the properties are not being considered

*/
struct Segment {

	let name		: String?
	let numberStops	: Int
	let travelMode	: String
	let description	: String?
	let color		: String
	let iconURL		: String
	let polyline	: String?
	let stops		: [Stop]

	static func createSegments(fromDictionary: [[String: AnyObject]]) -> [Segment]? {

		var segmentsArray = [Segment]()
		fromDictionary.forEach { (dictionary: [String: AnyObject]) in

			guard
				let numberStops = dictionary[JSONKeys.numberStops.rawValue] as? Int,
				let stopsDict = dictionary[JSONKeys.stops.rawValue] as? [[String: AnyObject]],
				let travelMode = dictionary[JSONKeys.travelMode.rawValue] as? String,
				let color = dictionary[JSONKeys.color.rawValue] as? String,
				let iconURL = dictionary[JSONKeys.iconURL.rawValue] as? String,
				let stops = Stop.createStopsForSegment(fromDictionaries: stopsDict) else {
					return
			}

			var name: String?
			var description: String?
			var polyline: String?

			if let _polyline = dictionary[JSONKeys.polyline.rawValue] as? String {
				polyline = _polyline
			}

			if let _name = dictionary[JSONKeys.name.rawValue] as? String {
				name = _name
			}

			if let _description = dictionary[JSONKeys.description.rawValue] as? String {
				description = _description
			}

			let segment = Segment(name: name, numberStops: numberStops, travelMode: travelMode, description: description, color: color, iconURL: iconURL, polyline: polyline, stops: stops)
			segmentsArray.append(segment)
		}

		return segmentsArray
	}
}
