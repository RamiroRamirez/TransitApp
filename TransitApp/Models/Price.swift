//
//  Price.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 05/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import Foundation

/*
	======= Price =======

	This struct represents the price of a travel/route.
	The parameters for this model are:

		* amount 		: What is the cost for the travel?
		* currency		: the currency of the amount
*/
struct Price {

	let amount	: Double
	let currency: String

	static func createPrice(fromDictionary dictionary: [String: AnyObject]) -> Price? {
		guard
			let amount = dictionary[JSONKeys.amount.rawValue] as? Double,
			let currency = dictionary[JSONKeys.currency.rawValue] as? String else {
				return nil
		}

		return Price(amount: amount, currency: currency)
	}
}


