//
//  ViewController.swift
//  YungCache
//
//  Created by Noah on 12/16/2020.
//  Copyright (c) 2020 Noah. All rights reserved.
//

import UIKit
import YungCache

class ViewController: UIViewController {
    @IBOutlet weak var setButton: UIButton!
    
    @IBOutlet weak var getButton: UIButton!
    
    @IBAction func setAction(_ sender: Any) {
        let model = YungModel(age: 10, name: "Yung")
        cache.setObjs([model], forKey: "YungModel")
    }
    
    @IBAction func getAction(_ sender: Any) {
        let obj:YungModel? = cache.getObj(forKey: "YungModel")
        print("name: \(String(describing: obj?.name))\n")
        print("age: \(String(describing: obj?.age))\n")
    }
    
    let cache = Cache<Data>(path: "Example")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

