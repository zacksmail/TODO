//
//  ViewController.swift
//  TODO
//
//  Created by StrifeClaude on 2019/4/27.
//  Copyright © 2019 StrifeClaude. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    var itemArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]
        {
            itemArray = items
        }
    }
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField:UITextField!
        
        let alert = UIAlertController(title:"添加一个新的ToDo项目", message: "", preferredStyle: .alert)
        
        let canncel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        let action = UIAlertAction(title: "添加项目", style: .default){(action) in
            
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField{(alertTextField) in
            
            alertTextField.placeholder = "创建一个新项目"
            
            textField = alertTextField
        }
        
        alert.addAction(canncel)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
}

