//
//  MapUtil.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-09.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import MapKit

class MapUtil: MKMapView {

	class func translateCoordinate(coordinate: CLLocationCoordinate2D, metersLat: Double,metersLong: Double) -> (CLLocationCoordinate2D)
	{
		var tempCoord = coordinate
		
		let tempRegion = MKCoordinateRegionMakeWithDistance(coordinate, metersLat, metersLong)
		let tempSpan = tempRegion.span
		
		tempCoord.latitude = coordinate.latitude + tempSpan.latitudeDelta
		tempCoord.longitude = coordinate.longitude + tempSpan.longitudeDelta
		
		return tempCoord
	}
	
	class func setRadius(radius: Double, withCity city: CLLocationCoordinate2D, InMapView mapView: GMSMapView)
	{
		let range = MapUtil.translateCoordinate(coordinate: city, metersLat: radius * 2, metersLong: radius * 2)
		let bounds = GMSCoordinateBounds(coordinate: city, coordinate: range)
		let update = GMSCameraUpdate.fitBounds(bounds, withPadding: 5.0)    // padding set to 5.0
		mapView.moveCamera(update)
		
		// location
		let marker = GMSMarker(position: city)
		marker.title = "title"
		marker.snippet = "snippet"
		marker.flat = true
		marker.map = mapView
		
		// draw circle
		let circle = GMSCircle(position: city, radius: radius)
		circle.map = mapView
		circle.fillColor = UIColor(red:0.09, green:0.6, blue:0.41, alpha:0.5)
		
		mapView.animateToLocation(city) // animate to center
	}

}
