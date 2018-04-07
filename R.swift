//
//  R.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-07.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation
import UIKit

struct R {
	//fileprivate static let applicationLocale = hostingBundle.referredLocalizations.first.flatMap(Locale.init) ?? Locale.current
	//fileprivate static let hostingBundle = Bundle(for: R.Class.self)
	
	//static func validate() throws {
	//	try font.validate()
	//	try intern.validate()
	//}
	
	struct attribute
	{
		static let iconText: [NSAttributedStringKey : Any] = [
			NSAttributedStringKey.foregroundColor: R.color.YumaRed,
			NSAttributedStringKey.font: UIFont(name: "FontAwesome", size: 42)!,
//			NSAttributedStringKey.shadow: R.shadow.darkGray5_downright1
		]

		static let labelText: [NSAttributedStringKey : Any] = [
			NSAttributedStringKey.foregroundColor: R.color.YumaRed,
			//NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)
			NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 16)!
//			NSAttributedStringKey.shadow: R.shadow.darkGray5_downright1
		]

		static let caption1: [NSAttributedStringKey : Any] = [
			NSAttributedStringKey.foregroundColor: R.color.YumaYel,
			NSAttributedStringKey.strokeColor: R.color.YumaRed,
			NSAttributedStringKey.strokeWidth: -4.0,
			NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 35),
			NSAttributedStringKey.shadow: R.shadow.darkGray3_downright1()
//			NSAttributedStringKey.strokeColor: R.color.YumaRed,
//			NSAttributedStringKey.strokeWidth: 3
		]

		static let caption2: [NSAttributedStringKey : Any] = [
			NSAttributedStringKey.foregroundColor: R.color.YumaRed,
			NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 18),
