//
//  DoAction.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class DoAction: NSObject {

	public func goto(dest: String) {
		perform(Selector(dest))
	}
}
