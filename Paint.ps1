Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing






$formWindow = New-Object System.Windows.Forms.Form

$formWindow.Text = "Paint!"
$formWindow.Width = 1200
$formWindow.Height = 800

$formWindow.ShowDialog()