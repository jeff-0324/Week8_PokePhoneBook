//
//  ProfilesImageManager.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/9/24.
//

import UIKit
import Alamofire

class ProfilesImageManager {
    
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
        
        guard let url = URL(string: urlAdress + randomNum) else {
            completion(nil)
            return
        }
        
        fetchData(url: url) { [weak self] (result: Result<PokemonData, AFError>) in
            guard let self = self else { return }
            switch result {
            case .success(let result) :
                guard let imageUrl = URL(string: result.sprites.frontDefault) else { return }
                
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
