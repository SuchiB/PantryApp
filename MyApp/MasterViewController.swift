//
//  MasterViewController.swift
//  PantryApp
//
//  Created by Suruchi on 27/08/2015.
//  Copyright © 2015 Shiva Narrthine. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    
    
    var toDoItems: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //code for persistant storage
        
//        if NSUserDefaults.standardUserDefaults().objectForKey("pantryList") != nil {
//            
//            toDoItems = NSUserDefaults.standardUserDefaults().objectForKey("pantryList") as! NSMutableArray
//            
//        }
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.navigationItem.setLeftBarButtonItem(nil, animated: true)
        //Load dummy data
        loadInitialData()
    }
    
    //Load initial dummy data
    func loadInitialData(){
        var item1 = ToDoItem(name:"Create New List")
        self.toDoItems.addObject(item1)
        item1 = ToDoItem(name: "Bunnings")
        self.toDoItems.addObject(item1)
        item1 = ToDoItem(name: "KMart")
        self.toDoItems.addObject(item1)
        item1 = ToDoItem(name: "Target")
        self.toDoItems.addObject(item1)
        item1 = ToDoItem(name: "Coles")
        self.toDoItems.addObject(item1)
        item1 = ToDoItem(name: "BigW")
        self.toDoItems.addObject(item1)
        item1 = ToDoItem(name: "Woolworth")
        self.toDoItems.addObject(item1)
        item1 = ToDoItem(name: "Morley Fresh")
        self.toDoItems.addObject(item1)
        item1 = ToDoItem(name: "HarveyNorman")
        self.toDoItems.addObject(item1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToList(segue:UIStoryboardSegue){
        
        let source: AddToDoViewController = segue.sourceViewController as! AddToDoViewController
        
        if let item: ToDoItem = source.toDoItem{
            self.toDoItems.addObject(item)
            self.tableView.reloadData()
        }
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.toDoItems.count
    }
    
    //Create a gradient color for the Table View Cell
    func tableCellColorForIndex(index: Int) -> UIColor {
        let itemCount = toDoItems.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        //NSUserDefaults.standardUserDefaults().setObject(self.toDoItems, forKey: "pantryList")
        
        // Configure the cell...
        
        let CellIndentifier: NSString!// = "ListPrototypeCell"
        
        //Applying different cell formates for first cell to show a create new List option
        if indexPath.row == 0 {
            
            CellIndentifier = "CreateNew"
            
        }else{
            
            CellIndentifier = "ListPrototypeCell"
            
        }
            
        
        let cell : UITableViewCell = (tableView.dequeueReusableCellWithIdentifier(CellIndentifier as String) as UITableViewCell!)
        
        let todoitem: ToDoItem = self.toDoItems.objectAtIndex(indexPath.row) as! ToDoItem
        
        cell.textLabel?.text = todoitem.itemName as String
        
        //set the colot to the Table View cell
        cell.backgroundColor = tableCellColorForIndex(indexPath.row)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let tappedItem: ToDoItem = self.toDoItems.objectAtIndex(indexPath.row) as! ToDoItem
        tappedItem.completed = !tappedItem.completed
        
        // NSLog(<#T##format: String##String#>, <#T##args: CVarArgType...##CVarArgType#>)
        tableView.reloadData()
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }*/
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            self.toDoItems.removeObjectAtIndex(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
                if let indexPath = self.tableView.indexPathForSelectedRow
                {
                    let object = self.toDoItems[indexPath.row]
                    let controller: ListDetailViewController = (segue.destinationViewController) as! ListDetailViewController
                    
                  // controller.detailItem = object as? ToDoItem
                  // controller.title = toDoItems[indexPath.row].itemName as String
                  
                }

    }
    

}
