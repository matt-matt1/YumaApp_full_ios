//
//  TableViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-28.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell
{
	@IBOutlet weak var cellView: UIView!
	@IBOutlet weak var cellQty: UITextField!
	@IBOutlet weak var cellLabel: UILabel!
	@IBOutlet weak var cellImage: UIImageView!
	
	var carts: Carts?
	var string: String?
	
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?)
	{
		super.init(style: style, reuseIdentifier: reuseIdentifier)
//		for row in (carts?.cart_rows)!
//		{
//			cellQty.text = row.quantity
//			cellLabel.text = row.id_product
//		}
//		cellLabel.text = string
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
	{
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
