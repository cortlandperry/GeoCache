import UIKit
import Foundation

struct GeoCache {
    var title: String;
    var details: String;
    var creator: String;
    var reward: String;
    var id: Int;
    var image: UIImage?;
    
    init?(fromDictionary dict: [String: Any]) {
        let keys = Array(dict.keys)
        let prop_key = ["title", "details", "creator", "reward", "id"]
        let keySet = Set(keys)
        let propSet = Set(prop_key)

        if propSet.isSubset(of: keySet) {
            self.title = dict["title"] as! String
            self.details = dict["details"] as! String
            self.creator = dict["creator"] as! String
            self.reward = dict["reward"] as! String
            self.id = dict["id"] as! Int
            return;
            
        }
        return nil
    }
    
    var dictionary: [String: Any] {
        get {
            var hold_dict: [String: Any] = ["title": self.title];
            hold_dict["details"] = self.details
            hold_dict["creator"] = self.creator
            hold_dict["reward"] = self.reward
            hold_dict["id"] = self.id
            return hold_dict;
        }
    }
    
    var description: String {
        get {
            let des: String = "\(self.title) is located at \(self.details), and was created by \(self.creator). The reward for this is \(self.reward)"
            return des;
        }
    }
    
}

func loadCachesFromDefaults() -> [GeoCache]? {
    let defaults = UserDefaults.standard;
    
    if let array = defaults.array(forKey: "Cache") {
        var cache_array: [GeoCache] = [GeoCache]();
        for cache in array {
            
            cache_array.append(GeoCache(fromDictionary: cache as! [String: Any])!)
        }
        return cache_array;
    }
    return nil;
    
}

func saveCachesToDefaults(_ caches: [GeoCache]) {
    let defaults = UserDefaults.standard;
    var dict_form: [[String:Any]] = [[String:Any]]()
    for cache in caches {
        dict_form.append(cache.dictionary)
    }
    defaults.set(dict_form, forKey: "Cache")
    
}

func randomCacheId() -> Int {
    return Int(arc4random())
}

func sendCacheToServer(_ cache: GeoCache) {
    let target = URL(string: "http://localhost:5000/createCache")
    var request: URLRequest = URLRequest(url: target!)
    
    request.httpMethod = "POST"
    let data = try? JSONSerialization.data(withJSONObject: cache.dictionary)
    request.httpBody = data
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let task = URLSession.shared.dataTask(with: request, completionHandler: {
        data, response, error in
        if let error = error {
            print(error.localizedDescription ?? "Some kind of error")
            return
        }
        
        let jresponse = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String];
        if jresponse![0] == "Success" {
            sendImage(id: cache.id, image: cache.image!);
        }
    })
    task.resume()
    
}

func loadCachesFromServer(onComplete: @escaping ([GeoCache]) -> ()) {
    var cache_list = [GeoCache]()
    let target = URL(string: "http://localhost:5000/getCaches")
    var request: URLRequest = URLRequest(url: target!)
    request.httpMethod = "GET"
    
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: {
        data, response, error in
        if let error = error {
            print(error.localizedDescription ?? "Some kind of error")
            return
        }
        let jresponse = try? JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
        if let caches = jresponse as? [[String: Any]] {
            for item in caches {
                cache_list.append(GeoCache(fromDictionary: item)!)
            }
        }
        onComplete(cache_list)

        
        
    })
    task.resume()
    
}

func sendImage(id: Int, image: UIImage) {
    let target = URL(string: "http://localhost:5000/addPicture?id=<\(String(id))>");
    var request: URLRequest = URLRequest(url: target!)
    request.httpBody = UIImageJPEGRepresentation(image, 0.25);
    request.httpMethod = "POST"
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: {
        data, response, error in
        if let error = error {
            print(error.localizedDescription ?? "Some kind of error")
            return
        }
    })
    task.resume();
    
    
}

func pullImageFromServer(id: Int, number: Int, onComplete: @escaping (UIImage) -> ()) {
    let target = URL(string: "http://localhost:5000/getImage?id=<\(String(id))>&img=<\(String(number))>")
    var request: URLRequest = URLRequest(url: target!)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: {
        data, response, error in
        if let error = error {
            print(error.localizedDescription ?? "Some kind of error")
            return
        }
        
        let jresponse = JSONSerialization.jsonObject(with: data!, options: [])
        
        

        
        
        
        
    })
    task.resume()

    
    
}

var apple: GeoCache = GeoCache(fromDictionary: ["title": "hello", "details": "sup", "creator": "swag", "reward": "swag", "id": 12])!






