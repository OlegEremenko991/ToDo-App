//
//  ToDoViewModel.swift
//  ToDo_App_MVVM
//
//  Created by Олег Еременко on 21.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit
import RealmSwift
import DynamicColor

class MainViewModel {
    let realm = try! Realm()
    var toDoItems: Results<ToDoItem>?
    
    weak var view: MainVC?
    
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
    
// MARK: Get an array of active items
    func activeItems() -> Results<ToDoItem> {
        toDoItems = realm.objects(ToDoItem.self).filter("done = false").sorted(byKeyPath: "itemName",ascending: true)
        return toDoItems!
    }
    
// MARK: Get an array of completed items
    func completedItems() -> Results<ToDoItem> {
        toDoItems = realm.objects(ToDoItem.self).filter("done = true").sorted(byKeyPath: "itemName", ascending: true)
        return toDoItems!
    }
    
    
// MARK: Adding gradient color to cells
    func addGradient(cell: TableViewCell, indexPath: IndexPath, color: UIColor){
        let calculation = CGFloat(indexPath.row) / 25
        if let colour = color.darkened(amount: calculation) as? UIColor {
            cell.backgroundColor = colour
        }
    }
// MARK: Change item status
    func changeItemStatus(item: ToDoItem){
        do {
            try realm.write {
                item.done = !item.done
            }
        } catch {
            print("Error saving task status, \(error)")
        }
    }

// MARK: Delete the item
    func delete(item: ToDoItem){
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Error deleting item, \(error)")
        }
    }
    
// MARK: - Pop-up alert
    
    func addToDoItem(){
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new task", message: "", preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "Save", style: .default) { action in
            let newItem = ToDoItem()
            newItem.itemName = textField.text!
            self.saveToDoItem(toDoItem: newItem)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive) { cancel in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelButton)
        alert.addAction(actionButton)
        alert.addTextField { field in
            textField = field
            textField.placeholder = "Enter a new task"
        }
        view!.present(alert, animated: true)
    }
}
