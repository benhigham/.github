Triage the current issue (or issue $ARGUMENTS if specified).

## Context

- !`gh issue view --json title,body,labels,author`
- !`gh issue list --state open --limit 20 --json title,number,labels`

## Steps

1. Categorise: bug / feature / question / improvement / docs
2. Assess priority: critical / high / medium / low
3. Check for duplicates — compare against open issues listed above
4. Add appropriate labels using `gh issue edit --add-label`
5. If duplicate found: comment linking to the original and close with `gh issue close`
6. Post a triage comment summarising: category, priority, related issues, suggested
   next steps
