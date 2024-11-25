{ pkgs, user, overlays, ... }: {

  nixpkgs.overlays = overlays;

  fonts = {
    packages = with pkgs; [
      sf-mono-liga-bin
    ];
  };

  
  homebrew = {
    # enable = true;

    brews = [
      # "go" # install for system to use apple sdk frameworks unavailable to nixpkgs
    ];
  };

  programs.zsh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.pathsToLink = ["/share/zsh"];

  environment.etc."pam.d/sudo_local".text = ''
    # Managed by Nix Darwin
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
    auth       sufficient     pam_tid.so
  '';

  services.nix-daemon.enable = true;

  nix = {
    settings = {
      cores = 0;
      max-jobs = 10;
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "@wheel"
        user.unixname
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  security.pam.enableSudoTouchIdAuth = true;

  system.stateVersion = 5;

  users.users.${user.unixname} = {
    name = user.unixname;
    home = "/Users/${user.unixname}";
  };

  time.timeZone = "America/Los_Angeles";

  system.defaults = {
    ActivityMonitor = {
      OpenMainWindow = true;
      IconType = 5;
      ShowCategory = 100;
    };

    LaunchServices = {
      LSQuarantine = false;
    };

    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      AppleMeasurementUnits = "Inches";
      AppleMetricUnits = 0;
      ApplePressAndHoldEnabled = false;
      AppleShowScrollBars = "Always";
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSTextShowsControlCharacters = true;
      NSWindowResizeTime = 0.001;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
    };

    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
      expose-animation-duration = 0.1;
      expose-group-by-app = true;
      launchanim = false;
      mineffect = "scale";
      minimize-to-application = false;
      mru-spaces = false;
      persistent-apps = [
        "/System/Applications/Notes.app"
        "/Applications/1Password.app"
        "/Applications/Arc.app"
        "/Users/tom/Applications/Slack.app"
        "/Applications/Notion.app"
        "/Applications/Linear.app"
        "/Applications/iTerm.app"
        "/Applications/Cursor.app"
        "/Users/tom/Applications/DataGrip.app"
        "/Applications/Claude.app"
        "/System/Applications/Utilities/Activity Monitor.app"
      ];
      persistent-others = [
        "/Users/${user.unixname}/Documents"
        "/Users/${user.unixname}/Downloads"
      ];
      show-recents = false;
      static-only = false;
      show-process-indicators = false;
      tilesize = 64;
      wvous-tl-corner = 2; # Top left screen corner → Notification Center
      wvous-tr-corner = 12; # Top right screen corner → Mission Control
      wvous-bl-corner = 3; # Bottom left screen corner → Application Windows
      wvous-br-corner = 4; # Bottom right screen corner → Desktop
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      _FXSortFoldersFirst = true;
      ShowPathbar = true;
    };

    SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = true;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  system.activationScripts.postActivation.text = ''
    ########################################
    # Energy saving                        #
    ########################################
    # Enable lid wakeup
    pmset -a lidwake 1

    # Restart automatically on power loss
    pmset -a autorestart 1

    # Disable machine sleep while charging
    pmset -c sleep 0

    # Never go into computer sleep mode
    sudo systemsetup -setcomputersleep Off > /dev/null

    # Hibernation mode
    # 0: Disable hibernation (speeds up entering sleep mode)
    # 3: Copy RAM to disk so the system state can still be restored in case of a
    #    power failure.
    pmset -a hibernatemode 0

    ########################################
    # Finder                               #
    ########################################
  
    # Finder: disable window animations and Get Info animations
    defaults write com.apple.finder DisableAllAnimations -bool true #
    
    # Avoid creating .DS_Store files on network or USB volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # Use list view in all Finder windows by default
    # Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false
        
    # Expand the following File Info panes:
    # “General”, “Open with”, and “Sharing & Permissions”
    defaults write com.apple.finder FXInfoPanesExpanded -dict \
        General -bool true \
        OpenWith -bool true \
        Privileges -bool true

    # Show the ~/Library folder
    chflags nohidden ~/Library

    ########################################
    # Mac App Store                        #
    ########################################

    # Enable the WebKit Developer Tools in the Mac App Store
    defaults write com.apple.appstore WebKitDeveloperExtras -bool true

    # Enable the automatic update check
    defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

    # Check for software updates daily, not just once per week
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

    # Download newly available updates in background
    defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

    # Install System data files & security updates
    defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

    # Turn on app auto-update
    defaults write com.apple.commerce AutoUpdate -bool true
    '';
}
