//
//  ListDetailViewController.swift
//  ToDoListApp
//
//  Created by Suruchi on 25/08/2015.
//
//

import UIKit

import CoreData


class ListDetailViewController: UIViewController,UITableViewDataSource , UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var myDatePicker: UIView!
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var datePickerAction: UIDatePicker!
    class ViewController: UIViewController {
        
        @IBOutlet weak var myDatePicker: UIDatePicker!
        
        
        @IBOutlet weak var selectedDate: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        @IBAction func datePickerAction(sender: AnyObject) {
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            var strDate = dateFormatter.stringFromDate(myDatePicker.date)
            self.selectedDate.text = strDate
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
    }
    

    

    var toBuyItem = [NSManagedObject]()
    var checked = [Bool]()

    
    @IBOutlet weak var detailCancle: UIBarButtonItem!
    
    @IBOutlet weak var detailTitle: UILabel!

    @IBOutlet var txtItem: UITextField!
    
    @IBOutlet var detailTableView: UITableView!
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerDataSource = ["White", "Red", "Green", "Blue"];

    
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

        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
    }
    
    //pickerView
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
        
    }

    @IBAction func addButton_Click(sender: AnyObject) {
        
        var detailName: String
        detailName = txtItem.text!
        
        //toByItm.addDetailItem(detailTitle.text!, detailItemName: txtItem.text!, detailItemCompleted: false)
        if detailName != "" {
        saveItem(detailName)
        txtItem.text = ""
        detailTableView.reloadData()
        }
        
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
        buyItem.setValue(false, forKey: "detailItemCompleted")
        
        
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
        
        
        if buyingItem.valueForKey("detailItemCompleted") as! Bool == false
            
        {
            
            cell.textLabel!.text = " " + cell.textLabel!.text!
            
        }
            
        else // check is true
            
        {
            
            cell.textLabel!.text = "\u{2705}" + cell.textLabel!.text!
        }
        

        
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
        
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle
    {
        
        return UITableViewCellEditingStyle.Insert
        
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
            let buyingItem = toBuyItem[indexPath.row]
            
            if buyingItem.valueForKey("detailItemCompleted") as! Bool == false
                
                
            
            //if cell.accessoryType == .Checkmark
            {
                cell.textLabel!.text =   "\u{2705}" + cell.textLabel!.text!

                buyingItem.setValue(true, forKey: "detailItemCompleted")
                print (buyingItem.valueForKey("detailItemCompleted"))
                //checked[indexPath.row - 1] = false
            }
            else
            {
                cell.accessoryType = .None
                buyingItem.setValue(false, forKey: "detailItemCompleted")
                print (buyingItem.valueForKey("detailItemCompleted"))
                
                
    
               // cell.accessoryType = .Checkmark
               // checked[indexPath.row - 1] = true
            }
            tableView.reloadData()
        }    
    }

 
    
    
    
    @IBAction func cancleDetailView(sender: UIBarButtonItem) {

        navigationController!.popViewControllerAnimated(true)
            print("cancel")
    }
        
}
