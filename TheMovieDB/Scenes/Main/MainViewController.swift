//
//  MainViewController.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, InterfaceMainViewController {
    var presenter: InterfaceMainPresenter?

    // MARK: - Init
    init() {
        super.init(nibName: "MainViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        presenter?.downloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MainViewController: InterfaceMainPresenterOutput {
    func dataFailure() {
        let alertController = UIAlertController(title: "ERROR", message: "Data can't be downloaded", preferredStyle: .alert)
        let actionRetry = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.presenter?.downloadData()
        }
        alertController.addAction(actionRetry)
        self.present(alertController, animated: true, completion: nil)
    }
}
