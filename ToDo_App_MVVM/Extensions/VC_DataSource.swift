//
//  VC_DataSource.swift
//  ToDo_App_MVVM
//
//  Created by Олег Еременко on 21.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.toDoItems?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! TableViewCell
        if let item = viewModel?.toDoItems?[indexPath.row] {
            cell.itemNameLabel.text = item.itemName
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.itemNameLabel.text = "No tasks added yet"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let itemForRemoval = viewModel?.toDoItems?[indexPath.row]{
                do {
                    try viewModel?.realm.write {
                        viewModel?.realm.delete(itemForRemoval)
                    }
                    
                } catch {
                    print("Error deleting item, \(error)")
                }
            }
            tableView.deleteRows(at: [indexPath], with: .left) //deleteRows дополнительно выполняет reloadData()
        }
    }
}
