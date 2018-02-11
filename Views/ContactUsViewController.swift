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

let MERCATOR_OFFSET = 268435456.0
let MERCATOR_RADIUS = 85445659.44705395
let DEGREES = 180.0


class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate
{
	@IBOutlet weak var tempLabel: UILabel!
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var phoneIcon: UILabel!
	@IBOutlet weak var phoneNumber: UILabel!
	@IBOutlet weak var phoneBtn: UIButton!
	@IBOutlet weak var emailIcon: UILabel!
	@IBOutlet weak var emailAddr: UILabel!
	@IBOutlet weak var emailBtn: UIButton!
	@IBOutlet weak var addrIcon: UILabel!
	@IBOutlet weak var addrText: UILabel!
	@IBOutlet weak var addrBtn: UIButton!
	@IBOutlet weak var zoomPlusIcon: UIButton!
	@IBOutlet weak var zoomMinusIcon: UIButton!
	@IBOutlet weak var myMap: MKMapView!
	@IBOutlet weak var mapZoomSlider: UISlider!
	var myZoomLevel: Double = 11
	
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
		//set label/buttons to our strings
		//navBar.
		//addGradienBorder(colors: [R.color.YumaRed, R.color.YumaYel], width: 1)
		navTitle.title = R.string.contact
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
//		let myImage = UIImage(contentsOfFile: FontAwesome.close.rawValue)
//		let myStyle = UIBarButtonItemStyle(rawValue: 30)
//		let myMetrics = UIBarMetrics(rawValue: 30)
//		navClose.setBackgroundImage(<#T##backgroundImage: UIImage?##UIImage?#>, for: <#T##UIControlState#>, style: <#T##UIBarButtonItemStyle#>, barMetrics: <#T##UIBarMetrics#>)
//		NSMutableAttributedString.fixAttributes(<#T##NSMutableAttributedString#>)
//		let attributes = [NSAttributedString: UIFont.fontNames(forFamilyName: "FontAwesome") as [String : Any]]
//		navClose.setTitleTextAttributes(attributes, for: .normal)
		navClose.title = FontAwesome.close.rawValue
		//navClose.title = FontAwesome.close.rawValue
		phoneIcon.text = FontAwesome.phone.rawValue
		phoneNumber.text = R.string.our_ph
		phoneBtn.setTitle(R.string.phoneAct, for: .normal)
//		phoneBtn.applyGradient(withColours: [R.color.YumaRed, R.color.YumaYel], gradientOrientation: GradientOrientation.vertical)
		//phoneBtn.applyGradient(withColours: [R.color.YumaRed, R.color.YumaYel], locations: [1.0, 0.0])
		//t(withColours: [R.color.YumaRed, R.color.YumaYel])
//		phoneBtn.layer.borderWidth = 2
//		phoneBtn.layer.borderColor = R.color.YumaDRed.cgColor
//		phoneBtn.layer.cornerRadius = 3
		emailIcon.text = FontAwesome.envelopeO.rawValue
		emailAddr.text = R.string.our_email
		emailBtn.setTitle(R.string.emailAct, for: .normal)
//		emailBtn.layer.cornerRadius = 3
		addrIcon.text = FontAwesome.mapPin.rawValue
		addrText.text = R.string.our_addr
		//addrBtn.title(for: .normal) = R.string.
//		addrBtn.applyGradient(withColours: [R.color.YumaRed, R.color.YumaYel])
//		addrBtn.layer.cornerRadius = 3
//		addrBtn.layer.borderColor = R.color.YumaDRed.cgColor
//		addrBtn.layer.borderWidth = 2
		addrBtn.setTitle(R.string.map_big, for: .normal)

		emailBtn.layer.addGradienBorder(colors: [R.color.YumaRed, R.color.YumaYel], width: 2)
		myMap.showsScale = true
		myMap.showsPointsOfInterest = true
		mapZoomSlider.maximumValue = 3
		mapZoomSlider.maximumValue = 17
		mapZoomSlider.setValue(Float(myZoomLevel), animated: false)
		mapZoomTo(myZoomLevel)
//		myMap.setCenterCoordinate(centerCoordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(R.string.real_lat)!, longitude: CLLocationDegrees(R.string.real_long)!), zoomLevel: mnbayanZoomLevel, animated: false)
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
	
	@IBAction func phoneBtnAct(_ sender: Any)
	{
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
		if MFMailComposeViewController.canSendMail()
		{
			let mail = MFMailComposeViewController()
			mail.mailComposeDelegate = self
			mail.setToRecipients([R.string.our_email])
			mail.setMessageBody("", isHTML: true)
			present(mail, animated: true)
		}
		else
		{
			print("\(R.string.err) \(R.string.cancel) \(R.string.email)")
		}
	}
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
	{
		controller.dismiss(animated: true)
	}
	@IBAction func addrBtnAct(_ sender: Any)
	{
		//show map
	}
	@IBAction func directionsAct(_ sender: Any)
	{
		myMap.showsUserLocation = true
		myMap.setUserTrackingMode(.follow, animated: true)
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
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		//let dest = segue.destination as! ContactUsViewController
		// Pass the selected object to the new view controller.
	}
	
	
//	func tableView(_ tableView: UITableView, viewForHeaderFooterInSection section: Int) -> UIView? {
//		let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyHeader") as! MyHeader
//		headerView.label.text = "Contact"
//		return headerView
//	}
	
	func mapZoomTo(_ zoomLevel: Double)
	{
		let currentRegion = self.myMap.region
		myMap.setCenterCoordinate(centerCoordinate: CLLocationCoordinate2D(latitude: currentRegion.center.latitude, longitude: currentRegion.center.longitude), zoomLevel: zoomLevel, animated: true)
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
