## Mac
- Jump to beginning of a line – Command+Left Arrow
- Jump to end of a line – Command+Right Arrow
- Jump to beginning of current word – Option+Left Arrow
- Jump to end of current word – Option+Right Arrow
- Jump to beginning of all text – Command+Up Arrow
- Jump to end of all text – Command+Down Arrow
Add Shift to any of those to make selections.

- Change keyboard language – Control+Space
- Mount external Network – Command+K (in Finder)

## Bash
- Jump to beginning of a line – Command+A
- Jump to end of a line – Command+E
- Jump back one word – Option+B
- Jump forward one word – Option+F
- Cut (and copy) the part of the selected line after the cursor –  Command+K
- Clean current screen – Command+L
- Enter the Newline control character – Command+J
- Search in your Bash history – Command+R
- Exit the history history search mode – Command+G

- command line enter bug fix – stty sane [2x enter]
- command line enter bug fix – reset (not validated yet)

## Slurm
- change to a random cpu node – srun --reservation interactive --pty bash
- change to a random gpu node and reserve it for 8h– srun --partition=g --gres=gpu:1 --time=8:00:00 --mem=10g  --reservation=interactive --pty bash
- reserve it for 3 days– srun --partition=g --gres=gpu:1 --time=3-00:00:00 --mem=10g  --reservation=interactive --pty bash
- submits a slurm job– sbatch
  They are bash scripts that define the specific partition that you want to use for the job.
- list my current jobs– squeue | grep peter
- kill my job– scancel <job-id>


## vim
- Enter command mode – Esc
- Jump to beginning of a line – 0
- Jump to first non-empty character of line – ^
- Jump to end of a line – $
- Jump to previous, next
	- sentence – ( , )
	- paragraph – { , }
	- section – [[ , ]]
	- section end – [] , ][
- Jump to beginning of file – gg
- Jump to end of file – G
- Move forward one word – w
- Move forward five word – 5w
- Move back one word – b
- Move back five word – 5b
- Insert text after the cursor – a
- Insert text at end of line – A
- Insert text before the cursor – i
- Execute command and insert output below cursor – :r ![command]

- Select mode – v
- Select line and enter select mode – V
	- switch case – ~
	- delete – d
	- filter through external command – !

- Delete a word – dw
- Delete a line – dd
- Delete three lines– 3dd
- Delete to beginning of line – d0
- Delete to end of line – d$
- Delete to end of sentence – d)
- Delete to beginning of file – dgg
- Delete to end of file – dG

- Search forward – /
- Search backward – ?
- Move to next search hit – n
- Move to previous search hit – N
- replace first hit – %s/original/replacement
- replace all hits – %s/original/replacement/g
- confirm replacement of hits – %s/original/replacement/gc
- Undo – u
- Redo undo – Cmd+r

## JupyterLab 
### Shortcuts in both modes:
- Run the current cell, select below – Shift+Enter
- Run selected cells – Command+Enter
- Run the current cell, insert below – Option+Enter
- Save and checkpoint – Command+S

### While in command mode:
- Show all shortcuts – H
- extend selected cells – Shift+Up/Down
- insert cell above – A
- insert cell below – B
- Cut selected cells – X
- Copy selected cells – C
- Paste cells below – V
- Paste cells above – Shift+V
- Delete selected cells – D,D
- Undo cell deletion – Z
- Save and Checkpoint – S
- Change the cell type to Code – Y
- Change the cell type to Markdown – M
- Open the command palette – P
- Scroll notebook up – Shift+Space
- Scroll notebook down – Space
- Hide cell - left mouse click on blue bar of selection

### While in edit mode:
- (Un-)comment blocks – Command+/
- Code completion or indent – Tab
- Indent – Command+]
- Dedent – Command+[
- Undo – Command+Z
- Redo – Command+Shift+Z / Command+Y
- Go to cell start – Command+Home
- Go to cell end – Command+End
- Go one word left/right – Command+Left/Right
- Open the command palette – Command+Shift+P
- Split cell into two at cursor – Command+Shift+-
- Merge selected cells – Shift+M
- Find and replace – Esc+F


## Firefox Browser
- Switch to next tab – Option+Command+Right Arrow
- Switch to previous tab – Option+Command+Left Arrow
- Go back – Backspace
- Reload current page – Command+R
- Close current tab – Command+W
- Open new tab – Command+N
- Open new private window – Command+Shift+P
- Find text – Command+F
- Bring search bar into focus – Command+K
- Exit Firefox – Command+Shift+Q
