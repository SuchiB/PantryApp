//
//  TableViewController.swift
//  MyApp
//
//  Created by Shiva Narrthine on 6/6/14.
//  Copyright (c) 2014 Shiva Narrthine. All rights reserved.
//

import UIKit



@objc(ToDoListTableViewController) class ToDoListTableViewController: UITableViewController {
    
    var detailViewController: ListDetailViewController? = nil

    @IBAction func unwindToList(segue:UIStoryboardSegue){
        let source: AddToDoViewController = segue.sourceViewController as! AddToDoViewController
        if let item: ToDoItem = source.toDoItem{
            self.toDoItems.addObject(item)
            self.tableView.reloadData()
        }
    }
    
    var toDoItems: NSMutableArray = []
   
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ListDetailViewController
        }

        loadInitialData()
    }
    
    func loadInitialData(){
        let item1 = ToDoItem(name:"Coles")
        self.toDoItems.addObject(item1)
        let item2 = ToDoItem(name: "Bunnings")
        self.toDoItems.addObject(item2)
        let item3 = ToDoItem(name: "KMart")
        self.toDoItems.addObject(item3)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIndentifier: NSString = "ListPrototypeCell"
        
        let cell : UITableViewCell = (tableView.dequeueReusableCellWithIdentifier(CellIndentifier as String) as UITableViewCell!)
        
        let todoitem: ToDoItem = self.toDoItems.objectAtIndex(indexPath.row) as! ToDoItem
        
        cell.textLabel?.text = todoitem.itemName as String
        
//        if todoitem.completed{
//            
//            cell.accessoryType = .Checkmark
//            
//        }
//            
//        else{
//            
//            cell.accessoryType = .None
//            
//        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
       // let tappedItem: ToDoItem = self.toDoItems.objectAtIndex(indexPath.row) as! ToDoItem
        //tappedItem.completed = !tappedItem.completed
       // NSLog(<#T##format: String##String#>, <#T##args: CVarArgType...##CVarArgType#>)
        tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.toDoItems.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}









