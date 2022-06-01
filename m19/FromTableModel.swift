//
//  FromTableModel.swift
//  m19
//
//  Created by Natalia Shevaldina on 13.05.2022.
//

import Foundation

struct FromTableModel: Codable {
    public var birth: Int?
    public var occupation: String?
    public var name: String?
    public var lastname: String?
    public var country: String?
    
    enum CodingKeys: String, CodingKey {
        case birth = "birth"
        case occupation = "occupation"
        case name = "name"
        case lastname = "lastname"
        case country = "country"
    }
    
    init(birth: Int, occupation: String, name: String, lastname: String, country: String) {
        self.birth = birth
        self.occupation = occupation
        self.name = name
        self.lastname = lastname
        self.country = country
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        birth = try value.decodeIfPresent(Int.self, forKey: .birth)
        occupation = try value.decodeIfPresent(String.self, forKey: .occupation)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        lastname = try value.decodeIfPresent(String.self, forKey: .lastname)
        country = try value.decodeIfPresent(String.self, forKey: .country)
    }
}


