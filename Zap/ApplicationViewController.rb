#
#  ApplicationViewController.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/18/11.
#  Copyright 2011 Chalk. All rights reserved.
#

class ApplicationViewController < NSViewController
    attr_accessor :label, :application
    def init
        if super
            initWithNibName "ApplicationViewController", bundle:nil
        end
        self
    end
    
    def loadView
        super
        self.label.stringValue = application.symlink
    end
end
