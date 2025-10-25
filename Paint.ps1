Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Main GUI window
$formWindow = New-Object System.Windows.Forms.Form
$formWindow.Text = "Paint!"
$formWindow.Width = 1100
$formWindow.Height = 750
$formWindow.BackColor = [System.Drawing.Color]::FromArgb(155,155,155)

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

$colorSidebar = New-Object System.Windows.Forms.Panel

$canvasWidth = 900
$canvasHeight = 600

$canvasMargin = 10
$canvasBox = New-Object System.Windows.Forms.PictureBox
$canvasBox.Size = New-Object System.Drawing.Size($canvasWidth, $canvasHeight)

$bitmap = New-Object System.Drawing.Bitmap($canvasWidth, $canvasHeight)
$g = [System.Drawing.Graphics]::FromImage($bitmap)

# Menu bar buttons
$colorSidebar.Dock = [System.Windows.Forms.DockStyle]::Left
$colorSidebar.Width = 100
$colorSidebar.BackColor = [System.Drawing.Color]::FromArgb(200,200,200)
$formWindow.Controls.Add($colorSidebar)

$canvasBox.Image = $canvasBitmap
$canvasBox.BackColor = [System.Drawing.Color]::FromArgb(255,255,255)

$formWindow.MainMenuStrip = $mainMenu
$formWindow.Controls.Add($mainMenu)

$fileMenu.Text = "File"
[void]$mainMenu.Items.Add($fileMenu)

$saveMenu.Text = "Save"
$saveMenu.Add_Click({SaveFile})
[void]$fileMenu.DropDownItems.Add($saveMenu)

$exitMenu.Text = "Exit"
$exitMenu.Add_Click({$formWindow.Close()})
[void]$fileMenu.DropDownItems.Add($exitMenu)

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

# Functions
function CenterCanvas {
    $x = [Math]::Max(($colorSidebar.Width + ($formWindow.ClientSize.Width - $colorSidebar.Width - $canvasBox.Height) /2), $colorSidebar.Width + $canvasMargin) # This is terrible code, calculate x from avalible space - margin*2 - sidebar 
    $y = [Math]::Max((($formwindow.ClientSize.Height - $canvasBox.Height) /2), $canvasMargin) # Even worse code, height - box height - margin
    $canvasBox.Location = New-Object System.Drawing.Point($x, $y)
}

function FillGrid {
    $gridSize = 40

    for ($x = 0; $x -lt $canvasWidth; $x += $gridSize) {
        for ($y = 0; $y -lt $canvasHeight; $y += $gridSize) {
            if ((($x / $gridSize) % 2) -bxor (($y / $gridSize) % 2)) {
                $color = 205
            } else {
                $color = 255
            }
            $color = [System.Drawing.Color]::FromArgb($color, $color, $color) # MAKE GRID LATER
            $brush = New-Object System.Drawing.SolidBrush($color)
            $g.FillRectangle($brush, $x, $y, $gridSize, $gridSize)
            $brush.Dispose()
        }
    }

    $canvasBox.Image = $bitmap

}

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

#Init funcs
CenterCanvas
FillGrid

#Show window
$formWindow.Controls.Add($canvasBox)
$formWindow.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$formWindow.MaximizeBox = $false
$formWindow.MinimizeBox = $false
$formWindow.TopMost = $true
$formWindow.ShowDialog()
