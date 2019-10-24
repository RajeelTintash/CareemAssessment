//  
//  NetworkProtocol.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation
import UIKit

typealias FAILURE_BLOCK <T : Codable> = ((T?,String?)->())?
typealias SUCCESS_BLOCK <T : Codable> = ((T)->())?

protocol NetworkProtocol {}

extension NetworkProtocol {
    @discardableResult
    /// This makes request to server and returns data or error though success or failure blocks
    ///
    /// - Parameters:
    ///   - urlString: Url string
    ///   - httpMethod: HTTP request method
    ///   - params: Parameters to be added to request body
    ///   - success: Success block with decoded model returned from server
    ///   - failure: Failure block with string describing the reason
    /// - Returns: URL session data task
    func makeRequest<DATA_MODEL : Codable, ERROR_MODEL : Codable>( _ urlString     : String,
                                                                   _ httpMethod    : RequestType,
                                                                   _ headers       : [String:String]? = nil,
                                                                   _ params        : [String: String]?,
                                                                   success         : SUCCESS_BLOCK<DATA_MODEL>,
                                                                   failure         : FAILURE_BLOCK<ERROR_MODEL>) -> URLSessionDataTask? {
        
        guard InternetReachability.shared.isConnected else {
            apiFailure("Internet is not reachable.", block: failure)
            return nil
        }
        let (urlRequest, urlError) = getURLRequest(urlString, httpMethod, headers, params)
        guard let request = urlRequest else {
            apiFailure(urlError ?? "Failed to extract url from components.", block: failure)
            return nil
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let requestError = error {
                self.apiFailure(requestError.localizedDescription, block: failure)
            } else if let _data = data, let _response = response as? HTTPURLResponse {
                guard _response.statusCode == 200 else {
                    self.apiFailure("Invalid response. Code \(_response.statusCode)", block: failure)
                    return
                }
                self.decodeData(_data, success, failure)
            } else if let _response = response as? HTTPURLResponse, _response.statusCode != 200 {
                self.apiFailure("Invalid response. Code \(_response.statusCode)", block: failure)
            } else {
                self.apiFailure("Some unexpected error occured.", block: failure)
            }
        }
        task.resume()
        debugPrintRequest(request, httpMethod, urlString)
        return task
    }
}


extension NetworkProtocol {
    /// Decodes data to either data model or error model
    ///
    /// - Parameters:
    ///   - data: Data fetched from server
    ///   - success: block that takes decoded data model
    ///   - failure: failure block that takes decoded error model and/or error string
    func decodeData<DATA_MODEL : Codable, ERROR_MODEL : Codable>(_ data: Data,
                                                                 _ success : SUCCESS_BLOCK<DATA_MODEL>,
                                                                 _ failure : FAILURE_BLOCK<ERROR_MODEL>) {
        let decoder                 = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(Formatter.movieDbApiDateFormatter)
        if let errorModel = try? decoder.decode(ERROR_MODEL.self, from: data) {
            self.apiError(errorModel: errorModel, block: failure)
            return
        }
        do {
            let model = try decoder.decode(DATA_MODEL.self, from: data)
            success?(model)
        } catch (let decodeError) {
            self.apiFailure("Failed to decode Error: \(decodeError.localizedDescription)", block: failure)
        }
    }
    
    /// Returns description of error in string through failure block when api couldn't be hit or request wasn't created successfuly
    ///
    /// - Parameters:
    ///   - description: description of error
    ///   - errorModel: decoded error model
    ///   - block: error block that takes decoded error model or/and error string
    func apiFailure<ERROR_MODEL: Codable>(_ description: String, errorModel: ERROR_MODEL? = nil, block: FAILURE_BLOCK<ERROR_MODEL>) {
        block?(errorModel, description)
    }
    
    /// Retruns a decoded error model in failure block when api was hit and server returned an error model
    ///
    /// - Parameters:
    ///   - errorModel: error model returned by server
    ///   - block: failure block
    func apiError<ERROR_MODEL: Codable>(errorModel: ERROR_MODEL?, block: FAILURE_BLOCK<ERROR_MODEL>) {
        block?(errorModel, nil)
    }
}

// MARK: - Internal Classes
extension NetworkProtocol {
    /// Creates url request
    ///
    /// - Parameters:
    /// - urlString: Url string
    /// - httpMethod: HTTP request method
    /// - params: Parameters to be added to request body
    /// - Returns: A tuple (URLRequest?, optional error string)
    private func getURLRequest(_ urlString     : String,
                               _ httpMethod    : RequestType,
                               _ headers       : [String:String]? = nil,
                               _ params        : [String: String]?) -> (URLRequest?, String?) {
        guard var urlComponents = URLComponents(string: urlString) else {
            return(nil, "Failed to create url components.")
        }
        if let _params = params {
            var queryItems = [URLQueryItem]()
            for (key,value) in _params {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            urlComponents.queryItems = queryItems
        }
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = urlComponents.url else {
            return(nil, "Failed to extract url from components.")
        }
        var request         = URLRequest(url: url)
        request.httpMethod  = httpMethod.rawValue
        if let headerFields = getAllHeaders(headers) {
            for (key, value) in headerFields {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return (request, nil)
    }
    
    /// Prints curl of a request for debug purposes
    ///
    /// - Parameters:
    ///   - request: URL request
    ///   - method: http method
    ///   - urlString: url string
    func debugPrintRequest(_ request: URLRequest,_ method: RequestType,_ urlString: String) {
        print("********** SERVER REQUEST **********")
        print("\(method.rawValue) -> URL: \(urlString)")
        debugPrint(request)
        print("*************** END ***************")
    }
}


extension NetworkProtocol {
    /// Combines and returns custom and default headers
    ///
    /// - Parameter headers: custom headers
    /// - Returns: Combined custom and default headers
    func getAllHeaders(_ headers : [String:String]? = nil) -> [String:String]? {
        let finalHeaders = defaultHeaders()?.merging(headers ?? [:]) { $1 }
        return finalHeaders
    }
    
    /// Returns default headers for all network calls
    ///
    /// - Returns: Dictionary containing device and app's info
    private func defaultHeaders() -> [String:String]?{
        let (version, build) = appVersionAndBuildNo()
        let params = [
            "bundle_identifier" : Bundle.main.bundleIdentifier ?? "",
            "app_version"       : version,
            "build"             : build,
            "ios"               : UIDevice.current.systemVersion,
            "device"            : UIDevice.modelName,
            "uuid"              : UUID().uuidString
        ]
        return params
    }
    
    /// Returns a tuple containing app's build and version
    ///
    /// - Returns: tuple containing app's build and version
    fileprivate func appVersionAndBuildNo() -> (String,String) {
        guard let infoDict = Bundle.main.infoDictionary else { return ("","") }
        let version     = infoDict["CFBundleShortVersionString"] as? String ?? ""
        let build       = infoDict["CFBundleVersion"]            as? String ?? ""
        return (version,build)
    }
}
