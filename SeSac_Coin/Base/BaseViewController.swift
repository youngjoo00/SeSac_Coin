//
//  BaseViewController.swift
//  SeSac_MVVM
//
//  Created by youngjoo on 2/22/24.
//

import UIKit
import Toast

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .sesacPuple
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    func showAlert(title: String, message: String, btnTitle: String, complectionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: btnTitle, style: .default) { _ in
            complectionHandler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func showToast(message: String) {
        var style = ToastStyle()
        style.backgroundColor = .black
        style.messageColor = .white
        self.view.makeToast(message, duration: 2.5, position: .center, style: style)
    }
    
}
