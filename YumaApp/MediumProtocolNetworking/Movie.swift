//
//  Movie.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Movie: Decodable {
	
	let title: String?
	let poster_path: String?
	let overview: String?
	let releaseDate: String?
	let backdrop_path: String?
	let release_date: String?
}
