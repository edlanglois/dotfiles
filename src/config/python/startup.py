# Python startup script
import atexit
import os


def register_xdg_history_file():
    """Maintain the REPL history file at $XDG_DATA_DIR/python/history

    Reference https://docs.python.org/3.11/library/readline.html
    """
    data_dir = os.environ.get("XDG_DATA_DIR")
    if not data_dir:
        home = os.environ.get("HOME")
        if not home:
            home = os.path.expanduser("~")
        data_dir = os.path.join(home, ".local", "share")
    histfile = os.path.join(data_dir, "python", "history")

    try:
        readline.read_history_file(histfile)
        h_len = readline.get_current_history_length()
    except FileNotFoundError:
        os.makedirs(os.path.dirname(histfile), exist_ok=True)
        open(histfile, "wb").close()
        h_len = 0

    def save(prev_h_len, histfile):
        new_h_len = readline.get_current_history_length()
        readline.set_history_length(1000)
        readline.append_history_file(new_h_len - prev_h_len, histfile)

    atexit.register(save, h_len, histfile)


try:
    # Readline is missing in at least one case I've experienced. Not sure why.
    # Avoid the failure anyways.
    import readline
except ImportError:
    pass
else:
    register_xdg_history_file()
