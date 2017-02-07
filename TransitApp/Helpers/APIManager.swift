//
//  APIManager.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 05/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import Foundation

struct APIManager {

	static func loadDataJSON(jsonName: String) -> Any? {
		guard
			let path = Bundle.main.path(forResource: jsonName, ofType: Resources.JSONType),
			let json = NSData(contentsOfFile: path) else {
				return nil
		}

		return try? JSONSerialization.jsonObject(with: json as Data, options: [])
	}

	static func fetchTransportOptions(completionBlock: ((_ travels: [Travel]?, _ error: NSError?) -> Void)?) {

		guard let travelsInformation = self.loadDataJSON(jsonName: Resources.TransportData) as? [String: AnyObject] else {
			// Simulate error... there is no connection to server in this example
			let error =  NSError(domain: "", code: 400, userInfo:nil)
			completionBlock?(nil, error)
			return
		}

		let travels = travelsInformation[JSONKeys.routes.rawValue] as? [[String: AnyObject]]

		var travelsArray = [Travel]()
		travels?.forEach({ (travelDicionary: [String: AnyObject]) in
			if let travel = Travel.createTravel(withDicionary: travelDicionary) {
				travelsArray.append(travel)
			}
		})

		completionBlock?(travelsArray, nil)
	}
}
