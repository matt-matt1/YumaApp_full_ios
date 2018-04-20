//
//  ContactUsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import MessageUI
import MapKit
import CoreLocation

let MERCATOR_OFFSET = 268435456.0
let MERCATOR_RADIUS = 85445659.44705395
let DEGREES = 180.0


class ContactUsViewController: UIViewController
{
	@IBOutlet weak var tempLabel: 		UILabel!
	@IBOutlet weak var navBar: 			UINavigationBar!
	@IBOutlet weak var navTitle: 		UINavigationItem!
	@IBOutlet weak var navClose: 		UIBarButtonItem!
	@IBOutlet weak var navHelp: 		UIBarButtonItem!
	@IBOutlet weak var phoneIcon: 		UILabel!
	@IBOutlet weak var phoneNumber: 	UILabel!
	@IBOutlet weak var phoneBtn: 		UIButton!
	@IBOutlet weak var emailIcon: 		UILabel!
	@IBOutlet weak var emailAddr: 		UILabel!
	@IBOutlet weak var emailBtn: 		UIButton!
	@IBOutlet weak var addrIcon: 		UILabel!
	@IBOutlet weak var addrText: 		UILabel!
	@IBOutlet weak var addrBtn: 		UIButton!
	@IBOutlet weak var zoomPlusIcon: 	UIButton!
	@IBOutlet weak var zoomMinusIcon: 	UIButton!
	@IBOutlet weak var myMap: 			MKMapView!
	@IBOutlet weak var mapZoomSlider: 	UISlider!
	@IBOutlet weak var labelMyLocation: UIButton!
	var myZoomLevel: 	Double = 		11
	let location = 						CLLocationManager()
	var pin: 							AnnotationPin!
	var coords: 						CLLocationCoordinate2D?
	let picker = 						UIPickerView()
	var pickerData: 	[String] = 		[]
	let store = 						DataStore.sharedInstance
	
	
	//	var myCustomView: UserCoinView?
	
	//	override func viewDidLayoutSubviews() {
	//		super.viewDidLayoutSubviews()
	//		if myCustomView == nil { // make it only once
	//			myCustomView = Bundle.mainBundle().loadNibNamed("UserCoinView", owner: self, options: nil).first as? UserCoinView
	//myCustomView.frame = ...
	//				self.view.addSubview(myCustomView) // you can omit 'self' here
	// if your app support both Portrait and Landscape orientations
	// you should add constraints here
	//		}
	//	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		coords = CLLocationCoordinate2D(latitude: CLLocationDegrees(R.string.real_lat)!, longitude: CLLocationDegrees(R.string.real_long)!)
		//let our_coords = CLLocationCoordinate2DMake(CLLocationDegrees(R.string.real_lat)!, CLLocationDegrees(R.string.real_long)!)
		location.delegate = self
		location.requestWhenInUseAuthorization()
		location.requestAlwaysAuthorization()
		//set label/buttons to our strings
		navTitle.title = R.string.contact
		tempLabel.isHidden = true
		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
//			if #available(iOS 10.0, *) {
//				navBar.superview?.constraints.forEach(
//					{ (constraint) in
//					if constraint.firstAnchor === navBar && constraint.firstAttribute == .top
//					{
						navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//					}})
//			} else {
//				navBar.superview?.constraints.forEach(
//					{ (constraint) in
//						if constraint.firstItem === navBar && constraint.firstAttribute == .top
//						{
//							navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//						}})
//			}
		}
