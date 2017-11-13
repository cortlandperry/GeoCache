//
//  DetailViewController.swift
//  GeoCache
//
//  Created by Cortland Perry on 11/12/17.
//  Copyright © 2017 Cortland Perry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var desc: String? = nil
    
    @IBOutlet weak var detailView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let details = desc {
            detailView.text = details
        }

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
