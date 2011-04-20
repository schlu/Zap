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
end

class NSView
    include SizeMixin
end