//
//  ViewController.swift
//  jsonExample
//
//  Created by SanzidAshan on 4/24/17.
//  Copyright © 2017 bcc. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UITableViewController {
    
    let pathToFile = Bundle.main.url(forResource: "simple", withExtension: "json")
    
    var foodArray = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

        
    }
    
        func loadData(){
    
            Alamofire.request(pathToFile!)
                .responseJSON(completionHandler: {
                    response in
                    self.parseData(data: response.data!)
                    self.tableView.reloadData()
                })
        }
    
    
        func parseData(data : Data ){
            
            do {
                
                // getting the data from json file
                let data = try Data(contentsOf: pathToFile!)
                
                // serializing the data in json Object
                let jsonRoot = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                // if the root is dictionary , then swift type would be [String : Int]
                // if the root is dictionary , then swift type would be [Array]
                print(jsonRoot!)
                let valueForMenu = jsonRoot?["menu"] as? [String: Any]
                //print(jsonObjectFromRoot!)
                
                foodArray = (valueForMenu?["food"] as? [ [String: String]])!
                
                print(foodArray)
            }
                
            catch{
                
                print(error)
            }

            
        }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FoodTableViewCell!
        
        let foodObj = foodArray[indexPath.row]
        
        
        //let FoodModelObj = FoodModel(food : foodObj)
            
            
            guard let name = foodObj["name"],
            let des = foodObj["description"],
            let price = foodObj["price"],
            let calories = foodObj["calories"]
            else {
            
                return cell!
        }
        
        
        
        
        

        
        cell?.nameLabel.text = name
        cell?.priceLabel.text = price
        cell?.descriptionLabel.text = des
        cell?.caloriesLabel.text = calories
        return cell!
    }
    


}

