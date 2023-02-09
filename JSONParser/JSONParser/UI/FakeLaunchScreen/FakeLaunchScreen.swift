//
//  FakeLaunchScreen.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 09.02.2023.
//

import UIKit

class FakeLaunchScreen: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ItemsListCoordinator(presenter: self, jsonFileName: "task").start(embedInNav: true)
    }
}
