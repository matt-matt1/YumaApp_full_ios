//
//  ExpandMapViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-20.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import MapKit


class ExpandMapViewController: UIViewController, CLLocationManagerDelegate
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var myMap: MKMapView!
	@IBOutlet weak var mapZoomSlider: UISlider!
	var pin: AnnotationPin!
	var myZoomLevel: Double = 11
	let location = CLLocationManager()

	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		navTitle.title = R.string.contact
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navClose.title = FontAwesome.close.rawValue
		navBar.translatesAutoresizingMaskIntoConstraints = false
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
//		else
//		{
//			navBar.superview?.constraints.forEach(
//				{ (constraint) in
//					if constraint.firstItem === navBar && constraint.firstAttribute == .top
//					{
//						navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//					}})
//		}
		myMap.showsScale = true
		myMap.showsPointsOfInterest = true
		myMap.showsUserLocation = true
		mapZoomSlider.minimumValue = 1
		mapZoomSlider.maximumValue = 16
		mapZoomSlider.setValue(Float(myZoomLevel), animated: false)
		let coords = CLLocationCoordinate2D(latitude: CLLocationDegrees(R.string.real_lat)!, longitude: CLLocationDegrees(R.string.real_long)!)
//		myMap.setCenterCoordinate(centerCoordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(R.string.real_lat)!, longitude: CLLocationDegrees(R.string.real_long)!), zoomLevel: myZoomLevel, animated: false)
		myMap.setCenterCoordinate(centerCoordinate: coords, zoomLevel: myZoomLevel, animated: false)
		pin = AnnotationPin(title: R.string.our_bus, subtitle: "Printers, Cartridges, Laptops ...", coord: coords)
		myMap.addAnnotation(pin)
		if CLLocationManager.locationServicesEnabled()
		{
			location.delegate = self
			location.desiredAccuracy = kCLLocationAccuracyBest
			location.startUpdatingLocation()
			myMap.showsUserLocation = true
//			labelMyLocation.setTitle(R.string.plotMe, for: .normal)
			let userLocation = location.location?.coordinate
			let ourPlace: MKPlacemark
			let userPlace: MKPlacemark
			if userLocation != nil
			{
				if #available(iOS 10.0, *)
				{
					ourPlace = MKPlacemark(coordinate: coords)
					userPlace = MKPlacemark(coordinate: userLocation!)
					//Fatal error: Unexpectedly found nil while unwrapping an Optional value
				}
				else
				{
					ourPlace = MKPlacemark(coordinate: coords, addressDictionary: nil)
					userPlace = MKPlacemark(coordinate: userLocation!, addressDictionary: nil)
				}
				let ourItem = MKMapItem(placemark: ourPlace)
				let userItem = MKMapItem(placemark: userPlace)
				
				let directionRequest = MKDirectionsRequest()
				directionRequest.source = userItem
				directionRequest.destination = ourItem
				directionRequest.transportType = .any
				
				let directions = MKDirections(request: directionRequest)
				directions.calculate(completionHandler:
					{
						(response, error) in
						guard let response = response else
						{
							if let error = error
							{
								print("\(R.string.err) \(error)")
							}
							return
						}
						let route = response.routes[0]
						self.myMap.add(route.polyline, level: .aboveRoads)
						self.myMap.setRegion(MKCoordinateRegionForMapRect(route.polyline.boundingMapRect), animated: true)
				})
			}
		}
    }

	override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
	}
	@IBAction func mapZoomMinusAct(_ sender: Any)
	{
		if myZoomLevel > Double(mapZoomSlider.minimumValue)
		{
			myZoomLevel -= 1
			mapZoomSlider.setValue(Float(myZoomLevel), animated: false)
			mapZoomTo(myZoomLevel)
		}
	}
	@IBAction func mapZoomPlusAct(_ sender: Any)
	{
		if myZoomLevel < Double(mapZoomSlider.maximumValue)
		{
			myZoomLevel += 1
			mapZoomSlider.setValue(Float(myZoomLevel), animated: false)
			mapZoomTo(myZoomLevel)
		}
	}
	@IBAction func mapZoomSliderAct(_ sender: Any)
	{
		myZoomLevel = Double(mapZoomSlider.value)
		mapZoomTo(Double(mapZoomSlider.value))
	}
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	func mapZoomTo(_ zoomLevel: Double)
	{
		let currentRegion = self.myMap.region
		//		tempLabel.text = "myZoom=\(myZoomLevel) : slider=\(mapZoomSlider.value)"
		myMap.setCenterCoordinate(centerCoordinate: CLLocationCoordinate2D(latitude: currentRegion.center.latitude, longitude: currentRegion.center.longitude), zoomLevel: zoomLevel, animated: true)
	}

}
