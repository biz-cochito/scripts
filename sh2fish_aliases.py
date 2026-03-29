"""
Convert POSIX-style (bash/zsh/etc.) aliases to fish abbreviations.
Usage: python3 aliases2fish.py <input_file> [output_file]
"""
import re
import sys
import os

class Color:
    RED = "\033[31m"
    GREEN = "\033[32m"
    YELLOW = "\033[33m"
    BLUE = "\033[34m"
    RESET = "\033[0m"

def escape_for_fish(cmd):
    """
    Escapes a command string for Fish shell.
    Fish uses \' to represent a single quote inside a single-quoted string.
    """
    if not cmd:
        return ""
    # 1. Escape any existing backslashes first to avoid double-escaping
    # 2. Escape single quotes so they don't terminate the Fish 'abbr' string
    return cmd.replace("\\", "\\\\").replace("'", "\\'")


def convert_to_fish(input_path, output_path):
    output_dir = os.path.dirname(output_path)
    if output_dir and not os.path.exists(output_dir):
        os.makedirs(output_dir)

    file_exists = os.path.isfile(output_path)

    # Improved regex to capture the full command regardless of outer quote type
    # Group 1: alias name, Group 2: the command inside the quotes
    alias_pattern = re.compile(r'^alias\s+([a-zA-Z0-9_\-\.]+)=[\'"](.*)[\'"]\s*$')
    param_pattern = re.compile(r"\$\d+|\$@|\$\*")

    try:
        with open(input_path, "r") as infile, open(output_path, "a") as outfile:
            if file_exists:
                outfile.write("\n")

            outfile.write(f"# Appended from {input_path}\n")

            for line in infile:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue

                match = alias_pattern.match(line)
                if match:
                    name = match.group(1)
                    raw_cmd = match.group(2)

                    # Handle positional parameters ($1, $@) -> Fish Functions
                    if param_pattern.search(raw_cmd):
                        # Convert bash vars to fish vars
                        cmd_fish = raw_cmd.replace("$@", "$argv").replace("$*", "$argv")
                        cmd_fish = re.sub(r"\$(\d+)", r"$argv[\1]", cmd_fish)

                        outfile.write(f"function {name}\n")
                        outfile.write(f"    {cmd_fish} $argv\n")
                        outfile.write(f"end\n")

                    # Handle standard abbreviations with nested quote protection
                    else:
                        escaped_cmd = escape_for_fish(raw_cmd)
                        outfile.write(f"abbr --add {name} '{escaped_cmd}'\n")
                else:
                    if line.startswith("alias"):
                        outfile.write(f"# Manual review needed: {line}\n")

        print(f"{Color.GREEN}Success: {Color.RESET}Auto-generated Fish abbreviations and functions appended to: {os.path.abspath(output_path)}")

    except FileNotFoundError:
        print(f"{Color.RED}Error: {Color.RESET}Input file '{input_path}' not found.")
    except Exception as e:
        print(f"{Color.RED}Error: {Color.RESET}{e}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 aliases2fish.py <input_file> [output_file]")
        sys.exit(1)
        
    input_path = sys.argv[1]
    
    if len(sys.argv) >= 3:
        output_path = sys.argv[2]
    else:
        xdg_config_home = os.environ.get("XDG_CONFIG_HOME", os.path.expanduser("~/.config"))
        output_path = os.path.join(xdg_config_home, "fish", "conf.d", "converted_aliases.fish")
        
    convert_to_fish(input_path, output_path)
