//
//  TransitAppTests.swift
//  TransitAppTests
//
//  Created by Ramiro Ramirez on 01/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import XCTest
import UIKit
@testable import TransitApp

class TransitAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

	// MARK: - Testing helpers

	private func createStartAnEndDateWithFiveMinutesDifference() -> (startDate: Date, endDate: Date)? {

		let startDate = Date()
		let calendar = Calendar.current

		guard let endDate = calendar.date(byAdding: .minute, value: 5, to: startDate) else {
			return nil
		}

		return (startDate: startDate, endDate: endDate)
	}

	private func createSegmentWithSpecificTime(date: Date) -> Segment {

		let stop = Stop(latitude: 50, longitude: 30, dateTime: date, name: nil, properties: nil)
		let segment = Segment(name: nil, numberStops: 0, travelMode: "bus", description: nil, color: "#d64820", iconURL: "https://d3m2tfu2xpiope.cloudfront.net/vehicles/subway.svg", polyline: "elr_I_fzpAfe@_Sf]dFr_@~UjCbg@yKvj@lFfb@`C|c@hNjc@", stops: [stop])
		return segment
	}

	private func createTravelToCalculeTotalTime(startDate: Date, endDate: Date) -> Travel {

		let firstSegment = self.createSegmentWithSpecificTime(date: startDate)
		let lastSegment = self.createSegmentWithSpecificTime(date: endDate)

		let price = Price(amount: 230, currency: "euros")
		return Travel(type: "transport_public", provider: "bvg", price: price, segments: [firstSegment, lastSegment], properties: nil)
	}

	// MARK: - Testing initializer models

	func testShouldCreateTravelCorrectly() {
		let travel = self.createTravelToCalculeTotalTime(startDate: Date(), endDate: Date())
		XCTAssertNotNil(travel, "Travel struct could not be created correctly")
	}

	func testShouldCreateSegmentCorrectly() {
		let segment = self.createSegmentWithSpecificTime(date: Date())
		XCTAssertNotNil(segment, "Segment struct could not be created correctly")
	}

	func testShouldCreatePriceCorrectly() {

		let price = Price(amount: 230, currency: "euros")
		XCTAssertNotNil(price, "Price struct could not be created correctly")
	}

	func testShouldCreateStopCorrectly() {

		let segment = self.createSegmentWithSpecificTime(date: Date())
		XCTAssertNotNil(segment.stops.first, "Stop struct could not be created correctly")
	}

	func testShouldFetchTravelDataCorrectly() {

		let dataJSON = APIManager.loadDataJSON(jsonName: Resources.TransportData)
		XCTAssertNotNil(dataJSON, "The data cannot be fetched correctly")
	}

	func testShouldCreateTravelFromDictionary() {

		let dataJSON = APIManager.loadDataJSON(jsonName: Resources.TransportData)
		XCTAssertNotNil(dataJSON, "The data cannot be fetched correctly")

		guard let _dataJson = dataJSON as? [String: AnyObject] else {
			XCTFail("dataJson is not the expected format")
			return
		}

		guard let travelDict = (_dataJson[JSONKeys.routes.rawValue] as? [[String: AnyObject]])?.first else {
			XCTFail("travels has not the correct format")
			return
		}

		let travel = Travel.createTravel(withDicionary: travelDict)
		XCTAssertNotNil(travel, "Travel struct could not be created correctly")
	}


	// MARK: - Travel Option Cell Helper Methods

	func testShouldCreateTimeStringCorrectly() {

		guard let _dates = self.createStartAnEndDateWithFiveMinutesDifference() else {
			XCTFail("End date could not be created")
			return
		}

		let travel = self.createTravelToCalculeTotalTime(startDate: _dates.startDate, endDate: _dates.endDate)
		let travelOptionCell = TATravelOptionCell()
		let minutesString = travelOptionCell.calculateTotalTimeString(travel: travel)

		XCTAssert((minutesString == "5 min"), "The time string doesn´t have the correct number of minutes")
		XCTAssert((minutesString?.contains("min") == true), "The string does not have the word min")
	}
}
