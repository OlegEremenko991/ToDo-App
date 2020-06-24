//
//  ToDoViewModel.swift
//  ToDo_App_MVVM
//
//  Created by Олег Еременко on 21.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoViewModel {
    let realm = try! Realm()
    var toDoItems: Results<ToDoItem>?
    
    weak var view: ViewController?
    
// MARK: - Methods to load and save items
    func loadItems() {
        toDoItems = realm.objects(ToDoItem.self).sorted(byKeyPath: "itemName", ascending: true)
        view!.tableView.reloadData()
    }
    
    func saveToDoItem(toDoItem: ToDoItem) {
        try! realm.write {
            realm.add(toDoItem)
        }
        view!.tableView.reloadData()
    }
    
// MARK: - Pop-up alert
    
    func addToDoItem(){
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Save", style: .default) { action in
            let newItem = ToDoItem()
            newItem.itemName = textField.text!
            self.saveToDoItem(toDoItem: newItem)
        }
        alert.addAction(action)
        alert.addTextField { field in
            textField = field
            textField.placeholder = "Enter a new task"
        }
        view!.present(alert, animated: true)
    }
}
