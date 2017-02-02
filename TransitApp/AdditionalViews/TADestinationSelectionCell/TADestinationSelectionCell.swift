//
//  TADestinationSelectionCell.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 02/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TADestinationSelectionCell				: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet private weak var titleLabel		: UILabel?
	@IBOutlet private weak var inputTextField	: UITextField?

	// MARK: - Properties

	var selectionOptionType						: DestinationSelectionOption = .start

	func setupCell(selectionOptionType: DestinationSelectionOption) {

		self.titleLabel?.text = selectionOptionType.title()
		self.inputTextField?.placeholder = selectionOptionType.placeholder()
	}
}
