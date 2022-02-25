//
//  ViewController.swift
//  UseApi
//
//  Created by 김규리 on 2022/02/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles = [Article]()
    var model = ArticleModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // tableView의 delegate와 dataSource가 ViewController라고 명시
        tableView.delegate = self
        tableView.dataSource = self
        
        model.delegate = self // ArticleModel의 delegate를 자기 자신으로 명시
        model.getArticles() // getArticles 함수 실행
    }

}

extension ViewController: ArticleModelProtocol { // ArticleModelProtocol 상속
    // MARK: ArticleModelProtocol functions
    func articlesRetrieved(articles: [Article]) {
        print("Get returned articles data from ArticleModel!")
        self.articles = articles // ArticleModel에서 불러온 data인 articles를 ViewController의 articles에 저장
        tableView.reloadData() // 뷰 다시 실행
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource { // UITableViewDelegate, UITableViewDataSource 프로토콜 상속
    
    // tableView에서 보여줘야하는 cell을 개수를 반환하는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.articles.count // articles 배열의 개수
        }
    
    // n번째에서 반환해줄 cell을 반환해주는 함수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 여기서 주의하셔야 할 점은 tableView에서 불러온 identifier가 ArticleCell인 인스턴스는 단순한 UITableViewCell이 아니라 저희가 커스텀한 ArticleCell입니다. 캐스팅으로 ArticleCell임을 명시해주세요. 그렇지 않다면 단순 UITableViewCell로만 인식할것입니다
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell // indexPath라는 매개변수를 통해 각각의 cell들을 커스텀해서 반환
        let article = self.articles[indexPath.row] //
        // TODO: customize it
        cell.displayArticle(article: article) // 각각의 셀에 기사 제목과 이미지 추가
        
        return cell
    }
    
    // n번째 cell이 유저에 의해서 클릭되었을 때 발동되는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // indexPath 매개변수를 통해 몇 번째 cell이 놀렸는지 알아낼 수 있음
        
    }
    
    
}

