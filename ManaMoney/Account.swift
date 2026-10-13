//
//  Account.swift
//  ManaMoney
//
//  Created by Samuele Angelicchio on 13/10/2026.
//
import Foundation


struct Account {
    let id: UUID
    let name: String
    let type: AccountType
    let currencyCode: String
    let openingBalanceCents: Int64
}

enum AccountType {
    case checking
    case prepaidCard
    case cash
    case savings
}
