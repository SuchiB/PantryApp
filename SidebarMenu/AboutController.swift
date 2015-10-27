//
//
//
//

import UIKit

class AboutController: UIViewController {
    // Declares buttons
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var linkButton: UIButton!
    
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
    
    // /When the user click the button open browsers and go to google
    @IBAction func linkToWeb(sender: AnyObject) {
                UIApplication.sharedApplication().openURL(NSURL(string: "http://www.google.com")!)
    }
}
