//
//  TAMapCell.swift
//  TransitApp
//
//  Created by Ramiro Ramirez on 08/02/2017.
//  Copyright © 2017 ramram. All rights reserved.
//

import UIKit
import MapKit
import Polyline

class TAMapCell							: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet private weak var mapView	: MKMapView?

	// MARK: - Setup Cell

	func setupCell(segments: [Segment]) {

		self.mapView?.delegate = self
		var polylineInfos = [(polyline: String, color: UIColor)]()
		segments.forEach { (segment: Segment) in

			// create dictionary with polyline and color
			if
				let _polyline = segment.polyline,
				let _color = UIColor(fromHexString: segment.color) {
					let polylineTuple = (polyline: _polyline, color: _color)
					polylineInfos.append(polylineTuple)
			}
		}

		// draw polylines in map:
		polylineInfos.forEach { (polyline: String, color: UIColor) in
			self.showPolylineInMap(polyline: polyline, color: color)
		}


	}

	// MARK: Polyline methods

	private func showPolylineInMap(polyline: String, color: UIColor) {
		guard
			let coordinates = decodePolyline(polyline) as [CLLocationCoordinate2D]?,
			let coordinate = coordinates.first else {
				return
		}

		self.mapView?.setCenter(coordinate, animated: true)
		let span = MKCoordinateSpan(latitudeDelta: GeneralHelpers.LatitudeLongitudeDelta, longitudeDelta: GeneralHelpers.LatitudeLongitudeDelta)
		let region = MKCoordinateRegion(center: coordinate, span: span)
		self.mapView?.setRegion(region, animated: true)

		let _polyline = TAPolyline(coordinates: coordinates, count: coordinates.count)
		_polyline.color = color
		self.mapView?.add(_polyline)
	}
}

// MARK: Polyline protocol methods

extension TAMapCell: MKMapViewDelegate {

	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

		guard let _overlay = overlay as? TAPolyline else {
			return MKOverlayRenderer()
		}

		let polylineRenderer = MKPolylineRenderer(overlay: overlay)
		polylineRenderer.strokeColor = _overlay.color
		polylineRenderer.lineWidth = GeneralHelpers.PolylineWidth

		return polylineRenderer
	}
}

// MARK: Polyline Custom class

class TAPolyline: MKPolyline {

	var color	: UIColor?
}
