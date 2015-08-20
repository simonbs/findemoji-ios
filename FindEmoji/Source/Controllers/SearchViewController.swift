//
//  SearchViewController.swift
//  FindEmoji
//
//  Created by Simon Støvring on 20/08/2015.
//  Copyright © 2015 SimonBS. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    var searchView: SearchView {
        return view as! SearchView
    }
    
    private let restaurantsLoader = RestaurantsLoader()
    private let dataSource = SearchDataSource()
    
    override func loadView() {
        view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.textField.attributedPlaceholder = NSAttributedString(string: ~"SEARCH_PLACEHOLDER", attributes: [
            NSForegroundColorAttributeName: UIColor.findEmojiDetailColor()
        ])
        
        searchView.tableView.dataSource = dataSource
        searchView.tableView.delegate = self
        
        presentWelcome()
        
        searchView.textField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChanged", name: UITextFieldTextDidChangeNotification, object: searchView.textField)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    private func searchForQuery(query: String) {
        restaurantsLoader.search(query) { [weak self] results, error in
            dispatch_async(dispatch_get_main_queue()) {
                defer {
                    self?.searchView.tableView.reloadData()
                }
                
                if error != nil {
                    if error?.code != NSURLErrorCancelled {
                        self?.dataSource.restaurants = []
                        self?.searchView.messageLabel.text = ~"SEARCH_ERROR"
                        self?.searchView.messageLabel.hidden = false
                    } else {
                        self?.dataSource.restaurants = []
                        self?.searchView.tableView.reloadData()
                        self?.searchView.messageLabel.hidden = true
                    }
                    
                    return
                }
                
                if let results = results {
                    let hasResults = results.count > 0
                    self?.dataSource.restaurants = results
                    self?.searchView.messageLabel.hidden = hasResults
                    self?.searchView.messageLabel.text = !hasResults ? String(format: ~"SEARCH_NO_RESULTS", arguments: [ query ]) : nil
                    return
                }
            }
        }
    }
    
    private func presentWelcome() {
        dataSource.restaurants = []
        searchView.tableView.reloadData()
        searchView.messageLabel.text = ~"WELCOME"
        searchView.messageLabel.hidden = false
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = .findEmojiAlternateBackgroundColor()
        } else {
            cell.contentView.backgroundColor = .findEmojiBackgroundColor()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchView.textField {
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textChanged() {
        if let query = searchView.textField.text where query.characters.count > 0 {
            searchForQuery(query)
        } else {
            presentWelcome()
        }
    }
    
}

