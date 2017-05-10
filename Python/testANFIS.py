from fuzzyErrorTest import *
import glob, os, sys
import logging
import matlab.engine

# validation_data_csv = sys.argv[1]
#
# log_filename = []
# log_filename.append('anfis_test_')
# log_filename.append(validation_data_csv[:-4])
# log_filename.append('.log')
# log_filename = ''.join(log_filename)

log_filename = 'testANFIS.log'
logging.basicConfig(filename=log_filename, level=logging.INFO, format='%(asctime)s %(message)s')

try:
    # will also store the final pickle file with the CSV filename and the number of epochs used
    names = matlab.engine.find_matlab()

    print names[0]
    eng = matlab.engine.connect_matlab(names[0])

    # validation_x = eng.workspace['validation_x']
    # validation_y = eng.workspace['validation_y']
    #
    # validation_vertical = eng.workspace['validation_vertical']
    # validation_horizontal = eng.workspace['validation_horizontal']

    validation_input = eng.workspace['validation_input']
    validation_output = eng.workspace['validation_output']

    logging.info('Logging Data for testANFIS')

    min_total_error = float("inf")

    for pickle_file in glob.glob("*.pkl"):
        print(pickle_file)
        logging.info("PICKLE FILE: %s", pickle_file)

        with open(pickle_file, 'rb') as f:
            anf = pickle.load(f)
        total_error, average_error = fuzzy_error_test(anf, validation_input, validation_output)
        print "total error", total_error
        logging.info("Total Error: %s", total_error)
        logging.info("Average Error: %s", average_error)

        if total_error < min_total_error:
            min_total_error = total_error
            min_total_error_pickle = pickle_file

    logging.info("The best pickle is: %s", min_total_error_pickle)
    logging.info("With a total error of: %s", min_total_error)

except:
    logging.exception('An exception has occured!!')
    raise
