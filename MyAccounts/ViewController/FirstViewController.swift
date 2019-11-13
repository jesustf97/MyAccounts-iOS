//
//  FirstViewController.swift
//  MyAccounts
//
//  Created by Jesús Calleja Rodríguez on 10/11/2019.
//  Copyright © 2019 Jesús Calleja Rodríguez. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    let people = ["Alex", "Javier", "Jessica","a", "b", "c", "d", "e", "f", "g"]
    
    @IBOutlet weak var allAccountsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allAccountsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        guard let path = Bundle.main.path(forResource: "accounts", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do{
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let array = json as? [Any] else { return }
            
            for account in array{
                guard let accountDict = account as? [String: Any] else { return }
                guard let accountName = accountDict["accountName"] as? String else{return}
                   guard let iban = accountDict["iban"] as? String else{return}
                guard let balance = accountDict["accountBalanceInCents"] as? Int else{return}
            
                print(accountName)
                print(iban)
                print(balance)
            }
            
        }
        catch{
                print(error)
        }
    }
}

extension FirstViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! CollectionViewItem
        item.accountNameText.text = people[indexPath.row]
        item.ibanText.text = "IBAN"
        return item
    }
    
    
}
