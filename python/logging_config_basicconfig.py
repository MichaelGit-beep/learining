import logging
logging.basicConfig(
    level=logging.INFO,
    handlers=[logging.FileHandler("D:\\logs.log"), logging.StreamHandler()],
    format=f'[%(asctime)s] %(filename)s on line %(lineno)s: %(message)s )'
)
logging.debug('This is a debug message')
logging.info('This is an info message')
logging.warning('This is a warning message')
logging.error('This is an error message')
logging.critical('This is a critical message')