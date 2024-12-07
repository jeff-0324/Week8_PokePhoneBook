//
//  TableViewCell.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/6/24.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var friendName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var friendNumber: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(stackView)
        [
            pokemonImageView,
            friendName,
            friendNumber
        ].forEach{stackView.addArrangedSubview($0)}
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pokemonImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
               make.leading.equalToSuperview().offset(10)
               make.centerY.equalToSuperview()
        }
        
        friendName.snp.makeConstraints { make in
            make.leading.equalTo(pokemonImageView.snp.trailing).inset(-20)
            
        }
        
        
    }
    
}
