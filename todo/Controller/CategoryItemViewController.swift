//
//  CategoryTableViewController.swift
//  todo
//
//  Created by Mac on 2/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import CoreData

class CategoryItemViewController: UITableViewController {
    var categoris = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        
        override func viewDidLoad() {
            super.viewDidLoad()
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String )
            loadCategoris()
            
        }
        
        // MARK: - Table view data source
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categoris.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            let category = categoris[indexPath.row]
            cell.textLabel?.text = category.name
            return cell
        }
        

        // MARK: - Table view delegate
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let item  = items[indexPath.row]
//            item.checked = !item.checked
//            saveItem()
//            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            context.delete(categoris[indexPath.row])
            categoris.remove(at: indexPath.row)
            saveCategoris()
        }

        
        // MARK: - Action
        
        @IBAction func addButtonPressed(_ sender: Any) {
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New Category Item", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
                if let text = textField.text {
                    let newCatogry = Category(context: self.context)
                    newCatogry.name = text
                    self.categoris.append(newCatogry)
                    print("Success!")
                    self.saveCategoris()                }

            }
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        // MARK: - Custome Function
        
        func saveCategoris() {
            do {
                try context.save()
            } catch {
                print("Error in saving item : \(error)")
            }

            self.tableView.reloadData()
        }

        func loadCategoris(with request : NSFetchRequest<Category> = Category.fetchRequest()) {

            do {
                categoris = try context.fetch(request)
            } catch {
                print("Error in load item : \(error)")
            }

            self.tableView.reloadData()
        }


    }

    // MARK: - Extension

