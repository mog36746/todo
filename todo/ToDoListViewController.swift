//
//  ViewController.swift
//  todo
//
//  Created by Mac on 1/26/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var items = ["First item", "Second Item", "Third Item"]
    
    let defaults = UserDefaults.standard
    let ITEM_KEY = "ITEM_KEY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String )
        if let data = defaults.array(forKey: ITEM_KEY) as? [String] {
            items = data
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Action
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = textField.text {
                self.items.append(text)
                print("Success!")
                self.defaults.set(self.items, forKey: self.ITEM_KEY)
                self.tableView.reloadData()
            }
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Custome Function




}

