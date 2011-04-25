#
#  UIViewMixin.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/17/11.
#  Copyright 2011 Chalk. All rights reserved.
#


module SizeMixin
    def bottom
        frame.size.height + frame.origin.y 
    end
    
    def left=(att)
        new_frame = frame
        new_frame.origin.x = att
        self.frame = new_frame
    end
    
    def width=(att)
        new_frame = frame
        new_frame.size.width = att
        self.frame = new_frame
    end
end

class NSView
    include SizeMixin
end