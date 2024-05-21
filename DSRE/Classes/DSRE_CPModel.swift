//
//  DSRE_CPModel.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 29/4/24.
//

import Foundation

class DSRE_CPModel: Codable {
    var id: Int?
    var cp_name: String?
    var cp_code: String?
    var tax_code: String?
    var contract_code: String?
    var address: String?
    var represen_name: String?
    var id_number: String?
    var mobile: String?
    var status: Int?
    var create_time: String?
    var license_business: String?
    var email: String?
    var cp_icon: String?
    var redirectUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cp_name
        case cp_code
        case tax_code
        case contract_code
        case address
        case represen_name
        case id_number
        case mobile
        case status
        case create_time
        case license_business
        case email
        case cp_icon
        case redirectUrl
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        cp_name = try container.decodeIfPresent(String.self, forKey: .cp_name)
        cp_code = try container.decodeIfPresent(String.self, forKey: .cp_code)
        tax_code = try container.decodeIfPresent(String.self, forKey: .tax_code)
        contract_code = try container.decodeIfPresent(String.self, forKey: .contract_code)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        represen_name = try container.decodeIfPresent(String.self, forKey: .represen_name)
        id_number = try container.decodeIfPresent(String.self, forKey: .id_number)
        mobile = try container.decodeIfPresent(String.self, forKey: .mobile)
        status = try container.decodeIfPresent(Int.self, forKey: .status)
        create_time = try container.decodeIfPresent(String.self, forKey: .create_time)
        license_business = try container.decodeIfPresent(String.self, forKey: .license_business)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        cp_icon = try container.decodeIfPresent(String.self, forKey: .cp_icon)
        redirectUrl = try container.decodeIfPresent(String.self, forKey: .redirectUrl)
    }
}
