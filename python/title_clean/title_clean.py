import os

import emoji


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
    if dir_path is None:
        dir_path = os.getcwd()
