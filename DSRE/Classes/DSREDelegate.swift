//
//  DSREDelegate.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 02/04/2024.
//

import UIKit

public protocol DSREDelegate: AnyObject {
    func didReceiveData(data: String)
}
