//
//  SearchDataSource.swift
//  FindEmoji
//
//  Created by Simon Støvring on 20/08/2015.
//  Copyright © 2015 SimonBS. All rights reserved.
//

import UIKit

private let RestaurantCellIdentifier = "Restaurant"

class SearchDataSource: NSObject, UITableViewDataSource {
    
    var restaurants: [Restaurant] = []
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let restaurant = restaurants[indexPath.row]
        let cell = tableView.cellWithIdentifier(reuseIdentifier: RestaurantCellIdentifier) as RestaurantTableViewCell
        cell.eliteLabel.text = restaurant.eliteEmoji
        cell.emojiLabel.text = restaurant.emoji
        cell.nameLabel.text = restaurant.name
        cell.addressLabel.text = restaurant.displayAddress
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
}