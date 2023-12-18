//
//  DictionaryExtension.swift
//  PruebaTecnia
//
//  Created by rnieves on 18/12/23.
//

import Foundation

extension Dictionary {

    mutating func merge(dict: [Key: Value]) -> Dictionary {
        for (keyMerge, valueMerge) in dict {
            updateValue(valueMerge, forKey: keyMerge)
        }
        return self
    }

}
