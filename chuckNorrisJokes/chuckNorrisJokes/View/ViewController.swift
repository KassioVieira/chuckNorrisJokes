//
//  ViewController.swift
//  chuckNorrisJokes
//
//  Created by Kássio Vieira da Luz on 09/08/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var jokeLabel: UILabel!
    
    var jokeViewModel = JokeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jokeViewModel.delegate = self
        
        jokeViewModel.getJoke()
     
    }

    @IBAction func generateJoke(_ sender: UIButton) {
        jokeViewModel.getJoke()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

}

extension ViewController: JokeViewModelDelegate {
    func didUpdateJoke(joke: String) {
        
        DispatchQueue.main.async {
            self.jokeLabel.text = joke
        }
      
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

