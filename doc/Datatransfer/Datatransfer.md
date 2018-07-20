# Transfer data into a scene
There are several options to transfer data into a scene. Basically the JFXSceneController has to be extended for processing data. Once the data is within the JFXSceneController you can change the gui accordingly. Two options of transferring data into a JFXScenController are explained below.   

## Transfer data as a constructor parameter
Data can be transferred as a constructor parameter. Therefore the data, at least a reference to it, has to be known before a JFXSceneController is instantiated. In this case, you can extend the constructor of the JFXSceneController, to pass data into it.

## Transfer data by calling a function
More flexible than passing data as a constructor parameter, is transferring data by calling a function. Transferring data by calling a function, allows to pass data, which was not known at the instantiation of the JFXSceneController, into it. Therefore you have to add a function to the class, derived from JFXSceneController. This function transfers the data as its parameter.
