//
//  ViewController.swift
//  Todoey
//
//  Created by VenusLab on 8/15/19.
//  Copyright © 2019 Kwin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for n in 1...40 {
            let item  = Item()
            item.title = "Item \(n)"
            itemArray.append(item)
        }
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
        
        
    }
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){
            (action) in
            // What will happen once the user click the add button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
             self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField {
            (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion:  nil)
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        cell.textLabel?.text = item.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

