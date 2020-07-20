//
//  ViewController.swift
//  ToDo_App_MVVM
//
//  Created by Олег Еременко on 21.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ToDoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ToDoViewModel.init()
        viewModel?.view = self
        viewModel?.loadItems()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        viewModel?.addToDoItem()
    }
}

