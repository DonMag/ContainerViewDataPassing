//
//  ExampleCode.swift
//  ContainerViewDataPassing
//
//  Created by Don Mag on 8/26/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

struct Movie {
	var description: String = ""
	var rating: Int = 0
}

class SampleCell: UICollectionViewCell {
	@IBOutlet var theLabel: UILabel!
}

class SampleCollectionViewController: UICollectionViewController {
	
	var movies: [Movie] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		movies.append(Movie(description: "One", rating: 1))
		movies.append(Movie(description: "Two", rating: 2))
		movies.append(Movie(description: "Three", rating: 3))
		movies.append(Movie(description: "Four", rating: 4))
		movies.append(Movie(description: "Five", rating: 5))
		
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let indexPath = sender as? IndexPath else {
			return
		}
		let idx = indexPath.item
		if let vc = segue.destination as? MovieViewController {
			vc.selectedMovie = movies[idx]
		}
	}
	
	// MARK: UICollectionViewDataSource
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return movies.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SampleCell
		
		cell.theLabel.text = movies[indexPath.item].description
		
		return cell
	}
	
	// MARK: UICollectionViewDelegate
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "ToMovieVC", sender: indexPath)
	}
	
}

class MovieViewController: UIViewController {
	var selectedMovie: Movie?
	
	var descVC: DescriptionViewController?
	var rateVC: RatingViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let m = selectedMovie,
			let dVC = descVC,
			let rVC = rateVC {
			
			dVC.theLabel.text = "Description: \(m.description)"
			rVC.theLabel.text = "Rating: \(m.rating)"
			
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? DescriptionViewController {
			descVC = vc
		}
		if let vc = segue.destination as? RatingViewController {
			rateVC = vc
		}
	}
}

class DescriptionViewController: UIViewController {
	@IBOutlet var theLabel: UILabel!
}
class RatingViewController: UIViewController {
	@IBOutlet var theLabel: UILabel!
}
