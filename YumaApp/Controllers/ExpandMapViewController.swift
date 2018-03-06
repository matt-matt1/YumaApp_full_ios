//
//  ExpandMapViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-20.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import MapKit


class ExpandMapViewController: UIViewController
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var myMap: MKMapView!
	@IBOutlet weak var mapZoomSlider: UISlider!
	
	var myZoomLevel: Double = 11
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		navTitle.title = R.string.contact
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navClose.title = FontAwesome.close.rawValue
		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}

		myMap.showsScale = true
		myMap.showsPointsOfInterest = true
		mapZoomSlider.minimumValue = 1
		mapZoomSlider.maximumValue = 16
		mapZoomSlider.setValue(Float(myZoomLevel), animated: false)
		myMap.setCenterCoordinate(centerCoordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(R.string.real_lat)!, longitude: CLLocationDegrees(R.string.real_long)!), zoomLevel: myZoomLevel, animated: false)

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
