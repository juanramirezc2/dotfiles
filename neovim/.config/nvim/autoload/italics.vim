"Add italics to group
function italics#AddItalicToGroup(group)
  redir => GroupDetails
    execute "try | silent hi ".a:group." | catch | silent echo 'error'  | endtry"
  redir END

  if GroupDetails !~ "\.error"
    " Resolve linked groups to find the root highlighting scheme
    while GroupDetails =~ "links to"
      let index = stridx(GroupDetails, "links to") + len("links to")
      let LinkedGroup =  strpart(GroupDetails, index + 1)
      redir => GroupDetails
      exe "silent hi " . LinkedGroup
      redir END
    endwhile

    echom GroupDetails
    " Extract the highlighting details (the bit after "xxx")
    let MatchGroups = matchlist(GroupDetails, '\<xxx\>\s\+\(.*\)')
    let ExistingHighlight = MatchGroups[1]
    " Check whether there's an existing gui= block
    let MatchGroups = matchlist(ExistingHighlight, '^\(.\{-}\) gui=\([^ ]\+\)\( .\{-}\)\?$')
    if MatchGroups != []
      " If there is, check whether "italic" is already in it
      let StartHighlight = MatchGroups[1]
      let GuiHighlight = MatchGroups2]
      let EndHighlight = MatchGroups[3]
      if GuiHighlight =~ '.*italic.*'
        " Already done
        return
      endif
      " Add "italic" to the gui block
      let GuiHighlight .= ',italic'
      let NewHighlight = StartHighlight . GuiHighlight . EndHighlight
    else
      " If there's no GUI block, just add one with italic in it
      let NewHighlight = ExistingHighlight . " gui=italic"
    endif

    " Create the highlighting group
    exe "hi " . a:group . " " NewHighlight
  endif
endfunction

