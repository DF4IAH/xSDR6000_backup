//
//  MainWindowController.swift
//  xSDR6000
//
//  Created by Douglas Adams on 3/1/17.
//  Copyright © 2017 Douglas Adams. All rights reserved.
//

import Cocoa
import xLib6000

// --------------------------------------------------------------------------------
// MARK: - Main Window Controller class implementation
// --------------------------------------------------------------------------------

final class MainWindowController                  : NSWindowController {
  
  // ----------------------------------------------------------------------------
  // MARK: - Overridden methods
  
  override func awakeFromNib() {
    windowFrameAutosaveName = "MainWindow"
  }
}
