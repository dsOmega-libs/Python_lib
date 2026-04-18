import logging
from rich.logging import RichHandler

def main():
    """Generate a greeting message.

    This function returns a simple greeting string that can be used
    as a starting point for the application.

    :return: A greeting message string
    :rtype: str
    """
    log = logging.getLogger("test")
    log.addHandler(RichHandler())
    log.info("test")
    return 'Hello World!'


if __name__ == "__main__":
    result = main()
    print(result)
