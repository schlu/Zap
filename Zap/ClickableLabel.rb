#
#  ClickableLabel.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/21/11.
#  Copyright 2011 Chalk. All rights reserved.
#


class ClickableLabel < NSTextField
    attr_accessor :clickDelegate
    
    def mouseUp(event)
        self.clickDelegate.labelClicked(self)
    end
end