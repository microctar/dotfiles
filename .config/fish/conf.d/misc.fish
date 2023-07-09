function mangaview -d "command to view manga"
  if test ( count $argv ) -gt 0
    feh --class "mangaviewer" \
        --sort "name" \
        --keep-zoom-vp \
        -x $argv[1]
  end
end
