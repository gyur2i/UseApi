//
//  ArticleService.swift
//  UseApi
//
//  Created by 김규리 on 2022/02/11.
//

import Foundation

struct ArticleService: Codable {
    var status:String?
    var totalResults:Int?
    var articles:[Article]?
}
