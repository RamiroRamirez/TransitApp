//
//  TAConstants.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 02/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import Foundation
import UIKit

struct CellHeights {
	static let DestinationSelection				= CGFloat(50)
}

enum CellIdentifiers: String {
	case startSelection 						= "TADestinationSelectionCell"
}

enum SegueIdentifiers: String {
	case toDestinationSelectionViewController	= "toDestinationSelectionViewController"
	case toDateSelectionViewController			= "toDateSelectionViewController"
}

struct NibNames {
	static let DestinationSelectionCell			= "TADestinationSelectionCell"
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
