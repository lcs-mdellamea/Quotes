//
//  RealQuote.swift
//  Quotes
//
//  Created by Madison Dellamea on 2/22/22.
//

import Foundation

//The Real Quote structure conforms to the decodable protocal. This means that we want Swift to be able to take a JSON object and 'decode' into an instance of this structure.
struct RealQuote: Decodable {
    let quoteText: String
    let quoteAuthor: String
    let senderName: String
    let senderLink: String
    let quoteLink: String
}

