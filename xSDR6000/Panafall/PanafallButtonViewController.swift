//
//  PanafallButtonViewController.swift
//  xSDR6000
//
//  Created by Douglas Adams on 6/9/16.
//  Copyright © 2016 Douglas Adams. All rights reserved.
//

import Cocoa
import xLib6000
import SwiftyUserDefaults

// --------------------------------------------------------------------------------
// MARK: - Panafall Button View Controller class implementation
// --------------------------------------------------------------------------------

final class PanafallButtonViewController    : NSViewController {
  
  // ----------------------------------------------------------------------------
  // MARK: - Internal properties
  
  // KVO-properties for popovers
  @objc dynamic weak var panadapter         : Panadapter?
  @objc dynamic weak var waterfall          : Waterfall?
  @objc dynamic var fillLevel               : Int {
    get { return Defaults[.fillLevel] }
    set { Defaults[.fillLevel] = newValue } }
  @objc dynamic var gradientNames           : [String] {
    return WaterfallViewController.gradientNames }
  
  // ----------------------------------------------------------------------------
  // MARK: - Private properties

  @IBOutlet private weak var buttonView             : PanafallButtonView!
  
  private var _bandwidth                    : Int { return panadapter!.bandwidth }
  
  private let kPanafallEmbedIdentifier      = NSStoryboardSegue.Identifier("PanafallEmbed")
  private let kBandPopoverIdentifier        = NSStoryboardSegue.Identifier(rawValue: "BandPopover")
  private let kAntennaPopoverIdentifier     = NSStoryboardSegue.Identifier(rawValue: "AntennaPopover")
  private let kDisplayPopoverIdentifier     = NSStoryboardSegue.Identifier(rawValue: "DisplayPopover")
  private let kDaxPopoverIdentifier         = NSStoryboardSegue.Identifier(rawValue: "DaxPopover")

  private let kPanadapterSplitViewItem      = 0
  private let kWaterfallSplitViewItem       = 1
  
  // ----------------------------------------------------------------------------
  // MARK: - Overridden methods
  
  /// Prepare to execute a Segue
  ///
  /// - Parameters:
  ///   - segue: a Segue instance
  ///   - sender: the sender
  ///
  override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
    
    switch segue.identifier! {
      
    case kPanafallEmbedIdentifier:                            // this will always occur first
      
      // pass a copy of the Params
      (segue.destinationController as! NSViewController).representedObject = representedObject
      
      // save a reference to the Panafall view controller
      let panafallViewController = segue.destinationController as? PanafallViewController
      
      // pass needed parameters
      panafallViewController!.configure(panadapter: panadapter)
      
      // save a reference to the panadapterViewController & waterfallViewController
      let panadapterViewController = panafallViewController!.splitViewItems[kPanadapterSplitViewItem].viewController as? PanadapterViewController
      let waterfallViewController = panafallViewController!.splitViewItems[kWaterfallSplitViewItem].viewController as? WaterfallViewController
      
      // pass needed parameters
      panadapterViewController!.configure(panadapter: panadapter)
      waterfallViewController!.configure(panadapter: panadapter)
      
    case kDisplayPopoverIdentifier:
      
      // pass the Popovers a reference to this controller
      (segue.destinationController as! NSViewController).representedObject = self
      
    case kAntennaPopoverIdentifier, kBandPopoverIdentifier, kDaxPopoverIdentifier:
      
      // pass the Popovers a reference to the panadapter
      (segue.destinationController as! NSViewController).representedObject = panadapter
      
    default:
      break
    }
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Internal methods
  
  /// Configure needed parameters
  ///
  /// - Parameter panadapter:               a Panadapter reference
  ///
  func configure(panadapter: Panadapter?, waterfall: Waterfall?) {
    self.panadapter = panadapter
    self.waterfall = waterfall
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Action methods
  
  /// Zoom + (decrease bandwidth)
  ///
  /// - Parameter sender: the sender
  ///
  @IBAction func zoomPlus(_ sender: NSButton) {
    
    // are we near the minimum?
    if _bandwidth / 2 > panadapter!.minBw {
      
      // NO, make the bandwidth half of its current value
      panadapter!.bandwidth = _bandwidth / 2
      
    } else {
      
      // YES, make the bandwidth the minimum value
      panadapter!.bandwidth = panadapter!.minBw
    }
  }
  /// Zoom - (increase the bandwidth)
  ///
  /// - Parameter sender: the sender
  ///
  @IBAction func zoomMinus(_ sender: NSButton) {
    // are we near the maximum?
    if _bandwidth * 2 > panadapter!.maxBw {
      
      // YES, make the bandwidth maximum value
      panadapter!.bandwidth = panadapter!.maxBw
      
    } else {
      
      // NO, make the bandwidth twice its current value
      panadapter!.bandwidth = _bandwidth * 2
    }
  }
  /// Close this Panafall
  ///
  /// - Parameter sender: the sender
  ///
  @IBAction func close(_ sender: NSButton) {
    
    buttonView.removeTrackingArea()
    
    // tell the Radio to remove this Panafall
    panadapter!.remove()
  }
  /// Create a new Slice (if possible)
  ///
  /// - Parameter sender: the sender
  ///
  @IBAction func rx(_ sender: NSButton) {
    
    // tell the Radio (hardware) to add a Slice on this Panadapter
    xLib6000.Slice.create(panadapter: panadapter!)
  }
  /// Create a new Tnf
  ///
  /// - Parameter sender: the sender
  ///
  @IBAction func tnf(_ sender: NSButton) {
    
    // tell the Radio (hardware) to add a Tnf on this Panadapter
    Tnf.create(frequency: "")
  }
}
