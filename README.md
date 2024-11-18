This project contains the code and data explained in details in the work titled : "Novel Concept-Oriented Synthetic Data approach for Training Generative AI-Driven Crystal Grain Analysis Using Diffusion Model"

Authors:

A. S. Saleh (1, 3,) 
K. Croes (1)
H. Ceric (4)
I. De Wolf (1, 3) 
H. Zahedmanesh (1,2)

1 imec, Kapeldreef 75, B-3001, Leuven, Belgium
2 Dept. Mechanical Engineering, Fac. Engineering Sciences, KU Leuven, B-3001, Leuven, Belgium
3 Dept. Materials Engineering, Fac. Engineering Sciences, KU Leuven, B-3001, Leuven, Belgium
4 Institute for Microelectronics, TU Wien, Gußhausstraße 27–29/E360, 1040 Wien, Austria

Correspondance: ahmed.saleh@imec.be

Abstract
The traditional techniques for extracting polycrystalline grain structures from microscopy images, 
such as transmission electron microscopy (TEM) and scanning electron microscopy (SEM), are labour-intensive, 
subjective, and time-consuming, limiting their scalability for high-throughput analysis. In this study, 
we present an automated methodology integrating edge detection with generative diffusion models to effectively identify grains, 
eliminate noise, and connect broken segments in alignment with predicted grain boundaries. 
Due to the limited availability of adequate images preventing the training of deep machine learning models, 
a new seven-stage methodology is employed to generate synthetic TEM images for training. 
This concept-oriented synthetic data approach can be extended to any field of interest where the scarcity of data is a challenge. 
The presented model was applied to various metals with average grain sizes down to the nanoscale, 
producing grain morphologies from low-resolution TEM images that are comparable to those obtained 
from advanced and demanding experimental techniques with an average accuracy of 97.23%. 

Files description:

Folder Code:
  * ConceptOrientedSyn_model.m : MATLAB code devoloped to create results shown in publication
  * net1.mat : Trained encoder/decoder network (NET1) containing all weights and biases of the network after training.
  * net2.mat : Trained diffusion model network (NET2) containing all weights and biases of the network after training.
  * TEM.png : input example

Folder Data:
  * Input synthetic TEM.zip: A compressed ZIP file containing 3000 Synthetic TEM gray scale images for microstructures in metal interconnects used as input in training process.
  * Target.zip: A compressed ZIP file containing the corresponding 3000 binary images for grain boundaries classification to be used as target in training process.
