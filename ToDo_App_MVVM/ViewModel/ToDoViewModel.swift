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
    
    let blue = UIColor(hexString: "#3498db")
    let red = UIColor(hexString: "#e74c3c")
    let yellow = UIColor(hexString: "#f1c40f")
    
// MARK: - Adding gradient color to cells
    func addGradient(cell: TableViewCell, indexPath: IndexPath){
        let calculation = CGFloat(indexPath.row) / 25
        DispatchQueue.main.async {
            if let colour = UIColor.systemIndigo.darkened(amount: calculation) as? UIColor {
                cell.backgroundColor = colour
            }
        }
    }
    
// MARK: - Pop-up alert
    
    func addToDoItem(){
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
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
