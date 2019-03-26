//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Harold Adrian Bolanos Rodriguez on 19/03/24.
//  Copyright © 2019 E11EVENN. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {

    //MARK - Var Definition
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Categories.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)

        
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Category Added Yet"
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(categoryArray?[indexPath.row] ?? "Nothing Row Selected")
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
            
        }
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category){
        
        do {
//            try context.save()
            try realm.write {
                realm.add(category)
            }
        } catch{
            print("Error saving context, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories(){
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    //MARK: - Delete Categories
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDelection = self.categoryArray?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDelection)
                }
            }catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newCat = Category()
            newCat.name = textField.text!
            
            self.save(category: newCat)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    

}
