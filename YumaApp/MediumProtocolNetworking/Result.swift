//
//  Result.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


enum Result<T, U> where U: Error
{
	case success(T)
	case failure(U)
}
