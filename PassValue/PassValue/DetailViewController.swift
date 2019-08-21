//
//  ViewController.swift
//  PassValue
//
//  Created by littlema on 2019/8/20.
//  Copyright © 2019 littema. All rights reserved.
//

import UIKit

protocol DataPassHelper {
    func insertData(text: String)
    
    func updateData(text: String, indexPath: IndexPath)
}

class DetailViewController: UIViewController {
    
    var textfidld: UITextField = {
        let textfidld = UITextField()
        textfidld.placeholder = "Enter Something..."
        textfidld.layer.borderColor = UIColor.lightGray.cgColor
        textfidld.layer.borderWidth = 1
        textfidld.translatesAutoresizingMaskIntoConstraints = false
        return textfidld
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Conform", for: .normal)
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(clickConformButton(_:)), for: .touchUpInside)
        return button
    }()

    var data: String? {
        didSet{
            textfidld.text = data
        }
    }
    
    var indexPath: IndexPath?
    
    var delegate: DataPassHelper?
    
    var insertDataHelper: ((String) -> Void)?
    
    var updateDataHelper: ((String, IndexPath) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        
        view.addSubview(textfidld)
        NSLayoutConstraint.activate([
            textfidld.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfidld.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            textfidld.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            textfidld.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        textfidld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfidld.frame.height))
        textfidld.leftViewMode = .always

    }
    
    @objc func clickConformButton(_ button: UIButton) {

        guard let text = textfidld.text else { return }
        
        if indexPath == nil {
            print("Insert by delegate")
            //delegate?.insertResult(text: text)
            insertDataHelper?(text)
        } else {
            print("Update by closure")
            guard let indexPath = indexPath else { return }
            delegate?.updateData(text: text, indexPath: indexPath)
            //updateDataHelper(text: text, indexPath: indexPath)
        }

        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        
        textfidld.layer.cornerRadius = textfidld.frame.height / 4
        
    }
    
}

