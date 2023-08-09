//
//  JokeViewModel.swift
//  chuckNorrisJokes
//
//  Created by Kássio Vieira da Luz on 09/08/2023.
//

import Foundation

protocol JokeViewModelDelegate {
    func didUpdateJoke(joke: String)
    func didFailWithError(error: Error)
}

struct JokeViewModel {
    
    let baseURL = "https://api.chucknorris.io/jokes/random"
    
    var delegate: JokeViewModelDelegate?
    
 
    func getJoke () {
    
        if let api = URL(string: baseURL) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: api) {(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let jokeData = data {
                    if let jokeText = self.parseJSON(jokeData) {
                        self.delegate?.didUpdateJoke(joke: jokeText)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> String? {
           
           let decoder = JSONDecoder()
           do {
               let decodedData = try decoder.decode(Joke.self, from: data)
               
               let jokeText = decodedData.value
               return jokeText
               
           } catch {
               print(error)
               return nil
           }
       }
}
