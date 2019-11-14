//
//  FirstViewController.swift
//  MyAccounts
//
//  Created by Jesús Calleja Rodríguez on 10/11/2019.
//  Copyright © 2019 Jesús Calleja Rodríguez. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    let people = ["Alex", "Javier", "Jessica"]
    var itemsInfo = Array<AccountItem>()
    
    @IBOutlet weak var allAccountsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allAccountsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        guard let path = Bundle.main.path(forResource: "accounts", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do{
            let data = try Data(contentsOf: url)
            
           if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if let accounts = json["accounts"] as? Array<Dictionary<String, Any>> {
                for account in accounts {
                    let accountItem = AccountItem(accountName: account["accountName"] as! String, iban: account["iban"] as! String, balance: account["accountBalanceInCents"] as! Int)
                    itemsInfo.append(accountItem)
                }
            }
       }
    } catch let err{
            print(err)
        }
    }
}

extension FirstViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! CollectionViewItem
        item.accountNameText.text = itemsInfo[indexPath.row].accountName
        item.ibanText.text = itemsInfo[indexPath.row].iban
        return item
    }
    
    
}
