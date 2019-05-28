//
//  HomeViewController.swift
//  CountriesTask
//
//  Created by Marwan Ihab on 5/28/19.
//  Copyright © 2019 Marwan Ihab. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import Alamofire
import SwiftyJSON
import Foundation
import SVProgressHUD

class HomeViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource{
    
    var listOfCountries = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  listOfCountries.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = listOfCountries[indexPath.row]
        return(cell)
    }
    
    
   
    let url2 = "https://restcountries.eu/rest/v2/all"
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        SVProgressHUD.show()
        self.getCountries()
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
    }
    
    func getCountries() {
        
        Alamofire.request(url2).responseJSON { response in
            switch response.result {
            case .success:
            
                if let data = response.data{
                    self.sendJSONFILE(file:data)
                    
                }
            case .failure(let error):
                print(error)
            }
        
    }
    }
    
    func sendJSONFILE(file:Data)  {
        
         do{
                let json = try JSONSerialization.jsonObject(with: file, options: [])
                guard let jsonArray = json as? [[String: Any]] else {
                return
               }
               for dic in jsonArray{
                guard let title = dic["name"] as? String else { return }
                listOfCountries.append(title)
               }
            self.myTableView.reloadData()
            SVProgressHUD.dismiss()

         } catch{
            print("error")
        }
           
            }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
        do {
            try  Auth.auth().signOut()
            if (AccessToken.current != nil) {
                
                let fbLoginManager = LoginManager()
                fbLoginManager.logOut()
                
                
            }
            GIDSignIn.sharedInstance().signOut()
           
            navigationController?.popToRootViewController(animated: true)
        } catch  {
            print("Error in logging out")
        }
       

    }
    
    

}
