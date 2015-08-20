//
//  RestaurantsLoader.swift
//  FindEmoji
//
//  Created by Simon Støvring on 20/08/2015.
//  Copyright © 2015 SimonBS. All rights reserved.
//

import Foundation

struct Restaurant {
    
    enum SmileyStatus: Int {
        case None = 0
        case NoRemarks = 1
        case Warning = 2
        case Severe = 3
        case Critical = 4
    }
    
    let id: Int
    let name: String
    let street: String
    let houseNumber: Int
    let zipCode: String
    let city: String
    let hasEliteSmiley: Bool
    let status: SmileyStatus
    
    var emoji: String {
        switch status {
        case .NoRemarks:
            return "😃"
        case .Warning:
            return "😐"
        case .Severe:
           return "😡"
        case .Critical:
            return "💩"
        case .None:
            fallthrough
        default:
            return "❓"
        }
    }
    
    var eliteEmoji: String? {
        return hasEliteSmiley ? "⭐️" : nil
    }
    
    var displayAddress: String {
        return "\(street) \(houseNumber), \(zipCode) \(city)"
    }
}

class RestaurantsLoader {
    
    private var currentTask: NSURLSessionDataTask?
    
    func search(query: String, completion: ([Restaurant]?, NSError?) -> Void) {
        currentTask?.cancel()
        if let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet()) {
            if let url = NSURL(string: "http://smiley.menuindex.dk/api/smiley/search?pattern=\(encodedQuery)&pageNumber=1&pageSize=10") {
                let request = NSURLRequest(URL: url)
                currentTask = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                    if let error = error {
                        completion(nil, error)
                        return
                    }
                    
                    guard let data = data else {
                        completion(nil, nil)
                        return
                    }
                    
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [AnyObject] {
                            let mapped: [Restaurant] = json.mapIfNotNil({ e in
                                guard let info = e as? [String: AnyObject] else {
                                    return nil
                                }
                                
                                guard let id = info["Id"] as? Int else {
                                    return nil
                                }
                                
                                guard let adr = info["Address"] as? [String: AnyObject] else {
                                    return nil
                                }
                                
                                guard let name = info["Name"] as? String else {
                                    return nil
                                }
                                
                                guard let street = adr["Street"] as? String else {
                                    return nil
                                }
                                
                                guard let houseNumber = adr["HouseNumber"] as? Int else {
                                    return nil
                                }
                                
                                guard let zipCode = adr["ZipCode"] as? String else {
                                    return nil
                                }
                                
                                guard let city = adr["City"] as? String else {
                                    return nil
                                }
                                
                                guard let hasEliteSmiley = info["HasEliteSmiley"] as? Bool else {
                                    return nil
                                }
                                
                                guard let rawStatus = info["LatestStatus"] as? Int else {
                                    return nil
                                }
                                
                                guard let status = Restaurant.SmileyStatus(rawValue: rawStatus) else {
                                    return nil
                                }
                                
                                return Restaurant(id: id, name: name, street: street, houseNumber: houseNumber, zipCode: zipCode, city: city, hasEliteSmiley: hasEliteSmiley, status: status)
                            })
                            
                            completion(mapped, nil)
                        }
                    } catch {
                        completion(nil, nil)
                    }
                }
                currentTask?.resume()
            }
        }
    }
    
}

private extension Array {
    
    func mapIfNotNil<U>(f: Element -> U?) -> [U] {
        var results: [U] = []
        for e in self {
            if let g = f(e) {
                results.append(g)
            }
        }
        
        return results
    }
    
}