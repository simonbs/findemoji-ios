//
//  SearchView.swift
//  FindEmoji
//
//  Created by Simon Støvring on 20/08/2015.
//  Copyright © 2015 SimonBS. All rights reserved.
//

import UIKit
import Robolayout

class SearchView: UIView {
    
    let textField = UITextField()
    let tableView = UITableView()
    let messageLabel = UILabel()
    private let headerView = UIView()
    
    init() {
        super.init(frame: CGRectZero)
        
        backgroundColor = .findEmojiBackgroundColor()
        
        headerView.backgroundColor = .findEmojiSecondaryColor()
        
        let searchEmojiLabel = UILabel()
        searchEmojiLabel.font = .systemFontOfSize(28)
        searchEmojiLabel.text = "🔍"
        searchEmojiLabel.textAlignment = .Center
        searchEmojiLabel.adjustsFontSizeToFitWidth = true
        searchEmojiLabel.minimumScaleFactor = 0.50
        
        textField.font = .boldSystemFontOfSize(28)
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        textField.textColor = .findEmojiPrimaryColor()
        textField.tintColor = .findEmojiPrimaryColor()
        textField.returnKeyType = .Done
        textField.autocapitalizationType = .None
        textField.autocorrectionType = .No

        tableView.separatorStyle = .None
        tableView.backgroundColor = .clearColor()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.allowsSelection = false
        
        messageLabel.hidden = true
        messageLabel.textAlignment = .Center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .findEmojiSecondaryColor()
        messageLabel.font = .systemFontOfSize(19)
        
        headerView.addSubview(searchEmojiLabel)
        headerView.addSubview(textField)
        addSubview(headerView)
        addSubview(tableView)
        addSubview(messageLabel)
        
        headerView.setLeadingToSuperview()
        headerView.setTrailingToSuperview()
        headerView.setTopToSuperview()
        headerView.setHeightEqual(66)
        
        searchEmojiLabel.setLeadingToSuperview(constant: layoutMargins.left)
        searchEmojiLabel.setWidthEqual(30)
        constraint(searchEmojiLabel, .CenterY, .Equal, textField, .CenterY)
        
        textField.setTrailingToSuperview()
        textField.setTopToSuperview(constant: 20)
        textField.setBottomToSuperview()
        constraint(textField, .Leading, .Equal, searchEmojiLabel, .Trailing, constant: layoutMargins.left)
        
        constraint(tableView, .Top, .Equal, headerView, .Bottom)
        tableView.setLeadingToSuperview()
        tableView.setTrailingToSuperview()
        tableView.setBottomToSuperview()
        
        messageLabel.setCenterHorizontallyInSuperview()
        messageLabel.setLeadingToSuperview(relation: .GreaterThanOrEqual, constant: layoutMargins.left)
        messageLabel.setTrailingToSuperview(relation: .LessThanOrEqual, constant: -layoutMargins.right)
        constraint(messageLabel, .Top, .Equal, headerView, .Bottom, constant: layoutMargins.top)
        
        translatesAutoresizingMaskIntoConstraints = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}