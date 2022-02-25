//
//  API.swift
//  McLube
//
//  Created by Jorge Zamarrón on 11/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit
import Foundation
import SwiftHTTP

class API {
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    typealias JSONCompletion = JSON? -> Void
    
    init(url: NSURL) {
        //print(url.absoluteString)
        self.queryURL = url
    }
    
    class func apiURL() -> String {
        return MicroNic.getAPI()
    }
    
    func get(completion: JSONCompletion) {
        do {
            let opt = try HTTP.GET(queryURL.absoluteString)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                }
                let json = JSON(data: response.data)
                completion(json)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
    func post(parameters: [String: AnyObject], completion: JSONCompletion) {
        do {
            let opt = try HTTP.POST(queryURL.absoluteString, parameters: parameters)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                }
                let json = JSON(data: response.data)
                completion(json)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
}
