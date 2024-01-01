//
//  ViewController.swift
//  MultiLineTagView
//
//  Created by 김지태 on 1/1/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var multiLineTagView: MultiLineTagView = {
        let view: MultiLineTagView = MultiLineTagView(rowHeight: 40)
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.multiLineTagView)
        
        self.multiLineTagView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        let words: [String] = ["Tag1", "Tag2", "Tag3", "Tag Tag Reee Test", "Hi My", "Github"]
        
        self.multiLineTagView.setTag(words: words)
    }
}

extension ViewController: MultiLineTagViewDelegate {
    func selectTag(tag: String) {
        print("Select Tag: \(tag)")
    }
    
    func deleteTag(tag: String) {
        print("Delete Tag: \(tag)")
    }
}
