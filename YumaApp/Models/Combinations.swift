//
//  Combinations.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Combinations: Decodable
{
	//<combination><id_product required="true" format="isUnsignedId"/><location maxSize="64" format="isGenericName"/><ean13 maxSize="13" format="isEan13"/><isbn maxSize="32" format="isIsbn"/><upc maxSize="12" format="isUpc"/><quantity maxSize="10" format="isInt"/><reference maxSize="32"/><supplier_reference maxSize="32"/><wholesale_price maxSize="27" format="isPrice"/><price maxSize="20" format="isNegativePrice"/><ecotax maxSize="20" format="isPrice"/><weight format="isFloat"/><unit_price_impact maxSize="20" format="isNegativePrice"/><minimal_quantity required="true" format="isUnsignedId"/><default_on format="isBool"/><available_date format="isDateFormat"/><associations><product_option_values nodeType="product_option_value" api="product_option_values"><product_option_value><id/></product_option_value></product_option_values><images nodeType="image" api="images/products"><image><id/></image></images></associations></combination>
}
