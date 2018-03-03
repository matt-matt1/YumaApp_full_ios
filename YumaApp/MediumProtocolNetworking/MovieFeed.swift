//
//  MovieFeed.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


enum MovieFeed {
	case nowPlaying
	case topRated
}
extension MovieFeed: Endpoint {
	
	var base: String {
		return "https://api.themoviedb.org"
	}
	
	var path: String {
		switch self {
		case .nowPlaying: return "/3/movie/now_playing"
		case .topRated: return "/3/movie/top_rated"
		}
	}
}
