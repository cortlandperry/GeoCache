//
//  TableViewController.swift
//  GeoCache
//
//  Created by Cortland Perry on 11/9/17.
//  Copyright © 2017 Cortland Perry. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var cache_list: [GeoCache] = [GeoCache]();
    var list_location: Int = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
       loadCachesFromServer(onComplete: { (caches_list_in) in
            self.cache_list = caches_list_in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
       })
        
        
        //print(cache_list.count)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cache_list.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.textLabel!.text = cache_list[indexPath.row].title
        return cell
    }
    
    @IBAction func unwindToTable(sender: UIStoryboardSegue) {
        let control: NewCacheViewController = sender.source as! NewCacheViewController
        // casting block
        if let cache = control.cache {
            print("reached")
            cache_list.append(cache)
            //saveCachesToDefaults(cache_list)
            sendCacheToServer(cache)
            let index = IndexPath(row: cache_list.count - 1, section: 0)
            tableView.insertRows(at: [index], with: .automatic)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toDetail" {
            if let dest = segue.destination as? DetailViewController {
                dest.desc = cache_list[((sender as? IndexPath)?.row)!].description;
            }
        }
        
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
