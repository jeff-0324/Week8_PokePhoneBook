//
//  PhoneBookViewController.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/8/24.
//

import UIKit
import SnapKit
import Alamofire

class PhoneBookViewController: UIViewController {
    private let enrolView = EnrolView()
    
    // navigationBar button
    private let rightButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "적용"
        barButton.style = .plain
        return barButton
    }()
    
//MARK: - setting
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        navigationBarSetup()
    }
    
    private func configureUI() {
        view.addSubview(enrolView)
        
        enrolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - 메서드 부분
extension PhoneBookViewController {
    
    private func navigationBarSetup() {
        navigationItem.title = "연락처 추가"
        navigationItem.rightBarButtonItem = rightButton
        
        rightButton.target = self
        rightButton.action = #selector(tappedAddButton)
        
        enrolView.tappedMakeImageButton = {[weak self] in
            guard let self = self else { return }
            fetchPokemonApi()
        }
    }
    
    // button action
    @objc func tappedAddButton() {
        navigationController?.popViewController(animated: true)
    }
}

// Networking part
extension PhoneBookViewController {
    
    // 범용적인 네트워킹 함수
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // pokemon api 요청 함수
    private func fetchPokemonApi() {
        let urlAdress = "https://pokeapi.co/api/v2/pokemon/"
        let randomNum = String(Int.random(in: 1...1000))
        
        guard let url = URL(string: urlAdress + randomNum) else {return}
        
        fetchData(url: url) { [weak self] (result: Result<PokemonData, AFError>) in
            guard let self else { return }
            switch result {
            case .success(let result) :
                guard let imageUrl = URL(string: result.sprites.frontDefault) else { return }
                AF.request(imageUrl).responseData { response in
                    if let data = response.data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.enrolView.pokemonImageView.image = image
                        }
                    }
                }
            case .failure(let error) :
                print("데이터 로드에 실패 \(error)")
            }
        }
    }
}
