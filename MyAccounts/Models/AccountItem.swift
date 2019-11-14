//
//  AccountItem.swift
//  MyAccounts
//
//  Created by Jesús Calleja Rodríguez on 14/11/2019.
//  Copyright © 2019 Jesús Calleja Rodríguez. All rights reserved.
//

import Foundation

struct AccountItem: Decodable {
    public let accountName: String
    public let iban: String
    public let balance: Int
    public let visible: Bool
}
