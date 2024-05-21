//
//  OTPViewController.swift
//  DSRE_Example
//
//  Created by Dũng Phạm Tiến  on 5/5/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import DSRE

class OTPViewController: UIViewController {

    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var tfOtp: UITextField!
    @IBOutlet var lbOTP: [UILabel]!
    @IBOutlet weak var stackOTP: UIStackView!
    
    var otpId: String?
    var isLoginChild: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tfOtp.becomeFirstResponder()
    }
    func configUI() {
        btnConfirm.layer.cornerRadius = 12
        btnConfirm.clipsToBounds = true
        tfOtp.delegate = self
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(actionTapOtp))
        stackOTP.addGestureRecognizer(ges)

    }
    
    @objc func actionTapOtp() {
        tfOtp.becomeFirstResponder()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func tfinputDidChange(_ sender: Any) {
        let text = (tfOtp.text ?? "")
        for (index, label) in lbOTP.sorted(by: {$0.tag < $1.tag}).enumerated() {
            if index > text.count - 1 {
                label.text = ""
            } else {
                label.text = String(text[index])
            }
        }
    }
    
    @IBAction func actionConfirm(_ sender: Any) {
        DSRE.share.verifyOtp(otpId: otpId ?? "", otp: tfOtp.text ?? "") { responseCode, authen in
            if responseCode.code == 0 {
                AppDelegate.shared.loginPhone = authen?.msisdn
                let vc = HomeViewController()
                vc.loginPhone = authen?.msisdn
                vc.isloginChild = true
                self.navigationController?.pushViewController(vc)
                
            } else {
                ToastView.showToast(type: .error, message: responseCode.message ?? "")
            }
        }
    }
}

extension OTPViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if newString.count > 6 {
            return false
        }
        return true
    }
    
}
