//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Jozef Porubcin on 6/28/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
	
	@IBOutlet weak var usernameLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	static let height: CGFloat = 54
	
	@IBAction func optionsButtonTapped(_ sender: UIButton) {
		print("options button pressed")
	}
	
}
