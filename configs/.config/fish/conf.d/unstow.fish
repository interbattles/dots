function unstow
  mv "$argv[1]" "$argv[1].sym" 
  if cp -r $(readlink "$argv[1].sym") $argv[1]
    rm -r "$argv[1].sym" 
    echo 'success'
  else
    mv "$argv[1].sym" "$argv[1]"
    echo 'failed to read location' >&2
  end
end
