//
//  DSRENetwork.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 20/04/2024.
//

import Foundation
import Alamofire

public class DSRENetwork {
    
    class func post( url: String, parameters: [String: Any]?, header: [String: String]? = nil, completion:@escaping(([String: Any]?) -> ())) {
        var param = parameters ?? ["": ""]
        var headerRequest = HTTPHeaders(header ?? [:])
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headerRequest)
            .validate(contentType: ["application/json; charset=utf-8"])
            .responseJSON { response in
            print("JSON:\(response) - url:\(url) - param:\(String(describing: param.description))")
                switch response.result{
                    
                case .failure(let error):
                    print("URL_ERROR:\(url) - mes:\(error.localizedDescription)")
                    if !error.localizedDescription.lowercased().contains("đã huỷ") && !error.localizedDescription.lowercased().contains("cancel") && !error.localizedDescription.lowercased().contains("cancelled") {
                    }
                    completion(nil)
                    break
                case .success(let value):
                    print("JSON:\(value)")
                    if let data = value as? [String: Any] {
                        completion(data)
                        break
                    }
                    
                }
        }
    }
}
