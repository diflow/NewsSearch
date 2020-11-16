//
//  ErrorsStruct.swift
//  NewsTask
//
//  Created by ivan on 14.11.2020.
//

import Foundation

struct ErrorsAPI: Decodable {
    
    let status: String?
    let code: String?
    let message: String?
}
