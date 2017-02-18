import UIKit
import SwifterSwift
import SwiftSpinner

class ViewController: UIViewController {
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var searchMoviesButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var popularItem1: UIButton!
    @IBOutlet weak var popularItem2: UIButton!
    @IBOutlet weak var popularItem3: UIButton!
    @IBOutlet weak var popularItem4: UIButton!
    @IBOutlet weak var popularItem5: UIButton!
    @IBOutlet weak var popularItem6: UIButton!
    
    var movies: [Movie]?
    var mostPopularMovesList: [Movie]?
    var mostPopularSeriesList: [Movie]?
    var movieSelected: Movie?
    var servers: [Server]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        getPopularItems() { (mostPopularMovies, mostPopularSeries) in
            self.mostPopularMovesList = mostPopularMovies
            self.mostPopularSeriesList = mostPopularSeries
            
            self.populateMostPopular(type: "Movies")
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchMoviesButton.isEnabled = true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Controls which part has been clicked in segmentedControl
    @IBAction func segmentedControlsChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            populateMostPopular(type: "Movies")
        case 1:
            populateMostPopular(type: "Series")
        default:
            break
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        dismissKeyboard()
        searchMoviesButton.isEnabled = false
        
        SwiftSpinner.show("Searching for movies")
        
        let phrase = searchInput.text!.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        search(phrase: phrase) { movies in
            self.movies = movies
            self.performSegue(withIdentifier: "showTable", sender: self)
        }
    }
    
    func populateMostPopular(type: String) {
        let mostPopular = [popularItem1, popularItem2, popularItem3, popularItem4, popularItem5, popularItem6]
        let mostPopularList: [Movie]?
        
        if type == "Movies" {
            mostPopularList = mostPopularMovesList
        } else {
            mostPopularList = mostPopularSeriesList
        }
        
        let length = min(mostPopular.count, (mostPopularList?.count)!) - 1
        
        for button in mostPopular {
            button?.setImage(nil, for: UIControlState.normal)
        }

        for i in 0...length {
            let imageUrl = NSURL(string: (mostPopularList?[i].image)!)
            let imagedData = NSData(contentsOf: imageUrl! as URL)!
            let image = UIImage(data: imagedData as Data)
            mostPopular[i]?.setImage(image, for: UIControlState.normal)
        }
    }
    
    //Load top the six most popular movies and once clicked redirect to MovieViewController
    @IBAction func viewPopularItem(_ sender: UIButton) {
        guard let button = sender as? UIButton else {
            return
        }
        
        var mostPopular: [Movie]?
        
        if segmentedControl.selectedSegmentIndex == 0 {
            mostPopular = mostPopularMovesList
        } else {
            mostPopular = mostPopularSeriesList
        }
        
        switch button.tag {
        case 1:
            movieSelected = mostPopular?[0]
            break
        case 2:
            movieSelected = mostPopular?[1]
            break
        case 3:
            movieSelected = mostPopular?[2]
            break
        case 4:
            movieSelected = mostPopular?[3]
            break
        case 5:
            movieSelected = mostPopular?[4]
            break
        case 6:
            movieSelected = mostPopular?[5]
            break
        default:
            break
        }
        
        getEpisodes(movie: movieSelected!) { servers in
            self.servers = servers
            if servers[0].episodes.count == 1 {
                self.performSegue(withIdentifier: "presentPopularMovie", sender: self)
            } else {
                self.performSegue(withIdentifier: "presentPopularSeries", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
        let backItem = UIBarButtonItem()
        backItem.title = "Search"
        navigationItem.backBarButtonItem = backItem
        
        if (segue.identifier == "presentPopularMovie") {
            let movieViewController: MovieViewController = segue.destination as! MovieViewController
            movieViewController.movie = movieSelected
            movieViewController.servers = servers!
        } else if (segue.identifier == "presentPopularSeries") {
            let seriesViewController: SeriesViewController = segue.destination as! SeriesViewController
            seriesViewController.movie = movieSelected
            seriesViewController.servers = servers!
        } else if (segue.identifier == "showTable") {
            let tableViewController: TableViewController = segue.destination as! TableViewController
            tableViewController.movies = movies
        }
    }
}
