//
//  ViewController.swift
//  ToDo_App_MVVM
//
//  Created by Олег Еременко on 21.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModel?
    
    let tableViewSections = ["Active", "Completed"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        viewModel?.addToDoItem()
    }
    
    private func setupViewModel(){
        viewModel = MainViewModel.init()
        viewModel?.view = self
        viewModel?.loadItems()
    }
}

