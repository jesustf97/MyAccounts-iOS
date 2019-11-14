//
//  SecondViewController.swift
//  MyAccounts
//
//  Created by Jesús Calleja Rodríguez on 10/11/2019.
//  Copyright © 2019 Jesús Calleja Rodríguez. All rights reserved.
//
import UIKit

class SecondViewController: UIViewController {
    
    var itemsInfoList = Array<AccountItem>()
    
    @IBOutlet weak var visibleAccounts: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visibleAccounts.dataSource = self
    
        guard let path = Bundle.main.path(forResource: "accounts", ofType: "json") else { return }
               let url = URL(fileURLWithPath: path)
               do{
                   let data = try Data(contentsOf: url)
                   
                  if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                   if let accounts = json["accounts"] as? Array<Dictionary<String, Any>> {
                       for account in accounts {
                           let accountItem = AccountItem(accountName: account["accountName"] as! String, iban: account["iban"] as! String, balance: account["accountBalanceInCents"] as! Int, visible: account["isVisible"] as! Bool)
                           itemsInfoList.append(accountItem)
                       }
                    itemsInfoList = deleteInvisibleAccounts(accountsList: itemsInfoList)
                   }
              }
           } catch let err{
                   print(err)
               }
           }
    }

extension SecondViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! CollectionViewItem
        
        item.accountNameText.text = fillEmptySpaces(field: itemsInfoList[indexPath.row].accountName)
        item.ibanText.text = fillEmptySpaces(field: itemsInfoList[indexPath.row].iban)
        item.accountBalanceText.text = fillEmptySpaces(field:  String(itemsInfoList[indexPath.row].balance))
        return item
    }
    
    func fillEmptySpaces(field : String) -> String {
        if(field.isEmpty){
            return "No disponible"
        } else {
            return field
        }
    }
    
    func deleteInvisibleAccounts(accountsList: Array<AccountItem>) -> Array<AccountItem>{
        var visibleAccountList = Array<AccountItem>()
        for account in accountsList {
            if(account.visible){
                visibleAccountList.append(account)
            }
        }
        return visibleAccountList
    }
}
