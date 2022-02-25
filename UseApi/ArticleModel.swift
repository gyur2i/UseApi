//
//  ArticleModel.swift
//  UseApi
//
//  Created by 김규리 on 2022/02/11.
//

import Foundation

protocol ArticleModelProtocol {
    func articlesRetrieved(articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        // Request articles
        // Parse the returned JSON into article instances and pass it back to the view controller with the protocol and delegate pattern
        
        // 1. 먼저 요청할 url을 string으로 담기
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=bb8e4fcfd4bc4ea4a1ba2b1b105a592f"
        // 2. 해당 스트링으로 URL 인스턴스 생성
        let url = URL(string: urlString)
        // 3. 해당 url이 만약에 nil 값이라면 여기서 중지
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        // 4. URLSession 만들기
        let session = URLSession.shared
        // 5. URLSession을 이용해서 dataTask 만들기
        let datatask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil { // 6. error가 없고 data를 성공적으로 불러왔을 때 동작
                let decoder = JSONDecoder() // 7. JSON 데이터를 swift 인스턴스 객체로 바꿔주기 위해 decoder 객체 생성
                // 8. decode 함수 에러 발생 방지 do-catch문 작성
                do{
                    // 9. ArticleService 모양의 swift 인스턴스로 파싱
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
                    // 10. 데이터를 성공적으로 받아왔으면 ArticleModelProtocol의 articlesRetrieved 함수를 이용하여 articles를 ViewController로 전송
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles: articleService.articles!)
                    }
                } catch {
                    print("Error parsing the json")
                }
            }
        }
        // 11. datatask 준비가 완료되면 datatask 실행
        datatask.resume()
    }
    
}

