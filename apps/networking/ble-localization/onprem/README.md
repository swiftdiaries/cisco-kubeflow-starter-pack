# BLE-RSSI Location Prediction on UCS infrastructure
Given a labelled (with location) set of indoor Bluetooth Low Energy (BLE)
RSSI measurements, this app predicts the location of the unlabelled data.

[Data Source](https://archive.ics.uci.edu/ml/datasets/BLE+RSSI+Dataset+for+Indoor+localization+and+Navigation#).

There are two possible ways of implementing this application:
  - [Using Kubeflow pipelines](./pipelines)
  - [Using Jupyter notebook server from Kubeflow](./notebook)
