function Show-HeaderTPa940 {
	Write-Output "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
	Write-Output "  CSIS 3560 Assignment 5 Part 2"
	Write-Output "  Name: Teresa Pan"
	Write-Output "  ID:    300370940"
	Write-Output "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
}

# Function for Caesar Cipher
function Get-CaesarCipher {
    param (
        [string]$Message,
        [int]$Rotation
    )

    # Validate rotation
    if ($Rotation -lt 1 -or $Rotation -gt 25) {
        Write-Error "Rotation must be between 1 and 25."
        return
    }

    # Convert string to character array
    $characters = $Message.ToCharArray()

    # Process each character and apply the Caesar Cipher
    $cipheredCharacters = $characters | ForEach-Object {
        $asciiValue = [int][char]$_
        
        if ($asciiValue -ge 97 -and $asciiValue -le 122) {  # Lowercase letters
            [char]((($asciiValue - 97 + $Rotation) % 26) + 97)
        } elseif ($asciiValue -ge 65 -and $asciiValue -le 90) {  # Uppercase letters
            $_
        } else {  # Non-alphabetic characters
            $_
        }
    }

    # Join the array of characters back into a string
    -join $cipheredCharacters
}

# Main script
Show-HeaderTPa940

# Prompt the user for the message and rotation
$message = Read-Host -Prompt "Enter the message to cipher "
$rotation = Read-Host -Prompt "Enter the rotation of the cipher "

# Call the Caesar Cipher function
$cipheredMessage = Get-CaesarCipher -Message $message -Rotation $rotation

# Display the ciphered text
Write-Output "`nYour ciphered text is $cipheredMessage"