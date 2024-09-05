#!/bin/bash

# Directory containing your dotfiles
mkdir "$HOME/dotfiles"
DOTFILES_DIR="$HOME/dotfiles"
  
# Directory for storing current dotfiles
mkdir "$HOME/dotfiles_backup"
BACKUP_DIR="$HOME/dotfiles_backup"

shopt -s dotglob

# Check if stow is installed
if ! command -v stow &> /dev/null
then
    echo "stow could not be found. Please install it first."
    exit 1
fi

# Backup the .config folder
backup_config() {
  echo "mv $HOME/.config $BACKUP_DIR/.config"
  echo ""
}

# Backup the other dotfiles that we want to stow
backup_dotfiles() {
  local package="$1"

  for item in "$package"/*; do
    # Skip current and parent directory entries
    [[ "$item" == "$package/." || "$item" == "$package/.." ]] && continue
    
    # Debug message to see the name of the item
    echo "moving: $item"
    
    # relative path, gives the path from the dotfiles directory
    local relative_path="${item#$package}"
        
    # Debug message to see of the name of the relative path is correct
    echo "relative_path: $relative_path"
    
    if [ "$relative_path" = "/.config" ]; then
      echo config!!
      continue
    fi

    echo "mv $HOME$relative_path $BACKUP_DIR$relative_path"
    echo ""


  done
}

# Stow packages
stow_package() {
  local package="$1"

  echo "stow $package"
}

# Iterate over each folder in the dotfiles directory
backup_config

for dir in "$DOTFILES_DIR"/*; do
  # Get the base name of the directory
  base_dir=$(basename "$dir")
    
  [[ "$dir" == "$DOTFILES_DIR/.git" ]] && continue

  backup_dotfiles "$dir"
done

for dir in "$DOTFILES_DIR"/*; do
  [[ "$dir" == "$DOTFILES_DIR/.git" ]] && continue

  stow_package $dir
done

echo "Dotfiles setup completed."
