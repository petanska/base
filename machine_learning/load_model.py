from keras.models import model_from_json
import json

testmodel = model_from_json(open('Model_211102_origDeepSTARR_S2-DHS-Dev600-Hk600.json').read())
testmodel.load_weights('Model_211102_origDeepSTARR_S2-DHS-Dev600-Hk600.h5')
with open('Model_211102_origDeepSTARR_S2-DHS-Dev600-Hk600_history.json', 'r') as json_file:
    model_hist = json.load(json_file)
