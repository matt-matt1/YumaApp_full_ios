//
//  Array.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

extension R
{
	struct array
	{
		static let help_add_address_guide: [String] = [
			"Enter address details - an alias (nickname) is for easy reference",
			"Press \"\(R.string.country)\" to select a country from the searchable list in the pop-up window",
			"Optionally, press \"\(R.string.state)\" to select a state/province from the list in the pop-up window, if the selected country is separated as such",
			"\"\(R.string.co)\", \"\(R.string.taxNo)\", \"\(R.string.addr2)\", \"\(R.string.state)\", \"\(R.string.ph)\", \"\(R.string.ph_mob)\" and \"\(R.string.other)\" are optional",//	\"\(R.string)\"
			"TIP:  Enter your phone contact(s), so the couriers can notify the contact person, if required",
			"Press \"\(R.string.addAddr.uppercased())\" to save the information you entered"
		]
		
		static let help_checkout_guide: [String] = [
			"There are some simple steps to complete for the items in your cart to be dispatched:",
			"Each step number is contained in the bar near the top; also every step has a tick mark that will become bright when the step is completed",
			"TIP:  Press your name (if logged-in, on Step 1) to see your account details",
			"Instructions and options for each step is shown in the main panel",
			"The \"\(R.string.markComp.uppercased())\" button will advance you to the next step to be completed",
			"When all steps are complete the item(s) are ready to be dispatched"]
		
		static let help_contact_us_guide: [String] = [
			"This page details how you can contact us - phone, email and visit",
			"Press the \"\(R.string.phoneAct.uppercased())\" button to place our phone number into your dialer",
			"Press the \"\(R.string.email.uppercased())\" button and a popup window will ask you to select the destination; then it will create a new message and place the destination's email address as the To address",
			"A map will be displayed with a red pin at our location; your current location is marked with a blue dot that pulsates when en route",
			//			"If you have internet facilities, you can tap \"\(R.string.plotMe)\" and see a route to our local store",
			"TIP:  You can press \"\(R.string.plotMe)\", if you have internet facilities, and a route will be drawn between your location and our local store",
			"Press the \"\(R.string.map_big.uppercased())\" button, if you have internet facilities, to display a full-screen map with a pin at our location",
			"TIP:  The map can be zoomed using the slider at the bottom, or by pressing the plus and minus buttons"]
		
		static let help_home_page_guide: [String] = [
			"Welcome to our store!  This is the mobile interface for \(R.string.app_name)",
			"A small slide-show of our products/services is in the middle"/*, that can be pressed"*/,
			"Click a button (containing an icon and below a few words) to view that page"]
		
		static let help_forgot_pw_guide: [String] = [
			"Enter your email address (remember the '@' symbol) and press \"\(R.string.proceed.uppercased())\"",
			"If an account with that email address is found, a popup box will appear for setting a new password"
		]
		
		static let help_login_guide: [String] = [
			"If you have an account with the store, enter your email address (eg. sam@amce_inc.com) and your password, then press the \"\(R.string.login.uppercased())\" button",
			"Ensure the \"\(R.string.remember)\" switch is on to prevent the app from asking you to login next time, otherwise switch off to make the app prompt for login next time",
			"If you don't have an account with the store, press \"\(R.string.createAcc)\" to create a new account, fill-in the form and press \"\(R.string.createAcc)\"",
			"If you have an account, but have forgotten your password, press \"\(R.string.forgotPW)\" and enter your email address then press \"\(R.string.proceed.uppercased())\""
		]
		
		static let help_my_account_guide: [String] =
			[
				"Here are some details related to your account:",
				"Press \"\(R.string.Info.uppercased())\" to see your account details, like your profile",
				"Press \"\(R.string.Addrs.uppercased())\" to see each address, if any, related to your account",
				"Press \"\(R.string.OrdHist.uppercased())\" to see the orders, if any, made with this account",
				"Press \"\(R.string.CreditSlips.uppercased())\" to see the credit slips, if any, connected to this account",
				"Press \"\(R.string.SignOut)\" to have the app temporarily forget the logged-in user, remove your details for this session only;  thus the app will prompt for login next time.  The screen will change to the login screen",
				"Press \"\(R.string.delAcc)\" to have the app permanetly delete this account and forget the logged-in user;  WARNING: the details will be removed forever;  thus the app will never  be able to login this account again.  The screen will change to the login screen"
		]
		
		struct help_my_account_addresses_guide
		{
			static let wide: [String] = [
				"List the address(es) that belong to the account, if any",
				"TIP:  The left pane has a preview and can be swiped left or right (side-to-side) to view another address, if available;  At the same time, the address will appear in the right pane - separate line to easily edit",
				"Press \"\(R.string.country)\" to select a country from the searchable list in the pop-up window",
				"Optionally, press \"\(R.string.state)\" to select a state/province from the list in the pop-up window, if the selected country is separated as such",
				"Press the \"\(R.string.delete.uppercased())\" button to mark the address as deleted",
				"If you have edited the address, press the \"\(R.string.upd.uppercased())\" button to set the changes",
				"NOTE:  On a narrow device the preview pane & the edit fields will be displayed on separate screens and an \"\(R.string.edit.uppercased())\" button will show"
			]
			static let narrow: [String] = [
				"List the address(es) that belong to the account, if any",
				"Swipe left or right to view another address, if available",
				"If you press the \"\(R.string.edit.uppercased())\" button, another screen will show the address in separated lines to easily change",
				"Press \"\(R.string.country)\" to select a country from the searchable list in the pop-up window",
				"Optionally, press \"\(R.string.state)\" to select a state/province from the list in the pop-up window, if the selected country is separated as such",
				"Press the \"\(R.string.delete.uppercased())\" button to mark the address as deleted",
				"NOTE:  On a wide device both the swipe preview & the separated form will be displayed on the same screen"
			]
		}
		
