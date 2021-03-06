function [bioRadioHandle] = connectBioRadio(pathToDllDirectory,pathToConfigFile,portName)

    % Load the library
    bioRadioHandle = BioRadio150_Load(pathToDllDirectory,false);

    % Start Communication and Program the Device
    BioRadio150_Start(bioRadioHandle, portName, 1, pathToConfigFile);

    display('BioRadio Connected!')


