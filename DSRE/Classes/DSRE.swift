//
//  DSRE.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 29/03/2024.
//

import Foundation
import Alamofire

public class DSRE {
    public static let share = DSRE()
    
    private var apiKey: String?
    
    private var clientId: String?
    
    private var delegate: DSREDelegate?
    
    public func initialize(apiKey: String, clientId: String) {
        self.apiKey = apiKey
        self.clientId = clientId
    }
    
    
    public func loginByMasterApp() {
        DSRENetwork.post(url: "google.com", parameters: nil) { response in
            
        }
    }
    
}
