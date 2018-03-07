//
//  AnnotationPin.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import MapKit

class AnnotationPin: NSObject, MKAnnotation
{
	var title: String?
	var subtitle: String?
	var coordinate: CLLocationCoordinate2D
	
	init(title: String, subtitle: String, coord: CLLocationCoordinate2D) {
		self.title = title
		self.subtitle = subtitle
		self.coordinate = coord
	}
}
