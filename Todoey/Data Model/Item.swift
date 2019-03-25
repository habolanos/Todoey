//
//  Item.swift
//  Todoey
//
//  Created by Harold Adrian Bolanos Rodriguez on 19/03/25.
//  Copyright © 2019 E11EVENN. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreate : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
