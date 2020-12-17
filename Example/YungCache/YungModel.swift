//
//  YungModel.swift
//  YungCache_Example
//
//  Created by yung on 2020/12/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class YungModel: NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.age, forKey: "age")
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as? String
        self.age = coder.decodeInteger(forKey: "age")
    }
    
    init(age:Int, name:String?) {
        self.name = name
        self.age = age
    }
    
    var name:String?
    var age:Int

}
