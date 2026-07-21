{ pkgs }: {
  deps = [
    pkgs.python310
    pkgs.ffmpeg
    pkgs.aria2
    pkgs.megatools
    pkgs.cacert
    pkgs.p7zip
    # RAR support (archive.py's /unzip) needs the proprietary `unrar` tool,
    # which lives in nixpkgs' unfree set. Uncomment BOTH lines below if you
    # need RAR extraction on Replit — p7zip alone already covers zip/7z/
    # tar/gz/bz2/xz.
    # pkgs.unrar
  ];
  env = {
    # NIXPKGS_ALLOW_UNFREE = "1";  # required if you uncomment pkgs.unrar above
    #
    # NOTE: pkgs.chromium removed — this Repl's nixpkgs channel builds it
    # from source (pulseaudio/libasyncns etc.) and fails/hangs. Not needed
    # anyway: Akbots/headless.py's playwright fallback self-installs its
    # own chromium binary on first use (see requirements.txt), though on
    # Replit specifically that binary is likely to still fail to actually
    # LAUNCH even once downloaded — it needs OS-level shared libraries
    # (libnss3, libgbm1, libasound2, etc.) that Replit's base image doesn't
    # ship and that couldn't safely be added here without knowing exactly
    # which package names exist on this Repl's pinned nixpkgs channel (a
    # previous attempt at this used a package name invalid on this channel
    # and broke deployment entirely — reverted). If you want headless
    # JS-rendering (used for Voot/Zee5-style or PocketFM-style sites) to
    # actually work on Replit, the reliable path is Docker/Render instead,
    # where the Dockerfile's `playwright install --with-deps chromium`
    # step is known to work. Everything that depends on headless.py
    # degrades gracefully (falls through to the next fallback) when it's
    # unavailable, so the bot still runs fine on Replit without it.
    #
    # NOTE: pkgs.python312 removed — not available on this Repl's nixpkgs
    # channel (only up to python310 here). runtime.txt bumped to match.
  };
}
