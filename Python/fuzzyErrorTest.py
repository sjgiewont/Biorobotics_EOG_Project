from myAnfis import anfis
import membership #import membershipfunction, mfDerivs
import numpy
import timeit
import cPickle as pickle


def fuzzy_error_test(anf, validation_input, validation_output):
    # test_xyz = numpy.loadtxt(test_table_csv, delimiter=',', usecols=[0, 1, 2])
    # test_angles = numpy.loadtxt(test_table_csv, delimiter=',', usecols=[3, 4, 5])

    total_error = 0
    average_error = []

    for row_num in range(len(validation_input)):
        input_val = validation_input[row_num]
        input_val = numpy.array([input_val])
        print "Input:", input_val

        predicted_output = anfis.predict(anf, input_val)

        # print "Expected Output: ", test_angles[row_num]
        print "Predicted Output: ", predicted_output

        if validation_output[row_num][0] == 0 or validation_output[row_num][1] == 0:
            continue
        percent_error = numpy.mean(abs(validation_output[row_num] - predicted_output) / validation_output[row_num])
        print "Percent Error: ", percent_error

        total_error = total_error + percent_error
        print "total error:", total_error

        average_error.append(percent_error)

        print row_num, len(validation_input)

    return total_error, numpy.mean(average_error)
