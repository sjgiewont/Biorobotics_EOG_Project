from myAnfis import anfis
import membership #import membershipfunction, mfDerivs
import numpy
import timeit
import cPickle as pickle


def fuzzy_error_test(anf, test_table_csv):
    test_xyz = numpy.loadtxt(test_table_csv, delimiter=',', usecols=[0, 1, 2])
    test_angles = numpy.loadtxt(test_table_csv, delimiter=',', usecols=[3, 4, 5])

    # with open('fuzzy_test_gauss.pkl', 'rb') as f:
    #     anf = pickle.load(f)

    total_error = 0
    average_error = []

    for row_num in range(len(test_xyz)):
        input_val = test_xyz[row_num]
        input_val = numpy.array([input_val])
        # print input_val

        predicted_output = anfis.predict(anf, input_val)

        # print "Expected Output: ", test_angles[row_num]
        # print "Predicted Output: ", predicted_output

        percent_error = numpy.mean(abs(test_angles[row_num] - predicted_output) / test_angles[row_num])
        # print "Percent Error: ", percent_error

        total_error = total_error + percent_error

        average_error.append(percent_error)

        print row_num, len(test_xyz)

    return total_error, numpy.mean(average_error)
