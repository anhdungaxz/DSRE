//
//  DSRE.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 29/03/2024.
//

import Foundation


public class DSRE {
    public static let share = DSRE()
    
    private var apiKey: String?
    
    private var clientId: String?
    
    private var delegate: DSREDelegate?
    
    public func initialize(apiKey: String, clientId: String) {
        self.apiKey = apiKey
        self.clientId = clientId
    }
    
    public func getLoginController(delegate: DSREDelegate) -> UINavigationController {
        let navi = UINavigationController(rootViewController: LoginViewController(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self)))
        navi.isNavigationBarHidden = true
        navi.modalPresentationStyle = .fullScreen
        self.delegate = delegate
        return navi
    }
    
    public func loginByMasterApp() {
        
    }
    
}
