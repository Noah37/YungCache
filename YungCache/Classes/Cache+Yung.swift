//
//  Cache+Yung.swift
//  Pods-YungCache_Example
//
//  Created by yung on 2020/12/17.
//

import Foundation

public extension Cache {
    func getObj<T:NSCoding>(forKey key: NSString) -> T? {
        guard let data = object(forKey: key) as? Data else { return nil }
        let obj = NSKeyedUnarchiver.unarchiveObject(with: data)
        return obj as? T
    }

    func setObj<T:NSCoding>(_ obj: T, forKey key: NSString) {
        let obj = NSKeyedArchiver.archivedData(withRootObject: obj)
        setObject(obj as! ObjectType, forKey: key)
    }
    
    func setObjs<T:NSCoding>(_ objs: [T], forKey key: NSString) {
        let obj = NSKeyedArchiver.archivedData(withRootObject: objs)
        setObject(obj as! ObjectType, forKey: key)
    }
}
