//
//  DSRE_CPModel.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 29/4/24.
//

import Foundation

class DSRE_BaseResponse: Decodable {
    var statusCode: Int?
    var message: String?
    var requestId: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case message
        case requestId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        requestId = try container.decodeIfPresent(String.self, forKey: .requestId)
    }
}
