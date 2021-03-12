//
//  ViewController.swift
//  ToDo_App_MVVM
//
//  Created by Олег Еременко on 21.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

final class MainVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public properties

    var viewModel: MainViewModel?
    
    // MARK: - Private properties
    
    private let tableViewSections = ["Active", "Completed"]
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    // MARK: - Private methods
    
    private func setupViewModel(){
        viewModel = MainViewModel.init()
        viewModel?.view = self
        viewModel?.loadItems()
    }
    
    // MARK: - IBActions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        viewModel?.addToDoItem()
    }
    
}

// MARK: - TableView DataSource and Delegate

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? viewModel?.activeItems().count ?? 0 : viewModel?.completedItems().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! ItemCell

        if let item = indexPath.section == 0 ? viewModel?.activeItems()[indexPath.row] : viewModel?.completedItems()[indexPath.row] {
            cell.itemNameLabel.text = item.itemName
            cell.accessoryType = item.done ? .checkmark : .none
            cell.tintColor = .yellow

            indexPath.section == 0 ? viewModel?.addGradient(cell: cell,
                                                            indexPath: indexPath,
                                                            color: .systemIndigo)
                                   : viewModel?.addGradient(cell: cell,
                                                            indexPath: indexPath,
                                                            color: .blue)
        } else {
            cell.itemNameLabel.text = "No tasks added yet"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if let itemForRemoval = indexPath.section == 0 ? viewModel?.activeItems()[indexPath.row] : viewModel?.completedItems()[indexPath.row] {
                viewModel?.delete(item: itemForRemoval)
            }
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let item = indexPath.section == 0 ? viewModel?.activeItems()[indexPath.row] :viewModel?.completedItems()[indexPath.row] else { return }
        viewModel?.changeItemStatus(item: item)
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return tableViewSections[0]
        case 1:
            return tableViewSections[1]
        default:
            return ""
        }
    }
}