		struct help_my_account_information_guide
		{
			static let loggedIn: [String] = [
				"The account profile details will be listed here",
				"It is required to fill-in \"\(R.string.fName)\", \"\(R.string.lName)\", \"\(R.string.emailAddr)\", a \"\(R.string.txtPass)\" (minimum 5 characters) and to accept the \"\(R.string.custDataPriv)\"",
				"\"\(R.string.bDate)\", \"\(R.string.co)\", \"\(R.string.website)\", \"\(R.string.siret)\", \"\(R.string.ape)\" along with \"\(R.string.offersFromPartners)\" and \"\(R.string.SignUpNewsletter)\" are optional",
				"Press \"\(R.string.bDate)\" to select a date from the list in the pop-up window",
				"NOTE:  Your email address cannot be changed;  but all other details can be changed",
				"Press \"\(R.string.txtPass)\" to change your password - a popup window will appear that will require that you enter your current password first",
			]
			static let newUser: [String] = [
				"A blank form will be shown for creating an account for a user",
				"It is required to fill-in \"\(R.string.fName)\", \"\(R.string.lName)\", \"\(R.string.emailAddr)\", a \"\(R.string.txtPass)\" (minimum 5 characters) and to accept the \"\(R.string.custDataPriv)\"",
				"\"\(R.string.bDate)\", \"\(R.string.co)\", \"\(R.string.website)\", \"\(R.string.siret)\", \"\(R.string.ape)\" along with \"\(R.string.offersFromPartners)\" and \"\(R.string.SignUpNewsletter)\" are optional",
				"Press \"\(R.string.bDate)\" to select a date from the list in the pop-up window",
				"NOTE:  Your email address cannot be changed;  but all other details can be changed",
				"Press \"\(R.string.generate)\" to issue a password of random characters - a popup window will appear to note the password",
				"When finished, press the \"\(R.string.createAcc.uppercased())\" button to set the changes",
			]
		}
		
		static let help_my_account_credit_slips_guide: [String] = [
			"Displays each credit slip, if any have been issued - available for redemsion (for products that have been returned)"
		]
		
		static let help_my_account_order_history_guide: [String] = [
			"Displays each order that has been made, if any",
			"Press \"\(R.string.details)\" to view more information",
			"Press \"\(R.string.reorder)\" to place the whole order again, if the store permits it"
		]
		
		static let help_order_details_guide: [String] = [
			"Here are the details of this order:",
			"Along with the order reference, date, carrier, payment method, status steps, addresses and messages, the item(s) and their quantities are itemized, with the shipping, tax and grand total",
			"Press \"\(R.string.reorder)\" to place the entire order again, if the store permits it",
			"To add a message, first select a product:  Press the \"\(R.string.prod)\" gray box to get a popup with a list of the products on this order (the first product is automattically selected);  press the \"\(R.string.msg)\" gray box and enter a message;  then press \"\(R.string.addMsg.uppercased())\"",
		]
		
		static let help_product_list_guide: [String] = [
			"Swipe left or right to view another product or service, if more",
			"TIP:  Each item in your cart (right side) has a small yellow circle in the top left corner that signifys the quantity for the order",
			"TIP:  If you double-tap (or double-click) on an item just it's picture will be displayed in a popup window along with it's name",
			"Press the \"\(R.string.add2cart.uppercased())\" button to place this item in your cart, if it is already in your cart, the quantity will just be increased",
			"TIP:  The \"\(R.string.checkOut.uppercased())\" button will only be bright when you have at least one item of value in the cart",
			"Press the cart icon, next to this help icon, to open an expanded view of your cart.  (Each item in in the shopping cart can also be clicked to open the expanded cart view)",
			"When finished, press the \"\(R.string.checkOut.uppercased())\" to finalize and pay"]
		
		static let help_cart_guide: [String] = [
			"Displays each item in your cart including, quantity, product name, thumbnail image, and if room, the unit price",
			"The total is placed at the bottom including the number of pieces, weight and price",
			"TIP:  The \"\(R.string.checkOut.uppercased())\" button will only be bright when you have at least one item of value in the cart",
			"If this list of items is longer than the screen, the list can be scrolled by swiping up or down",
			"Each item can be swiped to the left to reveal the \"\(R.string.delete)\" button, if pressed, the item, and all it's quantities, can then be removed from your cart",
			"TIP:  Press the \"+ / -\" buttons to increase / decrease the item quantity - if you decrease the quantity below 1, a window will appear asking to remove that item",
			"When the list is complete including the desired quantity for each item, press the \"\(R.string.checkOut.uppercased())\" to finalize and pay"]
		
		fileprivate init() {}
	}

}
