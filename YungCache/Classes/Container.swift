//
//  Container.swift
//  Pods-YungCache_Example
//
//  Created by daye on 2020/12/16.
//

import UIKit

final class Container<T> {
    let value:T
    init(_ value:T) {
        self.value = value
    }
}
