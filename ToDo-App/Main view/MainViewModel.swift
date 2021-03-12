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

final class MainViewModel {
    
    // MARK: - Public properties
    
    weak var view: MainVC?
    
    // MARK: - Private properties

    private let realm = try! Realm()
    private var toDoItems: Results<ToDoItem>?
    
    // MARK: - Public methods

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
    
    /// Get an array of active items
    func activeItems() -> Results<ToDoItem> {
        realm.objects(ToDoItem.self).filter("done = false").sorted(byKeyPath: "itemName",ascending: true)
    }
    
    /// Get an array of completed items
    func completedItems() -> Results<ToDoItem> {
        realm.objects(ToDoItem.self).filter("done = true").sorted(byKeyPath: "itemName", ascending: true)
    }
    
    /// Add gradient color to cells
    func addGradient(cell: ItemCell, indexPath: IndexPath, color: UIColor){
        let calculation = CGFloat(indexPath.row) / 25
        let desiredColor = color.darkened(amount: calculation)
        cell.backgroundColor = desiredColor
    }

    func changeItemStatus(item: ToDoItem){
        do {
            try realm.write {
                item.done = !item.done
            }
        } catch {
            print("Error saving task status, \(error)")
        }
    }

    func delete(item: ToDoItem){
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Error deleting item, \(error)")
        }
    }
    
    /// Pop-up alert
    func addToDoItem(){
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new task", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let newItem = ToDoItem()
            newItem.itemName = textField.text!
            self.saveToDoItem(toDoItem: newItem)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive) { cancel in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelButton)
        alert.addAction(saveAction)
        alert.addTextField { field in
            textField = field
            textField.placeholder = "Enter a title"
        }
        view!.present(alert, animated: true)
    }
}
