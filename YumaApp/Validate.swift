//
//  Validate.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


enum ValidType
{
	/// A valid date, in YYYY-MM-DD format.
	case birthDate
	/// Must not contain invalid HTML tags, nor XSS.
	case cleanHtml
	/// A valid HTML/CSS color, in #xxxxxx format or text format.
	case color
	/// A valid e-mail address.
	case email
	/// A valid image size, between 0 and 9999.
	case imageSize
	/// A valid language code, in XX or XX-XX format.
	case languageCode
	/// A valid ISO language code, in XX or XXX format.
	case languageIsoCode
	/// A valid link rewrite (a to z, 0 to 9, -, _ allowed).
	case linkRewrite
	/// A valid MD5 string: 32 characters, mixing lowercase, uppercase and numerals.
	case md5
	/// A valid ISO code, in 00 or 000 format.
	case numericIsoCode
	/// A valid password, in. between 5 and 32 characters long.
	case passwd
	/// A valid password, between 8 and 32 characters long.
	case passwdAdmin
	/// A valid PHP date – in fact, a string without '<' nor '>'.
	case phpDateFormat
	/// A valid price display method, meaning the value be equals to constants PS_TAX_EXC or PS_TAX_INC.
	case priceDisplayMethod
	/// A valid product reference (must not contain any of: <>;=#{}).
	case reference
	/// A valid URL (no http:// or https://).
	case url
	/// A valid product or category name (must not contain any of: <>;=#{}).
	case catalogName
	/// A valid carrier name (must not contain any of: <>;=#{}).
	case carrierName
	/// A valid configuration key (a to z, 0 to 9, -, _ allowed).
	case configName
	/// A valid standard name (must not contain any of: <>;=#{}).
	case genericName
	/// A valid image type (a to z, 0 to 9, -, _ allowed).
	case imageTypeName
	/// A valid name (must not contain any of: digits or !<>,;?=+()@#\"{}_$%:).
	case name
	/// A valid template name (a to z, 0 to 9, -, _ allowed).
	case tplName
	/// A valid postal address (must not contain any of: !<>?=+@{}_$%).
	case address
	/// A valid city name (must not contain any of: !<>;?=+@#\"{}_$%).
	case cityName
	/// A valid latitude-longitude coordinates, in 00000.0000 form.
	case coordinate
	/// A valid message.
	case message
	/// A valid phone number (+, 0 to 9, .,  ,() allowed).
	case phoneNumber
	/// A valid postal code (a to z, 0 to 9,  , - allowed).
	case postCode
	/// A valid state ISO code (2 or 3: a to z, 0 to 9, optional - 1, 3 ... allowed).
	case stateIsoCode
	/// A valid zipcode format.
	case zipCodeFormat
	/// A valid absolute URL (http, https, ://, a to z, 0 to 9, -, more allowed).
	case absoluteUrl
	/// A valid DNI (Documento Nacional de Identidad) identifier. Specific to Spanish shops (a to z, 0 to 9, -, . allowed).
	case dniLite
	/// A valid barcode (EAN13 - 13 digits).
	case ean13
	/// A valid friendly URL (a to z, 0 to 9, -, _ allowed).
	case isLinkRewrite
	/// A valid price display method (either PS_TAX_EXC or PS_TAX_INC).
	case price
	/// A valid barcode (UPC - 12 digits).
	case upc
}


func isValidEmail(_ email: String) -> Bool
{
	var emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	emailRegEx += "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	emailRegEx += "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	emailRegEx += "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	emailRegEx += "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
	emailRegEx += "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
	emailRegEx += "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
	
	let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
	return emailTest.evaluate(with: email)
}