//			NSAttributedStringKey.shadow: R.shadow.darkGray3_downright1()
//			NSAttributedStringKey.strokeColor: R.color.YumaRed,
//			NSAttributedStringKey.strokeWidth: 1
		]
	}
	
	struct array {
		static let help_product_list_guide: [String] = [
			"Swipe left or right to view products/services",
			"TIP: The solid circle, above, represents the current item and outlines represent the others",
			"Press the \"\(R.string.add2cart)\" button to copy this item to your cart",
			"When finished, press the \"\(R.string.add2cart)\" to return to the previous page; or press \"(R.string.checkOut)\" to launch the Checkout facility"]
		static let help_cart_guide: [String] = [
			"If the list of items is longer than the screen, the list can be scrolled by swiping up or down",
			"Each item can be swiped left to reveal the item \"\(R.string.edit)\" button or right to reveal the item \"\(R.string.delete)\" button",
			"TIP: The \"\(R.string.edit)\" button will allow you to modify the item quantity",
			"When the list is complete and has the correct quantity for each item, \"\(R.string.next)\" is the next step"]
		
		static let help_checkout_guide: [String] = [
			"There are some simple steps to complete for the items in your cart to be dispatched",
			"Each step number is contained in the bar near the top; completed steps have a tick mark next to them",
			"Instructions and options for each step is shown in the main panel in the page middle",
			"The \"\(R.string.next)\" button will proceed to the next step to complete",
			"When all steps are complete the item(s) are ready to be dispatched"]
		static let help_contact_us_guide: [String] = [
			"This page details how we can contacted - phone, email and visit",
			"If you have internet facilities, a map will be displayed with our location",
			"The call button will place the number in your dialer",
			"The email button will create a new message and set our email address as To address",
			"The expand map button will, if you have internet facilities, display a map with our location",
			"The map can be zoomed using the slider at the bottom, or press the plus and minus buttons"]
		static let help_home_page_guide: [String] = [
			"Welcome to our store! This is the mobile interface for \(R.string.app_name)",
			"A small slide-show of our products/services is in the middle, that can be pressed",
			"Click a button (containing an icon and below a word or two) to view that page"]

		fileprivate init() {}
	}
	
	struct color {
		static let YumaRed = UIColor(red: 0.66666666669999997, green: 0.0, blue: 0.094117647060000004, alpha: 1)
		//aa0018
		static let YumaYel = UIColor(red: 0.99942404029999998, green: 0.98555368190000003, blue: 0.0, alpha: 1)
		//f5bf2b
		static let YumaDRed = UIColor(red: 0.2352150381, green: 0.01725785062, blue: 0.005341128446, alpha: 1)
		// #colorLiteral(red: 0.2352150381, green: 0.01725785062, blue: 0.005341128446, alpha: 1)
		//static let YumaDRed2 = UIColor(hex: "#2d0202")
		static let YumaDRedTransparent = UIColor(red: 0.2352150381, green: 0.01725785062, blue: 0.005341128446, alpha: 0)
		static let AppleBlue = UIColor(red: 0.1520819664, green: 0.5279997587, blue: 0.985317409, alpha: 1)

		fileprivate init() {}
	}
	
	struct file {
		//static let fontAwesomeTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "FontAwesome", pathExtension: "ttf")
		
		//static func fontAwesomeTtf(_: Void = ()) -> Foundation.URL? {
		//	let fileResource = R.file.fontAwesomeTtf
		//	return fileResource.bundle.url(forResource: fileResource)
		//}
		
		fileprivate init() {}
	}
	
	struct font {
		//static let fontAwesome = Rswift.FontResource(fontName: "FontAwesome")
		//static let fontAwesome = UIFont(name: "FontAwesome", size: )

		static func FontAwesomeOfSize(pointSize: Int) -> UIFont
		{
			return UIFont(name: "FontAwesome", size: CGFloat(pointSize))!
		}
		
		//static func fontAwesome(size: CGFloat) -> UIKit.UIFont? {
		//	return UIKit.UIFont(resource: fontAwesome, size: size)
		//}
		
		//static func validate() throws {
		//	if R.font.fontAwesome(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'FontAwesome' could not be loaded, is 'FontAwesome.ttf' added to the UIAppFonts array in this targets Info.plist?") }
		//}
	}
	
	struct image
	{
		static let homeSliderCartridges = UIImage(named: "home-slider-cartridges")
		static let homeSliderLaptops = UIImage(named: "home-slider-laptops")
		static let homeSliderPrinters = UIImage(named: "home-slider-printers")
		//static let logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "logo")
		
//		static func homeSliderCartridges(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
//			return UIKit.UIImage(data: R.image.homeSliderCartridges, scale: traitCollection)
//		}
//		static func homeSliderLaptops(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
//			return UIKit.UIImage(resource: R.image.homeSliderLaptops, compatibleWith: traitCollection)
//		}
//
//		static func homeSliderPrinters(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
//			return UIKit.UIImage(resource: R.image.homeSliderPrinters, compatibleWith: traitCollection)
//		}
//
//		static func logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
//			return UIKit.UIImage(resource: R.image.logo, compatibleWith: traitCollection)
//		}
		
		fileprivate init() {}
	}
	
	struct nib {
		fileprivate init() {}
	}
	
	struct reuseIdentifier {
		fileprivate init() {}
	}
	
	struct segue {
		fileprivate init() {}
	}
	
	struct shadow
	{
		static func darkGray3_downright1() -> NSShadow
		{
			let shadow = NSShadow()
			shadow.shadowBlurRadius = 3
			shadow.shadowOffset = CGSize(width: 1, height: 1)
			shadow.shadowColor = UIColor.gray
			return shadow
		}

		static func darkGray5_downright1() -> NSShadow
		{
			let shadow = NSShadow()
			shadow.shadowBlurRadius = 5
			shadow.shadowOffset = CGSize(width: 1, height: 1)
			shadow.shadowColor = UIColor.gray
			return shadow
		}
		
		static func darkGray5_downright2() -> NSShadow
		{
			let shadow = NSShadow()
			shadow.shadowBlurRadius = 10
			shadow.shadowOffset = CGSize(width: 2, height: 2)
			shadow.shadowColor = UIColor.gray
			return shadow
		}
	}
	
	struct story {
		static let main = UIStoryboard(name: "Main", bundle: nil)
		static let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil)
		static let laps = UIStoryboard(name: "Laptops", bundle: nil)

		//static let main = _R.storyboard.main()
		
