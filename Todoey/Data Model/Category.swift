//
//  Category.swift
//  Todoey
//
//  Created by Harold Adrian Bolanos Rodriguez on 19/03/25.
//  Copyright © 2019 E11EVENN. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
