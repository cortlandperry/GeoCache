
import Foundation

struct GeoCache {
    var title: String;
    var details: String;
    var creator: String;
    var reward: String;
    
    init?(fromDictionary dict: [String: String]) {
        let keys = Array(dict.keys)
        let prop_key = ["title", "details", "creator", "reward"]
        let keySet = Set(keys)
        let propSet = Set(prop_key)
        
        if propSet.isSubset(of: keySet) {
            self.title = dict["title"]!
            self.details = dict["details"]!
            self.creator = dict["creator"]!
            self.reward = dict["reward"]!
            return;
            
        }
        return nil
    }
    
    var dictionary: [String: String] {
        get {
            var hold_dict: [String: String] = ["title": self.title];
            hold_dict["details"] = self.details
            hold_dict["creator"] = self.creator
            hold_dict["reward"] = self.reward
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
            
            cache_array.append(GeoCache(fromDictionary: cache as! [String: String])!)
        }
        return cache_array;
    }
    return nil;
    
}

func saveCachesToDefaults(_ caches: [GeoCache]) {
    let defaults = UserDefaults.standard;
    var dict_form: [[String:String]] = [[String:String]]()
    for cache in caches {
        dict_form.append(cache.dictionary)
    }
    defaults.set(dict_form, forKey: "Cache")
    
}


var apple: GeoCache = GeoCache(fromDictionary: ["title": "hello", "details": "sup", "creator": "swag", "reward": "swag"])!






