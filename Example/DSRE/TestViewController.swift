//
//  TestViewController.swift
//  DSRE_Example
//
//  Created by Dũng Phạm Tiến  on 04/04/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import DSRE

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actionLogin(_ sender: Any) {
//        self.present(DSRE.share.getLoginController(delegate: self), animated: true)
//        DSREMasterApp
        DSRE.share.loginByMasterApp()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TestViewController: DSREDelegate {
    func didReceiveData(data: String) {
        
    }
    
    
}
