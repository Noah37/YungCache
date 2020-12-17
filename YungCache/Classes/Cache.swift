//
//  Cache.swift
//  Pods-YungCache_Example
//
//  Created by daye on 2020/12/16.
//

import Foundation

open class Cache<ObjectType>:CacheProtocol {
    
    let diskCache:DiskCache
    let memoryCache:MemoryCache<ObjectType>
    
    public init(path:String) {
        self.diskCache = DiskCache(path: path)
        self.memoryCache = MemoryCache(countLimit: 1000, automaticallyRemoveAllObjects: true)
    }
    
    public func contains(forKey key:NSString) -> Bool {
        if memoryCache.contains(forKey: key) {
            return true
        }
        return diskCache.contains(forKey: key)
    }
    
    public func object(forKey key: NSString) -> ObjectType? {
        let mObj = memoryCache.object(forKey: key)
        if mObj != nil {
            return mObj
        }
        return diskCache.object(forKey: key) as? ObjectType
    }

    public func setObject(_ obj: ObjectType, forKey key: NSString) {
        memoryCache.setObject(obj, forKey: key)
        diskCache.setObject(obj as! DiskCache.ObjectType, forKey: key)
    }

    public func removeObject(forKey key: NSString) {
        memoryCache.removeObject(forKey: key)
        diskCache.removeObject(forKey: key)
    }

    public func removeAllObjects() {
        memoryCache.removeAllObjects()
        diskCache.removeAllObjects()
    }
    
    var totalCostLimit: Int = 1000

    var countLimit: Int = 1000
    
    typealias KeyType = NSString
}
