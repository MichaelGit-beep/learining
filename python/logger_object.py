import logging
import os
from logging.handlers import RotatingFileHandler


logger = logging.getLogger(__file__)


formater = logging.Formatter("%(levelname)s - %(asctime)s - %(filename)s - on line %(lineno)d: %(message)s")

stream_h = logging.StreamHandler()
file_h = logging.FileHandler(f"{os.path.dirname(__file__)}\\log.log")
rotated_file = RotatingFileHandler(f"{os.path.dirname(__file__)}\\ROtating.log", maxBytes=10000, backupCount=2)


file_h.setLevel(logging.INFO)
stream_h.setLevel(logging.INFO)
rotated_file.setLevel(logging.DEBUG)


file_h.setFormatter(formater)
stream_h.setFormatter(formater)
rotated_file.setFormatter(formater)

logger.setLevel(logging.DEBUG)
logger.addHandler(stream_h)
logger.addHandler(file_h)
logger.addHandler(rotated_file)

# # How to use thi costum logger object 

# from logger_object import logger

# logger.debug('This message should go to the log file')
# logger.info('So should this')
# logger.error('This message should go to the log fileAnd this, too')
# logger.warning('And this, too')
