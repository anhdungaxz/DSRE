//
//  DSRENetwork.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 20/04/2024.
//

import Foundation
import Alamofire

public class DSRENetwork {
    
    var apiKey: String?
    var clientID: String?
    
    class func post<T:Decodable>( url: String, parameters: [String: Any]?, header: [String: String]? = nil, completion:@escaping (AFDataResponse<T>) -> Void) {
        let param = parameters ?? ["": ""]
        let headerRequest = HTTPHeaders(header ?? [:])
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headerRequest)
            .validate(contentType: ["application/json; charset=utf-8"])
            .responseDecodable(of: T.self) { response in
                switch response.result{
                case .failure(let error):
                    print("DSRE URL_ERROR:\(url) - mes:\(error.localizedDescription)")
                    
                    break
                case .success(let value):
                    print("DSRE URL:\(url) - response: \(value)")
                    break
                }
                completion(response)
            }
    }
}
