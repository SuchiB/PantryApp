//
//  ListDetailViewController.swift
//  ToDoListApp
//
//  Created by Suruchi on 25/08/2015.
//  Copyright © 2015 Shiva Narrthine. All rights reserved.
//

import UIKit

class ListDetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailTitle: UILabel!

    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
