//
//  Extensions.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 24/11/21.
//

import UIKit

extension URLRequest {
    
    init(withurlString urlString : String, enableCache : Bool = false) {
        let url = URL.init(string: urlString)!
        self.init(url: url, cachePolicy: enableCache ? .returnCacheDataElseLoad : .useProtocolCachePolicy, timeoutInterval: 180.0)
    }
}

