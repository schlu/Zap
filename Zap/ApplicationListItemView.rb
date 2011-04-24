#
#  ApplicationListItemView.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/19/11.
#  Copyright 2011 Chalk. All rights reserved.
#


class ApplicationListItemView < JAObjectListViewItem
    attr_accessor :gradient, :application, :symlink, :directory, :url, :selected
    
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
        directory.stringValue = hyperlinkFromString(application.directory, withURL:NSURL.URLWithString("file://#{application.directory}"))
        url.stringValue = hyperlinkFromString("http://#{application.symlink}.dev/", withURL:NSURL.URLWithString("http://#{application.symlink}.dev/"))
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

    def reveal_in_finder
        NSWorkspace.sharedWorkspace.selectFile(application.directory, inFileViewerRootedAtPath:nil)
    end

    def remove(sender)
        alert = NSAlert.alertWithMessageText("This will permanently remove #{application.symlink} from pow", defaultButton:"Continue", alternateButton:"Cancel", otherButton:nil, informativeTextWithFormat:"")
        if alert.runModal == NSAlertDefaultReturn
            AppState.instance.delete_link_name application.symlink
        end
    end

    def open
        url = NSURL.URLWithString("http://#{application.symlink}.dev/")
        NSWorkspace.sharedWorkspace.openURL(url)
    end

    def labelClicked(sender)
        if sender == directory
            reveal_in_finder
        else
            open
        end
    end

    def hyperlinkFromString(inString, withURL:aURL)
        attrString = NSMutableAttributedString.new.initWithString(inString)
        range = NSMakeRange(0, attrString.length)
        
        attrString.beginEditing
        attrString.addAttribute(NSForegroundColorAttributeName, value:NSColor.blueColor, range:range)
        attrString.addAttribute(NSUnderlineStyleAttributeName, value:NSNumber.numberWithInt(NSSingleUnderlineStyle), range:range)
        #The next two attributes don't appear to work in MacRuby or I am dumb
        attrString.addAttribute(NSLinkAttributeName, value:aURL, range:range)
        attrString.addAttribute(NSCursorAttributeName, value:NSCursor.pointingHandCursor, range:range)
        
        attrString.endEditing
        attrString
    end
end
