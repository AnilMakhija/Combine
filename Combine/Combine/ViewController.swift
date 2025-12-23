//
//  ViewController.swift
//  Combine
//
//  Created by Anil on 25/04/25.
//

import UIKit
import Combine


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        bindTextField()
    }
    private func setupUI() {
            view.backgroundColor = .white
            searchTextField.placeholder = "Type to search..."
            searchTextField.borderStyle = .roundedRect
            searchTextField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(searchTextField)

            NSLayoutConstraint.activate([
                searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                searchTextField.widthAnchor.constraint(equalToConstant: 250)
            ])
        }

        private func bindTextField() {
            NotificationCenter.default
                .publisher(for: UITextField.textDidChangeNotification, object: searchTextField)
                .compactMap { ($0.object as? UITextField)?.text }
                .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
                .removeDuplicates()
                .sink { text in
                    print("Searching for: \(text)")
                }
                .store(in: &cancellables)
        }

}

