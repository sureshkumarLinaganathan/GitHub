//
//  Extensions.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 27/10/21.
//  Copyright © 2020 SureshKumar. All rights reserved.
//

import UIKit

extension URLRequest {
    
    init(withurlString urlString : String, enableCache : Bool = false) {
        let url = URL.init(string: urlString)!
        self.init(url: url, cachePolicy: enableCache ? .returnCacheDataElseLoad : .useProtocolCachePolicy, timeoutInterval: 180.0)
    }
}

