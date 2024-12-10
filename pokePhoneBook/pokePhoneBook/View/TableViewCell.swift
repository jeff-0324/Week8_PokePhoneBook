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
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()
    
    var friendName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    var friendNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
//MARK: - setting
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        [
            pokemonImageView,
            friendName,
            friendNumber
        ].forEach{contentView.addSubview($0)}
        
        pokemonImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        friendName.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.centerY.equalToSuperview()
            make.leading.equalTo(pokemonImageView.snp.trailing).offset(20)
        }
        
        friendNumber.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.centerY.equalToSuperview()
            make.leading.equalTo(friendName.snp.trailing).offset(30)
        }
    }
}