//		var i = 0
//		view.constraints.forEach { (constraint) in
//			//view.removeConstraint(constraint)
//			print("constraint\(i):1stItem=\"\(constraint.firstItem)\", 1stAttr=\"\(constraint.firstAttribute)\"")
//			i += 1
//		}
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navClose.title = FontAwesome.close.rawValue
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		phoneIcon.text = FontAwesome.phone.rawValue
		phoneNumber.text = R.string.our_ph
		phoneBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		phoneBtn.setTitle(R.string.phoneAct.uppercased(), for: .normal)
		emailIcon.text = FontAwesome.envelopeO.rawValue
		emailAddr.text = R.string.our_email
		emailBtn.isOpaque = false
		emailBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		emailBtn.setTitle(R.string.emailAct.uppercased(), for: .normal)
		//print("emailBtn has layers:\(emailBtn.layer)")
		//let labelLayer = UILabel()
		//labelLayer.text = R.string.emailAct
		//emailBtn.addSubview(labelLayer)
		addrIcon.text = FontAwesome.mapPin.rawValue
		addrText.text = R.string.our_addr
		addrBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		addrBtn.setTitle(R.string.map_big.uppercased(), for: .normal)
//		NSLayoutConstraint.activate([
//			phoneBtn.widthAnchor.constraint(equalToConstant: min(200, max(80, self.view.frame.width/5))),
//			emailBtn.widthAnchor.constraint(equalToConstant: min(200, max(80, self.view.frame.width/5))),
//			addrBtn.widthAnchor.constraint(equalToConstant: min(200, max(80, self.view.frame.width/5))),
//			])
		//print("min(200, max(80, self.view.frame.width/5))=\(self.view.frame.width/5)=\(min(200, max(80, self.view.frame.width/5)))")

		if CLLocationManager.locationServicesEnabled()
		{
			location.delegate = self
			location.desiredAccuracy = kCLLocationAccuracyBest
			location.startUpdatingLocation()
			myMap.showsUserLocation = true
			labelMyLocation.setTitle(R.string.plotMe, for: .normal)
			
//			let userLocation = location.location?.coordinate
//			let ourPlace: MKPlacemark
//			let userPlace: MKPlacemark
//			if #available(iOS 10.0, *)
//			{
//				ourPlace = MKPlacemark(coordinate: coords)
//				userPlace = MKPlacemark(coordinate: userLocation!)
//				//Fatal error: Unexpectedly found nil while unwrapping an Optional value
//			}
//			else
//			{
//				ourPlace = MKPlacemark(coordinate: coords, addressDictionary: nil)
//				userPlace = MKPlacemark(coordinate: userLocation!, addressDictionary: nil)
//			}
//			let ourItem = MKMapItem(placemark: ourPlace)
//			let userItem = MKMapItem(placemark: userPlace)
			
//			let directionRequest = MKDirectionsRequest()
//			directionRequest.source = userItem
//			directionRequest.destination = ourItem
//			directionRequest.transportType = .any
			
//			let directions = MKDirections(request: directionRequest)
//			directions.calculate(completionHandler:
//				{
//					(response, error) in
//					guard let response = response else
//					{
//						if let error = error
//						{
//							print("\(R.string.err) \(error)")
//						}
//						return
//					}
//					let route = response.routes[0]
//					self.myMap.add(route.polyline, level: .aboveRoads)
//					self.myMap.setRegion(MKCoordinateRegionForMapRect(route.polyline.boundingMapRect), animated: true)
//			})
		}
		else
		{
			labelMyLocation.isHidden = true
		}
		myMap.showsScale = true
		myMap.showsCompass = false
		myMap.showsPointsOfInterest = true
		myMap.delegate = self
		mapZoomSlider.minimumValue = 1
		mapZoomSlider.maximumValue = 16
		mapZoomSlider.setValue(Float(myZoomLevel), animated: false)
		myMap.setCenterCoordinate(centerCoordinate: coords!, zoomLevel: myZoomLevel, animated: false)
		pin = AnnotationPin(title: R.string.our_bus, subtitle: "Printers, Cartridges, Laptops ...", coord: coords!)
		myMap.addAnnotation(pin)
	}
	
	override func viewWillAppear(_ animated: Bool) {
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		
		//let header = UINib(nibName: "myHeader", bundle: nil).instantiate(withOwner: nil, options: nil) as! YumaHeader
		//let headerView: header = header(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 280, width: UIScreen.main.bounds.size.width, height: 280))
		
		//let headerView = Bundle.main.loadNibNamed("header", owner: self, options: nil)?.first as? SectionHeaderView
		//headerView?.frame = CGRect(x:0, y: 0, width: view.frame.width, height: 50.0)
		let mainStack = UIStackView()
		mainStack.axis = UILayoutConstraintAxis.vertical
		mainStack.distribution = UIStackViewDistribution.fill
		mainStack.spacing = 0
		
		//let header = UITableView()
		//header.register(UINib(nibName: "myheader", bundle: nil), forHeaderFooterViewReuseIdentifier: "myheader")
//		let titleStack = UIStackView()
//		titleStack.backgroundColor = UIColor.red
//		titleStack.axis = UILayoutConstraintAxis.horizontal
//		titleStack.distribution = UIStackViewDistribution.fill
//		titleStack.spacing = 16
//
//		let label = UILabel()
//		label.font = UIFont(name: "FontAwesome", size: 40)
//		label.text = FontAwesome.chevronCircleLeft.rawValue
//		label.backgroundColor = UIColor.red
//		//label.textColor = UIColor!.yellow
//		label.layoutMargins.left = 8.0
//		label.layoutMargins.top = 16
//		label.layoutMargins.bottom = 16
//		//label.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//		//label.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
//
//		let label2 = UILabel()
//		label2.font = UIFont(name: label.font.fontName, size: 26)
//		label2.text = "Contact Us"
//		//label2.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//		//label2.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
//
//		titleStack.addArrangedSubview(label)
//		titleStack.addArrangedSubview(label2)
//		label.centerYAnchor.constraint(equalTo: titleStack.centerYAnchor).isActive = true
//		label2.centerYAnchor.constraint(equalTo: titleStack.centerYAnchor).isActive = true
//		titleStack.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//		titleStack.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
//
//		mainStack.addArrangedSubview(titleStack)
		
		//let YumaHeader = UIView()
		//YumaHeader.addSubview(UINib(nibName: "YumaHeader", bundle: Bundle.main))
		//mainStack.addArrangedSubview(YumaHeader)
		//mainStack.addArrangedSubview(header)
		//mainStack.addSubview(headerView)
		let blank = UIView()
		blank.backgroundColor = R.color.YumaRed
		mainStack.addArrangedSubview(blank)
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		mainStack.backgroundColor = UIColor.blue
		
		self.view.addSubview(mainStack)
		//view.backgroundColor = UIColor.green
		mainStack.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
		
		mainStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
	}

	@objc func writePickedValue(_ sender: UIButton?)
	{
		let mail = MFMailComposeViewController()
		mail.mailComposeDelegate = self
		let picked = picker.selectedRow(inComponent: 0)
		mail.setToRecipients([(store.contacts[picked].email)!])
		mail.setSubject(pickerData[picked])
//		if picked == 1
//		{
//			mail.setSubject(R.string.customer + " _<your name>_; " + R.string.order + " _<date>_<item(s)>_")
//		}
//		else
//		{
//			mail.setSubject(R.string.err)
//		}
//		mail.title = R.string.contact.capitalized
		mail.setMessageBody(pickerData[picked] + ",\n\n\n...", isHTML: true)
		present(mail, animated: true)
		mail.becomeFirstResponder()
	}
	
	@IBAction func phoneBtnAct(_ sender: Any)
	{
		DataStore.sharedInstance.flexView(view: phoneBtn)
		let cleanPhNum = R.string.our_ph.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
		if let url = URL(string: "tel://\(cleanPhNum)"), UIApplication.shared.canOpenURL(url)
		{
			if #available(iOS 10, *)
			{
				UIApplication.shared.open(url, options: [:], completionHandler: nil)
			}
			else
			{
				UIApplication.shared.openURL(url as URL)
			}
		}
	}
	@IBAction func emailBtnAct(_ sender: Any)
	{
		DataStore.sharedInstance.flexView(view: emailBtn)
		if MFMailComposeViewController.canSendMail()
		{
			if store.contacts.count > 0
			{
				for contact in store.contacts
				{
					pickerData.append(contact.name![store.myLang].value!)
				}
			}
			let sb = UIStoryboard(name: "HelpStoryboard", bundle: nil)
			let vc = sb.instantiateInitialViewController() as? PickerViewController
			if vc != nil
			{
				self.present(vc!, animated: true, completion: nil)
				//vc?.dialog.layer.cornerRadius = 20
				vc?.dialog.cornerRadius = 20
				vc?.titleLbl.text = R.string.select + " " + R.string.emailTo
				vc?.button.setTitle(R.string.select, for: .normal)
				vc?.view.addSubview(self.picker)
				self.picker.translatesAutoresizingMaskIntoConstraints = false
				NSLayoutConstraint.activate([
					self.picker.centerXAnchor.constraint(equalTo: (vc?.dialog.centerXAnchor)!),
					self.picker.centerYAnchor.constraint(equalTo: (vc?.dialog.centerYAnchor)!),
					])
				vc?.pickerView.removeFromSuperview()
				vc?.button.addTarget(self, action: #selector(self.writePickedValue(_:)), for: .touchUpInside)
				//on pick goto writePickedValue
			}
			else
			{
				print("HelpStoryboard has no initial view controller")
			}
		}
		else
		{
			OperationQueue.main.addOperation
			{
				let alert = 					UIAlertController(title: R.string.err, message: R.string.email + " " + R.string.notAct, preferredStyle: .alert)
				let coloredBG = 				UIView()
				let blurFx = 					UIBlurEffect(style: .dark)
				let blurFxView = 				UIVisualEffectView(effect: blurFx)
				alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
				alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
				alert.view.superview?.backgroundColor = R.color.YumaRed
				alert.view.shadowColor = 		R.color.YumaDRed
				alert.view.shadowOffset = 		.zero
				alert.view.shadowRadius = 		5
				alert.view.shadowOpacity = 		1
				alert.view.backgroundColor = 	R.color.YumaYel
				alert.view.cornerRadius = 		15
				coloredBG.backgroundColor = 	R.color.YumaRed
				coloredBG.alpha = 				0.4
				coloredBG.frame = 				self.view.bounds
				self.view.addSubview(coloredBG)
				blurFxView.frame = 				self.view.bounds
				blurFxView.alpha = 				0.5
				blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
				self.view.addSubview(blurFxView)
				print("\(R.string.email) \(R.string.notAct)")
				alert.addAction(UIAlertAction(title: R.string.dismiss.uppercased(), style: .default, handler: { (action) in
					coloredBG.removeFromSuperview()
					blurFxView.removeFromSuperview()
					self.dismiss(animated: false, completion: nil)
				}))
				self.present(alert, animated: true, completion:
				{
				})
			}
		}
	}
	@IBAction func addrBtnAct(_ sender: Any)
	{
		Reachability.isInternetAvailable(website: R.string.URLbase)
		{
			(available) in
			
			guard available else
			{
				DataStore.sharedInstance.flexView(view: self.addrBtn)
				OperationQueue.main.addOperation
				{
					let alert = 					UIAlertController(title: R.string.err + " " + R.string.internet, message: R.string.unableConnect, preferredStyle: .alert)
					let coloredBG = 				UIView()
					let blurFx = 					UIBlurEffect(style: .dark)
					let blurFxView = 				UIVisualEffectView(effect: blurFx)
					alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
					alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
					alert.view.superview?.backgroundColor = R.color.YumaRed
					alert.view.shadowColor = 		R.color.YumaDRed
					alert.view.shadowOffset = 		.zero
					alert.view.shadowRadius = 		5
					alert.view.shadowOpacity = 		1
					alert.view.backgroundColor = 	R.color.YumaYel
					alert.view.cornerRadius = 		15
					coloredBG.backgroundColor = 	R.color.YumaRed
					coloredBG.alpha = 				0.4
					coloredBG.frame = 				self.view.bounds
					self.view.addSubview(coloredBG)
					blurFxView.frame = 				self.view.bounds
					blurFxView.alpha = 				0.5
					blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
					self.view.addSubview(blurFxView)
					print("\(R.string.unableConnect) \(R.string.email)")
					alert.addAction(UIAlertAction(title: R.string.dismiss.uppercased(), style: .default, handler: { (action) in
						coloredBG.removeFromSuperview()
						blurFxView.removeFromSuperview()
						self.dismiss(animated: false, completion: nil)
					}))
					self.present(alert, animated: true, completion:
						{
					})
				}
				return
			}
			self.present(ExpandMapViewController(), animated: false, completion: nil)
		}
	}
	@IBAction func directionsAct(_ sender: Any)
	{
		myMap.showsUserLocation = true
		myMap.setUserTrackingMode(.follow, animated: true)
		
		if coords != nil && CLLocationManager.locationServicesEnabled()
		{
			let userLocation = location.location?.coordinate
			let ourPlace: MKPlacemark
			let userPlace: MKPlacemark
			if #available(iOS 10.0, *)
			{
				ourPlace = MKPlacemark(coordinate: coords!)
				userPlace = MKPlacemark(coordinate: userLocation!)
				//Fatal error: Unexpectedly found nil while unwrapping an Optional value
			}
			else
			{
				ourPlace = MKPlacemark(coordinate: coords!, addressDictionary: nil)
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
	@IBAction func zoomPlusBtnAct(_ sender: Any)
	{
		if myZoomLevel < Double(mapZoomSlider.maximumValue)
		{
			myZoomLevel += 1
			mapZoomSlider.setValue(Float(myZoomLevel), animated: false)
			mapZoomTo(myZoomLevel)
		}
	}
	@IBAction func zoomMinusBtnAct(_ sender: Any)
	{
		if myZoomLevel > Double(mapZoomSlider.minimumValue)
		{
			myZoomLevel -= 1
			mapZoomSlider.setValue(Float(myZoomLevel), animated: false)
			mapZoomTo(myZoomLevel)
		}
	}
	@IBAction func zoomSliderAct(_ sender: Any)
	{
		myZoomLevel = Double(mapZoomSlider.value)
		mapZoomTo(Double(mapZoomSlider.value))
	}
	@IBAction func closeView(sender: AnyObject)
	{
		self.dismiss(animated: true, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
		let vc = HelpVC()// as! helpVC
		vc.backgroundColor = .red
		vc.title.text = "hi"
		self.view.addSubview(vc)
//		let vc = HelpVC() as! UIViewController
//		self.present(vc, animated: false, completion: nil)
	}
	
//	override func didReceiveMemoryWarning()
//	{
//		super.didReceiveMemoryWarning()
//		// Dispose of any resources that can be recreated.
//	}
	
	
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//	{
//		//let dest = segue.destination as! ContactUsViewController
//		// Pass the selected object to the new view controller.
//	}
	
	
	func mapZoomTo(_ zoomLevel: Double)
	{
		let currentRegion = self.myMap.region
//		tempLabel.text = "myZoom=\(myZoomLevel) : slider=\(mapZoomSlider.value)"
		myMap.setCenterCoordinate(centerCoordinate: CLLocationCoordinate2D(latitude: currentRegion.center.latitude, longitude: currentRegion.center.longitude), zoomLevel: zoomLevel, animated: true)
	}
}



extension ContactUsViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
	override func viewDidLayoutSubviews()
	{
		picker.delegate = self
		picker.dataSource = self
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return self.pickerData.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		return self.pickerData[row]
	}

}



extension MKMapView
{
	private func longitudeToPixelSpaceX(longitude:Double)->Double
	{
		return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * Double.pi / DEGREES)
	}
	
	private func latitudeToPixelSpaceY(latitude:Double)->Double
	{
		return round(MERCATOR_OFFSET - MERCATOR_RADIUS * log((1 + sin(latitude * Double.pi / DEGREES)) / (1 - sin(latitude * Double.pi / DEGREES))) / 2.0)
	}
	
	private func pixelSpaceXToLongitude(pixelX:Double)->Double
	{
		return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * DEGREES / Double.pi
	}
	
	private func pixelSpaceYToLatitude(pixelY:Double)->Double
	{
		return (Double.pi / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * DEGREES / Double.pi
	}
	
	private func coordinateSpanWithCenterCoordinate(centerCoordinate:CLLocationCoordinate2D, zoomLevel:Double)->MKCoordinateSpan
	{
		// convert center coordiate to pixel space
		let centerPixelX = longitudeToPixelSpaceX(longitude: centerCoordinate.longitude)
		let centerPixelY = latitudeToPixelSpaceY(latitude: centerCoordinate.latitude)
		
		// determine the scale value from the zoom level
		let zoomExponent:Double = 20.0 - zoomLevel
		let zoomScale:Double = pow(2.0, zoomExponent)
		
		// scale the map’s size in pixel space
		let mapSizeInPixels = self.bounds.size
		let scaledMapWidth = Double(mapSizeInPixels.width) * zoomScale
		let scaledMapHeight = Double(mapSizeInPixels.height) * zoomScale
		
		// figure out the position of the top-left pixel
		let topLeftPixelX = centerPixelX - (scaledMapWidth / 2.0)
		let topLeftPixelY = centerPixelY - (scaledMapHeight / 2.0)
		
		// find delta between left and right longitudes
		let minLng = pixelSpaceXToLongitude(pixelX: topLeftPixelX)
		let maxLng = pixelSpaceXToLongitude(pixelX: topLeftPixelX + scaledMapWidth)
		let longitudeDelta = maxLng - minLng
		
		let minLat = pixelSpaceYToLatitude(pixelY: topLeftPixelY)
		let maxLat = pixelSpaceYToLatitude(pixelY: topLeftPixelY + scaledMapHeight)
		let latitudeDelta = -1.0 * (maxLat - minLat)
		
		return MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
	}
	
	func setCenterCoordinate(centerCoordinate:CLLocationCoordinate2D, zoomLevel:Double, animated:Bool)
	{
		// clamp large numbers to 28
		var zoomLevel = zoomLevel
		zoomLevel = min(zoomLevel, 28)
		
		// use the zoom level to compute the region
		let span = self.coordinateSpanWithCenterCoordinate(centerCoordinate: centerCoordinate, zoomLevel: zoomLevel)
		let region = MKCoordinateRegionMake(centerCoordinate, span)
		if region.center.longitude == -180.00000000
		{
			print("Invalid Region")
		}
		else{
			self.setRegion(region, animated: animated)
		}
	}
}



extension ContactUsViewController: CLLocationManagerDelegate
{
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
	{
		let center = locations[0].coordinate
		let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
		let region = MKCoordinateRegion(center: center, span: span)
		myMap.setRegion(region, animated: true)
		myMap.showsUserLocation = true
	}
}



extension ContactUsViewController: MFMailComposeViewControllerDelegate
{
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
	{
		controller.dismiss(animated: true)
	}
}



extension ContactUsViewController: MKMapViewDelegate
{
//	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
//	{
//		let annotationView = MKAnnotationView(annotation: pin, reuseIdentifier: "myPin")
//		annotationView.image = #imageLiteral(resourceName: "logoPin")
//		annotationView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
//		return annotationView
//	}
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
	{
		let rend = MKPolylineRenderer(overlay: overlay)
		rend.strokeColor = R.color.YumaRed
		rend.lineWidth = 5.0
		return rend
	}
}