//		static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
//			return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
//		}
//
//		static func main(_: Void = ()) -> UIKit.UIStoryboard {
//			return UIKit.UIStoryboard(resource: R.storyboard.main)
//		}

		fileprivate init() {}
	}
	
	struct string {
		static let app_name = "Yuma Technical Mobile App"
		static let google_maps_key = "AIzaSyCGFpjQESGvGTS8LAkZujvq8rCgHS1mAuQ"

		static let en = "Website (English)"
		static let about = "About Us"
		static let contact = "Contact Us"
		static let services = "Services"
		static let qc = "Website (French-Canadian)"
		static let printers = "Printers"
		static let laptops = "Laptops"
		static let toners = "Cartridges"

		static let our_lat = "43.7443124"
		static let our_lat2 = "43.7443085"
		static let our_long2 = "-79.2975829"
		static let our_long = "-79.2953942"
		static let real_lat = "43.744349"
		static let real_long = "-79.295405"
		static let real_zoom = "14"
		//		<!--
		//		<attr name="our_lat" format="float">43.7443124</attr>
		//		<attr name="our_lat2" format="float">43.7443085</attr>
		//		<attr name="our_long" format="float">-79.2975829</attr>
		//		<attr name="our_long2" format="float">-79.2953942</attr>
		//		-->
		//		<attr name="our_zoom" format="float" translatable="false">17</attr>
		static let map_zoom = "11.8"
		static let our_addr = "24 Hancock Crescent, Scarborough, ON"
		static let our_bus = "Yuma Technical Inc."
		static let our_web = "yumatechnical.com"
		static let our_ph = "(647) 956-6145"
		static let our_email = "sales@yumatechnical.com"
		static let enweb = "http://yumatechnical.com/en/"
		static let qcweb = "http://yumatechnical.com/qc/"
		static let aboutweb = "http://yumatechnical.com/en/content/4-about-us?content_only=1"
		static let map_here = "We are here"
		//
		//		<!--<string name="qwerty">Qwerty</string>-->
		//
		static let title_activity_maps = "title_activity_maps"
		static let action_settings = "Settings"
		static let title_activity_tab_view = "TabView"
		static let section_format = "Hello World from section: %1$d"
		//		<!--general-->
		static let male = "male"
		static let female = "female"
		static let pieces = "pcs."
		static let kg = "kg"
		static let dismiss = "dismiss"
		static let load = "Loading"
		static let customer = "Customer"
		static let ords = "Orders"
		static let rusure = "Are you sure?"
		static let loc = "Location"
		static let copyright = "Copyright"
		static let Home = "Home"
		static let bhome = "Home Page"
		static let empty = "Empty"
		static let internet = "Internet"
		static let no_data = "Data unavailable"
		static let unableConnect = "Unable to access the website"// establish a connection
		static let no_local = "No local copy"
		static let no_connect = "No connection"
		static let noPrice = "Contact for price"
		static let invalid = "invalid"
		static let updating = "updating"
		static let updated = "updated"
		static let msVibrate = "30"
		static let msVibrateNo = "300"
		static let PleaseWait = "Please wait"
		static let tryCache = "Try Cache"
		static let next = "Next"
		static let proceed = "Proceed"
		static let complete = "Complete"
		static let map_big = "Expand map"
		static let APIpre = "http://yumatechnical.com"
		static let noRes = "Resource not found"
		static let date = "Date"
		static let status = "Status"
		static let plotMe = "Plot from my location"
		static let inv = "Invoice"
		static let details = "Details"
		static let choose = "-- please choose --"
		static let back = "back"
		static let err = "Error:"
		static let deld = "Deleted"
		static let notAct = "Not Active"
		static let or = "or"
		static let ok = "OK"
		static let tryAgain = "Try again"
		static let nickName = "nick name"
		//		<!--actions-->
		static let send = "Send"
		static let phoneAct = "Call"
		static let email = "Email"
		static let emailAct = "Email"
		static let reorder = "Reorder"
		static let edit = "Edit"
		static let delete = "Delete"
		static let show = "Show"
		static let hide = "Hide"
		static let retry = "Retry"
		static let cancel = "Cancel"
		static let retn = "Return"
		static let cont = "Continue"
		static let commit = "Commit"
		static let save = "Save"
		static let select = "Select"
		static let backaccount = "Back to your account"
		static let finish = "Finish"
		static let prev = "Previous"
		static let upd = "Update"
		//		<!--links-->
		static let login_link = "http://yumatechnical.com/en/login?back=my-account"
		static let createAccLink = "http://yumatechnical.com/en/login?create_account=1"
		static let forgotPWLink = "http://yumatechnical.com/en/password-recovery"
		static let logoutLink = "http://yumatechnical.com/en/?mylogout="
		static let searchLink = "http://yumatechnical.com/en/search?controller=search&amp;s="
		static let json_link = "http://yumatechnical.com/en/module/my_feeder/prodjson?"
		static let online_xml2json = "https://api.rss2json.com/v1/api.json?rss_url="
		static let linkPrinters = "id_category=12&amp;orderby=position&amp;orderway=asc"
		static let linkToners = "id_category=13&amp;orderby=position&amp;orderway=asc"
		static let linkLaptops = "id_category=14&amp;orderby=position&amp;orderway=asc"
		static let linkServices = "id_category=15&amp;orderby=position&amp;orderway=asc"
		//		<!--forms-->
		static let socialT = "Social title"
		static let mr = "Mr."
		static let mrs = "Mrs."
		static let fName = "First name"
		static let lName = "Last name"
		static let bDate = "Birthdate"
		static let bDatePH = "MM/DD/YYYY"
		static let bDateEx = "(E.g.: 05/31/1970)"
		static let optional = "Optional"
		static let offersFromPartners = "Receive offers from our partners"
		static let SignUpNewsletter = "Sign up for our newsletter"
		static let SignUpNewsletterMore = "You may unsubscribe at any moment. For that purpose, please find our contact info in the legal notice."
		static let custDataPriv = "Customer data privacy"
		static let custDataPrivMore = "The personal data you provide is used to answer queries, process orders or allow access to specific information. You have the right to modify and delete all the personal information found in the \(R.string.my_account) page."
		static let txtForgotPW = "Please enter the email address you used to register. You will receive a temporary link to reset your password."
		static let emailAddr = "Email Address"
		static let sendResetLink = "Send reset link"
//		static let noRemem = "Don't remember me"
		//		<!--search-->
		static let action_search = "search"
		static let searchResults = "Search results"
		static let sorry = "Sorry for the inconvenience."
		static let searchAgain = "Search again what you are looking for"
		static let search_hint = "Search"
		//		<!--login-->
		static let login = "Login"
		static let my_account = "My Account"
		static let txtPass = "Password"
		static let forgotPW = "Forgot your password?"
		static let accountMake = "No account? Create one here"
		static let submitLogin = "Sign in"
		static let checkEmail = "Check your email for the link to reset your password"
		static let Info = "Information"
		static let Addrs = "Addresses"
		static let OrdHist = "Order history"
		static let CreditSlips = "Credit slips"
		static let SignOut = "Sign out"
		static let Stay = "Stay logged in"
		static let notloggedin = "Not logged in"
		static let backLogin = "Back to login"
		static let alreadyAcc = "Already have an Account?"
		static let loginInstead = "Log in instead"
		static let createAcc = "Create an account"
		static let backYour = "Back to your account"
		static let OrderGuest = "Order as a guest"
		static let delTo = "Deliver to"
		static let invTo = "Invoice to"
		static let orderHistoryTop = "Here are the orders you've placed since your account was created."
		static let noOrderHist = "No past orders have been made."
		static let ordRef = "Order reference"
		static let placed = "placed"
		static let ordFoll = "Follow your order status (step-by-step)"
		static let delAddr = "Delivery address"
		static let invAddr = "Invoice address"
		static let creditSlipsTop = "Credit slips you have received after canceled orders."
		static let noCreditSlips = "You have not received any credit slips."
		static let wrong = "Incorrect Username / Password"
		static let acc = "Account"
		static let remember = "Remember Me"
		static let logAs = "Logged-in as"
		static let without = "Order without logging in"
		static let withoutMore = "ie. Forget delerivy address"
		//		<!--cart-->
		static let cart = "Cart"
		static let add2cart = "Add to cart"
		static let added = "Added"
		static let Total = "Total"
		static let contShop = "Continue shopping"
		static let checkOut = "Checkout"
		static let connAs = "Connected as"
		static let notYou = "Not you?"
		//		<!--product-->
		static let prod = "Product"
		static let prodImage = "Product Image"
		static let prodDesc = "Product Description"
		static let prodID = "Product ID number"
		static let prodPriceFloat = "Product Price as a number"
		static let prodName = "Product Name"
		static let prodPrice = "Product price"
		static let prodThumb = "Product Thumbnail"
		static let Qty = "Qty"
		static let Quant = "Quantity"
		static let unitP = "Unit price"
		static let subT = "Subtotal"
		static let shipAnd = "Shipping and handling"
		static let tax = "Tax"
		static let carr = "Carrier"
		static let weight = "Weight"
		static let shipCost = "Shipping cost"
		static let trackNo = "Tracking number"
		static let noBuy = "Cannot be purchased"
		static let Dims = "Dimensions (width x height x depth x weight)"
		static let Attrs = "Product Variations"
		static let txtProdMore = "Details"
		//		<!--address-->
		static let Addr = "Address"
		static let alias = "Alias"
		static let co = "Company"
		static let addr1 = "Address line1"
		static let addr2 = "Address line2"
		static let pcode = "Postcode"
		static let city = "City"
		static let state = "State"
		static let country = "Country"
		static let other = "other"
		static let ph = "Phone"
		static let ph_mob = "Mobile Phone"
		static let BillAddr = "Billing address is different"
		static let createAddr = "Create new address"
		//		<!--message-->
		static let msgs = "Messages"
		static let msgSucc = "Message successfully sent"
		static let addMsg = "Add a message"
		static let msgTop = "If you would like to add a comment about your order, please write it in the field below."
		static let plsChoose = "-- please choose --"
		//		<!--checkout-->
		static let Chkout = "Checkout"
		static let process = "process"
		static let s1 = "1. "
		static let chk1 = "Personal Information"
		static let ifSignOut = "If you sign out now, your cart will be emptied."
		static let s2 = "2. "
		static let chk2 = "Delivery Address"
		static let chk2Msg = "The selected address will be used both as your personal address (for the invoice) and as your delivery address."
		static let addAddr = "add new address"
		static let billAddrDiff = "Billing address differs from the shipping address"
		static let s3 = "3. "
		static let chk3 = "Shipping Method"
		static let regualarShip = "regular shipping"
		static let s4 = "4. "
		static let chk4 = "Payment Method"
		static let payByCard = "Pay by Credit or Debit card"
		static let payByChk = "Pay by check"
		static let payByCash = "Pay by cash"
		static let obligation = "Order with an obligation to pay"
		static let chkInstr = "Choose a %s, then press Next"
		//		<!--prestashop-->
		static let cookie_key = "DtMUx3asc8KUPENVAjmaWBNjZWQ8ONsInyIPeYevCnjManedCdobyVr8"
		static let secret = "dv0YPxjVdDNn6f2RFQ7IgX63BJa9gdpcqHwO4JcuchMQKUrgqTSQvmr6"
		static let cookie_iv = "2Yzmb84B"
		static let new_cookie_key = "def000000fbae20130bf310f0bf2c6535fe316f65c04b480ec8c93a37644fc158df2069ab09bb9b2cad6ece856a93b8d23c249ecdd09c62cbd44a8896004f58dcdb47f5a"
		static let WSbase = "http://yumatechnical.com/api/"
		static let APIkey = "UUXXLG3ZSDLFI86JC2USB919UHEQU7AP"
		static let API_key = "ws_key=UUXXLG3ZSDLFI86JC2USB919UHEQU7AP"
		static let URLbase = "http://yumatechnical.com/"
		//		<!--<string name="APIparams = "ws_key=UUXXLG3ZSDLFI86JC2USB919UHEQU7AP&amp;output_format=JSON</string>-->
		static let APIjson = "output_format=JSON"
		static let APIfull = "display=full"
		//		<!--help-->
		static let help = "Assistance"
		static let section_name = "section name"
		static let help2 = "All Guides"
		//		<!--orders-->
		static let order = "Order"
		static let ref = "reference"
		static let tPrice = "Total Price"
		static let payment = "Payment"

		fileprivate init() {}
	}
	
