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
    
    let dataFIlePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String )
//        if let data = defaults.array(forKey: ITEM_KEY) as? [String] {
//            items = data
//        }
        
        loadItem()
        
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
        saveItem()
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
                self.saveItem()

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
    
    func saveItem() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(items)
            try data.write(to: dataFIlePath!)
        } catch {
            print("Error in saving item : \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItem() {
        if let data = try? Data(contentsOf: dataFIlePath!) {
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error in load item : \(error)")
            }
        }

        
        self.tableView.reloadData()
    }


}

