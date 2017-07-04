//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Jozef Porubcin on 6/28/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

protocol PostActionCellDelegate: class {
	func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}

class PostActionCell: UITableViewCell {
	
	weak var delegate: PostActionCellDelegate?
	
	@IBOutlet weak var likeButton: UIButton!
	@IBOutlet weak var likeCountLabel: UILabel!
	@IBOutlet weak var timeAgoLabel: UILabel!
	
	static let height: CGFloat = 46
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	@IBAction func likeButtonTapped(_ sender: UIButton) {
		delegate?.didTapLikeButton(sender, on: self)
	}
	
}
