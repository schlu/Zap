#
#  ApplicationListItemView.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/19/11.
#  Copyright 2011 Chalk. All rights reserved.
#


class ApplicationListItemView < JAObjectListViewItem
    attr_accessor :gradient, :application, :symlink, :directory, :selected
    
    @@nib = nil
    
    def self.itemView
        if @@nib.nil?
            @@nib = NSNib.new.initWithNibNamed(self.to_s, bundle:nil)
        end
        @selected = false
        objects = Pointer.new(:object)
        @@nib.instantiateNibWithOwner(nil, topLevelObjects:objects);
        objects[0].find {|object| object.instance_of? self}
    end
                
    def drawRect(rect)
        super
        drawBackground
        symlink.stringValue = application.symlink
        directory.stringValue = application.directory
    end

    def gradient
        if @gradient.nil?
            @gradient = NSGradient.new.initWithStartingColor(NSColor.colorWithDeviceWhite(0.8, alpha:1.0), endingColor:NSColor.colorWithDeviceWhite(0.85, alpha:1.0))
        end
            
        @gradient;
    end
                
                
    def drawBackground 
        gradient.drawInRect(self.bounds, angle:(self.selected ? 270.0 : 90.0))
        NSColor.colorWithDeviceWhite(0.5, alpha:1.0).set
        NSRectFill(NSMakeRect(0.0, 0.0, self.bounds.size.width, 1.0))
        NSColor.colorWithDeviceWhite(0.93, alpha:1.0).set
        NSRectFill(NSMakeRect(0.0, self.bounds.size.height - 1.0, self.bounds.size.width, 1.0));
    end

    def reveal_in_finder(sender)
        NSWorkspace.sharedWorkspace.selectFile(application.directory, inFileViewerRootedAtPath:nil)
    end
end
