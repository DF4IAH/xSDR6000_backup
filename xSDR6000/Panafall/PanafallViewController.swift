//
//  PanafallViewController.swift
//  xSDR6000
//
//  Created by Douglas Adams on 10/14/15.
//  Copyright © 2015 Douglas Adams. All rights reserved.
//

import Cocoa
import xLib6000

// --------------------------------------------------------------------------------
// MARK: - Panafall View Controller class implementation
// --------------------------------------------------------------------------------

final class PanafallViewController          : NSSplitViewController {
  
  // ----------------------------------------------------------------------------
  // MARK: - Internal properties
  
  var radio: Radio?                         = Api.sharedInstance.radio
  weak var panadapter                       : Panadapter?
  
  // ----------------------------------------------------------------------------
  // MARK: - Private properties
  
  @IBOutlet weak var _panadapterSplitViewItem: NSSplitViewItem!
  
  //    private var _params                 : Params { return representedObject as! Params }
  
  private var _center                       : Int {return panadapter!.center }
  private var _bandwidth                    : Int { return panadapter!.bandwidth }
  private var _start                        : Int { return _center - (_bandwidth/2) }
  private var _end                          : Int { return _center + (_bandwidth/2) }
  private var _hzPerUnit                    : CGFloat { return CGFloat(_end - _start) / view.frame.width }
  
  private var _panadapterViewController     : PanadapterViewController? { return _panadapterSplitViewItem.viewController as? PanadapterViewController }
  
  // gesture recognizer related
  private var _doubleClick                  : NSClickGestureRecognizer!
  private var _rightClick                   : NSClickGestureRecognizer!
  
  // constants
  private let kButtonViewWidth              : CGFloat = 75                  // Width of ButtonView when open
  private let kEdgeTolerance                : CGFloat = 0.1                 // percent of bandwidth
  private let kLeftButton                   = 0x01                          // masks for Gesture Recognizers
  private let kRightButton                  = 0x02
  
  private let kCreateSlice                  = "Create Slice"                // Menu titles
  private let kRemoveSlice                  = "Remove Slice"
  private let kCreateTnf                    = "Create Tnf"
  private let kRemoveTnf                    = "Remove Tnf"
  private let kPermanentTnf                 = "Permanent"
  private let kNormalTnf                    = "Normal"
  private let kDeepTnf                      = "Deep"
  private let kVeryDeepTnf                  = "Very Deep"
  
  // ----------------------------------------------------------------------------
  // MARK: - Overridden methods
  
