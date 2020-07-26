//
//  RealmModel.swift
//  ToDo_App_MVVM
//
//  Created by Олег Еременко on 21.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    @objc dynamic var itemName = ""
    @objc dynamic var done: Bool = false
}
