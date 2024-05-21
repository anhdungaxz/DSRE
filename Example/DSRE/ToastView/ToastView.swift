//
//  ToastView.swift
//  VinaSport
//
//  Created by Lê Ngọc Lâm on 02/18/21.
//  Copyright © 2021 Lê Ngọc Lâm. All rights reserved.
//
//

import UIKit
import SnapKit
import SwifterSwift

@objc enum EnumToastType: Int {
    case success = 0
    case warning = 1
    case error = 2
    case normal = 3
}

class ToastView: UIView, NibLoadable {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbText: UILabel!
    @IBOutlet weak var imgToast: UIImageView!
    @IBOutlet weak var vImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configToast(type: EnumToastType, message: String) {
        lbText.textColor = UIColor.white
        lbText.text = message
        switch type {
        case .success:
            vBackground.backgroundColor = UIColor(hexString: "6C995C")
            imgToast.image = UIImage(named: "ic_toast_success")
        case .warning:
            vBackground.backgroundColor = UIColor(hexString: "EAA628")
            imgToast.image = UIImage(named: "ic_toast_warning")
        case .error:
            vBackground.backgroundColor = UIColor(hexString: "B72827")
            imgToast.image = UIImage(named: "ic_toast_error")
        case .normal:
            vBackground.backgroundColor = UIColor(hexString: "595959")
            vImage.isHidden = true
        }
    }
}

extension ToastView {
    static func showToast(type: EnumToastType, message: String) {
        ToastView.removeToast()
        
        let view = ToastView.loadFromNib()
        
        view.configToast(type: type, message: message)
        
        AppDelegate.shared.window?.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let vToast = AppDelegate.shared.window?.subviews.first(where: {$0 === view})
            vToast?.removeFromSuperview()
        }
    }
    
    static func removeToast() {
        guard let subView = AppDelegate.shared.window?.subviews else { return }
        
        for view in subView {
            if let view = view as? ToastView {
                view.removeFromSuperview()
            }
        }
        
    }
}

extension AppDelegate {

    static var shared: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
}
