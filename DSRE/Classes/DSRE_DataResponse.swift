//
//  DSRE_CPModel.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 29/4/24.
//

import Foundation

class DSRE_DataResponse<T: Codable>: DSRE_BaseResponse {
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}
