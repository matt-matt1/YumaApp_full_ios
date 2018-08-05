//
//  Character.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-08-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


extension Character
{
	//https://stackoverflow.com/questions/24102044/how-can-i-get-the-unicode-code-points-of-a-character
	/// eg. let char: Character = "A";  char.unicodeScalarCodePoint()
	func unicodeScalarCodePoint() -> UInt32
	{
		let characterString = String(self)
		let scalars = characterString.unicodeScalars
		
		return scalars[scalars.startIndex].value
	}
}
