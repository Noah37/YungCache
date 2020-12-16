//
//  Protocol.swift
//  Pods-YungCache_Example
//
//  Created by daye on 2020/12/16.
//

import Foundation

protocol CacheProtocol {
    
    associatedtype KeyType:AnyObject
    associatedtype ObjectType:Any
    
    func object(forKey key: KeyType) -> ObjectType?

    func setObject(_ obj: ObjectType, forKey key: KeyType) // 0 cost

    func removeObject(forKey key: KeyType)

    func removeAllObjects()

    var totalCostLimit: Int { get set } // limits are imprecise/not strict

    var countLimit: Int { get set } // limits are imprecise/not strict
}
