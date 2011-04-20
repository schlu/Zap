#
#  AppState.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/17/11.
#  Copyright 2011 Chalk. All rights reserved.
#


class AppState
    attr_accessor :applications
    
    def refresh_applications
        path = File.join(Dir.home, "Library/Application Support/Pow/Hosts")
        error = Pointer.new :object
        sym_links = NSFileManager.defaultManager.contentsOfDirectoryAtPath(path, error:error)
        self.applications = sym_links.collect do |sl|
            applicaiton = RackApplication.new
            applicaiton.symlink = sl
            directory = NSFileManager.defaultManager.destinationOfSymbolicLinkAtPath(File.join(path, sl), error:error)
            directory = directory.gsub(Dir.home, "~")
            applicaiton.directory = directory
            applicaiton
        end
    end
    
    def linkDirectory(directory)
        pow_dir = File.join(Dir.home, "Library/Application Support/Pow/Hosts")
        link_name = File.basename(directory)
        error = Pointer.new :object
        NSFileManager.defaultManager.createSymbolicLinkAtPath(File.join(pow_dir, link_name), withDestinationPath:directory, error:error)
    end
    
    @@instance = self.new
    def self.instance
        @@instance
    end
end