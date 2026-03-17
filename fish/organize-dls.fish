#!/usr/bin/env fish

set SOURCE_DIR "$HOME/Downloads/"

set IMAGES_DIR "$SOURCE_DIR/Images"
set VIDEOS_DIR "$SOURCE_DIR/Videos"
set DOCS_DIR "$SOURCE_DIR/Docs"
set ARCHIVES_DIR "$SOURCE_DIR/Archives"
set OTHERS_DIR "$SOURCE_DIR/Others"

set IMAGES_COUNT 0
set VIDEOS_COUNT 0
set DOCS_COUNT 0
set ARCHIVES_COUNT 0
set OTHERS_COUNT 0

# Create directories if they don't exist
mkdir -p $IMAGES_DIR $VIDEOS_DIR $DOCS_DIR $ARCHIVES_DIR $OTHERS_DIR

# Define file type categories
set IMAGE_EXTENSIONS "jpg" "jpeg" "png" "gif" "bmp" "tiff" "webp" "svg" "heic" "heif"
set VIDEO_EXTENSIONS "mp4" "mkv" "avi" "mov" "wmv" "flv" "webm" "mpeg" "mpg" "3gp"
set DOC_EXTENSIONS "pdf" "doc" "docx" "txt" "rtf" "odt" "xls" "xlsx" "ppt" "pptx"
set ARCHIVE_EXTENSIONS "zip" "rar" "7z" "tar" "gz" "bz2" "xz" "iso"

# Process each file in the source directory
for file in $SOURCE_DIR/*
    # Skip if it's a directory
    if test -d "$file"
        continue
    end

    # Get the file extension
    set ext (echo "$file" | awk -F. '{print tolower($NF)}')

    # Determine the destination directory based on file type
    set dest_dir "$OTHERS_DIR"
    if contains $ext $IMAGE_EXTENSIONS
        set dest_dir "$IMAGES_DIR"
        set IMAGES_COUNT (math $IMAGES_COUNT + 1)
    else if contains $ext $VIDEO_EXTENSIONS
        set dest_dir "$VIDEOS_DIR"
        set VIDEOS_COUNT (math $VIDEOS_COUNT + 1)
    else if contains $ext $DOC_EXTENSIONS
        set dest_dir "$DOCS_DIR"
        set DOCS_COUNT (math $DOCS_COUNT + 1)
    else if contains $ext $ARCHIVE_EXTENSIONS
        set dest_dir "$ARCHIVES_DIR"
        set ARCHIVES_COUNT (math $ARCHIVES_COUNT + 1)
    else
        set OTHERS_COUNT (math $OTHERS_COUNT + 1)
    end

    # Move the file
    mv "$file" "$dest_dir/"
    echo "Moved '$file' to '$dest_dir'"
end

echo "Download organization complete!"

# Print summary
echo (set_color green)"$IMAGES_COUNT"(set_color normal) "Images moved"
echo (set_color green)"$VIDEOS_COUNT"(set_color normal) "Videos moved"
echo (set_color green)"$DOCS_COUNT"(set_color normal) "Docs moved"
echo (set_color green)"$ARCHIVES_COUNT"(set_color normal) "Archives moved"
echo (set_color green)"$OTHERS_COUNT"(set_color normal) "Others moved"
