# MultiLineTagView
MultiLineTagView

This code has been modified by referring to another code.
(Original Code 
[Blog](https://nsios.tistory.com/203#comment15582758))

Using Swift, SnapKit

This code was written using SnapKit. If you use a Storyboard or other UI library, you will have to modify it yourself.

# Usage
### Quick Start

```swift
import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var multiLineTagView: MultiLineTagView = {
       let view: MultiLineTagView = MultiLineTagView(rowHeight: 100)
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
```

# Delegate

MultiLineTagViewDelegate

1. selectTag(tag: String)
2. deleteTag(tag: String)

Add features that fit your app service with Select and Delete Delegate.

Example Delegate exists for selection and deletion. Only the UI can be modified and used while maintained, and if you don't need Delegate, please modify the UI and Delegate together.



# Preview
<img width="30%" src="https://github.com/wlxo0401/MultiLineTagView/blob/main/screen_shot.png?raw=true"/>
<img width="50%" src="https://github.com/wlxo0401/MultiLineTagView/blob/main/screen_record.gif?raw=true"/>
