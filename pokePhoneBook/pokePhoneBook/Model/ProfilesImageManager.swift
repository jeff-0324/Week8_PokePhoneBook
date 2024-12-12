//
//  ProfilesImageManager.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/9/24.
//

import UIKit
import Alamofire

class ProfilesImageManager {
    
    init() {}
    
    // 범용적인 네트워킹 함수
    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // pokemon api 요청 함수
    func fetchPokemonApi(completion: @escaping (UIImage?) -> Void) {
        let urlAdress = "https://pokeapi.co/api/v2/pokemon/"
        let randomNum = String(Int.random(in: 1...1000))
        
        // 요청할 url주소를 생성
        guard let url = URL(string: urlAdress + randomNum) else {
            completion(nil)
            return
        }
        
        // 바로 위에서 생성한 url주소를 가지고 결과값을 받아오는 메서드
        fetchData(url: url) { [weak self] (result: Result<PokemonData, AFError>) in
            guard let self = self else { return }
            switch result {
            case .success(let result) :
                guard let imageUrl = URL(string: result.sprites.frontDefault) else { return }
                
                // 이미지가 저장된 url을 이용해 UIImage로 변환해서 completion(콜백함수)로 Image의 값을 넘겨준다.
                AF.request(imageUrl).responseData { response in
                    if let data = response.data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            completion(image)
                        }
                    }
                }
            case .failure(let error) :
                print("데이터 로드에 실패 \(error)")
                completion(nil)
            }
        }
    }
}
