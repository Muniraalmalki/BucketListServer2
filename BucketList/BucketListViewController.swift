//
//  BucketListViewController.swift
//  BucketList
//
//  Created by munira almallki on 06/03/1443 AH.
//

import UIKit
import CoreData
import Alamofire

class BucketListViewController: UITableViewController , AddItemTableViewControllerDelegate {
var items = [AddTask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchAllItems()
        // Do any additional setup after loading the view.
    }
    
    // create item to core data
        func addItem(text: String){
            
            let item = AddTask(objective: text)
            
            TaskModel.createTask(parameters: item) { error in
                if let error = error {
                    print("Error:\(error.localizedDescription)")
                    // show user an error
                }
            }
            
            
            items.append(item)
            self.tableView.reloadData()
            
            
            
        }
    // read item from core data
        func fetchAllItems(){
            TaskModel.getAllTask { taskModel, error in
                if let error = error{
                    print(error.localizedDescription)
                   
                }
                if let task = taskModel {
                    DispatchQueue.main.async {
                        self.items = task
                        self.tableView.reloadData()
                    }
                }
            }
            

        }

  

    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].objective
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
           performSegue(withIdentifier: "oneSegue", sender: indexPath)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        delateItem(path: indexPath.row)
        
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let sender = sender as? UIBarButtonItem {
                let navigationController = segue.destination as! UINavigationController
                let controller = navigationController.topViewController as! AddItemTableViewController
                controller.delegate = self
            }
        else if let sender = sender as? NSIndexPath{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemTableViewController
            controller.delegate = self
            
            let item = items[sender.row]
            controller.item = item.objective
            controller.indexPath = sender
        }
       
        }
    
   
    
    
    
    
    func saveButtonPressed(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath{
          // updateItem(text:text,path:ip.row)
            
         }else {
          addItem(text: text)
         }
       
         tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}

