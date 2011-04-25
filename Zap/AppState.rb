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
    
    def pow_installed?
        File.exists?(File.join(Dir.home, "Library/Application Support/Pow"))
    end
    
    def refresh_applications
        error = Pointer.new :object
        
        self.applications = symlinks_in_directoy.collect do |sl|
            applicaiton = RackApplication.new
            applicaiton.symlink = sl
            directory = NSFileManager.defaultManager.destinationOfSymbolicLinkAtPath(File.join(@@pow_dir, sl), error:error)
            directory = directory.gsub(Dir.home, "~")
            applicaiton.directory = directory
            applicaiton
        end
    end
    
    def symlinks_in_directoy
        error = Pointer.new :object
        sym_links = NSFileManager.defaultManager.contentsOfDirectoryAtPath(@@pow_dir, error:error)
    end
    
    def link_directory(directory)
        link_name = File.basename(directory)
        return if check_existing_symlink(link_name)
        error = Pointer.new :object
        NSFileManager.defaultManager.createSymbolicLinkAtPath(File.join(@@pow_dir, link_name), withDestinationPath:directory, error:error)
        NSApplication.sharedApplication.delegate.reload_application
    end
    
    def delete_link_name(link_name)
        File.delete(File.join(@@pow_dir, link_name))
        NSApplication.sharedApplication.delegate.reload_application
    end
    
    def rename_application(application, new_name)
        return if check_existing_symlink(new_name)
        File.rename(File.join(@@pow_dir, application.symlink), File.join(@@pow_dir, new_name)) 
        NSApplication.sharedApplication.delegate.reload_application
    end
    
    def check_existing_symlink(link_name)
        if symlinks_in_directoy.include? link_name
            alert = NSAlert.alertWithMessageText("An application with the name \"#{link_name}\" already exists", defaultButton:"OK", alternateButton:"", otherButton:nil, informativeTextWithFormat:"Please delete or edit the old one and try again")
            alert.runModal
            true
        else
            false
        end
    end
    
    @@instance = self.new
    def self.instance
        @@instance
    end
end