import os
import emoji

file_list = []

with os.scandir(".") as entries:
    for entry in entries:
        if entry.is_file():
            file_list.append(entry)


def get_clean_title(title):
    """
    Return a string with the emoji replaced and whitespace stripped.
    """
    title = emoji.replace_emoji(title, replace="")
    title = title.strip()
    return title


def clean_all_titles(dir_path=None):
    """
    Clean all the titles in the given directory (or the current working directory if none is provided).
    """
    # for root, dirs, files in os.walk(os.getcwd()):
    clean_titles = []

    for file in file_list:
        print(os.path.join(root, name))
