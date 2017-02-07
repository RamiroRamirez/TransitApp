//
//  Stop.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 05/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import Foundation
import DKHelper


/*
	======= STOP =======

	This struct represents one option route to go from one point to another.
	The parameters for this model are:

		* latitude 	: latitude of the stop point
		* longitude	: longitude of the stop point
		* dateTime	: time of the stop point
		* name		: name of the stop, if there is one
		* properties: Some Properties to be considered.

		-------+++IMPORTANT++++-------
		In this example, the properties are not being considered

*/
struct Stop {

	let latitude	: Double
	let longitude	: Double
	let dateTime	: Date
	let name		: String?
	let properties	: [String: AnyObject]?

	static func createStopsForSegment(fromDictionaries dictionaries: [[String: AnyObject]]) -> [Stop]? {

		var stopArray = [Stop]()
		dictionaries.forEach { (dictionary: [String: AnyObject]) in

			guard
				let latitude = dictionary[JSONKeys.latitude.rawValue] as? Double,
				let longitude = dictionary[JSONKeys.longitude.rawValue] as? Double,
				let dateTimeString = dictionary[JSONKeys.dateTime.rawValue] as? String,
				let dateTime = self.dateFromString(dateString: dateTimeString) else {
					return
			}

			var name: String?
			var properties : [String: AnyObject]?

			if let _name = dictionary[JSONKeys.name.rawValue] as? String {
				name = _name
			}

			if let _properties = dictionary[JSONKeys.properties.rawValue] as? [String: AnyObject]? {
				properties = _properties
			}

			let stop = Stop(latitude: latitude, longitude: longitude, dateTime: dateTime, name: name, properties: properties)
			stopArray.append(stop)
		}

		return stopArray
	}

	private static func dateFromString(dateString: String) -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = DateFormats.StopDateFormat

		return dateFormatter.date(from: dateString)
	}
}
