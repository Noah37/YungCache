//
//  DiskCache.swift
//  Pods-YungCache_Example
//
//  Created by daye on 2020/12/16.
//

import UIKit

public class DiskCache:CacheProtocol {
    
    public lazy var cachePath:String = {
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        return documentPath
    }()
    
    public lazy var cacheQueue:DispatchQueue = {
        let label = Bundle.main.bundleIdentifier ?? "com" + "." + self.path.OCString.lastPathComponent
        let queue = DispatchQueue(label: label, qos: DispatchQoS.userInitiated, attributes: [])
        return queue
    }()
    
    public let path:String
    
    public init(path:String) {
        self.path = path
    }
    
    static let shared:DiskCache = DiskCache(path: "YungCache")
    
    func contains(forKey key: NSString) -> Bool {
        var contains = false
        cacheQueue.sync {
            let path = pathFor(key: key as String)
            let manager = FileManager.default
            if manager.fileExists(atPath: path) {
                contains = true
            }
        }
        return contains
    }
    
    func object(forKey key: KeyType) -> ObjectType? {
        var obj:ObjectType?
        cacheQueue.sync {
            let path = pathFor(key: key as String)
            obj = self._cachedFile(at: path)
        }
        return obj
    }

    func setObject(_ obj: ObjectType, forKey key: KeyType) {
        cacheQueue.async {
            let path = self.pathFor(key: key as String)
            self._cacheFile(file: obj, at: path)
        }
    }

    func removeObject(forKey key: KeyType) {
        cacheQueue.async {
            let path = self.pathFor(key: key as String)
            let manager = FileManager.default
            let url = URL(fileURLWithPath: path)
            if manager.fileExists(atPath: path) {
                try? manager.removeItem(at: url)
            }
        }
    }

    func removeAllObjects() {
        let documentPath = cachePath
        let manager = FileManager.default
        cacheQueue.async {
            let contents = try! manager.contentsOfDirectory(atPath: documentPath)
            for content in contents {
                let path = documentPath.OCString.appendingPathComponent(content)
                if manager.fileExists(atPath: path) {
                    try? manager.removeItem(atPath: path)
                }
            }
        }
    }
    
    private func _cachedFile(at path:String) ->ObjectType? {
        let manager = FileManager.default
        if manager.fileExists(atPath: path) {
            let data = manager.contents(atPath: path)
            return data
        }
        return nil
    }
    
    private func _cacheFile(file data:Data, at path:String) {
        let url = URL(fileURLWithPath: path)
        let filePath = path.OCString.deletingLastPathComponent
        let manager = FileManager.default
        let isDirectory = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
        if !manager.fileExists(atPath: filePath, isDirectory: isDirectory) {
            try? manager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        }
        try? data.write(to: url, options: Data.WritingOptions.atomicWrite)
    }
    
    private func pathFor(key:String) ->String {
        let fileName = key.md5()
        var filePath = cachePath
        if path.count > 0 {
            filePath = filePath.OCString.appendingPathComponent(path)
        }
        if fileName.count > 0 {
            filePath = filePath.OCString.appendingPathComponent(fileName)
        }
        let fileExtension = key.OCString.pathExtension
        if fileExtension.count > 0 {
            return filePath.OCString.appendingPathExtension(fileExtension) ?? filePath
        }
        return filePath
    }

    var totalCostLimit: Int = 1000

    var countLimit: Int = 1000
    
    typealias KeyType = NSString
    typealias ObjectType = Data
}
