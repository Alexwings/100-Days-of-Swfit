//
//  AuthWebService.swift
//  StickySectionAndJumper
//
//  Created by Xinyuan Wang on 11/19/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import Foundation

class WebService: NSObject {
    
    static let typeName: String = String(describing: WebService.self)
    enum TaskType {
        case data, download
    }
    enum URLRequestType: String {
        case get = "GET"
        case post = "POST"
    }
    
    //MARK: Class method
    
    static func request(for url: URL?, method: WebService.URLRequestType, params: [String: String]? = nil, boday: [String: String]) -> URLRequest? {
        guard let url = url else { return nil }
        var req = URLRequest(url: url)
    }
    //MARK: Public methods
    var taskType: WebService.TaskType = .data
    var sessionConfig: URLSessionConfiguration?
    //MARK: Private methods
    private let queue: OperationQueue
    
    private lazy var session: URLSession = {
        let config = self.sessionConfig ?? URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: self, delegateQueue: queue)
    }()
    //MARK: initializations
    override init() {
        queue = OperationQueue()
        queue.name = WebService.typeName
        super.init()
    }
    
    convenience init(type: WebService.TaskType) {
        self.init()
        self.taskType = type
    }
    
}

extension WebService: URLSessionTaskDelegate {
    
}

extension WebService: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
    }
}
