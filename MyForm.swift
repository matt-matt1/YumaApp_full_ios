//
//  MyForm.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-14.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Eureka

class MyForm: FormViewController
{
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		form +++ Section("")
			<<< EmailRow()
			{
				row in
				row.title = R.string.emailAddr
				row.placeholder = "eg. myname@domain.com"
			}
			<<< PasswordRow()
			{
				row in
				row.title = R.string.txtPass
				row.placeholder = "min. 6 letters"
			}
	}
	
}


