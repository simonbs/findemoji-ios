//
//  RestaurantTableViewCell.swift
//  FindEmoji
//
//  Created by Simon Støvring on 20/08/2015.
//  Copyright © 2015 SimonBS. All rights reserved.
//

import UIKit
import Robolayout

class RestaurantTableViewCell: UITableViewCell {
    
    let eliteLabel = UILabel()
    let emojiLabel = UILabel()
    let nameLabel = UILabel()
    let addressLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        eliteLabel.font = .systemFontOfSize(36)
        eliteLabel.textAlignment = .Center
        eliteLabel.adjustsFontSizeToFitWidth = true
        eliteLabel.minimumScaleFactor = 0.50
        
        emojiLabel.font = .systemFontOfSize(36)
        emojiLabel.textAlignment = .Center
        emojiLabel.adjustsFontSizeToFitWidth = true
        emojiLabel.minimumScaleFactor = 0.50
        
        nameLabel.textColor = .findEmojiPrimaryColor()
        nameLabel.font = .boldSystemFontOfSize(18)
        nameLabel.numberOfLines = 0
        
        addressLabel.textColor = .findEmojiSecondaryColor()
        addressLabel.font = .systemFontOfSize(16)
        addressLabel.numberOfLines = 0
        addressLabel.adjustsFontSizeToFitWidth = true
        addressLabel.minimumScaleFactor = 0.80
        
        contentView.addSubview(eliteLabel)
        contentView.addSubview(emojiLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)

        eliteLabel.setLeadingToSuperview(constant: contentView.layoutMargins.left)
        eliteLabel.setCenterVerticallyInSuperview()
        eliteLabel.setTopToSuperview(relation: .GreaterThanOrEqual, constant: contentView.layoutMargins.top)
        eliteLabel.setBottomToSuperview(relation: .LessThanOrEqual, constant: -contentView.layoutMargins.bottom)
        eliteLabel.setWidthEqual(30)
        
        emojiLabel.setCenterVerticallyInSuperview()
        emojiLabel.setTopToSuperview(relation: .GreaterThanOrEqual, constant: contentView.layoutMargins.top)
        emojiLabel.setBottomToSuperview(relation: .LessThanOrEqual, constant: -contentView.layoutMargins.bottom)
        emojiLabel.setWidthEqual(30)
        contentView.constraint(emojiLabel, .Leading, .Equal, eliteLabel, .Trailing)
        
        nameLabel.setTopToSuperview(constant: contentView.layoutMargins.top)
        nameLabel.setTrailingToSuperview(relation: .LessThanOrEqual, constant: -contentView.layoutMargins.right)
        contentView.constraint(nameLabel, .Leading, .Equal, emojiLabel, .Trailing, constant: contentView.layoutMargins.left)
        
        addressLabel.setTrailingToSuperview(relation: .LessThanOrEqual, constant: -contentView.layoutMargins.right)
        contentView.constraint(addressLabel, .Top, .Equal, nameLabel, .Bottom)
        contentView.constraint(addressLabel, .Leading, .Equal, emojiLabel, .Trailing, constant: contentView.layoutMargins.left)
        
        addressLabel.setBottomToSuperview(constant: -contentView.layoutMargins.bottom)
        
        contentView.translatesAutoresizingMaskIntoConstraints = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}