func isValid(_ type: ValidType, _ str: String) -> Bool
{
	var regEx = ""
	var optns: NSRegularExpression.Options = []
	switch type
	{
	case .birthDate:
		regEx = "^([0-9]{4})-((0?[1-9])|(1[0-2]))-((0?[1-9])|([1-2][0-9])|(3[01]))( [0-9]{2}:[0-9]{2}:[0-9]{2})?$"
		break
	case .cleanHtml:
		regEx = ""
		break
	case .color:
		regEx = "^(#[0-9a-fA-F]{6}|[a-zA-Z0-9-]*)$"
		break
	case .email:
		regEx = "^[a-z0-9!#$%&\\'*+\\/=?^`{}|~_-]+[.a-z0-9!#$%&\\'*+\\/=?^`{}|~_-]*@[a-z0-9]+[._a-z0-9-]*\\.[a-z0-9]+$"//"ui"
		optns = [NSRegularExpression.Options.caseInsensitive, NSRegularExpression.Options.allowCommentsAndWhitespace]
		break
	case .imageSize:
		regEx = "^[0-9]{1,4}$"
		break
	case .languageCode:
		regEx = "^[a-zA-Z]{2}(-[a-zA-Z]{2})?$"
		break
	case .languageIsoCode:
		regEx = "^[a-zA-Z]{2,3}$"
		break
	case .linkRewrite:
		regEx = "^[_a-zA-Z0-9-]+$"
		break
	case .md5:
		regEx = "^[a-f0-9A-F]{32}$"
		break
	case .numericIsoCode:
		regEx = "^[0-9]{2,3}$"
		break
	case .passwd:
		regEx = "^[.a-zA-Z_0-9-!@#$%\\^&*()]{5,32}$"
		break
	case .passwdAdmin:
		regEx = "^[.a-zA-Z_0-9-!@#$%\\^&*()]{8,32}$"
		break
	case .phpDateFormat:
		regEx = "^[^<>]+$"
		break
	case .priceDisplayMethod:
		regEx = ""
		break
	case .reference:
		regEx = "^[^<>;={}]*$"//"u"
		optns = [NSRegularExpression.Options.allowCommentsAndWhitespace]
		break
	case .url:
		regEx = "^[~:#,%&_=\\(\\)\\.\\? \\+\\-@\\/a-zA-Z0-9]+$"
		break
	case .catalogName:
		regEx = "^[^<>;=#{}]*$"//u
		break
	case .carrierName:
		regEx = "^[^<>;=#{}]*$"//u
		break
	case .configName:
		regEx = "^[a-zA-Z_0-9-]+$"
		break
	case .genericName:
		regEx = "^[^<>;=#{}]*$"//u
		break
	case .imageTypeName:
		regEx = "^[a-zA-Z0-9_ -]+$"
		break
	case .name:
		regEx = "^[^0-9!<>,;?=+()@#\"{}_$%:]*$"//u//°
		break
	case .tplName:
		regEx = "^[a-zA-Z0-9_-]+$"
		break
	case .address:
		regEx = "^[^!<>?=+@{}_$%]*$"//u
		break
	case .cityName:
		regEx = "^[^!<>;?=+@#\"{}_$%]*$"//u//°
		break
	case .coordinate:
		regEx = "^\\-?[0-9]{1,8}\\.[0-9]{1,8}$"//s
		break
	case .message:
		regEx = "[<>{}]"//i
		break
	case .phoneNumber:
		regEx = "^[+0-9. ()-]*$"
		break
	case .postCode:
		regEx = "^[a-zA-Z 0-9-]+$"
		break
	case .stateIsoCode:
		regEx = "^[a-zA-Z0-9]{2,3}((-)[a-zA-Z0-9]{1,3})?$"
		break
	case .zipCodeFormat:
		regEx = "^[NLCnlc -]+$"
		break
	case .absoluteUrl:
		regEx = "https?:\\/\\/[:#%&_=\\(\\)\\.\\? \\+\\-\\@\\/a-zA-Z0-9]+$"
		break
	case .dniLite:
		regEx = "^[0-9A-Za-z-.]{1,16}$"//U
		break
	case .ean13:
		regEx = "^[0-9]{0,13}$"
		break
	case .isLinkRewrite:
		regEx = "^[_a-zA-Z0-9-]+$"
		break
	case .price:
		break
	case .upc:
		regEx = "^[0-9]{0,12}$"
	}
	let test = try! NSRegularExpression(pattern: regEx, options: optns)
	return test.firstMatch(in: str, options: [], range: NSRange(location: 0, length: str.count)) != nil
//	let test = NSPredicate(format:"SELF MATCHES[c] %@", regEx)
//	return test.evaluate(with: str)
}
