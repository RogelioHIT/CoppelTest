//
//  MovieViewModel.swift
//  CoppelTest
//
//  Created by Rogelio on 08/07/22.
//

import Foundation

struct MovieViewModel {
    
    var movie: Movie!
    
    var movieName: String {
        return movie.original_name.capitalized
    }
    
    init(with movie: Movie){
        self.movie = movie
    }
    
    
    static func getDummyModel() -> MovieViewModel {
        let randomNumber = Int.random(in: 1..<100)
        let dummyMovie = Movie(poster_path: "/vC324sdfcS313vh9QXwijLIHPJp.jpg", id: 31917, vote_average: 5.04, overview: "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.", first_air_date: "2010-06-08", original_language: "en", original_name: "Dummy #\(randomNumber)")
        return MovieViewModel(with: dummyMovie)
    }
    
}