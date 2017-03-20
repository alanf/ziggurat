//
//  HTTPRepository.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/5/15.
//  Copyright 2015 Square, Inc.
//

import Foundation

/// An extremely stripped down version of a class used to perform network requests.
/// Included to illustrate how I/O details are wrapped in a separate "Repository" object.
class HTTPRepository {
    
    let session: URLSession
    
    init(session:URLSession) {
        self.session = session
    }
    
    /// Used to fetch data from the network.
    /// A more interesting approach in Swift is to use a `Result` type for completion / error handling (http://nomothetis.svbtle.com/error-handling-in-swift)
    func executeRequest(_ request: URLRequest, completion: @escaping (Data?) -> ()) -> URLSessionDataTask {
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion(data)
        }) 
        task.resume()
        return task
    }
}
