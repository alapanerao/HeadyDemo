//
//  NetworkRequest.swift
//  HeadyDemo
//
//  Created by Alap Anerao on 23/05/20.
//  Copyright © 2020 Alap Anerao. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    associatedtype ModelTypeRanking
//    func decode(_ data: Data) -> (ModelType?, ModelTypeRanking?)
    func load(withCompletion completion: @escaping (ModelType?, ModelTypeRanking?) -> Void)
    func decodeCategory(_ data: Data) -> (ModelType?)
    func decodeRanking(_ data: Data) -> (ModelTypeRanking?)
}

extension NetworkRequest {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (ModelType?, ModelTypeRanking?) -> Void) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil, nil)
                return
            }
            completion(self?.decodeCategory(data), self?.decodeRanking(data))
        })
        task.resume()
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decodeCategory(_ data: Data) -> ([Resource.ModelType]?) {
        let wrapper = try? JSONDecoder().decode(Wrapper<Resource.ModelType, Resource.ModelTypeRanking>.self, from: data)
        return (wrapper?.categories)
    }
    
    func decodeRanking(_ data: Data) -> ([Resource.ModelTypeRanking]?) {
        let wrapper = try? JSONDecoder().decode(Wrapper<Resource.ModelType, Resource.ModelTypeRanking>.self, from: data)
        return (wrapper?.rankings)
    }
    
    func load(withCompletion completion: @escaping ([Resource.ModelType]?, [Resource.ModelTypeRanking]?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}

protocol APIResource {
    associatedtype ModelType: Decodable
    associatedtype ModelTypeRanking: Decodable
    var methodPath: String { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "https://stark-spire-93433.herokuapp.com")!
        components.path = methodPath
        return components.url!
    }
}

struct DataResource: APIResource {
    typealias ModelType = Category
    typealias ModelTypeRanking = Ranking
    let methodPath = "/json"
}
