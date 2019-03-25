//
//  Data.swift
//  Todoey
//
//  Created by Harold Adrian Bolanos Rodriguez on 19/03/24.
//  Copyright © 2019 E11EVENN. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
