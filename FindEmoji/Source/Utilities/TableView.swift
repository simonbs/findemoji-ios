//
//  TableView.swift
//  FindEmoji
//
//  Created by Simon Støvring on 20/05/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import UIKit

extension UITableView {
    
    func cellWithIdentifier<T: UITableViewCell>(style: UITableViewCellStyle = .Default, reuseIdentifier: String) -> T {
        return dequeueReusableCellWithIdentifier(reuseIdentifier) as? T ?? T(style: style, reuseIdentifier: reuseIdentifier)
    }
    
}

