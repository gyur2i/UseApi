//
//  ArticleCell.swift
//  UseApi
//
//  Created by 김규리 on 2022/02/11.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var headLineText: UILabel!
    @IBOutlet weak var headLineImage: UIImageView!
    // 렌더링해줄 article에 대한 데이터를 담을 변수 추가
    var articleToDisplay:Article?
    
    // headLineText와 headLineImage를 넣어주는 함수
    func displayArticle(article:Article){
        
//        headLineText.text=""
//        headLineImage.image = nil
    
        articleToDisplay = article // article 담기
        
        headLineText.text = articleToDisplay!.title // label 변수에 기사 title 넣기
        
        // 이미지 url이 없는 기사가 있을수도 있습니다. image url이 없다면 그냥 여기서 함수를 종료시켜줍니다.
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        let urlString = articleToDisplay!.urlToImage! // article의 url로부터 생성한 이미지,,,?
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if(error == nil && data != nil){
                if(self.articleToDisplay!.urlToImage == urlString){
                    // image를 변경하는 작업은 UI를 변경시키는 작업이므로 main thread에서 돌려주어야 합니다.
                    DispatchQueue.main.async {
                        self.headLineImage.image = UIImage(data: data!) // 이미지 주소인가,,,?
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
