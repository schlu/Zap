#
#  ApplicationListHeaderView.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/20/11.
#  Copyright 2011 Chalk. All rights reserved.
#

class ApplicationListHeaderView < JAObjectListViewItem
    attr_accessor :gradient, :selected, :linkedApplications
    
    @@nib = nil
    
    def self.headerView
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
        linkedApplications.stringValue = "#{AppState.instance.applications.count} applications"
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

    def create_symlink(sender)
        dialog = NSOpenPanel.openPanel
        dialog.canChooseFiles = false
        dialog.canChooseDirectories = true
        dialog.allowsMultipleSelection = false
        
        # Display the dialog and process the selected folder
        if dialog.runModalForDirectory(nil, file:nil) == NSOKButton
            # if we had a allowed for the selection of multiple items
            # we would have want to loop through the selection
            AppState.instance.link_directory dialog.filenames.first
        end
    end

    def setSelected(arg)
        @selected = arg
    end
end
