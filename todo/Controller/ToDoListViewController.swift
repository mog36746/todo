//
//  ViewController.swift
//  todo
//
//  Created by Mac on 1/26/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    var items = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let dataFIlePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String )
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(items[indexPath.row])
        items.remove(at: indexPath.row)
        saveItem()
    }

    
    // MARK: - Action
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = textField.text {
                let newItem = Item(context: self.context)
                newItem.title = text
                newItem.checked = false
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
        do {
            try context.save()
        } catch {
            print("Error in saving item : \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItem() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        
        do {
            items = try context.fetch(request)
        } catch {
            print("Error in load item : \(error)")
        }
        
        self.tableView.reloadData()
    }


}

