//
//  VC_Delegate.swift
//  ToDo_App_MVVM
//
//  Created by Олег Еременко on 23.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = viewModel?.toDoItems?[indexPath.row]{
            do {
                try viewModel?.realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving task status, \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
