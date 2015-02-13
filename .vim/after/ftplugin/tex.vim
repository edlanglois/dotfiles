set nofoldenable " Disable code folding - slow with syntax
syntax sync minlines=50

set conceallevel=2

" left( right) mappints
call IMAP(';(', '\left(', 'tex')
call IMAP(';)', '\right)', 'tex')
call IMAP(';{', '\left\{', 'tex')
call IMAP(';}', '\right\}', 'tex')
call IMAP(';[', '\left[', 'tex')
call IMAP(';]', '\right]', 'tex')
