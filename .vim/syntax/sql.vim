
syntax match SnippetStart /\vstart\s+snippet\s+\w+(\s*(\w+)@!$)@=/ containedin=sqlComment contained
syntax match SnippetEnd     /\vend\s+snippet\s+\w+(\s*(\w+)@!$)@=/ containedin=sqlComment contained
hi def link SnippetStart Underlined
hi def link SnippetEnd Underlined

