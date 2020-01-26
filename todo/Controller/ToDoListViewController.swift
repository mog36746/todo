//
//  ViewController.swift
//  todo
//
//  Created by Mac on 1/26/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var items = [Item]()
    
    let defaults = UserDefaults.standard
    let ITEM_KEY = "ITEM_KEY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String )
//        if let data = defaults.array(forKey: ITEM_KEY) as? [String] {
//            items = data
//        }
        
        // Add item in items Array
        let newItem1 = Item()
        newItem1.title = "First item"
        items.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Second item"
        items.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Third item"
        items.append(newItem3)
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = items[indexPath.row]
        cell.accessoryType = item.checked ? .checkmark : .none
        cell.textLabel?.text = item.title
        return cell
    }
    

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item  = items[indexPath.row]
        item.checked = !item.checked
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Action
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = textField.text {
                let newItem = Item()
                newItem.title = text
                self.items.append(newItem)
                print("Success!")
                //self.defaults.set(self.items, forKey: self.ITEM_KEY)
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

