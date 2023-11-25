import Foundation

enum MoviesDetailsViewModelState {
    case loading(Movie)
    case loaded(MovieDetails, [Movie])
    case error

    var title: String? {
        switch self {
        case .loaded(let movie, _):
            return movie.title
        case .loading(let movie):
            return movie.title
        case .error:
            return nil
        }
    }
}

final class MoviesDetailsViewModel {

    private let apiManager: APIManaging
    private let initialMovie: Movie
    var moviDetail: MovieDetails?
    var similarMovies: [Movie]?

    init(movie: Movie, apiManager: APIManaging = APIManager()) {
        self.initialMovie = movie
        self.apiManager = apiManager
        self.state = .loading(movie)
    }

    var updatedState: (() -> Void)?

    var state: MoviesDetailsViewModelState {
        didSet {
            updatedState?()
        }
    }

    func fetchData() {
        let group = DispatchGroup()
        group.enter()
        apiManager.execute(MovieDetails.details(for: initialMovie)) { [weak self] result in
            guard let self = self else { return }
            defer {
                group.leave()
            }
            switch result {
            case .success(let movieDetails):
                self.moviDetail = movieDetails
            case .failure:
                self.state = .error
            }
        }
        
        group.enter()
        apiManager.execute(Movie.similar(for: initialMovie)) { [weak self] result in
            guard let self = self else { return }
            defer {
                group.leave()
            }
            switch result {
            case .success(let movies):
                self.similarMovies = movies.results
            case .failure:
                self.state = .error
            }
        }
        
        group.notify(queue: .main) {
            if let movieDetails = self.moviDetail, let movies = self.similarMovies {
                self.state = .loaded(movieDetails, movies)
            }
        }
    }
}
