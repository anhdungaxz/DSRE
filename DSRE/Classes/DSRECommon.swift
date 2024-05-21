//
//  DSRECommon.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 29/4/24.
//

import Foundation

extension String {
    var dsreConvert0to84: String {
        
        if self == "" {
            
            return self
        }
        if self.count < 1 {
            
            return self
            
        }
        let firstIndex = self.index((self.startIndex), offsetBy: 1)
        let first = String(self[..<firstIndex])
        if first == "0" {
            let mob = String(String(describing: self.suffix(from: firstIndex)))
            return "84\(mob)"
        }
        return self
        
    }
}
