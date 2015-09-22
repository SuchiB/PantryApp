//
//  ListDetailViewController.swift
//  ToDoListApp
//
//  Created by Suruchi on 25/08/2015.
//  Copyright © 2015 Shiva Narrthine. All rights reserved.
//

import UIKit

class ListDetailViewController: UIViewController {
    
    @IBOutlet weak var detailCancle: UIBarButtonItem!
    
    @IBOutlet weak var detailTitle: UILabel!

    @IBOutlet var txtItem: UITextField!
    
    @IBOutlet var detailTableView: UITableView!
    var detailItem: ToDoItem? {
        didSet {
            // Update the view.
            //self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
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
        
        
        toByItm.addDetailItem(detailTitle.text!, detailItemName: txtItem.text!, detailItemCompleted: false)
        txtItem.text = ""
        detailTableView.reloadData()

        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return toByItm.buyingItems.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = toByItm.buyingItems[indexPath.row].detailItemName
        return cell
    }

    
    
    
    
    
    @IBAction func cancleDetailView(sender: UIBarButtonItem) {

        navigationController!.popViewControllerAnimated(true)
            print("cancel")
    }
        
}
