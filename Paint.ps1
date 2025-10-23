Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing




# Main GUI window
$formWindow = New-Object System.Windows.Forms.Form

$formWindow.Text = "Paint!"
$formWindow.Width = 1200
$formWindow.Height = 800

# Menu objects
$mainMenu = New-Object System.Windows.Forms.MenuStrip
$mainToolStrip = New-Object System.Windows.Forms.ToolStrip

$fileMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$editMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$undoMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$redoMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$saveMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$exitMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$helpMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$aboutMenu = New-Object System.Windows.Forms.ToolStripMenuItem

$saveToolStrip = New-Object System.Windows.Forms.ToolStripButton
$editToolStrip = New-Object System.Windows.Forms.ToolStripButton
$exitToolStrip = New-Object System.Windows.Forms.ToolStripButton
$aboutToolStrip = New-Object System.Windows.Forms.ToolStripButton
$undoToolStrip = New-Object System.Windows.Forms.ToolStripButton
$redoToolStrip = New-Object System.Windows.Forms.ToolStripButton

# Menu bar buttons
$formWindow.MainMenuStrip = $mainMenu
$formWindow.Controls.Add($mainMenu)
[void]$formWindow.Controls.Add($mainToolStrip)

[void]$formWindow.Controls.Add($mainMenu)
$fileMenu.Text = "File"
[void]$mainMenu.Items.Add($fileMenu)

$saveMenu.Text = "Save"
$saveMenu.Add_Click({SaveFile})
[void]$fileMenu.DropDownItems.Add($saveMenu)

$exitMenu.Text = "Exit"
$exitMenu.Add_Click({$formWindow.Close()})
[void]$fileMenu.DropDownItems.Add($exitMenu)

[void]$formWindow.Controls.Add($editMenu)
$editMenu.Text = "Edit"
[void]$mainMenu.Items.Add($editMenu)

$undoMenu.Text = "Undo"
$undoMenu.Add_Click({UndoEdit})
[void]$editMenu.DropDownItems.Add($undoMenu)

$redoMenu.Text = "Redo"
$redoMenu.Add_Click({RedoEdit})
[void]$editMenu.DropDownItems.Add($redoMenu)

$helpMenu.Text = "Help"
[void]$mainMenu.Items.Add($helpMenu)

$aboutMenu.Text = "About"
$aboutMenu.Add_Click({ShowAbout})
[void]$helpMenu.DropDownItems.Add($aboutMenu)

# Button functions
function SaveFile {

}

function UndoEdit {

}


function RedoEdit {

}

function ShowAbout {
    [void] [System.Windows.MessageBox]::Show("

    Ctrl+S:                   Save

    Ctrl+Z:                   Undo

    Ctrl+Shift+Z:         Redo

    Ctrl+L:                    exit

    ", "Help")
}

#Show window
$formWindow.ShowDialog()