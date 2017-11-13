//
//  ViewController.swift
//  GeoCache
//
//  Created by Cortland Perry on 10/26/17.
//  Copyright © 2017 Cortland Perry. All rights reserved.
//

import UIKit

class NewCacheViewController: UIViewController {
    var cache_list: [GeoCache] = [GeoCache]();
    var list_location: Int = 0;
    var cache: GeoCache? = nil;

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    @IBOutlet weak var creatorField: UITextField!
    @IBOutlet weak var rewardField: UITextField!
    @IBOutlet weak var cacheLabel: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cacheLabel.isUserInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        cache = nil
        dismiss(animated: true, completion: nil)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            print("failed")
            return
        }
        
        if titleField.text! != "" && rewardField.text! != "" && creatorField.text! != "" && detailField.text! != "" {
            let fields: [String: String] = ["title": titleField.text!, "details":  detailField.text!, "creator": creatorField.text!, "reward": rewardField.text!]
            let loadedCache = GeoCache(fromDictionary:fields)
            cache = loadedCache
        }
        else {
            cacheLabel.text = "Error: One of your fields are empty. Cannot create a GeoCache"
        }
        
    }
    
 
}

