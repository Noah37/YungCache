//
//  MemoryCache.swift
//  Pods-YungCache_Example
//
//  Created by yung on 2020/12/16.
//

import UIKit

public class MemoryCache<ObjectType>:CacheProtocol {
    
    private let storage = NSCache<KeyType, Container<ObjectType>>()
    
    public init(countLimit: Int, automaticallyRemoveAllObjects: Bool = false) {
        storage.countLimit = countLimit

        if automaticallyRemoveAllObjects {
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(storage, selector: #selector(type(of: storage).removeAllObjects), name: UIApplication.didEnterBackgroundNotification, object: nil)
            notificationCenter.addObserver(storage, selector: #selector(type(of: storage).removeAllObjects), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
        }
    }
    
    deinit {
        let notifications = NotificationCenter.default
        notifications.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        notifications.removeObserver(self, name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
        
    func contains(forKey key: NSString) -> Bool {
        let container = storage.object(forKey: key)
        let value = container.flatMap({ $0.value })
        return value != nil
    }
    
    func object(forKey key: KeyType) -> ObjectType? {
        let container = storage.object(forKey: key)
        let value = container.flatMap({ $0.value })
        return value
    }
    
    func setObject(_ obj: ObjectType, forKey key: KeyType) {
        storage.setObject(Container(obj), forKey: key)
    }

    func removeObject(forKey key: KeyType) {
        storage.removeObject(forKey: key)
    }

    func removeAllObjects() {
        storage.removeAllObjects()
    }
    
    subscript(key: KeyType) ->ObjectType? {
        get {
            return (storage.object(forKey: key))?.value
        }
        
        set(newValue) {
            if let newValue = newValue {
                storage.setObject(Container(newValue), forKey: key)
            } else {
                storage.removeObject(forKey: key)
            }
        }
    }

    var totalCostLimit: Int = 1000

    var countLimit: Int = 1000
    
    typealias KeyType = NSString
    
}
