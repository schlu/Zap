#
#  AppState.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/17/11.
#  Copyright 2011 Chalk. All rights reserved.
#


class AppState
    attr_accessor :applications
    
    @@pow_dir = File.join(Dir.home, "Library/Application Support/Pow/Hosts")
    
    def refresh_applications
        error = Pointer.new :object
        sym_links = NSFileManager.defaultManager.contentsOfDirectoryAtPath(@@pow_dir, error:error)
        self.applications = sym_links.collect do |sl|
            applicaiton = RackApplication.new
            applicaiton.symlink = sl
            directory = NSFileManager.defaultManager.destinationOfSymbolicLinkAtPath(File.join(@@pow_dir, sl), error:error)
            directory = directory.gsub(Dir.home, "~")
            applicaiton.directory = directory
            applicaiton
        end
    end
    
    def link_directory(directory)
        link_name = File.basename(directory)
        error = Pointer.new :object
        NSFileManager.defaultManager.createSymbolicLinkAtPath(File.join(@@pow_dir, link_name), withDestinationPath:directory, error:error)
        NSApplication.sharedApplication.delegate.reload_application
    end
    
    def delete_link_name(link_name)
        File.delete(File.join(@@pow_dir, link_name))
        NSApplication.sharedApplication.delegate.reload_application
    end
    
    @@instance = self.new
    def self.instance
        @@instance
    end
end