//
//  MultiLineTagView.swift
//  MultiLineTagView
//
//  Created by 김지태 on 1/1/24.
//

import UIKit

@objc protocol MultiLineTagViewDelegate: AnyObject {
    /*
     태그를 선택한 경우 수행
     */
    @objc optional func selectTag(tag: String)
    
    /*
     태그를 삭제한 경우 수행
     */
    @objc optional func deleteTag(tag: String)
}

class MultiLineTagView: UIView {
    // Delegate
    weak open var delegate: MultiLineTagViewDelegate?
    
    // 태그간 가로 간격
    private let horizontalSpacing: CGFloat
    // 태그간 세로 간격
    private let verticalSpacing: CGFloat
    // Label 높이
    private let rowHeight: CGFloat
    // 고유 높이?
    private var intrinsicHeight: CGFloat = 0
    // 패딩
    private let horizontalPadding: CGFloat
    
    // Tag View가 담길 곳
    private var tagViews: [UIView] = []
    
    init(
        horizontalSpacing: CGFloat = 8,
        verticalSpacing: CGFloat = 8,
        rowHeight: CGFloat,
        horizontalPadding: CGFloat = 0
    ) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.rowHeight = rowHeight
        self.horizontalPadding = horizontalPadding
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func setTag(words: [String]) {
        self.tagViews.removeAll()
        self.subviews.forEach { $0.removeFromSuperview() }
        
        // 단어 반복
        for word in words {
            // 태그 Label 생성
            let label: UILabel = {
                let label: UILabel = UILabel()
                label.text = word
                label.textAlignment = .center
                label.textColor = .white
                return label
            }()
            
            let selectButton: UIButton = {
                let button: UIButton = UIButton()
                button.addAction(UIAction { _ in
                    self.delegate?.selectTag?(tag: word)
                }, for: .touchUpInside)
                return button
            }()
            
            // 태그 삭제 버튼
            let deleteButton: UIButton = {
                let button: UIButton = UIButton()
                button.setTitle("del", for: .normal)
                button.addAction(UIAction { _ in
                    self.delegate?.deleteTag?(tag: word)
                }, for: .touchUpInside)
                return button
            }()
            
            // 태그 View 생성
            let view: UIView = {
                let view: UIView = UIView()
                view.layer.borderWidth = 1
                view.layer.borderColor = UIColor.blue.cgColor
                view.backgroundColor = .blue
                view.clipsToBounds = true
                view.layer.cornerRadius = 8
                return view
            }()
            
            // 태그 Label 원래 크기 구하기
            let labelWidth: CGFloat = label.intrinsicContentSize.width + self.horizontalPadding * 2
            let labelHeight: CGFloat = self.rowHeight
            
            // 태그 View의 크기 = 태그 Label 크기 + 제약 조건의 공백
            view.frame.size.width = labelWidth + 15 + 45
            view.frame.size.height = labelHeight
            
            // 태그 View에 Label, 선택 Button, 삭제 Button 추가
            view.addSubview(label)
            view.addSubview(deleteButton)
            view.addSubview(selectButton)
            
            // 태그 Label 제약 조건
            label.snp.makeConstraints {
                $0.top.bottom.equalToSuperview().inset(3)
                $0.leading.equalToSuperview().offset(9)
                $0.trailing.equalTo(deleteButton.snp.leading).offset(-6)
            }
            
            // 선택 버튼 제약 조건
            selectButton.snp.makeConstraints {
                $0.top.leading.bottom.equalToSuperview()
                $0.trailing.equalTo(deleteButton.snp.leading)
            }
            
            // 삭제 버튼 제약 조건
            deleteButton.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(5)
                $0.centerY.equalToSuperview()
                $0.height.equalTo(20)
                $0.width.equalTo(40)
            }
            
            // 태그 View 리스트에서 추가
            self.tagViews.append(view)
            // 부모 View에 추가
            self.addSubview(view)
        }
    }
    
    // 태그 View 위치 잡기
    final private func setupLayout() {
        // 태그 View 초기 값
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        
        // 반복하면서 태그 View의 위치를 이동
        self.tagViews.forEach { label in
            if currentX + label.frame.width > bounds.width {
                // 다음 행으로 이동
                currentX = 0
                currentY += self.rowHeight + self.verticalSpacing
            }
            label.frame.origin = CGPoint(x: currentX, y: currentY)
            // X 좌표 이동
            currentX += label.frame.width + self.horizontalSpacing
        }
        
        if self.tagViews.count == 0 {
            self.intrinsicHeight = 0
        } else {
            self.intrinsicHeight = currentY + self.rowHeight
        }
        
        invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = self.intrinsicHeight
        return size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayout()
    }
}

