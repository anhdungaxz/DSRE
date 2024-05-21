//
//  DSRE_CPModel.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 29/4/24.
//

import Foundation

public class DSRE_Authen: Codable {
    public var msisdn: String?
    public var token: String?
    
    enum CodingKeys: String, CodingKey {
        case msisdn
        case token
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        msisdn = try container.decodeIfPresent(String.self, forKey: .msisdn)
        token = try container.decodeIfPresent(String.self, forKey: .token)
    }
}
