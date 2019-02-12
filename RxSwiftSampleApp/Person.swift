//
//  PersonAge.swift
//  RxSwiftSampleApp
//
//  Created by mac on 1/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import RxSwift
class Person {
    let name: String
    var isFavorite: Bool = false
    private let age = Variable<Int>(0)
    var ageObservable: Observable<Int>{
        return age.asObservable()
    }
    init(name: String, isfavorite: Bool) {
        self.isFavorite = isfavorite
        self.name = name
    }
    func update(_ age: Int) {
        self.age.value = age
    }
}
