//
//  Box.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 27/10/21.
//  Copyright © 2020 SureshKumar. All rights reserved.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    deinit {
        listener = nil
    }
    
    
    
}
