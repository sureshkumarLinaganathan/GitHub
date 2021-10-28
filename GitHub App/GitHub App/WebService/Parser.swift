//
//  Parser.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 27/10/21.
//  Copyright © 2020 SureshKumar. All rights reserved.
//

import Foundation

class Parser{
    
    class func decode <T: Codable> (data: Any, type: T.Type) -> AnyObject{
        do{
            let jsonData = try JSONSerialization.data(withJSONObject:data , options: .prettyPrinted)
            let decodeObj  = try JSONDecoder().decode(type.self, from: jsonData)
            return decodeObj as AnyObject
        }catch {
            print(error.localizedDescription)
            return [] as AnyObject
        }
    }
    
}

    
