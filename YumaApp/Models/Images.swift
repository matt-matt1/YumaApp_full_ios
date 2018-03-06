//
//  Images.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Images: Decodable
{
	let image_type: ImageType
}
struct ImageType: Decodable
{
	let general: 			ImageTypeDetails
	let products: 			ImageTypeDetails
	let categories: 		ImageTypeDetails
	let manufacturers: 		ImageTypeDetails
	let suppliers: 			ImageTypeDetails
	let stores: 			ImageTypeDetails
	let customizations: 	ImageTypeDetails
}
struct ImageTypeDetails: Decodable
{
	let get: 						String//Bool
	let put: 						String//Bool
	let post: 						String//Bool
	let delete: 					String//Bool
	let head: 						String//Bool
	let upload_allowed_mimetypes: 	String//image/gif, image/jpg, image/jpeg, image/pjpeg, image/png, image/x-png
}

struct ImagesTypes: Decodable
{
	let name: 			String//!
	let width: 			String//!
	let height: 		String//!
	let categories: 	String//Bool
	let products: 		String//Bool
	let manufacturers: 	String//Bool
	let suppliers: 		String//Bool
	let stores: 		String//Bool
}
