//
//  Cache+Yung.swift
//  Pods-YungCache_Example
//
//  Created by yung on 2020/12/17.
//

import Foundation

public extension Cache {
    func getObj<T:NSCoding>(forKey key: String) -> T? {
        guard let data = object(forKey: key.OCString) as? Data else { return nil }
        let obj = NSKeyedUnarchiver.unarchiveObject(with: data)
        return obj as? T
    }
    
    func getObj<T>(forKey key: String) -> T? {
        guard let data = object(forKey: key.OCString) as? Data else { return nil }
        let obj = NSKeyedUnarchiver.unarchiveObject(with: data)
        return obj as? T
    }

    func setObj<T:NSCoding>(_ obj: T, forKey key: String) {
        let obj = NSKeyedArchiver.archivedData(withRootObject: obj)
        setObject(obj as! ObjectType, forKey: key.OCString)
    }
    
    func setObj<T>(_ obj: T, forKey key: String) {
        let obj = NSKeyedArchiver.archivedData(withRootObject: obj)
        setObject(obj as! ObjectType, forKey: key.OCString)
    }
    
    func setObjs<T:NSCoding>(_ objs: [T], forKey key: String) {
        let obj = NSKeyedArchiver.archivedData(withRootObject: objs)
        setObject(obj as! ObjectType, forKey: key.OCString)
    }
    
    func setObjs<T:StringProtocol>(_ objs: [T], forKey key: String) {
        let obj = NSKeyedArchiver.archivedData(withRootObject: objs)
        setObject(obj as! ObjectType, forKey: key.OCString)
    }
}
