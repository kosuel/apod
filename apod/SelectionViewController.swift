//
//  SelectionViewController.swift
//  apod
//
//  Created by ohhyung kwon on 9/6/2022.
//

import UIKit

// second scene
class SelectionViewController: UIViewController {
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView! // left list view
    @IBOutlet weak var chosenView: ChosenView! // right selected item view
    
    var apods = [Apod]()
    private var chosen: Apod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previousButton.fill(background: .white, text: .label)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // do random selection animation
        var animationCount = 0
        var previousRandom = -1
        
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            // get random item index. if it is same with previous index, do it again
            var random = Int.random(in: 0...self.apods.count-1)
            while random == previousRandom {
                random = Int.random(in: 0...self.apods.count-1)
            }
            previousRandom = random
            
            let animatingItem = self.apods[random]
            
            let colors = UIColor.cellColors
            let colorIndex = random % colors.count

            // change chosen view color and text
            self.chosenView.update(with: animatingItem, color: colors[colorIndex])
            
            animationCount += 1
            
            // end timer
            if animationCount >= 10 {
                timer.invalidate()
                
                self.chosen = animatingItem
                
                // final scale animation
                UIView.animate(withDuration: 0.25) {
                    self.chosenView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

                } completion: { _ in
                    UIView.animate(withDuration: 0.25) {
                        self.chosenView.transform = CGAffineTransform.identity
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
            let indexPath = self.collectionView.indexPath(for: cell) {

            let apod = apods[indexPath.item]
            
            let vc = segue.destination as! PhotoViewController
            vc.title = apod.title            
            vc.imageUrl = apod.url
        }
    }
}


// MARK: - Button actions
extension SelectionViewController {
    @IBAction func unwindToSelectionViewAction(unwindSegue: UIStoryboardSegue){
        // do nothing
    }

}

extension SelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    private enum CellIdentifier {
        static let basicCell = "Cell"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return apods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.basicCell, for: indexPath)
        
        let label = cell.contentView.viewWithTag(100) as? UILabel
        
        // set title
        let apod = apods[indexPath.item]
        label?.text = apod.title
        
        // set item color as random
        let colors = UIColor.cellColors
        let colorIndex = indexPath.item % colors.count
        
        cell.backgroundColor = colors[colorIndex]
        cell.layer.cornerRadius = 10

        return cell
    }
    
    // set item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.size.width, height: 60)
    }
}
