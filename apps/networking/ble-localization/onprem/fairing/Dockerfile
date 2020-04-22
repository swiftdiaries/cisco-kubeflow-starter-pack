FROM tensorflow/tensorflow:1.15.2-py3
RUN pip install pandas
ADD blerssi-model-cpu.py  /opt/blerssi-model-cpu.py
ADD iBeacon_RSSI_Labeled.csv /opt/iBeacon_RSSI_Labeled.csv
RUN chmod +x /opt/blerssi-model-cpu.py  /opt/iBeacon_RSSI_Labeled.csv 
CMD ["python","/opt/blerssi-model-cpu.py"]
