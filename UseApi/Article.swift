//
//  Article.swift
//  UseApi
//
//  Created by 김규리 on 2022/02/11.
//

import Foundation

struct Article : Codable {
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
}
