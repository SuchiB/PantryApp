//
//
//
//

import UIKit

class MainPageController: UITableViewController {
    
    @IBOutlet weak var menuButton:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        if self.revealViewController() != nil {
            
            
            menuButton.target = self.revealViewController()
            //Animation for when menu button is hit.
            menuButton.action = "revealToggle:"
            
            // Adds a pan Gesture recongizer the the page
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
    }
}
}