//
//  DiskCache.swift
//  Pods-YungCache_Example
//
//  Created by daye on 2020/12/16.
//

import UIKit

public class DiskCache<ObjectType>:CacheProtocol {
    
    func object(forKey key: KeyType) -> ObjectType? {
        return nil
    }

    func setObject(_ obj: ObjectType, forKey key: KeyType) {
        
    }

    func removeObject(forKey key: KeyType) {
        
    }

    func removeAllObjects() {
        
    }

    var totalCostLimit: Int = 1000

    var countLimit: Int = 1000
    
    typealias KeyType = NSString
}