//	fileprivate struct intern: Rswift.Validatable {
//		fileprivate static func validate() throws {
//			try _R.validate()
//		}
//
//		fileprivate init() {}
//	}
	
	fileprivate class Class {}
	
	fileprivate init() {}
	
//	static func format_Address(_ address: Address) -> String
//	{
//		var formed = ""
//		if address.company != nil && address.company != ""
//		{
//			formed.append("\(address.company!)\n")
//		}
//		if address.firstname != nil && address.firstname != ""
//		{
//			formed.append("\(address.firstname) ")
//		}
//		if address.lastname != nil && address.lastname != ""
//		{
//			formed.append(address.lastname)
//		}
//		if address.firstname != nil && address.firstname != "" || address.lastname != nil && address.lastname != ""
//		{
//			formed.append("\n")
//		}
//		if address.address1 != ""
//		{
//			formed.append("\(address.address1)\n")
//		}
//		if address.address2 != nil && address.address2 != ""
//		{
//			formed.append("\(address.address2!)\n")
//		}
//		if address.city != nil && address.city != ""
//		{
//			formed.append("\(address.city)\n")
//		}
//		if address.postcode != nil && address.postcode != ""
//		{
//			formed.append(address.postcode!)
//		}
//		if address.id_state != nil && address.id_state != ""
//		{
//			formed.append(address.id_state!)
//		}
//		if address.postcode != nil && address.postcode != "" || address.id_state != nil && address.id_state != ""
//		{
//			formed.append("\n")
//		}
//		if address.id_country != nil && address.id_country != ""
//		{
//			formed.append("\(address.id_country)\n")
//		}
//		return formed
//	}

}


extension UIColor
{
	convenience init(hex: String, alpha: CGFloat = 1.0)
	{
		var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		
		if (cString.hasPrefix("#")) { 	cString.removeFirst() 	}
		
		if ((cString.count) != 6)
		{
			self.init(hex: "ff0000") // return red color for wrong hex input
			return
		}
		
		var rgbValue: UInt32 = 0
		Scanner(string: cString).scanHexInt32(&rgbValue)
		
		self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
				  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
				  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
				  alpha: alpha)
	}
}
