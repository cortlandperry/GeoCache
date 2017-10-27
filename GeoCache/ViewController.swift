//
//  ViewController.swift
//  GeoCache
//
//  Created by Cortland Perry on 10/26/17.
//  Copyright © 2017 Cortland Perry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cache_list: [GeoCache] = [GeoCache]();
    var list_location: Int = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var rewardField: UITextField!
    @IBOutlet weak var creatorField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    @IBOutlet weak var cacheLabel: UITextView!
    
    
    @IBAction func addGeoCache(_ sender: UIButton) {
        if titleField.text! == "" || rewardField.text! == "" || creatorField.text! == "" || detailField.text! == "" {
            cacheLabel.text = "Error: One of your fields are empty. Cannot create a GeoCache"
        }
        else {
            let fields: [String: String] = ["title": titleField.text!, "details": detailField.text!, "creator": creatorField.text!, "reward": rewardField.text!]
            cache_list.append(GeoCache(fromDictionary: fields)!)
            saveCachesToDefaults(cache_list)
            cacheLabel.text = GeoCache(fromDictionary: fields)!.description
        }
    }
    
    @IBAction func nextCache(_ sender: UIButton) {
        list_location += 1
        let array_spot = list_location % cache_list.count
        if let caches = loadCachesFromDefaults() {
            cache_list = caches;
            creatorField.text = cache_list[array_spot].creator
            rewardField.text = cache_list[array_spot].reward
            detailField.text = cache_list[array_spot].details
            titleField.text = cache_list[array_spot].title
            cacheLabel.text = cache_list[array_spot].description;
            

            
        }
    }
    
 
}

