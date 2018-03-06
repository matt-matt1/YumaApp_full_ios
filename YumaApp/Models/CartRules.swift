//
//  CartRules.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation

struct CartRules: Decodable
{
	//<cart_rule>
	//	<id_customer format="isUnsignedId"/>
	//	<date_from required="true" format="isDate"/>
	//	<date_to required="true" format="isDate"/>
	//	<description maxSize="65534" format="isCleanHtml"/>
	//	<quantity format="isUnsignedInt"/>
	//	<quantity_per_user format="isUnsignedInt"/>
	//	<priority format="isUnsignedInt"/>
	//	<partial_use format="isBool"/>
	//	<code maxSize="254" format="isCleanHtml"/>
	//	<minimum_amount format="isFloat"/>
	//	<minimum_amount_tax format="isBool"/>
	//	<minimum_amount_currency format="isInt"/>
	//	<minimum_amount_shipping format="isBool"/>
	//	<country_restriction format="isBool"/>
	//	<carrier_restriction format="isBool"/>
	//	<group_restriction format="isBool"/>
	//	<cart_rule_restriction format="isBool"/>
	//	<product_restriction format="isBool"/>
	//	<shop_restriction format="isBool"/>
	//	<free_shipping format="isBool"/>
	//	<reduction_percent format="isPercentage"/>
	//	<reduction_amount format="isFloat"/>
	//	<reduction_tax format="isBool"/>
	//	<reduction_currency format="isUnsignedId"/>
	//	<reduction_product format="isInt"/>
	//	<reduction_exclude_special format="isBool"/>
	//	<gift_product format="isUnsignedId"/>
	//	<gift_product_attribute format="isUnsignedId"/>
	//	<highlight format="isBool"/>
	//	<active format="isBool"/>
	//	<date_add format="isDate"/>
	//	<date_upd format="isDate"/>
	//	<name required="true" maxSize="254" format="isCleanHtml">
	//		<language id="1" xlink:href="http://yumatechnical.com/api/languages/1" format="isUnsignedId"/>
	//		<language id="2" xlink:href="http://yumatechnical.com/api/languages/2" format="isUnsignedId"/>
	//	</name>
	//</cart_rule>
}