  /// the View has loaded
  ///
  override func viewDidLoad() {
    super.viewDidLoad()
    
    splitView.delegate = self
    
    // setup Left Double Click recognizer
    _doubleClick = NSClickGestureRecognizer(target: self, action: #selector(leftDoubleClick(_:)))
    _doubleClick.buttonMask = kLeftButton
    _doubleClick.numberOfClicksRequired = 2
    splitView.addGestureRecognizer(_doubleClick)
    
    // setup Right Single Click recognizer
    _rightClick = NSClickGestureRecognizer(target: self, action: #selector(rightClick(_:)))
    _rightClick.buttonMask = kRightButton
    _rightClick.numberOfClicksRequired = 1
    splitView.addGestureRecognizer(_rightClick)
  }
  /// Process scroll wheel events to change the Active Slice frequency
  ///
  /// - Parameter theEvent: a Scroll Wheel event
  ///
  override func scrollWheel(with theEvent: NSEvent) {
    
    // ignore events not in the Y direction
    if theEvent.deltaY != 0 {
      
      // find the Active Slice
      if let slice = radio!.findActiveSliceOn(panadapter!.id) {
        
        // use the Slice's step value, unless the Shift key is down
        var step = slice.step
        if theEvent.modifierFlags.contains(.shift) {
          // step value when the Shift key is down
          step /= 10
        }
        // Increase or Decrease?
        let incr = theEvent.deltaY < 0 ? step : -step
        
        // update the frequency
        adjustSliceFrequency(slice, incr: incr)
      }
    }
  }
  
//  deinit {
//    Swift.print("PanafallViewController - deinit")
//  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Private methods
  
  /// Respond to Left Double Click gesture
  ///
  /// - Parameter gr: the GestureRecognizer
  ///
  @objc private func leftDoubleClick(_ gr: NSClickGestureRecognizer) {
    
    // get the coordinates and convert to this View
    let mouseLocation = gr.location(in: splitView)
    
    // calculate the frequency
    let mouseFrequency = Int(mouseLocation.x * _hzPerUnit) + _start
    
    // is there an active Slice
    if let slice = radio!.findActiveSliceOn(panadapter!.id) {
      
      // YES, force it to the nearest step value
      let delta = (mouseFrequency % slice.step)
      if delta >= slice.step / 2 {
        
        // move it to the step value above the click
        slice.frequency = mouseFrequency + (slice.step - delta)
        
      } else {
        
        // move it to the step value below the click
        slice.frequency = mouseFrequency - delta
      }
      
    } else {
      
      // NO, create one at the mouse position
      radio!.sliceCreate(panadapter: panadapter!, frequency: mouseFrequency)
    }
    // redraw the Slices
    _panadapterViewController?.redrawSlices()
  }
  /// Respond to a Right Click gesture
  ///
  /// - Parameter gr: the GestureRecognizer
  ///
  @objc private func rightClick(_ gr: NSClickGestureRecognizer) {
    var item: NSMenuItem!
    
    // get the "click" coordinates and convert to this View
    let mouseLocation = gr.location(in: splitView)
    
    // create the popup menu
    let menu = NSMenu(title: "Panadapter")
    
    // calculate the frequency
    let mouseFrequency = Int(mouseLocation.x * _hzPerUnit) + _start
    
    // is the Frequency inside a Slice?
    let slice = radio!.findSliceOn(panadapter!.id, byFrequency: mouseFrequency, panafallBandwidth: _bandwidth)
    if let slice = slice {
      
      // YES, mouse is in a Slice
      item = menu.insertItem(withTitle: kRemoveSlice, action: #selector(contextMenu(_:)), keyEquivalent: "", at: 0)
      item.representedObject = slice
      item.target = self
      
    } else {
      
      // NO, mouse is not in a Slice
      item = menu.insertItem(withTitle: kCreateSlice, action: #selector(contextMenu(_:)), keyEquivalent: "", at: 0)
      item.representedObject = NSNumber(value: mouseFrequency)
      item.target = self
    }
    
    // is the Frequency inside a Tnf?
    let tnf = radio!.findTnfBy(frequency: mouseFrequency, panafallBandwidth: _bandwidth)
    if let tnf = tnf {
      
      // YES, mouse is in a TNF
      item = menu.insertItem(withTitle: kRemoveTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: 1)
      item.representedObject = tnf
      item.target = self
      
      menu.insertItem(NSMenuItem.separator(), at: 2)
      item = menu.insertItem(withTitle: kPermanentTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: 3)
      item.state = tnf.permanent ? NSControl.StateValue.on : NSControl.StateValue.off
      item.representedObject = tnf
      item.target = self
      
      item = menu.insertItem(withTitle: kNormalTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: 4)
      item.state = (tnf.depth == Tnf.Depth.normal.rawValue) ? NSControl.StateValue.on : NSControl.StateValue.off
      item.representedObject = tnf
      item.target = self
      
      item = menu.insertItem(withTitle: kDeepTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: 5)
      item.state = (tnf.depth == Tnf.Depth.deep.rawValue) ? NSControl.StateValue.on : NSControl.StateValue.off
      item.representedObject = tnf
      item.target = self
      
      item = menu.insertItem(withTitle: kVeryDeepTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: 6)
      item.state = (tnf.depth == Tnf.Depth.veryDeep.rawValue) ? NSControl.StateValue.on : NSControl.StateValue.off
      item.representedObject = tnf
      item.target = self
      
    } else {
      
      // NO, mouse is not in a TNF
      item = menu.insertItem(withTitle: kCreateTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: 1)
      item.representedObject = NSNumber(value: Float(mouseFrequency))
      item.target = self
    }
    
    // display the popup
    menu.popUp(positioning: menu.item(at: 0), at: mouseLocation, in: splitView)
    
  }
  /// Perform the appropriate action
  ///
  /// - Parameter sender: a MenuItem
  ///
  @objc private func contextMenu(_ sender: NSMenuItem) {
    
    switch sender.title {
      
    case kCreateSlice:        // tell the Radio to create a new Slice
      let freq = (sender.representedObject! as! NSNumber).intValue
      radio!.sliceCreate(panadapter: panadapter!, frequency: freq)
      
    case kRemoveSlice:        // tell the Radio to remove the Slice
      radio!.sliceRemove((sender.representedObject as! xLib6000.Slice).id)
      
    case kCreateTnf:          // tell the Radio to create a new Tnf
      let freq = (sender.representedObject! as! NSNumber).intValue
      radio!.tnfCreate(frequency: freq, panadapter: panadapter!)
      
    case kRemoveTnf:          // tell the Radio to remove the Tnf
      radio!.tnfRemove(tnf: sender.representedObject as! Tnf)
      
    case kPermanentTnf:           // update the Tnf
      (sender.representedObject as! Tnf).permanent = !(sender.representedObject as! Tnf).permanent
      
    case kNormalTnf:              // update the Tnf
      (sender.representedObject as! Tnf).depth = Tnf.Depth.normal.rawValue
      
    case kDeepTnf:                // update the Tnf
      (sender.representedObject as! Tnf).depth = Tnf.Depth.deep.rawValue
      
    case kVeryDeepTnf:           // update the Tnf
      (sender.representedObject as! Tnf).depth = Tnf.Depth.veryDeep.rawValue
      
    default:
      break
    }
  }
  /// Incr/decr the Slice frequency (scroll panafall at edges)
  ///
  /// - Parameters:
  ///   - slice: the Slice
  ///   - incr: frequency step
  ///
  private func adjustSliceFrequency(_ slice: xLib6000.Slice, incr: Int) {
    var isTooClose = false
    
    // adjust the slice frequency
    slice.frequency += incr
    
    let center = ((slice.frequency + slice.filterHigh) + (slice.frequency + slice.filterLow))/2
    // moving which way?
    if incr > 0 {
      // UP, too close to the high end?
      isTooClose = center > _end - Int(kEdgeTolerance * CGFloat(_bandwidth))
      
    } else {
      // DOWN, too close to the low end?
      isTooClose = center + incr < _start + Int(kEdgeTolerance * CGFloat(_bandwidth))
    }
    
    // is the new freq too close to an edge?
    if isTooClose  {
      
      // YES, adjust the panafall center frequency (scroll the Panafall)
      panadapter!.center += incr
      
      _panadapterViewController?.redrawFrequencyLegend()
    }
    // redraw all the slices
    _panadapterViewController?.redrawSlices()
  }
}