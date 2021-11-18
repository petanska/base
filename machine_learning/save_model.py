model_name = ''
model_json = testmodel.to_json()
with open('Model_' + model_name + '.json', "w") as json_file:
    json_file.write(model_json)
testmodel.save_weights('Model_' + model_name + '.h5')

model_hist = pd.DataFrame(history.history) 
hist_json  = model_hist.to_json()
with open('Model_' + model_name + '_history.json', "w") as json_file:
    json_file.write(hist_json)
