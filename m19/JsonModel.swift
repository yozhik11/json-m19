//
//  JsonModel.swift
//  m19
//
//  Created by Natalia Shevaldina on 12.05.2022.
//

import Foundation

struct JsonModel: Codable {
    public var birth: Int?
    public var occupation: String?
    public var name: String?
    public var lastname: String?
    public var country: String?
    
    init(birth: Int, occupation: String, name: String, lastname: String, country: String) {
        self.birth = birth
        self.occupation = occupation
        self.name = name
        self.lastname = lastname
        self.country = country
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.birth, forKey: "birth")
        dictionary.setValue(self.occupation, forKey: "occupation")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.lastname, forKey: "lastname")
        dictionary.setValue(self.country, forKey: "country")
        
        return dictionary
    }
}


