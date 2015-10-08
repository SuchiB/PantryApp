//
//  ListDetailViewController.swift
//  ToDoListApp
//
//  Created by Suruchi on 25/08/2015.
//
//

import UIKit

import CoreData


class ListDetailViewController: UIViewController,UITableViewDataSource {
    
    var toBuyItem = [NSManagedObject]()

    
    @IBOutlet weak var detailCancle: UIBarButtonItem!
    
    @IBOutlet weak var detailTitle: UILabel!

    @IBOutlet var txtItem: UITextField!
    
    @IBOutlet var detailTableView: UITableView!
    
    var detailItem: ToDoItem? {
        didSet {
            // Update the view.
           // self.configureView()
        }
    }
    
    func configureView() {
        // Get the clicked item name from the ToDoItem view to this view.
        if let detail = self.detailItem {
            if let label = self.detailTitle {
                label.text = detail.itemName as String
               print(detail.itemName)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

        // Do any additional setup after loading the view.
        //detailTitle.text = "Shopping List"
    }
    
    @IBAction func addButton_Click(sender: AnyObject) {
        
        var detailName: String
        detailName = txtItem.text!
        
        //toByItm.addDetailItem(detailTitle.text!, detailItemName: txtItem.text!, detailItemCompleted: false)
        
        saveItem(detailName)
        txtItem.text = ""
        detailTableView.reloadData()

        
    }
    
    // Save data into database in local mobile phone
    
    func saveItem(detailItemName: String) {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        
        let entity =  NSEntityDescription.entityForName("ToBuyItem",
            inManagedObjectContext:
            managedContext)
        
        let buyItem = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        
        buyItem.setValue(detailItemName, forKey: "detailItemName")
        
        
        //var error: NSError?
        do{
            try managedContext.save()
        }catch{
            
            print("Could not save \(error)")
            
        }
        
        toBuyItem.append(buyItem)
    }
    
    func deletItem(detailItemName: String) {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        
        let entity =  NSEntityDescription.entityForName("ToBuyItem",
            inManagedObjectContext:
            managedContext)
        
        let buyItem = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        
        buyItem.setValue(detailItemName, forKey: "detailItemName")
        buyItem.removeObserver(detailItemName, forKeyPath: "detailItemName")
        
        //var error: NSError?
        do{
            try managedContext.save()
        }catch{
            
            print("Could not save \(error)")
            
        }
        
    }
    
    
    //Get data from database
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"ToBuyItem")
        
        //        //3
        //        var error: NSError?
        //
        //        let fetchedResults =
        //        managedContext.executeFetchRequest(fetchRequest,
        //            error: &error) as? [NSManagedObject]
        //
        //        if let results = fetchedResults {
        //            people = results
        //        } else {
        //            print("Could not fetch \(error), \(error!.userInfo)")
        //        }
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                toBuyItem = results
            } else {
                print("Could not find any results")
            }
        } catch {
            print("There was an error fetching data from people database")
        }
        
        
    }


    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       // return toByItm.buyingItems.count
        return toBuyItem.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let buyingItem = toBuyItem[indexPath.row]
        //cell.textLabel?.text = toByItm.buyingItems[indexPath.row].detailItemName
        cell.textLabel?.text = buyingItem.valueForKey("detailItemName") as? String
        return cell
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            context.deleteObject(toBuyItem[indexPath.row] as NSManagedObject)
            toBuyItem.removeAtIndex(indexPath.row)
            do{
                try context.save()
            }catch{
                
                print("Could not save \(error)")
                
            }
            
            //tableView.reloadData()
            // remove the deleted item from the `UITableView`
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
            
        }
    }
    
       
    
    
    @IBAction func cancleDetailView(sender: UIBarButtonItem) {

        navigationController!.popViewControllerAnimated(true)
            print("cancel")
    }
        
}
