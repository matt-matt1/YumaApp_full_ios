//
//  Result.swift
//  ProtocolBasedNetworkingTutorialStarter
//
//  Created by Yuma Usa on 2018-03-18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import Foundation


enum Result<T, U> where U: Error
{
	case success(T)
	case failure(U)
}
