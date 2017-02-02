//
//  TAInitialViewController.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 02/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit

class TAInitialViewController							: UIViewController {

	// MARK: - Outlets

	@IBOutlet private weak var destinationSelectionView	: UIView?

	// MARK: - View Life Cycle

	override func viewDidLoad() {
        super.viewDidLoad()

		self.destinationSelectionView?.alpha = AlphaForViews.DestinationSelectionView
    }
}
