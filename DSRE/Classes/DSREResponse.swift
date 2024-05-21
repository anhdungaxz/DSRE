//
//  DSRE_CPModel.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 29/4/24.
//

import Foundation

public struct DSREResponse {
    public let code: Int
    
    public let message: String?

    public init(code: Int, message: String?) {
        self.code = code
        self.message = message
    }
}
