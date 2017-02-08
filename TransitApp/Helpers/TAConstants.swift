//
//  TAConstants.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 02/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import Foundation
import UIKit

enum CellIdentifiers: String {
	case startSelection 						= "TADestinationSelectionCell"
	case travelOption							= "TATravelOptionCell"
	case stop									= "TAStopCell"
	case route									= "TARouteCell"
	case changeWalk								= "TAChangeWalkCell"
	case mapCell								= "TAMapCell" 
}

enum SegueIdentifiers: String {
	case toDestinationSelectionViewController	= "toDestinationSelectionViewController"
	case toDateSelectionViewController			= "toDateSelectionViewController"
	case toSummaryOptionsViewController			= "toSummaryOptionsViewController"
	case toTravelDetailViewController			= "toTravelDetailViewController"
}

enum JSONKeys: String {

	case routes									= "routes"
	case providerAttributes						= "provider_attributes"
	case transportType							= "type"
	case provider								= "provider"
	case segments								= "segments"
	case price									= "price"
	case properties								= "properties"
	case amount									= "amount"
	case currency								= "currency"
	case name									= "name"
	case numberStops							= "num_stops"
	case stops									= "stops"
	case travelMode								= "travel_mode"
	case description							= "description"
	case color									= "color"
	case iconURL								= "icon_url"
	case polyline								= "polyline"
	case latitude								= "lat"
	case longitude								= "lng"
	case dateTime								= "datetime"
	case walking								= "walking"
	case change									= "change"
	case setup									= "setup"
	case parking								= "parking"
	case ciclying								= "cycling"
	case driving								= "driving"
}

struct Resources {
	static let TransportData					= "data"
	static let JSONType							= "json"
}

struct CellHeights {
	static let DestinationSelection				= CGFloat(50)
	static let TravelOption						= CGFloat(170)
	static let Route							= CGFloat(120)
	static let Stop								= CGFloat(19)
	static let Map								= CGFloat(465)
}

struct NibNames {
	static let DestinationSelectionCell			= "TADestinationSelectionCell"
	static let TravelOptionCell					= "TATravelOptionCell"
	static let StopCell							= "TAStopCell"
	static let RouteCell						= "TARouteCell"
	static let ChangeWalkCell					= "TAChangeWalkCell"
	static let MapCell							= "TAMapCell"
}

struct AlphaForViews {
	static let DestinationSelectionView			= CGFloat(0.9)
}

struct ConstraintsConstants {
	static let TableViewWithSearchHeight		= CGFloat(200)
	static let TableViewWithoutSearchHeight		= CGFloat(150)
}

struct CornerRadius {
	static let Standard							= CGFloat(5)
}

struct AnimationDurations {
	static let Standard							= TimeInterval(0.3)

}

struct SearchParametersKeys {
	static let Start							= "Start"
	static let End								= "End"
	static let ArriveDate						= "ArriveDate"
	static let DepartureDate					= "DepartureDate"
}

struct GeneralHelpers {
	static let AmountFactor						= Double(100)
	static let CornerRadiusPointFactor			= CGFloat(0.5)
	static let CornerRadiusBackgroundPointFactor = CGFloat(0.25)
	static let LatitudeLongitudeDelta			= Double(0.05)
	static let PolylineWidth					= CGFloat(4)
}

struct DateFormats {
	static let StopDateFormat					= "yyyy-MM-dd'T'HH:mm:ssZ"
	static let DateInDestinationCell			= "EEEEEE, dd MMM, H:mm"
}

extension Array {
	/*
	* Bounds-checked ("safe") index lookup for Arrays.
	* Example usage:
	* let foo = [0,1,2][safe: 1]	|	foo = (Int?) 1
	* let bar = [0,1,2][safe: 10]	|	bar = (Int?) nil
	*/
	subscript (safe index: Int) -> Element? {
		return ((self.indices ~= index) ? self[index] : nil)
	}
}

