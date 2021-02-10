#  Include all rules by default
all


#  Rule Modifications
#  ----------------------------------------------------------------------------
## MD029 - tells linter to allow ordered lists that will increment by 1.  By
## default (w/o modification) the linter doesn't accept lists structured like:
## 1. List item #1
## 2. List item #2
## 3. List item #3
rule 'MD029', :style => :ordered


#  Exclude the following linter rules that conflict with the team's Markdown
#  writing preferences.
#  ----------------------------------------------------------------------------
# MD002 - First header should be an h1 header. This conflicts with the way we
# 		  parse blog post h1 tags into the posts via templates
exclude_rule 'MD002'

## MD013 - Line length.  Disabled unless can determine automated way to fix.
exclude_rule 'MD013'

## MD024 - Multiple headers with the same content
exclude_rule 'MD024'

## MD033 - Inline HTML - used for Markdown purists
exclude_rule 'MD033'

## MD034 - Bare URL used, meaning not enclosed in < >
exclude_rule 'MD034'


#  Excluding these rules until content can be re-worked to adhere to the rules
#  ----------------------------------------------------------------------------
## MD022 - Headers should be surrounded by blank lines
exclude_rule 'MD022'

## MD026 - Trailing punctuation in header
exclude_rule 'MD026'

## MD032 - Lists should be surrounded by blank lines
exclude_rule 'MD032'

## MD026 - Emphasis used instead of a header
exclude_rule 'MD036'

## MD041 First line in file should be a top level header
exclude_rule 'MD041'
