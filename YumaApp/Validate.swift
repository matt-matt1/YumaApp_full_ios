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
	case email, birthDate, cleanHtml, color, imageSize, languageCode, languageIsoCode, linkRewrite, md5, numericIsoCode, passwd, passwdAdmin, phpDateFormat, priceDisplayMethod, reference, url, catalogName, carrierName, configName, genericName, imageTypeName, name, tplName, address, cityName, coordinate, message, phoneNumber, postCode, stateIsoCode, zipCodeFormat, absoluteUrl, dniLite, ean13, isLinkRewrite, price, upc
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
		/// A valid date, in YYYY-MM-DD format.
		regEx = "^([0-9]{4})-((0?[1-9])|(1[0-2]))-((0?[1-9])|([1-2][0-9])|(3[01]))( [0-9]{2}:[0-9]{2}:[0-9]{2})?$"
		break
	case .cleanHtml:
		/// Must not contain invalid HTML tags, nor XSS.
		regEx = ""
		break
	case .color:
		/// A valid HTML/CSS color, in #xxxxxx format or text format.
		regEx = "^(#[0-9a-fA-F]{6}|[a-zA-Z0-9-]*)$"
		break
	case .email:
		/// A valid e-mail address.
		regEx = "^[a-z0-9!#$%&\\'*+\\/=?^`{}|~_-]+[.a-z0-9!#$%&\\'*+\\/=?^`{}|~_-]*@[a-z0-9]+[._a-z0-9-]*\\.[a-z0-9]+$"//"ui"
		optns = [NSRegularExpression.Options.caseInsensitive, NSRegularExpression.Options.allowCommentsAndWhitespace]
		break
	case .imageSize:
		/// A valid image size, between 0 and 9999.
		regEx = "^[0-9]{1,4}$"
		break
	case .languageCode:
		/// A valid language code, in XX or XX-XX format.
		regEx = "^[a-zA-Z]{2}(-[a-zA-Z]{2})?$"
		break
	case .languageIsoCode:
		/// A valid ISO language code, in XX or XXX format.
		regEx = "^[a-zA-Z]{2,3}$"
		break
	case .linkRewrite:
		/// A valid link rewrite.
		regEx = "^[_a-zA-Z0-9-]+$"
		break
	case .md5:
		/// A valid MD5 string: 32 characters, mixing lowercase, uppercase and numerals.
		regEx = "^[a-f0-9A-F]{32}$"
		break
	case .numericIsoCode:
		/// A valid ISO code, in 00 or 000 format.
		regEx = "^[0-9]{2,3}$"
		break
	case .passwd:
		/// A valid password, in. between 5 and 32 characters long.
		regEx = "^[.a-zA-Z_0-9-!@#$%\\^&*()]{5,32}$"
		break
	case .passwdAdmin:
		/// A valid password, between 8 and 32 characters long.
		regEx = "^[.a-zA-Z_0-9-!@#$%\\^&*()]{8,32}$"
		break
	case .phpDateFormat:
		/// A valid PHP date – in fact, a string without '<' nor '>'.
		regEx = "^[^<>]+$"
		break
	case .priceDisplayMethod:
		/// A valid price display method, meaning the value be equals to constants PS_TAX_EXC or PS_TAX_INC.
		regEx = ""
		break
	case .reference:
		/// A valid product reference.
		regEx = "^[^<>;={}]*$"//"u"
		optns = [NSRegularExpression.Options.allowCommentsAndWhitespace]
		break
	case .url:
		/// A valid URL.
		regEx = "^[~:#,%&_=\\(\\)\\.\\? \\+\\-@\\/a-zA-Z0-9]+$"
		break
	case .catalogName:
		/// A valid product or category name.
		regEx = "^[^<>;=#{}]*$"//u
		break
	case .carrierName:
	/// A valid carrier name.
		regEx = "^[^<>;=#{}]*$"//u
		break
	case .configName:
	/// A valid configuration key.
		regEx = "^[a-zA-Z_0-9-]+$"
		break
	case .genericName:
	/// A valid standard name.
		regEx = "^[^<>;=#{}]*$"//u
		break
	case .imageTypeName:
	/// A valid image type.
		regEx = "^[a-zA-Z0-9_ -]+$"
		break
	case .name:
	/// A valid name.
		regEx = "^[^0-9!<>,;?=+()@#\"{}_$%:]*$"//u//°
		break
	case .tplName:
	/// A valid template name.
		regEx = "^[a-zA-Z0-9_-]+$"
		break
	case .address:
	/// A valid postal address.
		regEx = "^[^!<>?=+@{}_$%]*$"//u
		break
	case .cityName:
	/// A valid city name.
		regEx = "^[^!<>;?=+@#\"{}_$%]*$"//u//°
		break
	case .coordinate:
	/// A valid latitude-longitude coordinates, in 00000.0000 form.
		regEx = "^\\-?[0-9]{1,8}\\.[0-9]{1,8}$"//s
		break
	case .message:
	/// A valid message.
		regEx = "[<>{}]"//i
		break
	case .phoneNumber:
	/// A valid phone number.
		regEx = "^[+0-9. ()-]*$"
		break
	case .postCode:
	/// A valid postal code.
		regEx = "^[a-zA-Z 0-9-]+$"
		break
	case .stateIsoCode:
	/// A valid state ISO code.
		regEx = "^[a-zA-Z0-9]{2,3}((-)[a-zA-Z0-9]{1,3})?$"
		break
	case .zipCodeFormat:
	/// A valid zipcode format.
		regEx = "^[NLCnlc -]+$"
		break
	case .absoluteUrl:
	/// A valid absolute URL.
		regEx = "https?:\\/\\/[:#%&_=\\(\\)\\.\\? \\+\\-\\@\\/a-zA-Z0-9]+$"
		break
	case .dniLite:
	/// A valid DNI (Documento Nacional de Identidad) identifier. Specific to Spanish shops.
		regEx = "^[0-9A-Za-z-.]{1,16}$"//U
		break
	case .ean13:
	/// A valid barcode (EAN13).
		regEx = "^[0-9]{0,13}$"
		break
	case .isLinkRewrite:
	/// A valid friendly URL.
		regEx = "^[_a-zA-Z0-9-]+$"
		break
	case .price:
	/// A valid price display method (either PS_TAX_EXC or PS_TAX_INC).
		break
	case .upc:
	/// A valid barcode (UPC).
		regEx = "^[0-9]{0,12}$"
	}
	let test = try! NSRegularExpression(pattern: regEx, options: optns)
	return test.firstMatch(in: str, options: [], range: NSRange(location: 0, length: str.count)) != nil
//	let test = NSPredicate(format:"SELF MATCHES[c] %@", regEx)
//	return test.evaluate(with: str)
}
