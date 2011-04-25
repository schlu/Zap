#
#  NSTextFieldMixin.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/25/11.
#  Copyright 2011 Chalk. All rights reserved.
#


module NSTextFieldMixin
    def setWidthBasedOnCurrentFont
        self.width = self.stringValue.sizeWithAttributes({NSFontAttributeName => self.font}).width+10
    end
end

class NSTextField
    include(NSTextFieldMixin)
end